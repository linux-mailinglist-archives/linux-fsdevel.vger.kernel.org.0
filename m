Return-Path: <linux-fsdevel+bounces-52263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8752AE0EF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 23:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD36188B728
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 21:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE21C248F7C;
	Thu, 19 Jun 2025 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E+cJDysw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D6D241CBA
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750367944; cv=none; b=rX+cg2ENbSrXm7x+TeoXHmXYS7OZiONhpSNyoak4FsMiu7U7Mqlfqht3NSgwXEfNtDpdALBU1Gt8iCRtWRfQxRQjMACQRvDI+EZ8pwg4t//2TWlVvCcX+6E/HYm6wLWbx6rRU9bOGfhManSHdko/wEfsxMi8FIzXLcP2wjBNAok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750367944; c=relaxed/simple;
	bh=43N9xSLqG8Mvf1evULiPV3dhUbzzkfegXMMlVgJmLmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qStg0kvy1WSTT1zW4C1hEZB2sWde5vQ433YlvTPw2PP7S72tqT+s7r+98ceQ8owadwTilRh9jv/WOLK3NWbSxWXRNvXB0aAb0+2Ni3K6PX2RdyrOORwk2CP65K9Qa79AL1cux7zCpV0s0BSgpL7JkwUKp6xuDkGxPLRyxDdy6WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E+cJDysw; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70e64b430daso13212677b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 14:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750367940; x=1750972740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7reZQjMhm+dclXhsOljn44+uNt88uw72bwAiTZN+zs=;
        b=E+cJDyswwCd3O1ohVQNJiyY5eOa0jtJG+bh6ZhltL81dbG/GCbHysWF05E4h1ERuRy
         5m2LKxrLUkSDOCU4dYry+AJq2deT5henQP2QO7rE1MdJgkvzeKRraS1rHCfYuEqOeyl+
         Hjlc5RK+v4pBI25h7GsrGJLHLw0QRMB/XjYXeFZlNnTt63ug9uX7HYVvVmv3Kx3LgCdA
         77CKL4E6RMTbTmX2PRTgA4aski0Xm2/BJ+oHVAsTk140fbd0RZ1UrH+RiBIPT9d6L24d
         KOOFetthlX5SvcTG4XH1ARSDK6BjU5zdRU5XNwSfv9oZOpqzmC3ML9AyGmBjlXX2yJpY
         ZeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750367940; x=1750972740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7reZQjMhm+dclXhsOljn44+uNt88uw72bwAiTZN+zs=;
        b=HSjh6opJgQT6v39uU/4pNJP5WL85IOFEF6L2WEiYcb+Sa1/dLiu+1CN3WoMui6myd+
         giBe/hc7hMY4u/I883daam5Sjl5fnx9B7/dqmFpwRR4iyvGZFTp05rVhN0QPe+QaBkMG
         7TuW+VO9WB5YqdtT7P37BVNZAmY5pysRP6aKUZJg2Q98MWwOYmaiehTHP9Xl0LDJASdM
         XVW7/mfiSIlL/adAvWRhkr7+CheHy7PR3ngWDAFAqGoK6xkl8trt8488dFewVGCLznDY
         eoOekOs2y04Au45V+g+1Ai49//hiIavKvKxWIoU4znCZH8wsAURdgDA4nkjn/dAz7ovU
         vkaA==
X-Forwarded-Encrypted: i=1; AJvYcCUfsGTgI4R9/iNiVblNKR4EPEIW67ZGIxExs0gaLPHZXK6OTWSNuVNT16WcG/FA6AmWMo/0igpwLu/Qcbgp@vger.kernel.org
X-Gm-Message-State: AOJu0YzFtkTGTMEJi/ajHPiShMSkKDAlojXfBIQdA9RVcJLP/boZjQ3m
	jAcFA/xQkiKmr+2bQKGJzUkQzQUeCbReLujt7gGFg7flfSGd1ohtjUHSEfvBWJZJ1vH1b50RxXV
	HdJbfCiIt5wsD9phoJhAs81Tyvryoy0mC3GF5grvM
X-Gm-Gg: ASbGnct87BPa4MgihAgKQLtTRvIEViBYX9K8N9S/d/cJiyZqrpwUC3hm5Fysp8AH8cy
	W+Vc5KpPt6GyiOEjZHifu0uqIzGaUBZWlpBZAkDNuLAkyVJ1QCAtc9JTi3I0Rw4nvMxqhPY6bHg
	UkM7svgAR5FuBBiA/plLCPXaRtj8Zka9zgipvDsniKXWk=
X-Google-Smtp-Source: AGHT+IGuYWqaT27fYmWdeDZ9lvr/78HUoiTAJ+pb8mrK6LB7RxNHDSBjtW66gCKrmHYUPLvXFfpMQPNhl/c9KrbuTKM=
X-Received: by 2002:a05:690c:610f:b0:70e:1aa1:63b4 with SMTP id
 00721157ae682-712c65125d6mr9891227b3.38.1750367940400; Thu, 19 Jun 2025
 14:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com>
 <CAHC9VhQyDX+NgWipgm5DGMewfVTBe3DkLbe_AANRiuAj40bA1w@mail.gmail.com> <6797b694-6c40-4806-9541-05ce6a0b07fc@oracle.com>
In-Reply-To: <6797b694-6c40-4806-9541-05ce6a0b07fc@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Jun 2025 17:18:49 -0400
X-Gm-Features: AX0GCFu9kjUfnfMnqfxH4agmkNzznUIDL4onDD-B6Nh-8MzRljESBgn1ZFaZ0Ts
Message-ID: <CAHC9VhQsK_XpJ-bbt6AXM4fk30huhrPvvMSEuHHTPb=eJZwoUA@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 5:03=E2=80=AFPM Anna Schumaker
<anna.schumaker@oracle.com> wrote:
> On 5/20/25 5:31 PM, Paul Moore wrote:
> > On Tue, Apr 29, 2025 at 7:34=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >> On Mon, Apr 28, 2025 at 4:15=E2=80=AFPM Stephen Smalley
> >> <stephen.smalley.work@gmail.com> wrote:
> >>>
> >>> Update the security_inode_listsecurity() interface to allow
> >>> use of the xattr_list_one() helper and update the hook
> >>> implementations.
> >>>
> >>> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.s=
malley.work@gmail.com/
> >>>
> >>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >>> ---
> >>> This patch is relative to the one linked above, which in theory is on
> >>> vfs.fixes but doesn't appear to have been pushed when I looked.
> >>>
> >>>  fs/nfs/nfs4proc.c             | 10 ++++++----
> >>>  fs/xattr.c                    | 19 +++++++------------
> >>>  include/linux/lsm_hook_defs.h |  4 ++--
> >>>  include/linux/security.h      |  5 +++--
> >>>  net/socket.c                  | 17 +++++++----------
> >>>  security/security.c           | 16 ++++++++--------
> >>>  security/selinux/hooks.c      | 10 +++-------
> >>>  security/smack/smack_lsm.c    | 13 ++++---------
> >>>  8 files changed, 40 insertions(+), 54 deletions(-)
> >>
> >> Thanks Stephen.  Once we get ACKs from the NFS, netdev, and Smack
> >> folks I can pull this into the LSM tree.
> >
> > Gentle ping for Trond, Anna, Jakub, and Casey ... can I get some ACKs
> > on this patch?  It's a little late for the upcoming merge window, but
> > I'd like to merge this via the LSM tree after the merge window closes.
>
> For the NFS change:
>     Acked-by: Anna Schumaker <anna.schumaker@oracle.com>

Hi Anna,

Thanks for reviewing the patch.  Unfortunately when merging the patch
today and fixing up some merge conflicts I bumped into an odd case in
the NFS space and I wanted to check with you on how you would like to
resolve it.

Commit 243fea134633 ("NFSv4.2: fix listxattr to return selinux
security label")[1] adds a direct call to
security_inode_listsecurity() in nfs4_listxattr(), despite the
existing nfs4_listxattr_nfs4_label() call which calls into the same
LSM hook, although that call is conditional on the server supporting
NFS_CAP_SECURITY_LABEL.  Based on a quick search, it appears the only
caller for nfs4_listxattr_nfs4_label() is nfs4_listxattr() so I'm
wondering if there isn't some room for improvement here.

I think there are two obvious options, and I'm curious about your
thoughts on which of these you would prefer, or if there is another
third option that you would like to see merged.

Option #1:
Essentially back out commit 243fea134633, removing the direct LSM call
in nfs4_listxattr() and relying on the nfs4_listxattr_nfs4_label() for
the LSM/SELinux xattrs.  I think we would want to remove the
NFS_CAP_SECURITY_LABEL check and build nfs4_listxattr_nfs4_label()
regardless of CONFIG_NFS_V4_SECURITY_LABEL.

Option #2:
Remove nfs4_listxattr_nfs4_label() entirely and keep the direct LSM
call in nfs4_listxattr(), with the required changes for this patch.

Thoughts?

[1] https://lore.kernel.org/all/20250425180921.86702-1-okorniev@redhat.com/
--=20
paul-moore.com

