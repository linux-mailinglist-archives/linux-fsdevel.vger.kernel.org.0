Return-Path: <linux-fsdevel+bounces-63458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE788BBD76C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 11:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12621896175
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 09:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F461E47C5;
	Mon,  6 Oct 2025 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvkIYx+O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AC11F582C
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759743512; cv=none; b=FWK/WD12KvsAB8VIXxQ1Gp7iVTQ2RLI5FOwYUz0mQFAmPvtVYpbP+Ofa2z9aHX3iqES42pOVBQc2sF50ccDNaMCsmDLDY+yiyRUK5d6ZvFhjWOchvJ1yrPId0TtOHyNNKuSUl6ilB4wGv6MIuRsL5eGYWuHa7irqkc8WL7rrn2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759743512; c=relaxed/simple;
	bh=xz/hZvzoakCriGkhB/bKuYdZ7YxI5bb7fHg5f/gAr14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jE3p1HV9V4UnKzTkAOJoBS8EXPd/DbmK+oXqEJBZ7z92CEhYYZK+wUmyvIqC83wJCbALlLaMrCg/HubgPfdmNnbx4r58zgpcWtEzqGZlplME4qtO0w9dJP0mfhOlmG36sLpG+wayDiD6tE1opD0jZNvQNzfVPX2YqgHhQ3bJxW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvkIYx+O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759743508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wsVDhkH03OWQAuqDWfBRNCEFQGrTGPu8ofI2SiM2cKk=;
	b=RvkIYx+OGsz9McK+uIgc+q7D25+m0RBeNisOKf2fAzSZWCZpZBLkDTrFD07Ffcr5R9cw2A
	FB0SA9xLKFuX2CiZGOJliJrsVjjOpR5U7IPZ76yf3J9Imss3AE3fXoeT9q2T0Q4W9gR87R
	kFTy/Riz6yswcl7nr2tCPqpJ2u4/zsg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-cAU9wjBYNiS3814yzlZkgA-1; Mon, 06 Oct 2025 05:38:27 -0400
X-MC-Unique: cAU9wjBYNiS3814yzlZkgA-1
X-Mimecast-MFC-AGG-ID: cAU9wjBYNiS3814yzlZkgA_1759743506
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e7a2c3773so2514515e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Oct 2025 02:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759743506; x=1760348306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsVDhkH03OWQAuqDWfBRNCEFQGrTGPu8ofI2SiM2cKk=;
        b=qoQw/AdW63ZmWrdWzmc5v4kdBNuQXw8Weo3/45RI6+gbnHyUQjfZaFuWaipnz6s+NX
         Yv2NMP49WGpq+ZeBXAnHH//NlKKAtXUGqvnECFinW1QIk4dvPXXsOhYzlNkdj1Qz50TE
         2Xc6XKu8VIk6GsnksMyIfrtQEkKAi+t76OMrw7HycZ48kwDfnlU0mIWzpI322YZHmdZU
         017eELu+H/8I7ykmCBfvLG28tkGJnkw9HwR+CDN/DVVR5UuielJX7/Xj3iNY9FDqNkj9
         fEPweuq9ZvXVCKlKDf1HxpKM2UyEumTzD/igvZf5HDs/Or27NjV9SK6ZlA4z9SxzF7C+
         Hqcg==
X-Forwarded-Encrypted: i=1; AJvYcCUyZ4vR2P/zA2Ap5T1MoA6quUxlNq5Fd6oiT3rV3SfDBRh6CSuMY7ZDRnbjKD3zmOK82Xgvl+nCOAyTovOF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5UZkyr1Al7Lh1EVDC3QSpBowkosWrHvccqkI5Z3jisfe4fj93
	kDQw/BygdVHVYE/fm8ERXGpm/84IytKecooh2l9BCDOA4XxOP33Z4Do2rsT/nIN7oVS4Pkjzq+5
	043YTWADlQ8Hg5OXqRILdGS9ELaQqk//SMZ6ZzE3lreJVywBSBAnLpkH0rauKEQrx0A==
X-Gm-Gg: ASbGnctr7MX8Vra3rvzeRzNP0PtGhpdkJMejrJQScIKlh5/2YT3in7aXKfSaJ8wmQ50
	yJ2ZWMOOcekVeFKNX8SN2xtIqA+VZ4DKu8kEYIsHwnsD3D73vmos47WmSAx+5M+CykOR3OZdJ5S
	+/YX/Oh552/l9m41m/jpA7s+r4FjQErFe5S+j0e1B1X8MNgka/VTkaG3vkqJPIDl+kBS1IX2eya
	qM/MP91gAaodwGg6mxFLzkKP4AFPVS/Ds/vLopWWcHwg3+cp9tPggV1tWviqPloK90ddjxVa2z3
	LMlovEdPy3mYQ1ON/OYXfX0lFT+iZwTl0BzTmTdyW+5flmzVjwaPICskUzcLdkTH9g==
X-Received: by 2002:a05:600c:1f90:b0:45d:dc10:a5ee with SMTP id 5b1f17b1804b1-46e70cab483mr81343165e9.15.1759743505605;
        Mon, 06 Oct 2025 02:38:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlCYUUFPB4ex5CVbIn5iY3pHvG7kFW2Jjm67YSJUH6t7qfO2Y4261WpJcAoaKplrHvSbogkQ==
X-Received: by 2002:a05:600c:1f90:b0:45d:dc10:a5ee with SMTP id 5b1f17b1804b1-46e70cab483mr81342845e9.15.1759743504850;
        Mon, 06 Oct 2025 02:38:24 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6bb2sm19624486f8f.10.2025.10.06.02.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 02:38:24 -0700 (PDT)
Date: Mon, 6 Oct 2025 11:37:53 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v4 1/3] file_attr: introduce program to set/get fsxattr
Message-ID: <7mytyiatnhgwplgda3cmiqq3hb7z6ulwgvwbkueb5dm2sdxwlg@ijti4d7vgrck>
References: <20251003-xattrat-syscall-v4-0-1cfe6411c05f@kernel.org>
 <20251003-xattrat-syscall-v4-1-1cfe6411c05f@kernel.org>
 <20251005103656.5qu3lmjvlcjkwjx4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005103656.5qu3lmjvlcjkwjx4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On 2025-10-05 18:36:56, Zorro Lang wrote:
> On Fri, Oct 03, 2025 at 11:32:44AM +0200, Andrey Albershteyn wrote:
> > This programs uses newly introduced file_getattr and file_setattr
> > syscalls. This program is partially a test of invalid options. This will
> > be used further in the test.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> 
> [snap]
> 
> > +	if (!path1 && optind < argc)
> > +		path1 = argv[optind++];
> > +	if (!path2 && optind < argc)
> > +		path2 = argv[optind++];
> > +
> > +	if (at_fdcwd) {
> > +		fd = AT_FDCWD;
> > +		path = path1;
> > +	} else if (!path2) {
> > +		error = stat(path1, &status);
> > +		if (error) {
> > +			fprintf(stderr,
> > +"Can not get file status of %s: %s\n", path1, strerror(errno));
> > +			return error;
> > +		}
> > +
> > +		if (SPECIAL_FILE(status.st_mode)) {
> > +			fprintf(stderr,
> > +"Can not open special file %s without parent dir: %s\n", path1, strerror(errno));
> > +			return errno;
> > +		}
> > +
> > +		fd = open(path1, O_RDONLY);
> > +		if (fd == -1) {
> > +			fprintf(stderr, "Can not open %s: %s\n", path1,
> > +					strerror(errno));
> > +			return errno;
> > +		}
> > +	} else {
> > +		fd = open(path1, O_RDONLY);
> > +		if (fd == -1) {
> > +			fprintf(stderr, "Can not open %s: %s\n", path1,
> > +					strerror(errno));
> > +			return errno;
> > +		}
> > +		path = path2;
> > +	}
> > +
> > +	if (!path)
> > +		at_flags |= AT_EMPTY_PATH;
> > +
> > +	error = file_getattr(fd, path, &fsx, fa_size,
> > +			at_flags);
> > +	if (error) {
> > +		fprintf(stderr, "Can not get fsxattr on %s: %s\n", path,
> > +				strerror(errno));
> > +		return error;
> > +	}
> 
> We should have a _require_* helper to _notrun your generic and xfs test cases,
> when system doesn't support the file_getattr/setattr feature. Or we always hit
> something test errors like below on old system:
> 
>   +Can not get fsxattr on ./fifo: Operation not supported
> 
> Maybe check if the errno is "Operation not supported", or any better idea?

There's build system check for file_getattr/setattr syscalls, so if
they aren't in the kernel file_attr will not compile.

Then there's _require_test_program "file_attr" in the tests, so
these will not run if kernel doesn't have these syscalls.

However, for XFS for example, there's [1] and [2] which are
necessary for these tests to pass. 

So, there a few v6.17 kernels which would still run these tests but
fail for XFS (and still fails as these commits are in for-next now).

For other filesystems generic/ will also fail on newer kernels as it
requires similar modifications as in XFS to support changing file
attributes on special files.

I suppose it make sense for this test to fail for other fs which
don't implement changing file attributes on special files.
Otherwise, this test could be split into generic/ (file_get/setattr
on regular files) and xfs/ (file_get/setattr on special files).

What do you think?

[1]: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=for-next&id=8a221004fe5288b66503699a329a6b623be13f91
[2]: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=for-next&id=0239bd9fa445a21def88f7e76fe6e0414b2a4da0

> 
> 
> Thanks,
> Zorro
> 
> > +	if (action) {
> > +		fsx.fa_xflags |= (fa_xflags | unknwon_fa_flag);
> > +
> > +		error = file_setattr(fd, path, &fsx, fa_size,
> > +				at_flags);
> > +		if (error) {
> > +			fprintf(stderr, "Can not set fsxattr on %s: %s\n", path,
> > +					strerror(errno));
> > +			return error;
> > +		}
> > +	} else {
> > +		if (path2)
> > +			print_xflags(fsx.fa_xflags, 0, 1, path, 0, 1);
> > +		else
> > +			print_xflags(fsx.fa_xflags, 0, 1, path1, 0, 1);
> > +	}
> > +
> > +	return error;
> > +
> > +usage:
> > +	printf("Usage: %s [options]\n", argv[0]);
> > +	printf("Options:\n");
> > +	printf("\t--get, -g\t\tget filesystem inode attributes\n");
> > +	printf("\t--set, -s\t\tset filesystem inode attributes\n");
> > +	printf("\t--at-cwd, -a\t\topen file at current working directory\n");
> > +	printf("\t--no-follow, -n\t\tdon't follow symlinks\n");
> > +	printf("\t--set-nodump, -d\t\tset FS_XFLAG_NODUMP on an inode\n");
> > +	printf("\t--invalid-at, -i\t\tUse invalid AT_* flag\n");
> > +	printf("\t--too-big-arg, -b\t\tSet fsxattr size bigger than PAGE_SIZE\n");
> > +	printf("\t--too-small-arg, -m\t\tSet fsxattr size to 19 bytes\n");
> > +	printf("\t--new-fsx-flag, -x\t\tUse unknown fa_flags flag\n");
> > +
> > +	return 1;
> > +}
> > 
> > -- 
> > 2.50.1
> > 
> 

-- 
- Andrey


