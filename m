Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC17201FAD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 04:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbgFTCQQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 22:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbgFTCQQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 22:16:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE76FC06174E
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2020 19:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=5nW+YDRp+Clmgvn8LCF6w7dYXG7ldqVpZZcmYzDTdB8=; b=L45Yiwm5dY1KQnhDLNtrx8XwXh
        xb0KWvZ1XuKci3DILsmauk7BpaV+46E45Q1R+G5ccFqyKWUndmVssAUTTLTDrh9AaFG2VA0zFUBF/
        nEAkyudooUy/+KZPOdRA9ytfN+mtZGsQrOivXitmO9ZV5teJl5RvapMUGOgDNxII0+H/Lwip0MxXc
        633T9hiZf1m4e+qvM+oK+qfZvIsxLxlsq25j+/rxI7Oc9vtNRahlEbfuBdPsrQMFAUflCo2kAzWK8
        63sOSmMQGMR4OpZ4tPVNEGxbMjFgUd2zU9ZHlY0pBm5xstZRWMpfEbgFuQ63U2pEfwuzQ9+kGRAT+
        3cSheEAA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmT3D-0003hV-SU; Sat, 20 Jun 2020 02:16:11 +0000
Date:   Fri, 19 Jun 2020 19:16:11 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Files dated before 1970
Message-ID: <20200620021611.GD8681@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Deepa,

Your commit 95582b008388 ("vfs: change inode times to use struct
timespec64") changed the behaviour of some filesystems with regards to
files from before 1970.  Specifically, this line from JFS, unchanged
since before 2.6.12:

fs/jfs/jfs_imap.c:3065: ip->i_atime.tv_sec = le32_to_cpu(dip->di_atime.tv_sec);

le32_to_cpu() returns a u32.  Before your patch, the u32 was assigned
to an s32, so a file with a date stamp of 1968 would show up that way.
After your patch, the u32 is zero-extended to an s64, so a file from
1968 now appears to be from 2104.

Obviously there aren't a lot of files around from before 1970, so it's
not surprising that nobody's noticed yet.  But I don't think this was
an intended change.

I see a similar problem in bfs, efs & qnx4.  Other filesystems might also
have the same problem, but I haven't done an intensive investigation.
This started as a bit of banter, and I inadvertently noticed this bug,
so I felt I had a moral imperative to report it.

Thanks for all the work you've done on the y2038 problem; it's really
important.  It might even be the right thing to do to start treating
32-bit filesystem seconds as being unsigned.  But from the commit message,
that didn't seem to be the intended effect.

The fix is simple; cast the result to (int) like XFS and ext2 do.
But someone needs to go through all the filesystems with care.  And it'd
be great if someone wrote an xfstest for handling files from 1968.
