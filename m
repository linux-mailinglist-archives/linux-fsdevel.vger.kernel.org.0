Return-Path: <linux-fsdevel+bounces-63442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D10BB9586
	for <lists+linux-fsdevel@lfdr.de>; Sun, 05 Oct 2025 12:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E2D1896836
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Oct 2025 10:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D4B26C3AE;
	Sun,  5 Oct 2025 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUN9Anrr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FFE1AF0BB
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Oct 2025 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759660627; cv=none; b=NOiO3mniNtvY9pmkkx4Tqmygpr3p0W+f1txOMpU/ZO52mf8dSTpcrlcrp9SHUnkNT/T7Fc9S9Jg7rM2NfK4K9ZWZypgJfRmrpY2nilQruodcqF+zN4NFNuvjwEXeSwKN80WP/Q0aoTxr8xJRhEz7JbTacvwIQAn+CWiX1sf8nUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759660627; c=relaxed/simple;
	bh=6LIHPOQPLDWrr6EbSN7wwdKPe2nDjZ08h3rW+KOWZrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgOC05PVvbX1kjccRwV96tAL9/ICCnXpit56KEpZlge5/DnfVmscu8iN5kZO7zoO8IMjc3SgMGKcwVBmM/xpCnwKMenTxUt4yIH/QF+xyUvS8NvCrGoJLrGKFsADEA3pS7fD1XbCRTS8oLqRoyrisMqNRNZYswmiO33B7hffWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gUN9Anrr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759660624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXE+Do4eiYEQpRMZRWtP81SSjx9Cj+R+tBIOazUtRqs=;
	b=gUN9Anrr0iQVvomA4xAn4cpGcv3Kh/0Y/0KXb5L2D47t9JroSbVzWxpC6u+gxd1rOdJaUQ
	0UH7c50Paxe9zSmPYyv3vxX6lQFGeXS8si1wI8uUtaE+z0mu4dB60EafILqPLtptc07goc
	wWfT60ILpIXaTiokwSL3p4PYC/hjV90=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-j_1HaTPIPr2z02qOsrRCqQ-1; Sun, 05 Oct 2025 06:37:03 -0400
X-MC-Unique: j_1HaTPIPr2z02qOsrRCqQ-1
X-Mimecast-MFC-AGG-ID: j_1HaTPIPr2z02qOsrRCqQ_1759660622
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32ec67fcb88so3074335a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Oct 2025 03:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759660622; x=1760265422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXE+Do4eiYEQpRMZRWtP81SSjx9Cj+R+tBIOazUtRqs=;
        b=fe/2E8fq5pVQ+4TnuWjPLGx8k5xn4BXLMXuWU3+1q5nO/DcSSgFhB+OZv1xMsfQqiQ
         /raPJ5Cg3y9KhZ6qb4hxe7oOmCxeyKiGIWo5FsbrASkeFOu76QSZnr1KkOX8UsdTK0Jb
         h5cZcHjhE/TCia2bLGv++B5DUk2F8wQw4C8GqmsR1woByaDgxn+Ok9/I9xbXePWI6j0Q
         bVse4Gf+e3hDpjNGDgmGhrrq9+xjYHTQoLoqvGCqAEClkKlHuK+EgwhnC55eXWyVAaos
         lmDy13XSqeVWffSz7vCCFnk08xIJJY0rNWzpckfxfQI9XlFjLV/PjzsjNMviiVAhKUTX
         6ISg==
X-Forwarded-Encrypted: i=1; AJvYcCXF2VUJYw5teDV+yVwFz6h596o+IHWs5DVJ3OoKAKi3f5R+LoIb7vjEM4a73pW+hV7Cbn/JqSYaBRDXG9bP@vger.kernel.org
X-Gm-Message-State: AOJu0YxKy1G387rkcCBGmloSkNWI/jQgaNs3j1kpve/kU5DhtbwZ8J0i
	0JGNBcYZ/Xk4PTPw1Ti6eKdVGyGdkh6ChmpoytRQcxSbruUzFinf2yG/4fQZV4OYDJSvN4Go8Db
	rEdL/E9i4A6ZXcrnq3P1Ponq8KxXdgUJ7NIcjqgnfsK9b6EmCEEtz9BL7Kj69cS2VLAV2pLrPvr
	s=
X-Gm-Gg: ASbGncs/1pLJTnX1qZbXwdURoYMZl3k5xTEWVXsaKau26Cyjpnz2yNOipzkHXKSXLxv
	p4ZeYDo/pjuhRpo8qeBWrcGNcPqhjY4tj3bM8nsTaxyEliHxY936VeoQrM88IV0t6qPMzz+fILE
	f2O3HLYLRhx7pT6PzSm0whmGv0X7NVQIXl99IAL4+BqpZca8aKV8kt2xk90GXODv0Jh9ZCrQ1kb
	T0fpa+EzSlyqMUhiftbPO/lIeXy/8sTM7fmWdLe0fV4BNmhkeP+Kdm24GpCtBjTSQIlioLXrSuL
	MBFVzOUgZD4LwfPe7l5+xthm+e/W64uhTBo94rV+VFCuCpTFd/jtaIE7nyJxyMlXxCU/NL11B6c
	Yj1rK2+mHvw==
X-Received: by 2002:a17:90b:1b48:b0:327:ba77:a47 with SMTP id 98e67ed59e1d1-339c2782afbmr12219252a91.15.1759660621775;
        Sun, 05 Oct 2025 03:37:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm83AyjS7X4hJtAl1cFaaDJwlNM/NB1MMUPpV8cEk9b8Sb3eLjy4T+3C65MTyp4EHmOdh1hA==
X-Received: by 2002:a17:90b:1b48:b0:327:ba77:a47 with SMTP id 98e67ed59e1d1-339c2782afbmr12219225a91.15.1759660621290;
        Sun, 05 Oct 2025 03:37:01 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099d4d324sm9665636a12.27.2025.10.05.03.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 03:37:00 -0700 (PDT)
Date: Sun, 5 Oct 2025 18:36:56 +0800
From: Zorro Lang <zlang@redhat.com>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v4 1/3] file_attr: introduce program to set/get fsxattr
Message-ID: <20251005103656.5qu3lmjvlcjkwjx4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251003-xattrat-syscall-v4-0-1cfe6411c05f@kernel.org>
 <20251003-xattrat-syscall-v4-1-1cfe6411c05f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003-xattrat-syscall-v4-1-1cfe6411c05f@kernel.org>

On Fri, Oct 03, 2025 at 11:32:44AM +0200, Andrey Albershteyn wrote:
> This programs uses newly introduced file_getattr and file_setattr
> syscalls. This program is partially a test of invalid options. This will
> be used further in the test.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---

[snap]

> +	if (!path1 && optind < argc)
> +		path1 = argv[optind++];
> +	if (!path2 && optind < argc)
> +		path2 = argv[optind++];
> +
> +	if (at_fdcwd) {
> +		fd = AT_FDCWD;
> +		path = path1;
> +	} else if (!path2) {
> +		error = stat(path1, &status);
> +		if (error) {
> +			fprintf(stderr,
> +"Can not get file status of %s: %s\n", path1, strerror(errno));
> +			return error;
> +		}
> +
> +		if (SPECIAL_FILE(status.st_mode)) {
> +			fprintf(stderr,
> +"Can not open special file %s without parent dir: %s\n", path1, strerror(errno));
> +			return errno;
> +		}
> +
> +		fd = open(path1, O_RDONLY);
> +		if (fd == -1) {
> +			fprintf(stderr, "Can not open %s: %s\n", path1,
> +					strerror(errno));
> +			return errno;
> +		}
> +	} else {
> +		fd = open(path1, O_RDONLY);
> +		if (fd == -1) {
> +			fprintf(stderr, "Can not open %s: %s\n", path1,
> +					strerror(errno));
> +			return errno;
> +		}
> +		path = path2;
> +	}
> +
> +	if (!path)
> +		at_flags |= AT_EMPTY_PATH;
> +
> +	error = file_getattr(fd, path, &fsx, fa_size,
> +			at_flags);
> +	if (error) {
> +		fprintf(stderr, "Can not get fsxattr on %s: %s\n", path,
> +				strerror(errno));
> +		return error;
> +	}

We should have a _require_* helper to _notrun your generic and xfs test cases,
when system doesn't support the file_getattr/setattr feature. Or we always hit
something test errors like below on old system:

  +Can not get fsxattr on ./fifo: Operation not supported

Maybe check if the errno is "Operation not supported", or any better idea?


Thanks,
Zorro

> +	if (action) {
> +		fsx.fa_xflags |= (fa_xflags | unknwon_fa_flag);
> +
> +		error = file_setattr(fd, path, &fsx, fa_size,
> +				at_flags);
> +		if (error) {
> +			fprintf(stderr, "Can not set fsxattr on %s: %s\n", path,
> +					strerror(errno));
> +			return error;
> +		}
> +	} else {
> +		if (path2)
> +			print_xflags(fsx.fa_xflags, 0, 1, path, 0, 1);
> +		else
> +			print_xflags(fsx.fa_xflags, 0, 1, path1, 0, 1);
> +	}
> +
> +	return error;
> +
> +usage:
> +	printf("Usage: %s [options]\n", argv[0]);
> +	printf("Options:\n");
> +	printf("\t--get, -g\t\tget filesystem inode attributes\n");
> +	printf("\t--set, -s\t\tset filesystem inode attributes\n");
> +	printf("\t--at-cwd, -a\t\topen file at current working directory\n");
> +	printf("\t--no-follow, -n\t\tdon't follow symlinks\n");
> +	printf("\t--set-nodump, -d\t\tset FS_XFLAG_NODUMP on an inode\n");
> +	printf("\t--invalid-at, -i\t\tUse invalid AT_* flag\n");
> +	printf("\t--too-big-arg, -b\t\tSet fsxattr size bigger than PAGE_SIZE\n");
> +	printf("\t--too-small-arg, -m\t\tSet fsxattr size to 19 bytes\n");
> +	printf("\t--new-fsx-flag, -x\t\tUse unknown fa_flags flag\n");
> +
> +	return 1;
> +}
> 
> -- 
> 2.50.1
> 


