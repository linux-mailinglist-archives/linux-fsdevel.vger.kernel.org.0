Return-Path: <linux-fsdevel+bounces-63788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC69BCDCE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 17:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0211885398
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 15:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6312F99BD;
	Fri, 10 Oct 2025 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Za+WjAO5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE02F9D91
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760110260; cv=none; b=iYAz9KpqxQKHO4tZ5SrL4nr6WlUOpKyNSeP+Qk8RlWifhtHGd9Z//qKhxEJ4uBJUUBtZgaDW3iRRsPZkEw4GIyPGz4Yxnyf41XApFucHwpkqDgST34QKak8AIf8AbRok4Y/vS9MjIk6a9Q+v8pIOId5pOun2N1VgSy2XxWjnBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760110260; c=relaxed/simple;
	bh=/03Pw5upvDM5utHp0VziZGnocQcEhzmDgUxgcESsugw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyP+vZqIG4rUqXXYL7JSK6txxz3FGoT3CaCnb5sfQeg5PeNxSpdXrrBILsJ+n8e1ieJgax+LPOhCLZo8a6hXpJjA6r7vOaDwbSu5PZbxGnm9dBJAp8RbwsnGcW43DAwle8UUDW+IztHpmI5Nb3z7UiGkjLXvxje5zT+DkN/3b5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Za+WjAO5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760110257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=toyaPl0BwPmMTea5F2bVNCmB2GMR7wLyTYNGYyEE7m0=;
	b=Za+WjAO5/3I1jFKVzDGaYr0rAhrhsArTGse2ZH0CUT1LCdXQ5/dRUklpcG9WyTsC2FMO0B
	P9mI4Lge075/+3MnJVxryzolYuVzqW/35kzs0St0FQor4UJvWUnXWeDSlktrn8OXox7SKW
	GIAclg90Gi4728MdeE+1hqS789Ja8ZU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-UF6QCyvgOxaW1DFCmmURzg-1; Fri, 10 Oct 2025 11:30:55 -0400
X-MC-Unique: UF6QCyvgOxaW1DFCmmURzg-1
X-Mimecast-MFC-AGG-ID: UF6QCyvgOxaW1DFCmmURzg_1760110255
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33428befc49so6123586a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 08:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760110254; x=1760715054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toyaPl0BwPmMTea5F2bVNCmB2GMR7wLyTYNGYyEE7m0=;
        b=nOHoik7euLcjs6pZLCRn1NoH7+QnXjRx/d88AO6g2358TmWndFZkoDUP+rsyz55iXh
         Adfm01AjzqVNylDuq7C68HlMwvQDg/goEF9gg+cy9RQzvawx3igjH3gP2APPNx2q/X1J
         o2WI/FnC8/pqfX110a14uuv062U3GDptSMfyKr5tTX7/k1b9nzbGiPWrXO079Ht9pDLT
         096sOfSr8G5qxdWxRoFO6rBHshWdQyd5R30Sw1qGV8wxuKCjU3bwNi9gaZvJq2eLRkJZ
         Mg+1IpQ3YV4YoIRDWa5yaOpM6wub691FFknJ8ReA6wL96/VnRtiC206TVRrisMpiUq4m
         z1Sg==
X-Forwarded-Encrypted: i=1; AJvYcCX05q8PmsrIZ4cuv90+ivcmuOIcmrVYXfZOs30O1j/xHGZrI4B3go7Mi8tb5cVzhxCGPOYVKtSq+WfgHZbV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+zlh2F8oTt6x2CUpMp9Z8ag/PgtJ1BQcQQypzLNY3piuJQdWC
	8hqag6HQlQ0SoWEGVIsfT1c1ZuOs+OSy9UJa/K00fTcdt1g85i18vZbXqHISnGmApwz1cgxUFRv
	sIJ03grNQ/EGGcySQ0GNvtZx1ewzxHxya65pKHLATZ015kWtrTULKChm6iuRtfrJW3s7sHJENLQ
	M=
X-Gm-Gg: ASbGncvTrIfw9MAy2CMGNKE+DbzvgbZUmxbZnZf2LSOlpS8n0CM2D6s39uYkNSM85Gb
	ve49/4MHhvX44iP5/7z7WUUtokLwbxi57igcm33gXL7hhTcXkUlB0b1nKxY72xfH1rVJB6F/1E6
	RsY9zsWkgAUvspS1SoJV4WWbi6IPtM5POy7NWmbQfxAl5fJAzCURjm+43w7kZKRMaIxzqzemuga
	PRgfckXxqnsY2QejJjecaB0IV1CTRWsYTm9S7/C1VLCXVdTGQiqXYX+awaMQqF2/6ezes9bP7Zz
	jtZCExjUm+3yIkCYSVNg0jsVCBcjXbWNRmqUhUA3eZgvL6WKbU79VfXik4etY+0yNJVYahWOQJB
	9H1rl
X-Received: by 2002:a17:90b:1a8b:b0:32e:2fa7:fe6b with SMTP id 98e67ed59e1d1-33b5171dc4bmr17090585a91.14.1760110253879;
        Fri, 10 Oct 2025 08:30:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1f0AGOsJEpmCcJ38D9CxFjhHy8Xot8TOmTMK+pphk9BVjIZONuSrczqBgiHp9KjaWoWWqJg==
X-Received: by 2002:a17:90b:1a8b:b0:32e:2fa7:fe6b with SMTP id 98e67ed59e1d1-33b5171dc4bmr17090474a91.14.1760110253113;
        Fri, 10 Oct 2025 08:30:53 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b52a5656dsm4025456a91.11.2025.10.10.08.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:30:52 -0700 (PDT)
Date: Fri, 10 Oct 2025 23:30:47 +0800
From: Zorro Lang <zlang@redhat.com>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v4 1/3] file_attr: introduce program to set/get fsxattr
Message-ID: <20251010153047.2abso45wwnkfeykz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251003-xattrat-syscall-v4-0-1cfe6411c05f@kernel.org>
 <20251003-xattrat-syscall-v4-1-1cfe6411c05f@kernel.org>
 <20251005103656.5qu3lmjvlcjkwjx4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <7mytyiatnhgwplgda3cmiqq3hb7z6ulwgvwbkueb5dm2sdxwlg@ijti4d7vgrck>
 <20251009185630.GA6178@frogsfrogsfrogs>
 <g25qhhy73arfepcubtsvrhfc3e3e2dktoludzpfwqxvkcphkxf@4n5s4jpvxmpr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g25qhhy73arfepcubtsvrhfc3e3e2dktoludzpfwqxvkcphkxf@4n5s4jpvxmpr>

On Fri, Oct 10, 2025 at 11:30:30AM +0200, Andrey Albershteyn wrote:
> On 2025-10-09 11:56:30, Darrick J. Wong wrote:
> > On Mon, Oct 06, 2025 at 11:37:53AM +0200, Andrey Albershteyn wrote:
> > > On 2025-10-05 18:36:56, Zorro Lang wrote:
> > > > On Fri, Oct 03, 2025 at 11:32:44AM +0200, Andrey Albershteyn wrote:
> > > > > This programs uses newly introduced file_getattr and file_setattr
> > > > > syscalls. This program is partially a test of invalid options. This will
> > > > > be used further in the test.
> > > > > 
> > > > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > > > ---
> > > > 
> > > > [snap]
> > > > 
> > > > > +	if (!path1 && optind < argc)
> > > > > +		path1 = argv[optind++];
> > > > > +	if (!path2 && optind < argc)
> > > > > +		path2 = argv[optind++];
> > > > > +
> > > > > +	if (at_fdcwd) {
> > > > > +		fd = AT_FDCWD;
> > > > > +		path = path1;
> > > > > +	} else if (!path2) {
> > > > > +		error = stat(path1, &status);
> > > > > +		if (error) {
> > > > > +			fprintf(stderr,
> > > > > +"Can not get file status of %s: %s\n", path1, strerror(errno));
> > > > > +			return error;
> > > > > +		}
> > > > > +
> > > > > +		if (SPECIAL_FILE(status.st_mode)) {
> > > > > +			fprintf(stderr,
> > > > > +"Can not open special file %s without parent dir: %s\n", path1, strerror(errno));
> > > > > +			return errno;
> > > > > +		}
> > > > > +
> > > > > +		fd = open(path1, O_RDONLY);
> > > > > +		if (fd == -1) {
> > > > > +			fprintf(stderr, "Can not open %s: %s\n", path1,
> > > > > +					strerror(errno));
> > > > > +			return errno;
> > > > > +		}
> > > > > +	} else {
> > > > > +		fd = open(path1, O_RDONLY);
> > > > > +		if (fd == -1) {
> > > > > +			fprintf(stderr, "Can not open %s: %s\n", path1,
> > > > > +					strerror(errno));
> > > > > +			return errno;
> > > > > +		}
> > > > > +		path = path2;
> > > > > +	}
> > > > > +
> > > > > +	if (!path)
> > > > > +		at_flags |= AT_EMPTY_PATH;
> > > > > +
> > > > > +	error = file_getattr(fd, path, &fsx, fa_size,
> > > > > +			at_flags);
> > > > > +	if (error) {
> > > > > +		fprintf(stderr, "Can not get fsxattr on %s: %s\n", path,
> > > > > +				strerror(errno));
> > > > > +		return error;
> > > > > +	}
> > > > 
> > > > We should have a _require_* helper to _notrun your generic and xfs test cases,
> > > > when system doesn't support the file_getattr/setattr feature. Or we always hit
> > > > something test errors like below on old system:
> > > > 
> > > >   +Can not get fsxattr on ./fifo: Operation not supported
> > > > 
> > > > Maybe check if the errno is "Operation not supported", or any better idea?
> > > 
> > > There's build system check for file_getattr/setattr syscalls, so if
> > > they aren't in the kernel file_attr will not compile.
> > > 
> > > Then there's _require_test_program "file_attr" in the tests, so
> > > these will not run if kernel doesn't have these syscalls.
> > > 
> > > However, for XFS for example, there's [1] and [2] which are
> > > necessary for these tests to pass. 
> > > 
> > > So, there a few v6.17 kernels which would still run these tests but
> > > fail for XFS (and still fails as these commits are in for-next now).
> > > 
> > > For other filesystems generic/ will also fail on newer kernels as it
> > > requires similar modifications as in XFS to support changing file
> > > attributes on special files.
> > > 
> > > I suppose it make sense for this test to fail for other fs which
> > > don't implement changing file attributes on special files.
> > > Otherwise, this test could be split into generic/ (file_get/setattr
> > > on regular files) and xfs/ (file_get/setattr on special files).
> > > 
> > > What do you think?
> > 
> > generic/772 (and xfs/648) probably each ought to be split into two
> > pieces -- one for testing file_[gs]etattr on regular/directory files;
> > and a second one for the special files.  All four of them ought to
> > _notrun if the kernel doesn't support the intended target.
> 
> I see, yeah that's what I thought of, I will split them and send new
> patchset soon

This patchset has been merged, as the feature has been merged, so let's
have the coverage at first. Please feel free to change the cases base on
the newest for-next branch.

> 
> > 
> > Right now I have injected into both:
> > 
> > mkfifo $projectdir/fifo
> > 
> > $here/src/file_attr --get $projectdir ./fifo &>/dev/null || \
> > 	_notrun "file_getattr not supported on $FSTYP"
> 
> Thanks! Looks like a good check to use

Yes, use you src/file_attr program in the _require_ helper, refer to
_require_idmapped_mounts or _require_seek_data_hole or others.

Thanks,
Zorro

> 
> > 
> > to make the failures go away on 6.17.
> > 
> > --D
> > 
> > > [1]: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=for-next&id=8a221004fe5288b66503699a329a6b623be13f91
> > > [2]: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=for-next&id=0239bd9fa445a21def88f7e76fe6e0414b2a4da0
> > > 
> > > > 
> > > > 
> > > > Thanks,
> > > > Zorro
> > > > 
> > > > > +	if (action) {
> > > > > +		fsx.fa_xflags |= (fa_xflags | unknwon_fa_flag);
> > > > > +
> > > > > +		error = file_setattr(fd, path, &fsx, fa_size,
> > > > > +				at_flags);
> > > > > +		if (error) {
> > > > > +			fprintf(stderr, "Can not set fsxattr on %s: %s\n", path,
> > > > > +					strerror(errno));
> > > > > +			return error;
> > > > > +		}
> > > > > +	} else {
> > > > > +		if (path2)
> > > > > +			print_xflags(fsx.fa_xflags, 0, 1, path, 0, 1);
> > > > > +		else
> > > > > +			print_xflags(fsx.fa_xflags, 0, 1, path1, 0, 1);
> > > > > +	}
> > > > > +
> > > > > +	return error;
> > > > > +
> > > > > +usage:
> > > > > +	printf("Usage: %s [options]\n", argv[0]);
> > > > > +	printf("Options:\n");
> > > > > +	printf("\t--get, -g\t\tget filesystem inode attributes\n");
> > > > > +	printf("\t--set, -s\t\tset filesystem inode attributes\n");
> > > > > +	printf("\t--at-cwd, -a\t\topen file at current working directory\n");
> > > > > +	printf("\t--no-follow, -n\t\tdon't follow symlinks\n");
> > > > > +	printf("\t--set-nodump, -d\t\tset FS_XFLAG_NODUMP on an inode\n");
> > > > > +	printf("\t--invalid-at, -i\t\tUse invalid AT_* flag\n");
> > > > > +	printf("\t--too-big-arg, -b\t\tSet fsxattr size bigger than PAGE_SIZE\n");
> > > > > +	printf("\t--too-small-arg, -m\t\tSet fsxattr size to 19 bytes\n");
> > > > > +	printf("\t--new-fsx-flag, -x\t\tUse unknown fa_flags flag\n");
> > > > > +
> > > > > +	return 1;
> > > > > +}
> > > > > 
> > > > > -- 
> > > > > 2.50.1
> > > > > 
> > > > 
> > > 
> > > -- 
> > > - Andrey
> > > 
> > > 
> > 
> 
> -- 
> - Andrey
> 


