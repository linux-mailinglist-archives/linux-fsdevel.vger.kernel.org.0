Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49552F253E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 02:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbhALBIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 20:08:35 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:51142 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731223AbhALBIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:08:35 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A435E58D380;
        Tue, 12 Jan 2021 12:07:50 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kz8A1-005Wb8-EO; Tue, 12 Jan 2021 12:07:49 +1100
Received: from dave by discord.disaster.area with local (Exim 4.94)
        (envelope-from <david@fromorbit.com>)
        id 1kz8A1-004qat-4N; Tue, 12 Jan 2021 12:07:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com, andres@anarazel.de
Subject: [RFC] xfs: reduce sub-block DIO serialisation
Date:   Tue, 12 Jan 2021 12:07:40 +1100
Message-Id: <20210112010746.1154363-1-david@fromorbit.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=EmqxpYm9HcoA:10 a=fO6qUVe31NdUr43OTE4A:9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

This is the XFS implementation on the sub-block DIO optimisations
for written extents that I've mentioned on #xfs and a couple of
times now on the XFS mailing list.

It takes the approach of using the IOMAP_NOWAIT non-blocking
IO submission infrastructure to optimistically dispatch sub-block
DIO without exclusive locking. If the extent mapping callback
decides that it can't do the unaligned IO without extent
manipulation, sub-block zeroing, blocking or splitting the IO into
multiple parts, it aborts the IO with -EAGAIN. This allows the high
level filesystem code to then take exclusive locks and resubmit the
IO once it has guaranteed no other IO is in progress on the inode
(the current implementation).

This requires moving the IOMAP_NOWAIT setup decisions up into the
filesystem, adding yet another parameter to iomap_dio_rw(). So first
I convert iomap_dio_rw() to take an args structure so that we don't
have to modify the API every time we want to add another setup
parameter to the DIO submission code.

I then include Christophs IOCB_NOWAIT fxies and cleanups to the XFS
code, because they needed to be done regardless of the unaligned DIO
issues and they make the changes simpler. Then I split the unaligned
DIO path out from the aligned path, because all the extra complexity
to support better unaligned DIO submission concurrency is not
necessary for the block aligned path. Finally, I modify the
unaligned IO path to first submit the unaligned IO using
non-blocking semantics and provide a fallback to run the IO
exclusively if that fails.

This means that we consider sub-block dio into written a fast path
that should almost always succeed with minimal overhead and we put
all the overhead of failure into the slow path where exclusive
locking is required. Unlike Christoph's proposed patch, this means
we don't require an extra ILOCK cycle in the sub-block DIO setup
fast path, so it should perform almost identically to the block
aligned fast path.

Tested using fio with AIO+DIO randrw to a written file. Performance
increases from about 20k IOPS to 150k IOPS, which is the limit of
the setup I was using for testing. Also passed fstests auto group
on a both v4 and v5 XFS filesystems.

Thoughts, comments?

-Dave.


