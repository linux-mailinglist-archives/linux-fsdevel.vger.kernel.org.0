Return-Path: <linux-fsdevel+bounces-35461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D939D5054
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 17:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79329B267FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 16:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0DA19F101;
	Thu, 21 Nov 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEVS99su"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D860155CBF;
	Thu, 21 Nov 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204890; cv=none; b=ALv1YjMpJCKxeU6OVH+ILQF18Yv2JQ4mCyhTSHF5kmrwvcF3uczfqOVYa1EQNN1A3EpuRHQ7vYsYWJHQ4Nup0PvxmJgUGwKtJr+m8UjsC/CmlSb9ZDY4x/lkT3lWeKYTbgmbvV0qIF3I3WTmtdUbLIaiDz1p3CgprLLNi0uwvss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204890; c=relaxed/simple;
	bh=gF+y8oWfA2KuMu5p1cbT0vK/FJTgYlyMW30jF96xGPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyMEVDeBpxrav7Q9Ll9iwWwSOPEmtCmpnhXUpMPbAJOa8ClshsDPMr09J+Jkom+X/KtA3IlvK7yC+AEVJwxrdcLLJzLJLFrcJ8pJ34g+14V6wv2NSHz8+tTYYUi/htTplFKJqP0JbkFxcXsGTEeeaA9U4XbDlN4YTZO+lfKGYBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEVS99su; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9ed49edd41so199067666b.0;
        Thu, 21 Nov 2024 08:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732204886; x=1732809686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/D7HID2373t79vMCmeYvvZaFKSvpWPkH3dxYYPJQ+KQ=;
        b=iEVS99suSqd7Kro+PQw8vzEC/b11EGXTfECNL1Rjf+OMxv5ur1pBOVi40elanIYKAe
         mLdTe/GI6+bwrbkv8LpR0BjIkBfIkqCTU8Zx3vTjP5XFViqRJA6RqN/a0/1lND0zUKO7
         fOHl7JUANOIHuluVH4LLrEKpYzamv1bimTD8q7+zQ6PXbSQOtb3h5nRCXemv+qpgxbvG
         J9TNOVsx6CSLmabkiJrMoYaJ9AXTxscWEpkXcTOnjEULWfoZutOCB9X1Fwg2+liiyc1R
         lVLh0Fs46KkMVECCp6beMBqrMaF7bsyRmnYDyZVcj6fBx8soqWlPjRRwKGwPUpW9AHFZ
         WNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732204886; x=1732809686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/D7HID2373t79vMCmeYvvZaFKSvpWPkH3dxYYPJQ+KQ=;
        b=EB96QsjpZwrVGcUALAARQ4wDy9+C/Z2DOU9eBePgJZ5GatbSXMtQGUseWjGl+iIHQM
         YyR7345klWx4PWYbdRNpX5I3GDxjeQ5Uw02ri2cJrk7b50t+BiXjHkZz9L8mFlU77dXr
         1yxRMJfE+0/EyjRnlt93HGvIfShklLtBXJ5f8poGqbtIBmG84qt9U0U+GfyIZNHLxruH
         OsXTDpUO+Q2sTL6drQh1qkrJn1MgVGoO4kAjrLbRxdaOAB2Vp29FxiRddTfY3JCcJhLD
         x1tRy2D+q+N7o2TNj+jAtypK2dblLJ9HrTucMth44om/v4I7IaCwMya838HwqGAVSfK2
         431Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQBWLXpdxTKku75uNggqAEmTlEYCyqcJiCb9JVzqJ6RIiXLFDvwDnJKoTxxpPJVm2IDpbj05x/YGQh/Q==@vger.kernel.org, AJvYcCUZ3iwK0EKIF+cf+2/CfUqyx/TxeZgUhXzk377O374QzCQXKT1Bi1GFglC8iSU8i4YNZjI8iPXK3/AL@vger.kernel.org, AJvYcCWppWT/DkTOd/JcB7ZS57C4wZCESzyTeFumQZ7SMfrOt4ltr9qXn/ba6fFmRLNbe5AC+Wcv8iu21AoH9g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1a4BEI+opn7wTANisW5uD2k+SrzTObVo/6gviPg8QAAdF9CkH
	mbRzfx0Jk3LhWa1xgmIva/sg+Zec2VupX4I0/0qIv1pY8f6miXqAZqHcf4ubnwNbSdUpCGaI/DV
	2LQl9CGVr7t37WnN2nhEALCICU/jMQ1PTNTE=
X-Gm-Gg: ASbGncvjFDQ5hu/R2Lk1Wk9awzaaCp0cu0SNu9FDcD5xcekCYfd9S+MO36uuOFaXZuf
	HU6uGw4pEwA6JIUrejTO7LINnDURoDXI=
X-Google-Smtp-Source: AGHT+IHdxsoaDROzQG8qEj5x/K+j8d0Op0HAfKhZzlzLbAAPgZOVvmKuZZFzk9WC4mWx+/oxlwIOMbxa3djrhsRAlko=
X-Received: by 2002:a17:907:9281:b0:aa1:f73b:be3d with SMTP id
 a640c23a62f3a-aa4dd56aa50mr737837466b.27.1732204884517; Thu, 21 Nov 2024
 08:01:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121112218.8249-1-jack@suse.cz> <20241121112218.8249-4-jack@suse.cz>
In-Reply-To: <20241121112218.8249-4-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 21 Nov 2024 17:01:13 +0100
Message-ID: <CAOQ4uxgJiiv2KrEkxwND9zpwYLakAMPX_UruGC_6Zrd5ep7duw@mail.gmail.com>
Subject: Re: [PATCH 03/19] fsnotify: check if file is actually being watched
 for pre-content events on open
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, brauner@kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 12:22=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> From: Amir Goldstein <amir73il@gmail.com>
>
> So far, we set FMODE_NONOTIFY_ flags at open time if we know that there
> are no permission event watchers at all on the filesystem, but lack of
> FMODE_NONOTIFY_ flags does not mean that the file is actually watched.
>
> For pre-content events, it is possible to optimize things so that we
> don't bother trying to send pre-content events if file was not watched
> (through sb, mnt, parent or inode itself) on open. Set FMODE_NONOTIFY_
> flags according to that.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> Link: https://patch.msgid.link/2ddcc9f8d1fde48d085318a6b5a889289d8871d8.1=
731684329.git.josef@toxicpanda.com
> ---
>  fs/notify/fsnotify.c             | 27 +++++++++++++++++++++++++--
>  include/linux/fsnotify_backend.h |  3 +++
>  2 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 569ec356e4ce..dd1dffd89fd6 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -193,7 +193,7 @@ static bool fsnotify_event_needs_parent(struct inode =
*inode, __u32 mnt_mask,
>         return mask & marks_mask;
>  }
>
> -/* Are there any inode/mount/sb objects that are interested in this even=
t? */
> +/* Are there any inode/mount/sb objects that watch for these events? */
>  static inline bool fsnotify_object_watched(struct inode *inode, __u32 mn=
t_mask,
>                                            __u32 mask)
>  {
> @@ -632,7 +632,9 @@ EXPORT_SYMBOL_GPL(fsnotify);
>   */
>  void file_set_fsnotify_mode(struct file *file)
>  {
> -       struct super_block *sb =3D file->f_path.dentry->d_sb;
> +       struct dentry *dentry =3D file->f_path.dentry, *parent;
> +       struct super_block *sb =3D dentry->d_sb;
> +       __u32 mnt_mask, p_mask;
>
>         /* Is it a file opened by fanotify? */
>         if (FMODE_FSNOTIFY_NONE(file->f_mode))
> @@ -658,6 +660,27 @@ void file_set_fsnotify_mode(struct file *file)
>                 file->f_mode |=3D FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
>                 return;
>         }

This was lost in translation:

@@ -672,8 +672,10 @@ void file_set_fsnotify_mode(struct file *file)
        /*
         * If there are permission event watchers but no pre-content event
         * watchers, set FMODE_NONOTIFY | FMODE_NONOTIFY_PERM to indicate t=
hat.
+        * Pre-content events are only reported for regular files and dirs.
         */
-       if (likely(!fsnotify_sb_has_priority_watchers(sb,
+       if ((!d_is_dir(dentry) && !d_is_reg(dentry)) ||
+           likely(!fsnotify_sb_has_priority_watchers(sb,
                                                FSNOTIFY_PRIO_PRE_CONTENT))=
) {
                file->f_mode |=3D FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
                return;

> +
> +       /*
> +        * OK, there are some pre-content watchers. Check if anybody can =
be
> +        * watching for pre-content events on *this* file.
> +        */
> +       mnt_mask =3D READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify=
_mask);
> +       if (likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) &&
> +           !fsnotify_object_watched(d_inode(dentry), mnt_mask,
> +                                    FSNOTIFY_PRE_CONTENT_EVENTS))) {
> +               file->f_mode |=3D FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
> +               return;
> +       }
> +
> +       /* Even parent is not watching for pre-content events on this fil=
e? */
> +       parent =3D dget_parent(dentry);
> +       p_mask =3D fsnotify_inode_watches_children(d_inode(parent));
> +       dput(parent);
> +       if (!(p_mask & FSNOTIFY_PRE_CONTENT_EVENTS)) {
> +               file->f_mode |=3D FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
> +               return;
> +       }

inlining broke the logic and your branch fails the new PRE_ACCESS
test cases of fanotify03 LTP test (now pushed to branch fan_hsm).

Specifically in the test case that fails, parent is not watching and
inode is watching pre-content and your code gets to the p_mask
test and marks this file as no-pre-content watchers.

This passes the test:

@@ -684,17 +686,18 @@ void file_set_fsnotify_mode(struct file *file)
         * watching for pre-content events on *this* file.
         */
        mnt_mask =3D READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify_m=
ask);
-       if (likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) &&
-           !fsnotify_object_watched(d_inode(dentry), mnt_mask,
-                                    FSNOTIFY_PRE_CONTENT_EVENTS))) {
-               file->f_mode |=3D FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
+       if (unlikely(fsnotify_object_watched(d_inode(dentry), mnt_mask,
+                                            FSNOTIFY_PRE_CONTENT_EVENTS)))=
 {
                return;
        }

        /* Even parent is not watching for pre-content events on this file?=
 */
-       parent =3D dget_parent(dentry);
-       p_mask =3D fsnotify_inode_watches_children(d_inode(parent));
-       dput(parent);
+       p_mask =3D 0;
+       if (unlikely(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED)) {
+               parent =3D dget_parent(dentry);
+               p_mask =3D fsnotify_inode_watches_children(d_inode(parent))=
;
+               dput(parent);
+       }
        if (!(p_mask & FSNOTIFY_PRE_CONTENT_EVENTS)) {
                file->f_mode |=3D FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
                return;

Thanks,
Amir.

