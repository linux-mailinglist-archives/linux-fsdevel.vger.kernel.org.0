Return-Path: <linux-fsdevel+bounces-23126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052F692774F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 15:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1691F247A6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 13:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8191B1208;
	Thu,  4 Jul 2024 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pzz7/Ilj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823A71B011C
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720100214; cv=none; b=SFCok37LENdSARxwupLgCSgxUjqR9n//586ycCuHh1OUAIP4O3zD/n2AcFKamTnoaT6SkcfSwztKigctGoHVXAGWE0S4h6AMwAD+muAsz43pbD6YzsGqaXsp3JKcHVOTiV+Z2I5yzsSK0z2lqrS3S8+2aTxo7Po56oVY1zJfJ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720100214; c=relaxed/simple;
	bh=V2tOAHaVrYonStI9abDwgL3tFaJn3HXhUBB56LP2hL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oY0658HupOoEZdx9/JnlNeWvU57jMztFFNevoJodYEviTGALTWQ+8U/ra40aK+2FRfeCq9pkveBTSdqLE6QKoovAViTe9DpcETrWPd6protLYgS1AD0bG1uKvDV2beblZHUbzBPF006yubTlx0ZjlhOH9k0iIbVk/TR7DqBuuH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pzz7/Ilj; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ce08616a9so2517e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jul 2024 06:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720100209; x=1720705009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GqKWhDVIpU54/3Lm4p0n8dZsoucJ9m4r5oxiQez9CN0=;
        b=Pzz7/Ilj1w04GL34Szws4M9O6AreAnw47HuYtYKtPbzSgtaLgjMhYQUKP03R8it125
         CYku+anocFMD7gmgIa8lQL3cIe4W+DyixYgNqG/KMJGOB3rN4Xz/dWTIeAlkfsA6yjlI
         vFdJ59kY8stS/aWTud/fBaGAyjnhAU6svvqsse4JxUd+OXxKNdrErB6xnj7oaFCdbI9o
         PUuXgF5D/srTGjaP6DZcpTWtArdR4eCCnT4sScXZDl6f/1WH6cpqWUGngeqFxprsFTGz
         4djQvDjQtvWY1a6Xksaaq+Ko9oAWDjrkCbLdMoAS+pmv2lWCrUN7THMFYI0s9lgKVmRT
         dZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720100209; x=1720705009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqKWhDVIpU54/3Lm4p0n8dZsoucJ9m4r5oxiQez9CN0=;
        b=DveqlHT+ypRV+nvOIB8JAPcW6WlDSF2v+KAvNTI85XFBITBjUQEQykAZtV1GZemrpx
         /NrjUekSwKd5j8skp7WLVWUKfbLgqhNFShiqwgCjweSISF6t/5+OgI4bkNfTb74KhI95
         J6/O/Mf+y4gCdEYwR9Q7gSMyIy8diE6lfi+xgFqYzFf2/oIHkTYY0Tc4bslikD1y9MsU
         PHZe1aQNFJ/25vxFndvyvW+Bz8RSENUJiQrzgS1Nf0mFQ7s22qoNXPPtBrjNSzPnLQVV
         R0FCGQxeYDVBpeigKjGpyDOz92QDhN7JQOYzEFK8IwjeiawPSF57lI2P/mVkBMyGSDWj
         Aq+w==
X-Forwarded-Encrypted: i=1; AJvYcCWP09x66cgvNTsFy32ai+RCM91WmaRUNXh6RjpdecApYmq+umIY7HGnbTfwSOoy9iYef1Ckm763S73y3YZHeq9sv5Ys3B12pk392QJoOg==
X-Gm-Message-State: AOJu0YyDJZ49CEfQGD1ass/kbfJSz6+EFJlGtPWrEdsTgPTcGEVWrUWE
	9ZW1oW10W9joD++VNJH+sDfZB1chEAjEZdhxbLYrshq52wxVOCkvxFV1WVUILYDbD6u6kM3sMhO
	K6alWiltNVyBolX3M5XaqtHtFSB1yysSrhSQN
X-Google-Smtp-Source: AGHT+IH6SWc1AXTl+5ysSGba6hAiJwdZ9zfcwMC0vSQ9DYlubLUsWHEgrhDgFV9pvmLBGi0YR6GhhmlJxdASvzp4g1A=
X-Received: by 2002:ac2:596a:0:b0:52c:dd94:73f3 with SMTP id
 2adb3069b0e04-52e9f2a8ea6mr93485e87.3.1720100209127; Thu, 04 Jul 2024
 06:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000037162f0618b6fefb@google.com> <tencent_8BBB6433BC9E1C1B7B4BDF1BF52574BA8808@qq.com>
In-Reply-To: <tencent_8BBB6433BC9E1C1B7B4BDF1BF52574BA8808@qq.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 4 Jul 2024 15:36:37 +0200
Message-ID: <CACT4Y+agurcHCQnLTrVjLXr1-kEj1wbmXCHX6LPM=J1-o5wT2g@mail.gmail.com>
Subject: Re: [PATCH] hfsplus: fix uninit-value in copy_name
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 May 2024 at 07:28, 'Edward Adam Davis' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> [syzbot reported]
> BUG: KMSAN: uninit-value in sized_strscpy+0xc4/0x160
>  sized_strscpy+0xc4/0x160
>  copy_name+0x2af/0x320 fs/hfsplus/xattr.c:411
>  hfsplus_listxattr+0x11e9/0x1a50 fs/hfsplus/xattr.c:750
>  vfs_listxattr fs/xattr.c:493 [inline]
>  listxattr+0x1f3/0x6b0 fs/xattr.c:840
>  path_listxattr fs/xattr.c:864 [inline]
>  __do_sys_listxattr fs/xattr.c:876 [inline]
>  __se_sys_listxattr fs/xattr.c:873 [inline]
>  __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
>  x64_sys_call+0x2ba0/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:195
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:3877 [inline]
>  slab_alloc_node mm/slub.c:3918 [inline]
>  kmalloc_trace+0x57b/0xbe0 mm/slub.c:4065
>  kmalloc include/linux/slab.h:628 [inline]
>  hfsplus_listxattr+0x4cc/0x1a50 fs/hfsplus/xattr.c:699
>  vfs_listxattr fs/xattr.c:493 [inline]
>  listxattr+0x1f3/0x6b0 fs/xattr.c:840
>  path_listxattr fs/xattr.c:864 [inline]
>  __do_sys_listxattr fs/xattr.c:876 [inline]
>  __se_sys_listxattr fs/xattr.c:873 [inline]
>  __x64_sys_listxattr+0x16b/0x2f0 fs/xattr.c:873
>  x64_sys_call+0x2ba0/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:195
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [Fix]
> When allocating memory to strbuf, initialize memory to 0.
>
> Reported-and-tested-by: syzbot+efde959319469ff8d4d7@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/hfsplus/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 9c9ff6b8c6f7..858029b1c173 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -698,7 +698,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
>                 return err;
>         }
>
> -       strbuf = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
> +       strbuf = kzalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
>                         XATTR_MAC_OSX_PREFIX_LEN + 1, GFP_KERNEL);
>         if (!strbuf) {
>                 res = -ENOMEM;

Hi Edward,

Was this ever merged anywhere? I still don't see it upstream.

