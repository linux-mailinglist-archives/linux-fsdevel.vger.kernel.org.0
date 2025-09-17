Return-Path: <linux-fsdevel+bounces-61923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 678A1B7D5BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E245D4880E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 11:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED58536C081;
	Wed, 17 Sep 2025 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="J7W0TKO9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F862EB5D5;
	Wed, 17 Sep 2025 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758108996; cv=none; b=iqT5kqZylJcWoHiS2bCZFNIHVpo9ucUIx6HT2Zer0Wm74SlAFEEphFn+2kMyQE7Oe88HZE0Nz6x5wtPJj7KEAselwLwjUq5A62z7PUbHSLy6Tu8B1xiV/NJ8pZtD5s8IiVEGwQ02CO2y4nxUf8519ElzmKupCTZx4oMFNvFuB2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758108996; c=relaxed/simple;
	bh=wRXgDn7HywfAgrTjrDN0yqYd57MJsiJj40hGha2SdgA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEAUdPxDYuK7SJxoaxPVR9+musAETjQpNd9JyzeCdXBBAh89pNl3C4YDyr1eRnNtmkmmiAUWBddrLiTilLOgOp8sfVAc+sCrhVajzinpsItiZbuJ1UZo6CAkocuUrDy/L5SUT0L/jg2MqfOf0GGl84zQUcYEUbCGR3YuFMpw+X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=J7W0TKO9; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1758108994; x=1789644994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dWbPeUw7wRMdj3193lZI9i/Wb7Z9FK8CyLLo3CIDTyU=;
  b=J7W0TKO9JJbtwzA/KDWqDK0oSH7h8b6rDkysJ29/nwBk/k/r5pNoat1e
   7MIiLQxSt4djiCdB9ZXVTEfCVT6GV1QaHwF69P/zrLnAKU937F2TGSIPy
   FKtHtrBvzqiwJnE05uBWJHorC+8PrZmvjeUKgWsmpQDuHaCYYS/MP9lTI
   z1ooHGTk8EXOVg4wn9qcnDVcmnRq8yFaOX/9KoODiwI9yeJIt7s4ujdOe
   QPBzne+lkpuM+OJc9n/KoDi/xPO3EvkZU5ITE2d0I8mnAqqMl9OFPEGz6
   e9FqmhhCKM8KbbV1sucbMrU1Jd5gEVWCdW1r9uLN5LkFCHb0cgUwmkgqv
   g==;
X-CSE-ConnectionGUID: 3Vojkt4tS96bxJte7xtpaw==
X-CSE-MsgGUID: OVp1OPtcR5+yogFIzkg6NQ==
X-IronPort-AV: E=Sophos;i="6.18,263,1751241600"; 
   d="scan'208";a="3150228"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 11:36:32 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:33744]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.60:2525] with esmtp (Farcaster)
 id 7ed5f850-98bb-4f32-9e4d-0ddd3fe41eee; Wed, 17 Sep 2025 11:36:31 +0000 (UTC)
X-Farcaster-Flow-ID: 7ed5f850-98bb-4f32-9e4d-0ddd3fe41eee
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 17 Sep 2025 11:36:31 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Wed, 17 Sep 2025
 11:36:30 +0000
Date: Wed, 17 Sep 2025 11:36:27 +0000
From: Jakub Acs <acsjakub@amazon.de>
To: Amir Goldstein <amir73il@gmail.com>
CC: Jan Kara <jack@suse.cz>, <linux-unionfs@vger.kernel.org>, Miklos Szeredi
	<miklos@szeredi.hu>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] ovl: check before dereferencing s_root field
Message-ID: <20250917113627.GA51799@dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com>
References: <20250915101510.7994-1-acsjakub@amazon.de>
 <CAOQ4uxgXvwumYvJm3cLDFfx-TsU3g5-yVsTiG=6i8KS48dn0mQ@mail.gmail.com>
 <x4q65t5ar5bskvinirqjbrs4btoqvvvdsce2bdygoe33fnwdtm@eqxfv357dyke>
 <CAOQ4uxhbDwhb+2Brs1UdkoF0a3NSdBAOQPNfEHjahrgoKJpLEw@mail.gmail.com>
 <gdovf4egsaqighoig3xg4r2ddwthk2rujenkloqep5kdub75d4@7wkvfnp4xlxx>
 <CAOQ4uxhOMcaVupVVGXV2Srz_pAG+BzDc9Gb4hFdwKUtk45QypQ@mail.gmail.com>
 <scmyycf2trich22v25s6gpe3ib6ejawflwf76znxg7sedqablp@ejfycd34xvpa>
 <CAOQ4uxgSQPQ6Vx4MLECPPxn35m8--1iL7_rUFEobBuROfEzq_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgSQPQ6Vx4MLECPPxn35m8--1iL7_rUFEobBuROfEzq_A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, Sep 17, 2025 at 01:07:45PM +0200, Amir Goldstein wrote:
> Might something naive as this be enough?
> 
> Thanks,
> Amir.
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 60046ae23d514..8c9d0d6bb0045 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1999,10 +1999,12 @@ struct dentry *d_make_root(struct inode *root_inode)
> 
>         if (root_inode) {
>                 res = d_alloc_anon(root_inode->i_sb);
> -               if (res)
> +               if (res) {
> +                       root_inode->i_opflags |= IOP_ROOT;
>                         d_instantiate(res, root_inode);
> -               else
> +               } else {
>                         iput(root_inode);
> +               }
>         }
>         return res;
>  }
> diff --git a/fs/gfs2/export.c b/fs/gfs2/export.c
> index 3334c394ce9cb..809a09c6a89e0 100644
> --- a/fs/gfs2/export.c
> +++ b/fs/gfs2/export.c
> @@ -46,7 +46,7 @@ static int gfs2_encode_fh(struct inode *inode, __u32
> *p, int *len,
>         fh[3] = cpu_to_be32(ip->i_no_addr & 0xFFFFFFFF);
>         *len = GFS2_SMALL_FH_SIZE;
> 
> -       if (!parent || inode == d_inode(sb->s_root))
> +       if (!parent || is_root_inode(inode))
>                 return *len;
> 
>         ip = GFS2_I(parent);
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index 83f80fdb15674..7827c63354ad5 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -199,7 +199,7 @@ static int ovl_check_encode_origin(struct inode *inode)
>          * Root is never indexed, so if there's an upper layer, encode upper for
>          * root.
>          */
> -       if (inode == d_inode(inode->i_sb->s_root))
> +       if (is_root_inode(inode))
>                 return 0;
> 
>         /*
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index ec867f112fd5f..ed84379aa06ca 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -665,6 +665,7 @@ is_uncached_acl(struct posix_acl *acl)
>  #define IOP_DEFAULT_READLINK   0x0010
>  #define IOP_MGTIME     0x0020
>  #define IOP_CACHED_LINK        0x0040
> +#define IOP_ROOT       0x0080
>   /*
>   * Keep mostly read-only and often accessed (especially for
> @@ -2713,6 +2714,11 @@ static inline bool is_mgtime(const struct inode *inode)
>         return inode->i_opflags & IOP_MGTIME;
>  }
> 
> +static inline bool is_root_inode(const struct inode *inode)
> +{
> +       return inode->i_opflags & IOP_ROOT;
> +}
> +
>  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
>         int flags, const char *dev_name, void *data,
>         int (*fill_super)(struct super_block *, void *, int));
> 

This would prevent the null-ptr-deref, but the encoding procedure would
continue (for non-root inode), potentially reaching other code paths
that assume fs is still mounted - could that maybe be a problem?

I had considered similar direction initially, too, but then decided I'm
unable to verify the paths and that it's safer to just fail if we detect
no root (or cannot take the lock).

Am I thinking wrong?

Jakub



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


