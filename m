Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90C1D59E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 05:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfJNDWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Oct 2019 23:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729656AbfJNDWo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Oct 2019 23:22:44 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C43020815;
        Mon, 14 Oct 2019 03:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571023363;
        bh=DZGxU3jIaLGXs3D+KeuDCfCc+vTrN2Or/46bphL3odE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jADCgt78IbkZHWbtmlhFaAPgGVpOmY9CpVyfKh45IIJQ+cmkV3zl68mFJl/d0cVRI
         DegfmSrGrkNMPc5O0CMZ/X9J6dMM55F11/h8jElpok2lBLpnDREk82eyvmtM3roSic
         m9PbzJVx3tbokZQ2WwGs+cTzRo1Yq8MP3/I730GE=
Date:   Sun, 13 Oct 2019 20:22:42 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs/namespace.c: fix use-after-free of mount in
 mnt_warn_timestamp_expiry()
Message-ID: <20191014032242.GD10007@sol.localdomain>
Mail-Followup-To: Deepa Dinamani <deepa.kernel@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
References: <000000000000805e5505945a234b@google.com>
 <20191009071850.258463-1-ebiggers@kernel.org>
 <CABeXuvomuEY7-8SJuRDh+MS+fSE9evMudFe6KEdP+y-0D89fJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABeXuvomuEY7-8SJuRDh+MS+fSE9evMudFe6KEdP+y-0D89fJw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 13, 2019 at 07:04:10PM -0700, Deepa Dinamani wrote:
> Thanks for the fix.
> 
> Would it be better to move the check and warning to a place where the
> access is still safe?
> 
> -Deepa

True, we could just do

diff --git a/fs/namespace.c b/fs/namespace.c
index fe0e9e1410fe..9f2ceb542f05 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2764,14 +2764,14 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
 
+	mnt_warn_timestamp_expiry(mountpoint, mnt);
+
 	error = do_add_mount(real_mount(mnt), mountpoint, mnt_flags);
 	if (error < 0) {
 		mntput(mnt);
 		return error;
 	}
 
-	mnt_warn_timestamp_expiry(mountpoint, mnt);
-
 	return error;
 }

But then the warning ("Mounted %s file system ...") is printed even if
do_add_mount() fails so nothing was actually mounted.

Though, it's just a warning message and I think failures here are rare, so maybe
we don't care.  Al, what do you think?

- Eric
