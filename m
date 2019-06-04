Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE7BC3432C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 11:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfFDJ3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 05:29:04 -0400
Received: from ns.lynxeye.de ([87.118.118.114]:40447 "EHLO lynxeye.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726877AbfFDJ3E (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:29:04 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jun 2019 05:29:04 EDT
Received: by lynxeye.de (Postfix, from userid 501)
        id 6B50EE7421F; Tue,  4 Jun 2019 11:21:44 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on lynxeye.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham version=3.3.1
Received: from brom.techweek.pengutronix.de (unknown [185.66.195.81])
        by lynxeye.de (Postfix) with ESMTPSA id 4AB12E741C4;
        Tue,  4 Jun 2019 11:21:43 +0200 (CEST)
Message-ID: <7a642f570980609ccff126a78f1546265ba913e2.camel@lynxeye.de>
Subject: understanding xfs vs. ext4 log performance
From:   Lucas Stach <dev@lynxeye.de>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Tue, 04 Jun 2019 11:21:15 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this question is more out of curiosity and because I want to take the
chance to learn something.

At work we've stumbled over a workload that seems to hit pathological
performance on XFS. Basically the critical part of the workload is a
"rm -rf" of a pretty large directory tree, filled with files of mixed
size ranging from a few KB to a few MB. The filesystem resides on quite
slow spinning rust disks, directly attached to the host, so no
controller with a BBU or something like that involved.

We've tested the workload with both xfs and ext4, and while the numbers
aren't completely accurate due to other factors playing into the
runtime, performance difference between XFS and ext4 seems to be an
order of magnitude. (Ballpark runtime XFS is 30 mins, while ext4
handles the remove in ~3 mins).

The XFS performance seems to be completly dominated by log buffer
writes, which happen with both REQ_PREFLUSH and REQ_FUA set. It's
pretty obvious why this kills performance on slow spinning rust.

Now the thing I wonder about is why ext4 seems to get a away without
those costly flags for its log writes. At least blktrace shows almost
zero PREFLUSH or FUA requests. Is there some fundamental difference in
how ext4 handles its logging to avoid the need for this ordering and
forced access, or is it ext just living more dangerously with regard to
reordered writes?

Does XFS really require such a strong ordering on the log buffer
writes? I don't understand enough of the XFS transaction code and
wonder if it would be possible to do the strongly ordered writes only
on transaction commit.

Regards,
Lucas

