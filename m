Return-Path: <linux-fsdevel+bounces-58777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 082C8B3168C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7239FB60001
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 11:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433292FA0ED;
	Fri, 22 Aug 2025 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjghIzxp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2602F1FDC;
	Fri, 22 Aug 2025 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862968; cv=none; b=PgTbibjRuSfQq9QbfgkUhBuHS8LpHBe16VAj7omRCMCeEENRIKKiyLkrU+le1TLIET6XoRXFlNcQNMWtRk2+SlszyJf51DEWTaAkNYu8y55eY8j0keN//dzGikv2pg3d74WXGndiQ86FEQyO3rkjx86tChR8h6VOWgK+nBAFXTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862968; c=relaxed/simple;
	bh=2ZgvWGZyte81/H9FakASlsYnjCXiuVza/6Ya2b5gQ/o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=F3x5cdKC3eGosWXeLqkrBbMkQFB74lOix2HATnSrnkDZsRWyr+T07ArKeBpcK8u0vs8mStEKESxon8wjU3sBelGogGWGWGwuojqJC1MDyfmuUT8YQPn0/B6Eo49YSLJ5u2qe88US+32TfmpCqciTXVl7x82xsjELWCRKYNJ4OJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjghIzxp; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3252c3b048cso326610a91.2;
        Fri, 22 Aug 2025 04:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755862966; x=1756467766; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IrxqxJ/z0GXDKnUNlG2Sxv83KoiQHzcR3+GYFfPsus=;
        b=CjghIzxpV7C8mACquGQtS2v3epHFI+F7OdRl408sHk4K7intFXCTP8HJuhufqsaWVs
         Rx7NHmgLeN6DGnmy5bi2BSixHiI23M8xnKp/M8sMSFtSAsu6Z82xrD2BzBbWOvcXHPfX
         Q1kOM9hHA0wQlKzvvta0JOPN0UZ+8TazzL3pH7ty2yLExZesjWrPCFRQnDIYg46NI3Ga
         8XIoF1qKf5NWje5h9eh6ESqPWLH0/dBFnti1o47X96ED+XOC/bVhWiPkJYgwDkiyH18z
         QeC4oPD2eCJEetUYKVKgG1MmiOEqUKDlOGFJlVhwSiXA/HXcncHajcUeu0lDjYJmJic6
         1Xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755862966; x=1756467766;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IrxqxJ/z0GXDKnUNlG2Sxv83KoiQHzcR3+GYFfPsus=;
        b=R7l/Pvut059iv3Tb9MCa+pBkNDX9AV8ASKSca3YwOjvd2y8fbD0gR78nyTv5EYOSlr
         0eSFHi9fEnAPwpHHz/xN5ouiNeI1EHe0cMY7hAgrwuW9DHDWMUUrOcKXJkNOTY6nnYzi
         UXqOhZQBQVCiSgYTBZ7x3c0xkEIHNVMRs4Q1O5Oe676NHs1laHxUvkzPlSf4wPR1CjPO
         Iw5leH1/MCQ4ncf4GmOueVOBR7TnSVjaWVDNME18nnuD/C4a+osQEhIn6kHUT6FOgdmX
         7Tar+xjsO/QXsFShiPrm4TFkj69n2jzsiVUgDtU3ox74ddH+sDETTHbDlW4aTOEptFuV
         LnUw==
X-Forwarded-Encrypted: i=1; AJvYcCV+utEYM8Zfgp69YdmO9rEdK1/e+17P+3clndoCBSYezMYU1r0Lpxizb7t9ihccrokGlSPsimcCM31I@vger.kernel.org, AJvYcCWqsLSucRecSM3ToJF8ceoN0H64/CPWuzSJhfTHgbtZxcmFJoZju9WzL6RJ3kK1XR7hwCeI0RVBDggzbA==@vger.kernel.org, AJvYcCXLSNsEzx97SysoqHurnNffECaE3RxSOr/9yY0SSwY3ObcaL0Jr8loVVLnJZt/w6C4d3b4dDBXvJifMIOjvwg==@vger.kernel.org, AJvYcCXf+1a6jtXqEcD89pRecnkKkfvuL6eCL/SbeoXVTnzrkSlNzdxCEdZK/BitFpN+Cbb3P7JOjQkflz2H2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTfIDM3xzpggS6kMjFjOBQ/qJYSEOXuou7Xb8xkULR8ZiIGuLV
	vb4p92rpZR37bHpYiLi+KtM8Kg/tTgy9L2hT656p+ckYbsuxrqSdNyzwJIIOcA==
X-Gm-Gg: ASbGnctheBP7rFiuj43I/sv0aLNt8ZkVjQiXpZ8TnydFdy+ZKu2jhny+1zniOBf0M7/
	cWE6z3DQYrvnINdP9bCFnceb3OVfuvPs3x/ECEJw90B593ffPO5EWhz5NP28G7ffnqcGW2ADQg4
	XXExSHqFUtJcZXaNRJ8Isx1pBrVMZ93RPYyd4WJDpLg79OVIoorsmfpsDGZF27BSQAusKBEf7wD
	COyx8g0PfOhE8AIiokOz47bofMyJBovCoaLyX4JqTspU85DdFoyZFFEgivHG5dTszfPalnoCEY1
	2Ii2L30d4pU814W4ue37xVkU8Ahd0sr6Ozvta2eVCaaVqM8Pw7OscErVtrQ4Jnalog2NT3o/1JX
	gCbMCuw==
X-Google-Smtp-Source: AGHT+IGzpwZKeNE+QW88zOUTMTbT0VTyb4Dib3iu0t0qNTYT48x8j0waVes403+0Hn+e+x7joqllPQ==
X-Received: by 2002:a17:90b:4f8e:b0:321:38a:229a with SMTP id 98e67ed59e1d1-32515ee4be2mr4108642a91.7.1755862966144;
        Fri, 22 Aug 2025 04:42:46 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32513902819sm2341260a91.14.2025.08.22.04.42.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Aug 2025 04:42:45 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH 02/50] make the i_state flags an enum
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <3307530.5fSG56mABF@saltykitkat>
Date: Fri, 22 Aug 2025 19:42:29 +0800
Cc: josef@toxicpanda.com,
 brauner@kernel.org,
 kernel-team@fb.com,
 linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org,
 viro@zeniv.linux.org.uk
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED0538C1-E4C4-423F-9251-9C75F8ABE691@gmail.com>
References: <3307530.5fSG56mABF@saltykitkat>
To: Sun YangKai <sunk67188@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

On Aug 22, 2025, at 19:18, Sun YangKai <sunk67188@gmail.com> wrote:
>=20
> Hi Josef,
>=20
> Sorry for the bothering, and I hope this isn't too far off-topic for =
the=20
> current patch series discussion.
>=20
> I recently learned about the x-macro trick and was wondering if it =
might be=20
> suitable for use in this context since we are rewriting this. I'd =
appreciate=20
> any thoughts or feedback on whether this approach could be applied =
here.

I think x-macro is easy to write, but hard to read or grep.

>=20
> Thanks in advance for your insights!
>=20
> Below is the patch for reference:
>=20
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d7ab4f96d705..6a766aaa457e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2576,28 +2576,36 @@ static inline void kiocb_clone(struct kiocb =
*kiocb,=20
> struct kiocb *kiocb_src,
>  * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to =
wait
>  * upon. There's one free address left.
>  */
> -#define __I_NEW 0
> -#define I_NEW (1 << __I_NEW)
> -#define __I_SYNC 1
> -#define I_SYNC (1 << __I_SYNC)
> -#define __I_LRU_ISOLATING 2
> -#define I_LRU_ISOLATING (1 << __I_LRU_ISOLATING)
> -
> -#define I_DIRTY_SYNC (1 << 3)
> -#define I_DIRTY_DATASYNC (1 << 4)
> -#define I_DIRTY_PAGES (1 << 5)
> -#define I_WILL_FREE (1 << 6)
> -#define I_FREEING (1 << 7)
> -#define I_CLEAR (1 << 8)
> -#define I_REFERENCED (1 << 9)
> -#define I_LINKABLE (1 << 10)
> -#define I_DIRTY_TIME (1 << 11)
> -#define I_WB_SWITCH (1 << 12)
> -#define I_OVL_INUSE (1 << 13)
> -#define I_CREATING (1 << 14)
> -#define I_DONTCACHE (1 << 15)
> -#define I_SYNC_QUEUED (1 << 16)
> -#define I_PINNING_NETFS_WB (1 << 17)
> +#define INODE_STATE(X) \

And it should be INODE_STATE().

> + X(I_NEW), \
> + X(I_SYNC), \
> + X(I_LRU_ISOLATING), \
> + X(I_DIRTY_SYNC), \
> + X(I_DIRTY_DATASYNC), \
> + X(I_DIRTY_PAGES), \
> + X(I_WILL_FREE), \
> + X(I_FREEING), \
> + X(I_CLEAR), \
> + X(I_REFERENCED), \
> + X(I_LINKABLE), \
> + X(I_DIRTY_TIME), \
> + X(I_WB_SWITCH), \
> + X(I_OVL_INUSE), \
> + X(I_CREATING), \
> + X(I_DONTCACHE), \
> + X(I_SYNC_QUEUED), \
> + X(I_PINNING_NETFS_WB)
> +
> +enum __inode_state_bits {
> + #define X(state) __##state
> + INODE_STATE(X)
> + #undef X
> +};
> +enum inode_state_bits {
> + #define X(state) state =3D (1 << __##state)
> + INODE_STATE(X)
> + #undef X
> +};
>=20
> #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
> #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
> diff --git a/include/trace/events/writeback.h b/include/trace/events/
> writeback.h
> index 1e23919c0da9..4c545c72c40a 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -9,26 +9,10 @@
> #include <linux/backing-dev.h>
> #include <linux/writeback.h>
>=20
> -#define show_inode_state(state) \
> - __print_flags(state, "|", \
> - {I_DIRTY_SYNC, "I_DIRTY_SYNC"}, \
> - {I_DIRTY_DATASYNC, "I_DIRTY_DATASYNC"}, \
> - {I_DIRTY_PAGES, "I_DIRTY_PAGES"}, \
> - {I_NEW, "I_NEW"}, \
> - {I_WILL_FREE, "I_WILL_FREE"}, \
> - {I_FREEING, "I_FREEING"}, \
> - {I_CLEAR, "I_CLEAR"}, \
> - {I_SYNC, "I_SYNC"}, \
> - {I_DIRTY_TIME, "I_DIRTY_TIME"}, \
> - {I_REFERENCED, "I_REFERENCED"}, \
> - {I_LINKABLE, "I_LINKABLE"}, \
> - {I_WB_SWITCH, "I_WB_SWITCH"}, \
> - {I_OVL_INUSE, "I_OVL_INUSE"}, \
> - {I_CREATING, "I_CREATING"}, \
> - {I_DONTCACHE, "I_DONTCACHE"}, \
> - {I_SYNC_QUEUED, "I_SYNC_QUEUED"}, \
> - {I_PINNING_NETFS_WB, "I_PINNING_NETFS_WB"}, \
> - {I_LRU_ISOLATING, "I_LRU_ISOLATING"} \
> +#define inode_state_name(s) { s, #s }
> +#define show_inode_state(state) \
> + __print_flags(state, "|", \
> + INODE_STATE(inode_state_name) \
> )
>=20
> /* enums need to be exported to user space */
>=20
> Best regards,
> Sun YangKai
> <x-macro.patch>


