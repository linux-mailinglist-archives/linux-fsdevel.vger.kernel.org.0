Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF441DD30C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 May 2020 18:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgEUQYp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 12:24:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:37598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgEUQYp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 12:24:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E33FEAF22;
        Thu, 21 May 2020 16:24:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C232C1E126B; Thu, 21 May 2020 18:24:43 +0200 (CEST)
Date:   Thu, 21 May 2020 18:24:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     linux-fsdevel@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>
Subject: Ignore mask handling in fanotify_group_event_mask()
Message-ID: <20200521162443.GA26052@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Amir!

I was looking into backporting of commit 55bf882c7f13dd "fanotify: fix
merging marks masks with FAN_ONDIR" and realized one oddity in
fanotify_group_event_mask(). The thing is: Even if the mark mask is such
that current event shouldn't trigger on the mark, we still have to take
mark's ignore mask into account.

The most realistic example that would demonstrate the issue that comes to my
mind is:

mount mark watching for FAN_OPEN | FAN_ONDIR.
inode mark on a directory with mask == 0 and ignore_mask == FAN_OPEN.

I'd expect the group will not get any event for opening the dir but the
code in fanotify_group_event_mask() would not prevent event generation. Now
as I've tested the event currently actually does not get generated because
there is a rough test in send_to_group() that actually finds out that there
shouldn't be anything to report and so fanotify handler is actually never
called in such case. But I don't think it's good to have an inconsistent
test in fanotify_group_event_mask(). What do you think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
