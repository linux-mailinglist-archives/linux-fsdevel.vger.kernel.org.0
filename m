Return-Path: <linux-fsdevel+bounces-19866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2D18CA784
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 07:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673EE282629
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 05:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E113F8F1;
	Tue, 21 May 2024 05:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krQXJ+iv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A65B610C;
	Tue, 21 May 2024 05:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716267863; cv=none; b=OCtZ46ssT98TfvRzR5Z79l1vmClCiPGL6uc0rDcUa9/251QiyhNtFHvDnfDd4BB4OaGCO4LQwQnHQYnmfqEvtrLRR/YiepS+w44Am+9jTeUrhrocJYmlAFg9SdD2D9Yymw/PSiXEmRXG/Hh5dCm88v9RaXPsCrBjGqocrI1mKvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716267863; c=relaxed/simple;
	bh=97PxihTc9hshgLJfsF3ImXlIAmhViSK96qjnNgOAQgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIXNRHPc4xtJnfaBUkfreySI/9PntBEmOpUW7C/Fh7P6npY7L9EhuXLVGYRqCpuNZtUBG8TS6JH8Nj6e0rzK7BE43zI6Tm9cEKWxcDwoSYF+3N72ain2kJq0ppd5et4pYJOHGl57OQlf+U0MVDGLJlrzEXkFtrypYNxmfQQJnWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krQXJ+iv; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-61b4cbb8834so28487307b3.0;
        Mon, 20 May 2024 22:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716267861; x=1716872661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QDbtlT09zWn+TAG8clpVDLU8Z+ZeH0+DkEI12Wz3R4=;
        b=krQXJ+ivbSxkKKtshRBNG2kYcMqe368oPriMH/PjXjx1PvXD9JPjW72dETLZXGMKM+
         S/BicnzamBfHLG4YZe4mgGX6a1QBdYkfvp+TZu+MR8qTJCYkktn7TWkK+Vx//d6S5qEl
         C8GMAQ7xz+XCjNYidCmPG18decEqjRmNv9vOsSyzGu7VmUMrsN92/64InDaC8MSRxX4A
         gM2BYKCHhLn8YRfumA7hA+CY2tTFx0jSdNE9t4y9zDHCWNVL9fgzVKNaEIpwJ/6ZausV
         ASv65/1WApiRPfKIGA2VoGC3OfL5imAI7PtJmLfNVB2Bu31ATe1fkq0P++ZuYUpmNGky
         zM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716267861; x=1716872661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QDbtlT09zWn+TAG8clpVDLU8Z+ZeH0+DkEI12Wz3R4=;
        b=PDJs/UtUEXh7njDtc/b1saaS4IPx2ousnE7rnSVaAPbPHk+O1VH+220xiO+sUX+Wik
         kwUzqMWKfxg+O+MMkfwkhPVcKA0YEsensMASkDN9UIOCv60xaiLTJpkgfJ6LfWlBmOX2
         ogJuifbWvcb/Sb6aOqVRDXbCqoY0I4kwSbcco3jb0ChZgVoTz8nQqyU5jnu31c9MCt7Z
         nvGfCEZonEoXM624aewCcpFzSK8qM4YCZtAHQzTf0mTWN78g5xtp/Bt3bRa6qYdKBy0S
         NmglV3fznsUX9DG+UglNUYdxp6ejXztSmEvMqfLOfP9EvsWcoSB3oTZoEtEgZILBiQMr
         EFsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk66P+F8MRA/NGwdBIDD3S+e1gidef5f40HXqFD3XNPnkb+YDJuciG/NbszQTbzL4U+nVVZvuHOuJQk9odwD+RN0VVnPHkaWu4F4XeTn+pxf1EwJyeFtRzsgHPZOLvjDVMBctnltErmNBkRcZXyuLcx8FN68KE4UnaPOMvvAsDdLfaAEtIng==
X-Gm-Message-State: AOJu0YwV5Nmx/uTFsSvwgWtnjr8vVwM23LomL+YT2fa00vTH6R0eE6bn
	aHp47Ws8g/FQG839H9HN6uargb6uXe6b/AxzfOO06Mg+YmkLWsiYRZdRq82df4+AEBi1CoSd/Sq
	OWFNPz6ZODivg37rMJ+RPBmUNB27/c5lQ
X-Google-Smtp-Source: AGHT+IHkbaVvQ38fmMR3spKzkIG6N5rKJ/HA3RUD4jPnsho+kRoMUSZXDTU0WasN2QSwtHDmYkonxdTqYqLL94MD8eU=
X-Received: by 2002:a81:4503:0:b0:61b:bd65:3025 with SMTP id
 00721157ae682-622b00218bcmr305383337b3.40.1716267860942; Mon, 20 May 2024
 22:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520-exportfs-u64-mount-id-v1-1-f55fd9215b8e@cyphar.com>
 <f51a4bf68289268206475e3af226994607222be4.camel@kernel.org> <20240520.221843-swanky.buyers.maroon.prison-MAgYEXR0vg7P@cyphar.com>
In-Reply-To: <20240520.221843-swanky.buyers.maroon.prison-MAgYEXR0vg7P@cyphar.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 May 2024 08:04:09 +0300
Message-ID: <CAOQ4uxiaRGypAB0v49FW8Se+=4e4to1FAg77sxLPCkO55KcuHQ@mail.gmail.com>
Subject: Re: [PATCH RFC] fhandle: expose u64 mount id to name_to_handle_at(2)
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Jeff Layton <jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 1:28=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2024-05-20, Jeff Layton <jlayton@kernel.org> wrote:
> > On Mon, 2024-05-20 at 17:35 -0400, Aleksa Sarai wrote:
> > > Now that we have stabilised the unique 64-bit mount ID interface in
> > > statx, we can now provide a race-free way for name_to_handle_at(2) to
> > > provide a file handle and corresponding mount without needing to worr=
y
> > > about racing with /proc/mountinfo parsing.

Both statx() and name_to_handle_at() support AT_EMPTY_PATH, so
there is a race-free way to get a file handle and unique mount id
for statmount().

Why do you mean /proc/mountinfo parsing?

> > >
> > > As with AT_HANDLE_FID, AT_HANDLE_UNIQUE_MNT_ID reuses a statx AT_* bi=
t
> > > that doesn't make sense for name_to_handle_at(2).

Christian is probably regretting merging AT_HANDLE_FID now ;-)

Seriously, I would rearrange the AT_* flags namespace this way to
explicitly declare the overloaded per-syscall AT_* flags and possibly
prepare for the upcoming setxattrat(2) syscall [1].

[1] https://lore.kernel.org/linux-fsdevel/20240426162042.191916-1-cgoettsch=
e@seltendoof.de/

The reason I would avoid overloading the AT_STATX_* flags is that
they describe a generic behavior that could potentially be relevant to
other syscalls in the future, e.g.:
renameat2(..., AT_RENAME_TEMPFILE | AT_FORCE_SYNC);

But then again, I don't understand why you need to extend name_to_handle_at=
()
at all for your purpose...

Thanks,
Amir.

--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
[...]
+
+#define AT_PRIVATE_FLAGS       0x2ff   /* Per-syscall flags mask.  */
+
+/* Common flags for *at() syscalls */
 #define AT_SYMLINK_NOFOLLOW    0x100   /* Do not follow symbolic links.  *=
/
-#define AT_EACCESS             0x200   /* Test access permitted for
-                                           effective IDs, not real IDs.  *=
/
-#define AT_REMOVEDIR           0x200   /* Remove directory instead of
-                                           unlinking file.  */
 #define AT_SYMLINK_FOLLOW      0x400   /* Follow symbolic links.  */
 #define AT_NO_AUTOMOUNT                0x800   /* Suppress terminal
automount traversal */
 #define AT_EMPTY_PATH          0x1000  /* Allow empty relative pathname */

+/* Flags for statx(2) */
 #define AT_STATX_SYNC_TYPE     0x6000  /* Type of synchronisation
required from statx() */
 #define AT_STATX_SYNC_AS_STAT  0x0000  /* - Do whatever stat() does */
 #define AT_STATX_FORCE_SYNC    0x2000  /* - Force the attributes to
be sync'd with the server */
[...]

 #define AT_RECURSIVE           0x8000  /* Apply to the entire subtree */

-/* Flags for name_to_handle_at(2). We reuse AT_ flag space to save bits...=
 */
-#define AT_HANDLE_FID          AT_REMOVEDIR    /* file handle is needed to
+/* Flags for name_to_handle_at(2) */
+#define AT_HANDLE_FID          0x200   /* file handle is needed to
                                        compare object identity and may not
                                        be usable to open_by_handle_at(2) *=
/
+/* Flags for faccessat(2) */
+#define AT_EACCESS             0x200   /* Test access permitted for
+                                           effective IDs, not real IDs.  *=
/
+/* Flags for unlinkat(2) */
+#define AT_REMOVEDIR           0x200   /* Remove directory instead of
+                                           unlinking file.  */
+
+/* Flags for renameat2(2) (should match legacy RENAME_* flags) */
+#define AT_RENAME_NOREPLACE    0x001   /* Don't overwrite target */
+#define AT_RENAME_EXCHANGE     0x002   /* Exchange source and dest */
+#define AT_RENAME_WHITEOUT     0x004   /* Whiteout source */
+#define AT_RENAME_TEMPFILE     0x008   /* Source file is O_TMPFILE */
+
+/* Flags for setxattrat(2) (should match legacy XATTR_* flags) */
+#define AT_XATTR_CREATE                0x001   /* set value, fail if
attr already exists */
+#define AT_XATTR_REPLACE       0x002   /* set value, fail if attr
does not exist */
+

