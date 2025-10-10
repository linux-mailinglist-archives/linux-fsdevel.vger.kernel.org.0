Return-Path: <linux-fsdevel+bounces-63727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90274BCC58D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 11:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 07AD8354F76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 09:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9720B23AB9F;
	Fri, 10 Oct 2025 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHkhATlP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4BA13AD1C
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760088638; cv=none; b=Pe5rfzoCAwp0tctvSBG82OZNR7PVTQPdLSb8pmrdXnytw4dsFmaI5QD6lsM24RBIuajYeXDs3U990DE/CAaZGstTChKpGMkaPIkBWmCyrbO9CuLwshMvwJUiiCHhHDmYXEbk//0OBawIZHo/VLsXqtYavP42q4Mkam+n4jZMbMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760088638; c=relaxed/simple;
	bh=Mj1VFJrp5c9ZO6C9l+r3P2v9gziELaHnsFG5WfCZSmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EX5vRpTruRUdxssijdPiFd+9U17llcnMsJGsOHaoYv8sJ8zHSn0cCVn3rWD2zfyPI1v2OY4h2mQJqPmpTyE/6aQkoqSQLLVPfAGK2P0uSfWLr3dKjZVaR6kJsGyAA3UYpDa7uIMxrrnh6WmMiAL8flKnOwTQuqyoCA07AAj2oTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHkhATlP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760088635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m19Suyk+a/n7mC2eYJunRdPA51fybU8+8EZ/+1nO9VI=;
	b=eHkhATlPwYPcw6efcNA4DM/a3kid8xBATl7Yvjvk14DEbcZU+JHJujXLTyLtWHhlVulS6g
	lkHS+Ck3Hrz+6HAHpc5BxSihh147RZuQB4b+yKDZNz6B8OZkPynmIu+6ndBQwOOoFreykt
	E7nI61ahO9jcd2KkdFO8+2yXZh/xF+k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-cCb6EO4cNRCHyCRReyCDXw-1; Fri, 10 Oct 2025 05:30:33 -0400
X-MC-Unique: cCb6EO4cNRCHyCRReyCDXw-1
X-Mimecast-MFC-AGG-ID: cCb6EO4cNRCHyCRReyCDXw_1760088632
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e2d845ebeso10634245e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 02:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760088632; x=1760693432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m19Suyk+a/n7mC2eYJunRdPA51fybU8+8EZ/+1nO9VI=;
        b=X3QTojvrBZAqA/5Qe0H2S3n1pkJyqrdYXn5nY5RcUaaFDoyopqjUHO6p7eJmig9f4w
         DBB4rTQ5jYX/IVLLq6ZJp7bBp+ztDK+KJ2O1XyNQW8cQlkBbw1tsAQeZiMnEQlGEf2MK
         kFSF6Yv5x/PVpyspbIhVBQWGJanYFSvEEw2P14vhVMA+lvxVdlYoP/T0zEnsX6TVLdsY
         BM3lj+u7mlRTNeaUl3f1Pz5NktXhIw+q6Bhf11qSGN0/8WqWc71EVfuOQQfOWyiPbHBH
         exkdRF9RtDiuKPURkmNQ1cj6NuvLGlMsC4zRWr2KPEuegxXS0mt70w/VOyreSzUqdQJ8
         uidA==
X-Forwarded-Encrypted: i=1; AJvYcCUh8gXz3XTLiuBEsQ8xbEDca0Zmzztw5fVZLA5sYl6whwMNklbGdcilvdeUKRSccgWWMlyMTpN7H3Bwn2Y7@vger.kernel.org
X-Gm-Message-State: AOJu0YyxuiJvZFPwu0d3ESBxzAGm68FS/PPrn6FQTLTFwMfJMl+vUyZ5
	TH/+AYKvQNTzSRl8fC7OuECBlgIiPsnKxsu9ataY6dIR6pGyf2uBrTFmvTI7St52r5nvJj9+NuJ
	2biFakZzCCEFC59pNVQFni6WtgVWpz7jSRdx2Wwgk24w2Nm/+n7kZs2lF2dBdYrSLzg==
X-Gm-Gg: ASbGnctgMumPUOkabXQ2IZskBNRBbzrPbCn1NL7Hrmte0pYEs3923Cy9EkhGwi2hiFY
	ApWx8gDXctXvrl+3M2EDx29cz2jjYRVKJPaMYWTEkSXIlc1n77ki28rmsvN9QrQHwXulnb7uNzV
	EKnNt7zLuKLtNtSwfBgtOFvDJ9q3dFAbKVC/v2VceTvpeEbbt3czNLS+Xp2JqHG5sBZ58XtTvUz
	dgaXtIpo/rUc8GjvRzDzUTwde3wqd7s2wYlZYclEZEuVEr3STEcxxHhOjoDzqzJ/Z2mi+AQMVlj
	AOkj65gaYyJHpnbfZ9/R+T4xcvi7WEK9queF5AvkH2UWjqtJ3TQNp/k1Z4Iv
X-Received: by 2002:a05:600c:8b22:b0:46e:4882:94c7 with SMTP id 5b1f17b1804b1-46fa9b02c6amr75031585e9.28.1760088632088;
        Fri, 10 Oct 2025 02:30:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEValMKthgp8I9VN0cd5Fx0yrOVtvxfOWumQ9lQuIn4WkPIIugbGuRT1eABE90tSGUAw2wzQw==
X-Received: by 2002:a05:600c:8b22:b0:46e:4882:94c7 with SMTP id 5b1f17b1804b1-46fa9b02c6amr75031225e9.28.1760088631453;
        Fri, 10 Oct 2025 02:30:31 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482ba41sm39161405e9.4.2025.10.10.02.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 02:30:31 -0700 (PDT)
Date: Fri, 10 Oct 2025 11:30:30 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v4 1/3] file_attr: introduce program to set/get fsxattr
Message-ID: <g25qhhy73arfepcubtsvrhfc3e3e2dktoludzpfwqxvkcphkxf@4n5s4jpvxmpr>
References: <20251003-xattrat-syscall-v4-0-1cfe6411c05f@kernel.org>
 <20251003-xattrat-syscall-v4-1-1cfe6411c05f@kernel.org>
 <20251005103656.5qu3lmjvlcjkwjx4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <7mytyiatnhgwplgda3cmiqq3hb7z6ulwgvwbkueb5dm2sdxwlg@ijti4d7vgrck>
 <20251009185630.GA6178@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009185630.GA6178@frogsfrogsfrogs>

On 2025-10-09 11:56:30, Darrick J. Wong wrote:
> On Mon, Oct 06, 2025 at 11:37:53AM +0200, Andrey Albershteyn wrote:
> > On 2025-10-05 18:36:56, Zorro Lang wrote:
> > > On Fri, Oct 03, 2025 at 11:32:44AM +0200, Andrey Albershteyn wrote:
> > > > This programs uses newly introduced file_getattr and file_setattr
> > > > syscalls. This program is partially a test of invalid options. This will
> > > > be used further in the test.
> > > > 
> > > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > > ---
> > > 
> > > [snap]
> > > 
> > > > +	if (!path1 && optind < argc)
> > > > +		path1 = argv[optind++];
> > > > +	if (!path2 && optind < argc)
> > > > +		path2 = argv[optind++];
> > > > +
> > > > +	if (at_fdcwd) {
> > > > +		fd = AT_FDCWD;
> > > > +		path = path1;
> > > > +	} else if (!path2) {
> > > > +		error = stat(path1, &status);
> > > > +		if (error) {
> > > > +			fprintf(stderr,
> > > > +"Can not get file status of %s: %s\n", path1, strerror(errno));
> > > > +			return error;
> > > > +		}
> > > > +
> > > > +		if (SPECIAL_FILE(status.st_mode)) {
> > > > +			fprintf(stderr,
> > > > +"Can not open special file %s without parent dir: %s\n", path1, strerror(errno));
> > > > +			return errno;
> > > > +		}
> > > > +
> > > > +		fd = open(path1, O_RDONLY);
> > > > +		if (fd == -1) {
> > > > +			fprintf(stderr, "Can not open %s: %s\n", path1,
> > > > +					strerror(errno));
> > > > +			return errno;
> > > > +		}
> > > > +	} else {
> > > > +		fd = open(path1, O_RDONLY);
> > > > +		if (fd == -1) {
> > > > +			fprintf(stderr, "Can not open %s: %s\n", path1,
> > > > +					strerror(errno));
> > > > +			return errno;
> > > > +		}
> > > > +		path = path2;
> > > > +	}
> > > > +
> > > > +	if (!path)
> > > > +		at_flags |= AT_EMPTY_PATH;
> > > > +
> > > > +	error = file_getattr(fd, path, &fsx, fa_size,
> > > > +			at_flags);
> > > > +	if (error) {
> > > > +		fprintf(stderr, "Can not get fsxattr on %s: %s\n", path,
> > > > +				strerror(errno));
> > > > +		return error;
> > > > +	}
> > > 
> > > We should have a _require_* helper to _notrun your generic and xfs test cases,
> > > when system doesn't support the file_getattr/setattr feature. Or we always hit
> > > something test errors like below on old system:
> > > 
> > >   +Can not get fsxattr on ./fifo: Operation not supported
> > > 
> > > Maybe check if the errno is "Operation not supported", or any better idea?
> > 
> > There's build system check for file_getattr/setattr syscalls, so if
> > they aren't in the kernel file_attr will not compile.
> > 
> > Then there's _require_test_program "file_attr" in the tests, so
> > these will not run if kernel doesn't have these syscalls.
> > 
> > However, for XFS for example, there's [1] and [2] which are
> > necessary for these tests to pass. 
> > 
> > So, there a few v6.17 kernels which would still run these tests but
> > fail for XFS (and still fails as these commits are in for-next now).
> > 
> > For other filesystems generic/ will also fail on newer kernels as it
> > requires similar modifications as in XFS to support changing file
> > attributes on special files.
> > 
> > I suppose it make sense for this test to fail for other fs which
> > don't implement changing file attributes on special files.
> > Otherwise, this test could be split into generic/ (file_get/setattr
> > on regular files) and xfs/ (file_get/setattr on special files).
> > 
> > What do you think?
> 
> generic/772 (and xfs/648) probably each ought to be split into two
> pieces -- one for testing file_[gs]etattr on regular/directory files;
> and a second one for the special files.  All four of them ought to
> _notrun if the kernel doesn't support the intended target.

I see, yeah that's what I thought of, I will split them and send new
patchset soon

> 
> Right now I have injected into both:
> 
> mkfifo $projectdir/fifo
> 
> $here/src/file_attr --get $projectdir ./fifo &>/dev/null || \
> 	_notrun "file_getattr not supported on $FSTYP"

Thanks! Looks like a good check to use

> 
> to make the failures go away on 6.17.
> 
> --D
> 
> > [1]: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=for-next&id=8a221004fe5288b66503699a329a6b623be13f91
> > [2]: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=for-next&id=0239bd9fa445a21def88f7e76fe6e0414b2a4da0
> > 
> > > 
> > > 
> > > Thanks,
> > > Zorro
> > > 
> > > > +	if (action) {
> > > > +		fsx.fa_xflags |= (fa_xflags | unknwon_fa_flag);
> > > > +
> > > > +		error = file_setattr(fd, path, &fsx, fa_size,
> > > > +				at_flags);
> > > > +		if (error) {
> > > > +			fprintf(stderr, "Can not set fsxattr on %s: %s\n", path,
> > > > +					strerror(errno));
> > > > +			return error;
> > > > +		}
> > > > +	} else {
> > > > +		if (path2)
> > > > +			print_xflags(fsx.fa_xflags, 0, 1, path, 0, 1);
> > > > +		else
> > > > +			print_xflags(fsx.fa_xflags, 0, 1, path1, 0, 1);
> > > > +	}
> > > > +
> > > > +	return error;
> > > > +
> > > > +usage:
> > > > +	printf("Usage: %s [options]\n", argv[0]);
> > > > +	printf("Options:\n");
> > > > +	printf("\t--get, -g\t\tget filesystem inode attributes\n");
> > > > +	printf("\t--set, -s\t\tset filesystem inode attributes\n");
> > > > +	printf("\t--at-cwd, -a\t\topen file at current working directory\n");
> > > > +	printf("\t--no-follow, -n\t\tdon't follow symlinks\n");
> > > > +	printf("\t--set-nodump, -d\t\tset FS_XFLAG_NODUMP on an inode\n");
> > > > +	printf("\t--invalid-at, -i\t\tUse invalid AT_* flag\n");
> > > > +	printf("\t--too-big-arg, -b\t\tSet fsxattr size bigger than PAGE_SIZE\n");
> > > > +	printf("\t--too-small-arg, -m\t\tSet fsxattr size to 19 bytes\n");
> > > > +	printf("\t--new-fsx-flag, -x\t\tUse unknown fa_flags flag\n");
> > > > +
> > > > +	return 1;
> > > > +}
> > > > 
> > > > -- 
> > > > 2.50.1
> > > > 
> > > 
> > 
> > -- 
> > - Andrey
> > 
> > 
> 

-- 
- Andrey


