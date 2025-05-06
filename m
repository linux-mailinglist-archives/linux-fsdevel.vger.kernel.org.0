Return-Path: <linux-fsdevel+bounces-48287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C18FAACDF3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 21:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1E916F670
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 19:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6389D1F4176;
	Tue,  6 May 2025 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fauAmZt3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094C0146593;
	Tue,  6 May 2025 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746559252; cv=none; b=LlDcdwSvyJTa1EWpZfEHCeSoj6ElNizYAqkk6oS1AGxwkAVHt1d0LJLu7xqelKdWU71HUoMiftzTbr+gISq2PBKXL2v+CD0ptUNnDbBQdzFKHFucYyfd2GoCK63KDHipTqROp0FQBT1VZqgU+mrUCThpgY9ahFqa98ti0m3tMfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746559252; c=relaxed/simple;
	bh=2RQ+atHs2ge8P3oUSkl6KzvkCoWLmkp0NnYSwcGFpkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EedVwMVIq8fQsCDlzSNWdQBdX5LTEeT2c9AVuhhvjWx4VPc2rVNtc1QdJ3YWJfdhQ11nh0OyfWK3O1cYXmtkLEN8f61fZih6H5cl7y4hg9U3E9+lIDoTmOi/9Ht5M2j+/PggLBUJoGhqEt+H/6NSMyiymoNfqPdFQ4Za7hn+T+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fauAmZt3; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac345bd8e13so1001860766b.0;
        Tue, 06 May 2025 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746559249; x=1747164049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+RWW3H7hnBPC+BlgVAu1FamM2anZ6JxP0vKTBmQ48L8=;
        b=fauAmZt3pXiP7ZW8myV/2YyBE8zTU+gvp/Ch3b/u2gkg9a40WI0mujBKnv5d2DaY3j
         qIyWaehp1/Pu7GZqndlhQcOb6vjmHEIBrid5o7blZ6GkUjqtKVGGnuXC2H12/Zv14Qr/
         SYRRYyq5GyI/195Z0JSr9u6O7VJahlVLBmw48C5lE/uDkOrShLmDve88jXw24a7ZDvSU
         RsYiLfKF3mJHn2wyF6hygtUkGYEJEYJ5GY9saCxpO8tQHXoVXQ442CNkyhL1/73Kh6YM
         IAPpTOFITIHfGezENx+n0794iUGlusFCxcPN5zM7tBncs9A2OxjQo02ZoRyAUs+zN2Vs
         GEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746559249; x=1747164049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RWW3H7hnBPC+BlgVAu1FamM2anZ6JxP0vKTBmQ48L8=;
        b=vfSDFh2/IjM54T3sg+hoI3+xsXvsj1TQoDK/vx8slbb8rTsj7gEj2u9kTYPacA3RpD
         D6xd+ip07jyAzagytqlu2xrkGEXWhc12vKztJJaMa7Q+4Hfr+y13A3f4O3UUZzmfZugW
         2ZlCLU2AyfZ2/44vEPFw5wKR4vj+2ubr+6/iyta1uUnu1m4O3U/zmuJ4PMb8OMPDbkOH
         h5TMN7VsJ+zWgQ0hRh0iqlqAtbY53DR4ztm9VmtarP5V56/y74SrltgnuEEiWIWZFLF3
         oaBA947OdMyD67qfWSyt0xxIRztFw+XfGvdqEWJWP04Kl2IfpsQ0wI0E1MBUVKmxYtvi
         X9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ6PFqyzAHHdMz//olUZHqjJeoS5vRyDQczfaBS4f47RJP3pAR9NYLzT9fqCK/Ts/Fm8ankAFSMo+T6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwI3osw0DTZy6KecIfj0NkFTSSFnslLArpamW0v9PYtaKFrxwpn
	2Ef/qTWJOvJIFFdfLIZMoc8T0xmE4JhF3o3KttPNk5v+g8hiRgfejiqdRw==
X-Gm-Gg: ASbGncuUgi3hCsbiW7wpRintDPQytlUWFzymkUOFnJogzJFa6KE99SFqba3X6UeSJqv
	mkoB3/6SADfCHHN96y4jFBhmdv78WMDUOPR1QFCE8hJkV3ZVvux0JGgr4cN3KzGsrIfnKf1u3tK
	tdOJMZbxkNEPnX5pBMuHnhJhTeilSrNgMy0+KIo3gHj1bR/WlgcLLz0WNxAP8DnnO6+bvKAbdtJ
	AcK4d1Ol1r+Jbj3hqq9HhCOknBol7iJ2CFZ9nprbi955npB0tyiFveZ1aZ8Fyr8CafhPvwzYd8V
	X31Xlz1kj2MX0+ICNP/mhOJOCqcf8nW7bvcg0WNGhsOscX5nwTEvNKY=
X-Google-Smtp-Source: AGHT+IEKTE1cNiZjY7lEaOeC36nnC6rJcUfJMoBq5x+Q128iUL5mPzSvwrzHHgK40Xv3H+/rOeF1uA==
X-Received: by 2002:a17:907:3ea3:b0:ac6:d142:2c64 with SMTP id a640c23a62f3a-ad1e8bcf2c7mr73472766b.18.1746559248868;
        Tue, 06 May 2025 12:20:48 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad18914733esm750651166b.33.2025.05.06.12.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 12:20:48 -0700 (PDT)
Date: Tue, 6 May 2025 21:20:47 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <ukytl7lwaprjovct6qvkgdqaou6kt3pxpjdocv5r45r6unpjbx@qjq6ffj4x3x7>
References: <20250505030345.GD2023217@ZenIV>
 <3qdz7ntes5ufac7ldgfsrnvotk4izalmtdf7opqox5mk3kpxus@gabtxt27uwah>
 <20250506172539.GN2023217@ZenIV>
 <j2tom2y6562wa7r6wjsxwgc25t3uoine45ills367o4y2booxr@3jdyomwkvt6w>
 <20250506175104.GO2023217@ZenIV>
 <4pg5rjsoxzxjgcx2wzucw2wr7uvaxws423stdlv75t2udfkash@jff3ci54z35u>
 <20250506181604.GP2023217@ZenIV>
 <juv6ldm6i53onsz355znrhcivf6bmog25spdkvnlvydhansmao@bpzxifunwl2n>
 <20250506190513.GQ2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506190513.GQ2023217@ZenIV>

On 2025-05-06 20:05:13 +0100, Al Viro wrote:
> On Tue, May 06, 2025 at 08:34:27PM +0200, Klara Modin wrote:
> 
> > > What's more, on the overlayfs side we managed to get to
> > >         upper_mnt = clone_private_mount(upperpath);
> > >         err = PTR_ERR(upper_mnt);
> > >         if (IS_ERR(upper_mnt)) {
> > >                 pr_err("failed to clone upperpath\n");
> > >                 goto out;
> > > so the upper path had been resolved...
> > > 
> > > OK, let's try to see what clone_private_mount() is unhappy about...
> > > Could you try the following on top of -next + braino fix and see
> > > what shows up?  Another interesting thing, assuming you can get
> > > to shell after overlayfs mount failure, would be /proc/self/mountinfo
> > > contents and stat(1) output for upper path of your overlayfs mount...
> > 
> > It looks like the mount never succeded in the first place? It doesn't
> > appear in /proc/self/mountinfo at all:
> > 
> > 2 2 0:2 / / rw - rootfs rootfs rw
> > 24 2 0:22 / /proc rw,relatime - proc proc rw
> > 25 2 0:23 / /sys rw,relatime - sysfs sys rw
> > 26 2 0:6 / /dev rw,relatime - devtmpfs dev rw,size=481992k,nr_inodes=120498,mode=755
> > 27 2 259:1 / /mnt/root-ro ro,relatime - squashfs /dev/nvme0n1 ro,errors=continue
> > 
> > I get the "kern_mount?" message.
> 
> What the... actually, the comment in front of that thing makes no
> sense whatsoever - it's *not* something kernel-internal; we get
> there for mounts that are absolute roots of some non-anonymous
> namespace; kernel-internal ones fail on if (!is_mounted(...))
> just above that.
> 
> OK, the comment came from db04662e2f4f "fs: allow detached mounts
> in clone_private_mount()" and it does point in an interesting
> direction - commit message there speaks of overlayfs and use of
> descriptors to specify layers.
> 
> Not that check_for_nsfs_mounts() (from the same commit) made any sense
> there - we don't *care* about anything mounted somewhere in that mount,
> since whatever's mounted on top of it does not follow into the copy
> (which is what has_locked_children() call is about - in effect, in copy
> you see all mountpoints that had been covered in the original)...
> 
> Oh, well - so we are seeing an absolute root of some non-anonymous
> namespace there.  Or a weird detached mount claimed to belong to
> some namespace, anyway.
> 
> Let's see if that's the way upperpath comes to be (and get a bit more
> information on that weird mount):
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index eb990e9a668a..9b4c4afa2b29 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2480,31 +2480,52 @@ struct vfsmount *clone_private_mount(const struct path *path)
>  
>  	guard(rwsem_read)(&namespace_sem);
>  
> -	if (IS_MNT_UNBINDABLE(old_mnt))
> +	if (IS_MNT_UNBINDABLE(old_mnt)) {
> +		pr_err("unbindable");
>  		return ERR_PTR(-EINVAL);
> +	}
>  
>  	if (mnt_has_parent(old_mnt)) {
> -		if (!check_mnt(old_mnt))
> +		if (!check_mnt(old_mnt)) {
> +			pr_err("mounted, but not in our namespace");
>  			return ERR_PTR(-EINVAL);
> +		}
>  	} else {
> -		if (!is_mounted(&old_mnt->mnt))
> +		if (!is_mounted(&old_mnt->mnt)) {
> +			pr_err("not mounted");
>  			return ERR_PTR(-EINVAL);
> +		}
>  
>  		/* Make sure this isn't something purely kernel internal. */
> -		if (!is_anon_ns(old_mnt->mnt_ns))
> +		if (!is_anon_ns(old_mnt->mnt_ns)) {
> +			if (old_mnt == old_mnt->mnt_ns->root)
> +				pr_err("absolute root");
> +			else
> +				pr_err("detached, but claimed to be in some ns");
> +			if (check_mnt(old_mnt))
> +				pr_err("our namespace, at that");
> +			else
> +				pr_err("some other non-anon namespace");
>  			return ERR_PTR(-EINVAL);
> +		}
>  
>  		/* Make sure we don't create mount namespace loops. */
> -		if (!check_for_nsfs_mounts(old_mnt))
> +		if (!check_for_nsfs_mounts(old_mnt)) {
> +			pr_err("shite with nsfs");
>  			return ERR_PTR(-EINVAL);
> +		}
>  	}
>  
> -	if (has_locked_children(old_mnt, path->dentry))
> +	if (has_locked_children(old_mnt, path->dentry)) {
> +		pr_err("has locked children");
>  		return ERR_PTR(-EINVAL);
> +	}
>  
>  	new_mnt = clone_mnt(old_mnt, path->dentry, CL_PRIVATE);
> -	if (IS_ERR(new_mnt))
> +	if (IS_ERR(new_mnt)) {
> +		pr_err("clone_mnt failed (%ld)", PTR_ERR(new_mnt));
>  		return ERR_PTR(-EINVAL);
> +	}
>  
>  	/* Longterm mount to be removed by kern_unmount*() */
>  	new_mnt->mnt_ns = MNT_NS_INTERNAL;

I then get:

[    0.881616] absolute root
[    0.881618] our namespace, at that

In btrfs_get_tree_subvol:

	ret = vfs_get_tree(dup_fc);
	if (!ret) {
		ret = btrfs_reconfigure_for_mount(dup_fc);
		up_write(&dup_fc->root->d_sb->s_umount);
	}
	if (!ret)
		mnt = vfs_create_mount(fc);
	else
		mnt = ERR_PTR(ret);
	put_fs_context(dup_fc);

Should it perhaps be:
		mnt = vfs_create_mount(dup_fc);

If I try that it works.

