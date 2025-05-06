Return-Path: <linux-fsdevel+bounces-48292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C33A1AACE4B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 21:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8FBB1C27774
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 19:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018B220AF67;
	Tue,  6 May 2025 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGAjus86"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59BD1F582E;
	Tue,  6 May 2025 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560675; cv=none; b=uN8Qmb02hJeD5TSwml5fdVb7D59swNelqWV/p7XZZ02YI1Pn5SPxeENYBQ7dQFTo8/tCDwaBwRmqK5fAGk8A2bNCRgfPzr6vAtLaQ7pToKEZO0bzhCWQUXrRHoOPtGvTvnrm2ZIujtRRnaBi09UKAjXokRpTJtoI6DGMjp0RE9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560675; c=relaxed/simple;
	bh=iCLceQAvGGgLx7ailjPPv7qnczZ7u5pcKjKS+9T3xlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQJG+HS4HUMisu3cFstqt4KTgVWego/qEWx5/cL93sBpH14bFxNB/cEs9UPFvMwuUKAdZsqGu+nEPmQzUj7uUxdIO2YqirrS/WSxeZaK/QWYCsw1+7iQgdR1ZnAeFSNJde0FJWvpAgboInfRZPN57L3y6IUHvIAxqqBn8OSAur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGAjus86; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54b1095625dso7355531e87.0;
        Tue, 06 May 2025 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746560672; x=1747165472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hMIe2ULk3ss66Vq8V2iHUMo34667nXvurvPAfn1Wkns=;
        b=RGAjus86nHgx8oULH5JwrS1kSPnKeL/9jA/C1WWSIbG+QC2ABHxsjwx/zmpPRPkgeC
         TcMT846wJ6IpTn2ZG/y1+dtODLda/keptM3y0AAWYTKoEscewVBe1spqcJf1ZpmWwf+H
         NJ9NyrGJGwF+SbUzvwaQngM0EUaIU05i3xhygqmXiVRduStITBeAqR42ND67j2u60cLN
         z80bmnoYFCP7nOIRGTL96QFi6y84+VSRAcrmsWrZskYCgQK5v7dj/fv51Vxdt1gVjWJ2
         rh5XcsOn3JmgZzRDUI4oUB2j+QxhWoDnnU/HrRcbQTiUVOvC/QHIboCbn0iN4uhunk4k
         /TTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746560672; x=1747165472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMIe2ULk3ss66Vq8V2iHUMo34667nXvurvPAfn1Wkns=;
        b=DV/yY5XDophQAGjZGrUbmv265iJrd/3UdUQ1UCWEoFkwIx2OXJ6/hVVda1qBRW3cGa
         7kOXRO5nvc2Xn+6oOeuWTr00QrV0Rf6dEYxD3ia3rukSmRIbEnLBtJffi6LAssu72ajm
         51d0gBDAOB3IP55QqNsojujU2p5emh2fPBBxK2yYWYq6fJpkG1qe0l5r+9RGupZ+gwoC
         f7zXxC3DkVQdamg4i2vgIY0la8g+AAkJY3/nO2sdb7I1pUvZSwal9Nt/b6Y0HvHQYUyJ
         tEbfv7uiiafucU9jj4SQ55qBoC6tADttmt0PDARFkurWWWPWGpLBBFad1Nj9LaQqH4rr
         E1sg==
X-Forwarded-Encrypted: i=1; AJvYcCUnOAnC3Ac/lR6zY7PwgIgXUFDpGBtXrAQEFQew3VjTNiJ83NHwkmCBbZQmBC5d+kwtUAo0AVJCMIILdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXvTyLInfmVOHnnG1xb95zH+Z2ya+dyL0WWCrZb4/cxI7GVb9t
	xSVfOl6TxvbD1Y1Olly4MoSpLItE0T768SzsbyQgLx6pnbwqxrQNwk0lLQ==
X-Gm-Gg: ASbGncujSVxFd9wOU2M/iOsYscpt5CbxQuD98Al3oHToGMbXhNNX5+HpbqUplbD0DYs
	EMS1cOcC0iJjnNQEr6uaksjOW1VK785KXtBxNq51WYjJIenLqegNdzRpl3L73pYSkj9RJZN5TCZ
	MT2WoA2ZVtDUcGeAwgV8D70umve11n/alUGDqRNsjBMl4kUJEn3NpbKW5/RryHVRWV4cxKmiROI
	m09RuygqLzV5FUsSIMaNbEF3UFdapHaklllqsGvz1S9q3PjUZCHdvwEE5f8SXFkHIh7HKYJ1GMc
	H38Uzofe73yaFixImOFNtW2oxV2oeUGl4IcpkmfK4YwTCCREChnjtrw=
X-Google-Smtp-Source: AGHT+IEk2wNJMHx98GOXG9B/XyTv0RLJjPo3njt2RphS34yzwmk20/0Dye2+6DVKAhlhFIq3jQU/mA==
X-Received: by 2002:a05:6512:6d6:b0:549:8b24:989d with SMTP id 2adb3069b0e04-54fb92ad014mr323971e87.0.1746560671433;
        Tue, 06 May 2025 12:44:31 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-54ea94ee0absm2176388e87.141.2025.05.06.12.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 12:44:31 -0700 (PDT)
Date: Tue, 6 May 2025 21:44:30 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <kike7hgn5louavoqxcf72iasabluf7vf5hlqpfydopjy3qiudv@ci35lif2pjqs>
References: <20250505030345.GD2023217@ZenIV>
 <3qdz7ntes5ufac7ldgfsrnvotk4izalmtdf7opqox5mk3kpxus@gabtxt27uwah>
 <20250506172539.GN2023217@ZenIV>
 <j2tom2y6562wa7r6wjsxwgc25t3uoine45ills367o4y2booxr@3jdyomwkvt6w>
 <20250506175104.GO2023217@ZenIV>
 <4pg5rjsoxzxjgcx2wzucw2wr7uvaxws423stdlv75t2udfkash@jff3ci54z35u>
 <20250506181604.GP2023217@ZenIV>
 <usokd3dnditdgjf772khf76rwjczn3qfd2qtxgxyvmqxpf5wmb@yfb66jhpnwtd>
 <20250506193305.GR2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506193305.GR2023217@ZenIV>

On 2025-05-06 20:33:05 +0100, Al Viro wrote:
> On Tue, May 06, 2025 at 08:58:59PM +0200, Klara Modin wrote:
> > > OK, let's try to see what clone_private_mount() is unhappy about...
> > > Could you try the following on top of -next + braino fix and see
> > > what shows up?  Another interesting thing, assuming you can get
> > > to shell after overlayfs mount failure, would be /proc/self/mountinfo
> > > contents and stat(1) output for upper path of your overlayfs mount...
> > 
> > 	ret = vfs_get_tree(dup_fc);
> > 	if (!ret) {
> > 		ret = btrfs_reconfigure_for_mount(dup_fc);
> > 		up_write(&dup_fc->root->d_sb->s_umount);
> > 	}
> > 	if (!ret)
> > 		mnt = vfs_create_mount(fc);
> > 	else
> > 		mnt = ERR_PTR(ret);
> > 	put_fs_context(dup_fc);
> > 
> > 
> > I tried replacing fc with dup_fc in vfs_create_mount and it seems to
> > work.
> 
> *blink*
> 
> OK, I'm a blind idiot - blind for not seeing the braino duplication,
> idiot for not thinking to check if the same thing has happened
> more than once.

No worries, thanks for taking the time to debug.

> 
> Kudos for catching that.  I still wonder what the hell got passed
> to overlayfs, though - vfs_create_mount() should've hit
>         if (!fc->root)
> 		return ERR_PTR(-EINVAL);
> since fc->root definitely was NULL there.  So we should've gotten
> a failing btrfs mount; fine, but that does not explain the form
> of breakage you are seeing on the overlayfs side...  Actually...
> is that mount attempted while still on initramfs?  Because if
> it is, we are running into a separate clone_private_mount()
> bug.
> 
> There's nothing to prohibit an overlayfs mount with writable layer
> being a subtree of initramfs; odd, but nothing inherently wrong
> with that setup.  And prior to that clone_private_mount() change
> it used to be fine; we would get a private mount with root
> pointing to subtree of initramfs and went on to use that.
> 

Yep, this is still within the initramfs. I later switch_root into the
overlay.

> We used to require the original mount to be in our namespace;
> Christian's change added "... or root of anon namespace".
> The order of checks went wrong, though.  We check for "is
> it an absolute root" *first* and treat that as a discriminator
> between the new and old cases.  It should be the other way
> round - "is it in our namespace" should take precedence.
> 
> IOW,
> 	if (!check_mount(...)) { // if it's not ours...
> 		// ... it should be root...
> 		if (mnt_has_parent(...))
> 			fail
> 		// ... of anon namespace...
> 		if (!is_mounted(...) || !is_anon_ns(...))
> 			fail
> 		// ... and create no namespace loops -
> 		// or no hidden references to namespaces, period
> 		if (mnt_ns_loop(...)) // or, perhaps, if (mnt_ns_from_dentry(...))
> 			fail
> 	}
> Anyway, that's a separate issue.

