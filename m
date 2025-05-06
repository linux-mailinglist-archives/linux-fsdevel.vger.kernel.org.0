Return-Path: <linux-fsdevel+bounces-48277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C928AACC8C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 19:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CC63A6C1A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 17:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC532857E1;
	Tue,  6 May 2025 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9+nFElg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF720B806;
	Tue,  6 May 2025 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746554077; cv=none; b=Pt2cDdzFRuqXxkqRo7jSH24nai1WLqFy/SwhoRHM6xuzD4BVdSAREfNbIvFf3pbXzg2jMYTV03lQNAEr/LU+P6+blO/IQQAYhXYddB99VNwckmz64WoJjXFVaHnKitszv99+ZWVz15or12zwlTL/mmWqhpntQlcZLUicC5i/t3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746554077; c=relaxed/simple;
	bh=Eucb11S8bEltbG2mCe4bl0bqZSd7ym5+JqpmwDHLHrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEOKQXdc+WMtBUEWeGBB9as8FYshOExhpFni9a1TyXs4oWoRcVkm3ezx4VEwmzYfjfsd3SsFL6RoNYZhJb8G1ntyuYP+krJamZl46gugAJU1X3P+MV9kSgcoQ2jNvKNrwuqPX7qtorKm6B1Ynp3qdReL8zd/7Pm/WE+DCQZ2YUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9+nFElg; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so10493027a12.0;
        Tue, 06 May 2025 10:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746554074; x=1747158874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RoYAZy3cUC77nH+PXUuQWd2RABtwyv5lO3b9CKb8qVQ=;
        b=V9+nFElgKBT4Jzu/XwBE+Sa1ItxUudOjAEQLrFImBSG1CBOAuhDlxAt1MUYx/p003M
         nbsySAHrU6ZVNn84Pij49e9P4nANNljcep+9ANcuwANkcgCw/IYiUcv30yECVkS0i0ye
         8QoHK0ASjmj5romWEoQGhXKpCrBll5QtxziPT+q+/jvW+ssi/yIh4n1AwEbb1ExjMGuY
         YD6zHbGD/nxi3wnlHducHnZ0cysCzyOcShlQa/9AmkgcxXOndFevVK1mxhj7VugF0SRm
         mROmKV/scuewjKGEeCTFdGFT44t9OYTL5YZwk+F7iFe+9KvaJUr1N15xX9QYZTrbOceI
         QsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746554074; x=1747158874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoYAZy3cUC77nH+PXUuQWd2RABtwyv5lO3b9CKb8qVQ=;
        b=JZrEebmRV+In68efEFGEOWrLgRbMAEzfjhSltF16PmenFUbFN7ZPvHXjd5VaNIUKTp
         CaMd0yvm9DWDoR/cRp9dkXf11IES1g0Rsk3C6IYzS6tUTljuACIZwEle/B17gupjweeN
         MHqTNqdfEZpwfHe9G9dejLOhV3rOW8NnUueuZdh1c22caMoEyfbiu9nzyMdkEyqm45Z6
         pCMRiCVaWhNWZntM1dn0wI5wFFo12O8yxonIqDR1Rkf647PEvEJkWY19LW4L+UaFi06/
         UTzCZfJ7Z8ry5f0yICHF668IPTiI7dk2GTOyMrjonzGd98wEbELmiN6u/sFKj0D4KM5g
         CP0g==
X-Forwarded-Encrypted: i=1; AJvYcCV8RkPXFph3l5Q8xMvpHPNv6G8F2tZk53ck4TAz8EWSfjF4xlS6xbwHL2Dm4MrOfHHKADBVNR4kJgcG2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWpBQjOedEBUpuvgGwAYOBfbQzsFXTJrPQlnA6Sdzi09wPsL85
	Sx1aCWxzM4OCQxdyRGqBUb833kjkOYpTPFKHPIcBIiatWWGoirfd
X-Gm-Gg: ASbGnctQiZ9X0Y3n2YH4zQwBxFL4sHrL92RGLzvx7yI9YwLcnuWE/0yXbxhCE1WRuWb
	FvoH+wp02W079X4KVCFYpB9tEml4SVCR3PWmggyQHIBxRuuu4TG92eXE1RwBX+a+TwByCAGbA+b
	qo6wU1BCh/fYhtDviGTP6/17plOJKnbic5HStNsjtMGxDzZZj3xDeK17sjlC4bJAJSLphlys49L
	PT3yKghVIWHSnGexKtLN+Hm0xEzrPvp1BrqlSmNpmxEjGE/2muixKkaG6alf/N9n+rsbdtZWpm1
	vuG/KHWPdiOXJN95l669C/mPGjE+tLQ2hCYl+XrH1eyBycC0S8GnWSq+1FsWORKjXA==
X-Google-Smtp-Source: AGHT+IElTAZMJEvDZh4aWK/R0zstlhdoUI54p1U9U1eeSfvZw0nrr7q+LwWXrLzUUnFVzRkpsZY94w==
X-Received: by 2002:a17:907:1797:b0:ac4:76d:6d2c with SMTP id a640c23a62f3a-ad1e8cd5d7amr37116766b.40.1746554073628;
        Tue, 06 May 2025 10:54:33 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad1891a1f2dsm738373466b.40.2025.05.06.10.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 10:54:33 -0700 (PDT)
Date: Tue, 6 May 2025 19:54:32 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <4pg5rjsoxzxjgcx2wzucw2wr7uvaxws423stdlv75t2udfkash@jff3ci54z35u>
References: <20250505030345.GD2023217@ZenIV>
 <3qdz7ntes5ufac7ldgfsrnvotk4izalmtdf7opqox5mk3kpxus@gabtxt27uwah>
 <20250506172539.GN2023217@ZenIV>
 <j2tom2y6562wa7r6wjsxwgc25t3uoine45ills367o4y2booxr@3jdyomwkvt6w>
 <20250506175104.GO2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506175104.GO2023217@ZenIV>

On 2025-05-06 18:51:04 +0100, Al Viro wrote:
> On Tue, May 06, 2025 at 07:47:29PM +0200, Klara Modin wrote:
> > On 2025-05-06 18:25:39 +0100, Al Viro wrote:
> > > On Tue, May 06, 2025 at 03:36:03PM +0200, Klara Modin wrote:
> > > 
> > > >   25:	49 8b 44 24 60       	mov    0x60(%r12),%rax
> > > 	rax = fc->root
> > > >   2a:*	48 8b 78 68          	mov    0x68(%rax),%rdi		<-- trapping instruction
> > > 	rdi = rax->d_sb, hitting rax == 0
> > > 
> > > > > -	mnt = fc_mount(dup_fc);
> > > > > -	if (IS_ERR(mnt)) {
> > > > > -		put_fs_context(dup_fc);
> > > > > -		return PTR_ERR(mnt);
> > > > > +	ret = vfs_get_tree(dup_fc);
> > > > > +	if (!ret) {
> > > > > +		ret = btrfs_reconfigure_for_mount(dup_fc);
> > > > > +		up_write(&fc->root->d_sb->s_umount);
> > > 
> > > ... here.  D'oh...  Should be dup_fc, obviously - fc->root hadn't been
> > > set yet.  Make that line
> > > 		up_write(&dup_fc->root->d_sb->s_umount);
> > > and see if it helps.  Sorry about the braino...
> > 
> > Thanks, that fixes the oops for me.
> > 
> > Though now I hit another issue which I don't know if it's related or
> > not. I'm using an overlay mount with squashfs as lower and btrfs as
> > upper. The mount fails with invalid argument and I see this in the log:
> > 
> > overlayfs: failed to clone upperpath
> 
> Seeing that you already have a kernel with that thing reverted, could
> you check if the problem exists there?

Yeah, it works fine with the revert instead.

