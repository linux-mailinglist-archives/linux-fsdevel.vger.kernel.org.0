Return-Path: <linux-fsdevel+bounces-63847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A30BCF850
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 18:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACE13A6AAA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 16:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F06327F177;
	Sat, 11 Oct 2025 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q65szLDQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F6B259C9C
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Oct 2025 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760200158; cv=none; b=coygOcRsz9BvPXa0HB84U/2O/J09UXiowC+5uqBd5lNR073IRE8ReRvuhI6YcrgkbCXBMyoo4YPC2vIZ8yBAZaUXU3TQ4E25+ywwfuvBXRIJYISmDsKEV2MSmQmDUFPYQfOprwuCx8FmuYw4VaSmsCK/Tf2LH84A1DX4FxldkDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760200158; c=relaxed/simple;
	bh=JQkZAF5fIUjq1WhmaqA0Vdp2xoDiRWzOFj+He3bCG+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3e3/+Am9ByqT/cWQTO2Xq8fXjmQnyhAgSVM0n/uwJRBbehGgpE0TkOZB+OcblPU+UIU+7FZd4IotnN9+pFwawYAFrWNYR7hVymWgCEc/AMOfim9idmL0AYqGCP6iwLyoUqbk9LBEUM5/PXgTdAMT3QJowR4WOFhUX0zuzf0qu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q65szLDQ; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d71bcab6fso26489247b3.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Oct 2025 09:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760200156; x=1760804956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QhgVdNH9OFffSS/en9blipGoQpflch+9wtbKeb3Qhvo=;
        b=Q65szLDQpnqhyDenrZlxjo2Xife8HTjlRHhDqxUidV3bJg8rFaaopgSlHL5YOusWT8
         dvj970ybGrr15x3EhFoOzy23bTezQ/Yxn3mO67cfOxLEHX0EUgmUnQ5UOyNfKAHBnXG9
         C34POTYEEnGOPlBe0z4cB2xPHfx2WVNodjB6sC7A/3t9P5d7rQrj36AWKAOQtILqBsCw
         H/uEy2U7nrqY6P8s3Y4dHGa/tl6wGGpv3WTgl5onTXPOljN788sOIp9BsTXkdIxwd0UJ
         rSWih46JNBBEWGQi/915irCp1ags8rOq522E+T5aJGOkMtn6i6EidanKRZwFub5uKWVz
         ttgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760200156; x=1760804956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhgVdNH9OFffSS/en9blipGoQpflch+9wtbKeb3Qhvo=;
        b=fg7Yw36WUDML7dexRXPanwaqO96MWXVLEvqcWHnN7QJptJoaO9WeRPattp2eHZiB7J
         sugb3YSgz1oSvVGrbsisKUyR+aInBkwDaD08oiOhrLawFcR1MdUcZmo3jZz/6fVADfxy
         WT/nMdis9lKjv3Tjnh0YwKrnxIekf8fJctkNOwNS+apdnHR5dQmO4WbD2RUe8gCGHaC9
         VSxRgb74zlfjvSqOo6HAwo2yL3Jyce65QgzHn25/iCSMS3sZeXv34Vp5txazFkxt4JoY
         xr6iOSHRb22NwROgVWM9lveHUuLuGbveNllsHu2mCfKgfau06jucJ+ffAb5VRkdAICe8
         4fBA==
X-Forwarded-Encrypted: i=1; AJvYcCUrF4Gp9wym9lQMynCPWSJOMhZ6B5yWC6bes3eKmkhBnIqCrMsG4EmxjmYcQDVya6syGUbVD2sGepKSMQPI@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Nt8ssRLQcYgrp2l7w/slMmLoTGYIcaqCDVN0xBI+G08aYzTR
	h8ntnij9WWak+bAgfR9JABVNpdMXrASdVlZLjVkNtEssl0ud1o143djN3lLR9Filu1yx2SjsySE
	TV02SajJS5NSZBypcNaY1nPQod1V0CN7pPVnUIfQ=
X-Gm-Gg: ASbGncvSES92xB7ncu9dXWrJv3HQVrO4ZJiVtgmAx/bINkp8CTp+KFG38zmPBmo3Cdj
	7gE+2pyz599bno7UJTdlfXR835WNionIjoJ5ZSpRBIv5laYjAU+MHBzNFHIG/bS8jAIHT8Ogdue
	TPKOTPAvFgDPP0hoD59BzmQ+xKIe5WkGei0/Zmxzg851MdliEmk02FtJ7bMf9zkhL3sestPVs6B
	RjHLCU6NNLQ0yLsKQ8RbM++
X-Google-Smtp-Source: AGHT+IEl0kcnSOrr1nOWP3LqMH7IADn9dvqYxTvClMDl2hvjiRQQ/af7lXgC3y7fcHcZFKCac1xnqrbeAZUSZFA0jSQ=
X-Received: by 2002:a05:690e:240f:b0:635:4ecc:fc20 with SMTP id
 956f58d0204a3-63ccb93460cmr10188136d50.40.1760200155709; Sat, 11 Oct 2025
 09:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a5f67878-33ca-4433-9c05-f508f0ca5d0a@I-love.SAKURA.ne.jp>
 <CAK+_RL=ybNZz3z-Fqxhxg+0fnuA1iRd=MbTCZ=M3KbSjFzEnVg@mail.gmail.com>
 <CAK+_RLkaet_oCHAb1gCTStLyzA5oaiqKHHi=dCFLsM+vydN2FA@mail.gmail.com> <340c759f-d102-4d46-b1f2-a797958a89e4@I-love.SAKURA.ne.jp>
In-Reply-To: <340c759f-d102-4d46-b1f2-a797958a89e4@I-love.SAKURA.ne.jp>
From: Tigran Aivazian <aivazian.tigran@gmail.com>
Date: Sat, 11 Oct 2025 17:29:04 +0100
X-Gm-Features: AS18NWA6iAY7Z9E10iz6O4ME84zlpxWoNbpXyly8NvxwnZrgZafWKW0pmNUE7aw
Message-ID: <CAK+_RLmbaxE9Q-ORiOUV8emrB+M6e7YgUNZEb48VwD28EuqwhQ@mail.gmail.com>
Subject: Re: [PATCH] bfs: Verify inode mode when loading from disk
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Thank you for your detailed explanation.

On Sat, 11 Oct 2025 at 00:19, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:

> Which pattern (just adding a new "if", or adding "else" with "if" and "else if" updated,
> or replace the 0x0000FFFF mask with 0x00000FFF) do you prefer?

There is also the fourth way, see the patch below. It makes it as
explicit as possible that vtype value is the authoritative one and
sets the type bits from vtype by keeping (in i_mode) only the
permission/suid/sgid/sticky bits upfront. What do you think?

diff -ur a/fs/bfs/inode.c b/fs/bfs/inode.c
--- a/fs/bfs/inode.c    2025-10-10 16:52:40.968468556 +0100
+++ b/fs/bfs/inode.c    2025-10-11 15:33:20.431967395 +0100
@@ -38,6 +38,8 @@
        struct inode *inode;
        struct buffer_head *bh;
        int block, off;
+       u32 dmode, dvtype;
+       umode_t expect_type = 0;

        inode = iget_locked(sb, ino);
        if (!inode)
@@ -61,23 +63,43 @@
        off = (ino - BFS_ROOT_INO) % BFS_INODES_PER_BLOCK;
        di = (struct bfs_inode *)bh->b_data + off;

-       inode->i_mode = 0x0000FFFF & le32_to_cpu(di->i_mode);
-       if (le32_to_cpu(di->i_vtype) == BFS_VDIR) {
+       dmode = le32_to_cpu(di->i_mode);
+       dvtype = le32_to_cpu(di->i_vtype);
+
+       /* Keep only permission/suid/sgid/sticky bits from on-disk mode. */
+       inode->i_mode = dmode & (S_IRWXU | S_IRWXG | S_IRWXO | S_ISUID
| S_ISGID | S_ISVTX);
+
+       if (dvtype == BFS_VDIR) {
+               expect_type = S_IFDIR;
                inode->i_mode |= S_IFDIR;
                inode->i_op = &bfs_dir_inops;
                inode->i_fop = &bfs_dir_operations;
-       } else if (le32_to_cpu(di->i_vtype) == BFS_VREG) {
+       } else if (dvtype == BFS_VREG) {
+               expect_type = S_IFREG;
                inode->i_mode |= S_IFREG;
                inode->i_op = &bfs_file_inops;
                inode->i_fop = &bfs_file_operations;
                inode->i_mapping->a_ops = &bfs_aops;
+       } else {
+               brelse(bh);
+               printf("Bad file type vtype=%u mode=0%07o %s:%08lx\n",
+                       dvtype, dmode, inode->i_sb->s_id, ino);
+               goto error;
        }

-       BFS_I(inode)->i_sblock =  le32_to_cpu(di->i_sblock);
-       BFS_I(inode)->i_eblock =  le32_to_cpu(di->i_eblock);
+       /* If the on-disk mode carried type bits, they must match vtype. */
+       if ((dmode & S_IFMT) && ((dmode & S_IFMT) != expect_type)) {
+               brelse(bh);
+               printf("Inconsistent type vtype=%u mode=0%07o
fmt=0%07o %s:%08lx\n",
+                       dvtype, dmode, (dmode & S_IFMT),
inode->i_sb->s_id, ino);
+               goto error;
+       }
+
+       BFS_I(inode)->i_sblock = le32_to_cpu(di->i_sblock);
+       BFS_I(inode)->i_eblock = le32_to_cpu(di->i_eblock);
        BFS_I(inode)->i_dsk_ino = le16_to_cpu(di->i_ino);
        i_uid_write(inode, le32_to_cpu(di->i_uid));
-       i_gid_write(inode,  le32_to_cpu(di->i_gid));
+       i_gid_write(inode, le32_to_cpu(di->i_gid));
        set_nlink(inode, le32_to_cpu(di->i_nlink));
        inode->i_size = BFS_FILESIZE(di);
        inode->i_blocks = BFS_FILEBLOCKS(di);

