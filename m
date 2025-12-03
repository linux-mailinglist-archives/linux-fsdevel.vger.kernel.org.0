Return-Path: <linux-fsdevel+bounces-70577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 565CACA0F30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 19:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA4A232DCFBA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 17:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1E0306D58;
	Wed,  3 Dec 2025 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MOhshlP2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988AC33F8A3
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777318; cv=none; b=DFgwtRFzg+RFgxwE4Kzt8A0hRGmPYUVA7x8gxJ6f+BldhchU3ZC3jAF7qfYHJ4tf1BXxGaG8nx/yCn5tJrvXcf/ZSbUL3UStfOghB5B3Bzae/GPvxncnd1hPDUNk8gocYptvd3euZzFWnS+y48vke2U5wh4ZU+oNN3/D0ZsfIA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777318; c=relaxed/simple;
	bh=u3Dy2G3WRTyFesbvCVKYgejnMDOxq7tkjLs3uSapkfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9Gy33mbND2l75EJQKs1hnue7a5f2QauSaSnfUn9s9KK6ACd4lLoGMoQ4b0K/ba2ru5kQdlANQd9vG7o2nvuTXE8qt+WR4ToBzk5RDIGFFyKKqAkWu9okNPczY0PNd9D+S5SzTX6ED+o9NiFCEZGMYtAeRZKxwYbDnvPR1RNfUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MOhshlP2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-340bcc92c7dso632110a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 07:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1764777316; x=1765382116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p/Pi5AWZHYDPsiAr+hwgDoJDjponKbr9dQ4aVc/nMQ=;
        b=MOhshlP2iwKgV6mqQ9uU1z08WtQGIGmY554H3UBMXEUdWqoYheVwV+Cu7HFMW+P6PD
         FPBoR+sDs7FUTlo22RmQut8CEtXCVBf6za6xlFmhAbYjPKZ1qpXixUMfoEnnpKV4LkTe
         H2SniOzX7L04ifLK+PB+p+U61BN5yWxZjQKBALxwpy/8PkpKb6XooXUQILaD8TJhvf96
         GQgsZMrx6WDOEVbiP+4L56uVTVWe4Mq6KaLM6J/x4FB/RvJkDl4icuAn7Fus2cvN+IUP
         MDOb+S5ANpQLb7ptx/wpOJasjusw1dMCx4mkV56a5nRSBgqq4QDiZcIMZheNVorQqZKS
         WvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764777316; x=1765382116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/p/Pi5AWZHYDPsiAr+hwgDoJDjponKbr9dQ4aVc/nMQ=;
        b=SsJfL9WMmQttm4Ew5BuKaMhOfRIQ8cAqXKOFTEPDfFAFDIcKA5IwFrcE/tWQbt3vND
         isySx+Vhat9ZOSiKLt6NNbu1VBtxonpYzecvYGZQDbTpzDbNOUMlKrS2+lTJEpqVENl4
         AChITrQWoFkGdFy72Nho2n/cRwQQrnV80c0XFfhVvu65+anr8Yyj2i2E0x0fcH93H/fS
         y5KPIVCxP6SWxGLfJwICTvoKcMt2a9Zmbm92NzMe1n1IDP8jzB8OUcthUTdqUxyTsZs9
         oFPdHYQ0cGbUQlywirAV2AtUJxMS9/Jd60aaL0e/DDtjHzRewKn6GyMca0It3tvzkSJj
         GZRg==
X-Forwarded-Encrypted: i=1; AJvYcCXGGBFQrerSTnf5Td05XT/ohWjWX2TomMOSW+/UH4jty3oXl6vbEWxIJ5+oiJ6x2S7XSnvcWn9/ukraJ4iE@vger.kernel.org
X-Gm-Message-State: AOJu0YwGMY8yq0MOQ3yj1nj4JyZLAoYU9B3d5CFzpDKu62181/v8yEpu
	xQ/hwNoujDPULFWiJQFOLHQAWXNLOLooBlJc30qHKtshq1ad923O4oTV3NhJn3UPLclNeY8PAm9
	4kqY0IAecRYDVoaFn7eolY38XKtBTHGwZRx16nGh3EKb6HVeRHPo=
X-Gm-Gg: ASbGncseNxmRZiVP0P5tGKNLMOPlnyXlV3lKgnahgueLxPFNFMJRtQJBgylvQdlTwym
	NGtiTGp6ufCgM3njekKHS6AplXevryB84q2F9IOUM8XifAyP2L74/X3cxookb7Tjj0SwHl+XkUC
	pBeYlRTNYsdUs6aiWBGhOFEaiW4mnFKTqCoDXIiwHa7HlRRvMYhljSxy4yy0ckUIJ4UDhcDN7oA
	J/gWvdVWQZO4a4QXv7cvyUfjJGMjcfvPTAsw0QmFzGxMH39FRPP/cFj0QkklazEUBBbAtc=
X-Google-Smtp-Source: AGHT+IFqrCGVBw0W6skiqMchfp9P0aCB9lQB6KewuBkAjCizkiC6upTGzicvdWl58VewJl0Dw2tgBc6JaUZoagFsGFM=
X-Received: by 2002:a17:90b:5610:b0:349:162d:ae0c with SMTP id
 98e67ed59e1d1-349162daf89mr2486825a91.4.1764777315815; Wed, 03 Dec 2025
 07:55:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com>
 <CAHC9VhQyDX+NgWipgm5DGMewfVTBe3DkLbe_AANRiuAj40bA1w@mail.gmail.com>
 <6797b694-6c40-4806-9541-05ce6a0b07fc@oracle.com> <CAHC9VhQsK_XpJ-bbt6AXM4fk30huhrPvvMSEuHHTPb=eJZwoUA@mail.gmail.com>
 <CAHC9VhQnR6TKzzzpE9XQqiFivV0ECbVx7GH+1fQmz917-MAhsw@mail.gmail.com> <CAEjxPJ7_7_Uru3dwXzNLSj5GdBTzdPDQr5RwXtdjvDv9GjmVAQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7_7_Uru3dwXzNLSj5GdBTzdPDQr5RwXtdjvDv9GjmVAQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Dec 2025 10:55:01 -0500
X-Gm-Features: AWmQ_bmh5eHBqsgQJybJ_-JtI6h64GzWSkh4DPBnzoJo8LXqkNENNTHyNoV6hjI
Message-ID: <CAHC9VhQDHTNkrB4YuNoafM0bhAav=CP5Ux6ZZGY9+WF0+0_9ww@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Anna Schumaker <anna.schumaker@oracle.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 10:35=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Jul 23, 2025 at 10:10=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Thu, Jun 19, 2025 at 5:18=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Tue, May 27, 2025 at 5:03=E2=80=AFPM Anna Schumaker
> > > <anna.schumaker@oracle.com> wrote:
> > > > On 5/20/25 5:31 PM, Paul Moore wrote:
> > > > > On Tue, Apr 29, 2025 at 7:34=E2=80=AFPM Paul Moore <paul@paul-moo=
re.com> wrote:
> > > > >> On Mon, Apr 28, 2025 at 4:15=E2=80=AFPM Stephen Smalley
> > > > >> <stephen.smalley.work@gmail.com> wrote:
> > > > >>>
> > > > >>> Update the security_inode_listsecurity() interface to allow
> > > > >>> use of the xattr_list_one() helper and update the hook
> > > > >>> implementations.
> > > > >>>
> > > > >>> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-ste=
phen.smalley.work@gmail.com/
> > > > >>>
> > > > >>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > >>> ---
> > > > >>> This patch is relative to the one linked above, which in theory=
 is on
> > > > >>> vfs.fixes but doesn't appear to have been pushed when I looked.
> > > > >>>
> > > > >>>  fs/nfs/nfs4proc.c             | 10 ++++++----
> > > > >>>  fs/xattr.c                    | 19 +++++++------------
> > > > >>>  include/linux/lsm_hook_defs.h |  4 ++--
> > > > >>>  include/linux/security.h      |  5 +++--
> > > > >>>  net/socket.c                  | 17 +++++++----------
> > > > >>>  security/security.c           | 16 ++++++++--------
> > > > >>>  security/selinux/hooks.c      | 10 +++-------
> > > > >>>  security/smack/smack_lsm.c    | 13 ++++---------
> > > > >>>  8 files changed, 40 insertions(+), 54 deletions(-)
> > > > >>
> > > > >> Thanks Stephen.  Once we get ACKs from the NFS, netdev, and Smac=
k
> > > > >> folks I can pull this into the LSM tree.
> > > > >
> > > > > Gentle ping for Trond, Anna, Jakub, and Casey ... can I get some =
ACKs
> > > > > on this patch?  It's a little late for the upcoming merge window,=
 but
> > > > > I'd like to merge this via the LSM tree after the merge window cl=
oses.
> > > >
> > > > For the NFS change:
> > > >     Acked-by: Anna Schumaker <anna.schumaker@oracle.com>
> > >
> > > Hi Anna,
> > >
> > > Thanks for reviewing the patch.  Unfortunately when merging the patch
> > > today and fixing up some merge conflicts I bumped into an odd case in
> > > the NFS space and I wanted to check with you on how you would like to
> > > resolve it.
> > >
> > > Commit 243fea134633 ("NFSv4.2: fix listxattr to return selinux
> > > security label")[1] adds a direct call to
> > > security_inode_listsecurity() in nfs4_listxattr(), despite the
> > > existing nfs4_listxattr_nfs4_label() call which calls into the same
> > > LSM hook, although that call is conditional on the server supporting
> > > NFS_CAP_SECURITY_LABEL.  Based on a quick search, it appears the only
> > > caller for nfs4_listxattr_nfs4_label() is nfs4_listxattr() so I'm
> > > wondering if there isn't some room for improvement here.
> > >
> > > I think there are two obvious options, and I'm curious about your
> > > thoughts on which of these you would prefer, or if there is another
> > > third option that you would like to see merged.
> > >
> > > Option #1:
> > > Essentially back out commit 243fea134633, removing the direct LSM cal=
l
> > > in nfs4_listxattr() and relying on the nfs4_listxattr_nfs4_label() fo=
r
> > > the LSM/SELinux xattrs.  I think we would want to remove the
> > > NFS_CAP_SECURITY_LABEL check and build nfs4_listxattr_nfs4_label()
> > > regardless of CONFIG_NFS_V4_SECURITY_LABEL.
> > >
> > > Option #2:
> > > Remove nfs4_listxattr_nfs4_label() entirely and keep the direct LSM
> > > call in nfs4_listxattr(), with the required changes for this patch.
> > >
> > > Thoughts?
> > >
> > > [1] https://lore.kernel.org/all/20250425180921.86702-1-okorniev@redha=
t.com/
> >
> > A gentle ping on the question above for the NFS folks.  If I don't
> > hear anything I'll hack up something and send it out for review, but I
> > thought it would nice if we could sort out the proper fix first.
>
> Raising this thread back up again to see if the NFS folks have a
> preference on option #1 or #2 above, or
> something else altogether. Should returning of the security.selinux
> xattr name from listxattr() be dependent on
> NFS_CAP_SECURITY_LABEL being set by the server and should it be
> dependent on CONFIG_NFS_V4_SECURITY_LABEL?

Thanks for bringing this back up Stephen, it would be good to get this reso=
lved.

--=20
paul-moore.com

