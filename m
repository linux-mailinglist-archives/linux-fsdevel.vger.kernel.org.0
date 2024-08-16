Return-Path: <linux-fsdevel+bounces-26116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12519549F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 14:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE765B22420
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 12:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17A31B86C7;
	Fri, 16 Aug 2024 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrQnCd6X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EFB1AED29
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812970; cv=none; b=n+wsWUKqfbFLIUCzuZn3ohl10t/2UayA06dhyZ/+6zgBiXuhf7/qdExCPXi+HlhkqMunDPOQplMlh0+obVcLxLbmMb7c0CilisBPRoBWVu9aHvnh+K/KDtSqMQabfZPZGsWatcMsLPQgYAmxsYGnv/pSKWcMkcXRX8VEx1hw2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812970; c=relaxed/simple;
	bh=VQTi3TNqwWn161CVg6P5GMzZWWbNkUT7vFwTIJ1l09M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcvgvMj9hGW92zzLiZb2VuGgkiJJu/199cZOT4jl/cBiuifdcIoZTbk4APPEuv9AmAs8lP/runLUUwN4PAOznPJd9n0+td0exCPv4wYPNrebfvncmzq+rdIinepcHdqxChXRhZFS8BFH3gy18MWu7L/08yLZuT6aAHzEL0Us+xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LrQnCd6X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723812964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hx4kADNFpWzPmEqoY10EizQF72Ojbwj/HlT/y8nD2sU=;
	b=LrQnCd6X/OgRCVLYsgvIBMmPnZLvItCQ0VYG0bHlxmUtCbzM5XTR3zIz0RThFV1L4uLFnR
	puq92qSA5Q0uzHsGwq1IYJ5MLuJ04bEWLOTtbbuOxrFYoWxAw9UoDAnyzdC/WjMPHhOpuJ
	q4xiR9LYhcDat870PCkSiiPcDYmfFVo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-M6pJX_wkMgiqHaHVgZtWDA-1; Fri, 16 Aug 2024 08:56:02 -0400
X-MC-Unique: M6pJX_wkMgiqHaHVgZtWDA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1fda155bc43so14945545ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 05:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723812962; x=1724417762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hx4kADNFpWzPmEqoY10EizQF72Ojbwj/HlT/y8nD2sU=;
        b=wa4Pq7V2TZMfBcBMvFC8XYuoBSUDXiHD2FgV0hDYIzmNYxXP8E+na2DVvtQLluio8r
         vMK40nkN/N8/ihQg2W4FmqayXPYC8eTuk0G+PWyWN9pg9SSE+rIcV3e58gwVnPiOBCJs
         fhOF3ZgOdhnZqHDe8FpZomxhXkazM119HgyezRFCHlHIyYdNuBcbnnVqDLCFr9yuts6b
         BO1jtZwr2rL5V6K4AM2i9OwBmwHK6EG142ZEG/LXEEazenC88t0GZwiYml73MUaUQr7v
         /D/1g9cl2cEX7uZuClFefQ/v2DmRbE3XF344DSa7OBzERQdNeoMHJi8+mcELOkOW5rSx
         5vFw==
X-Forwarded-Encrypted: i=1; AJvYcCWpWPpK4E/TOkhPzMUigJk7fDPMqlincSVQm6bojFETWi1pqRdlXplkdK0YPcnmU4rOpJYMRnaFKz5JRhC38MBEYl+l7FY3lQeQD2t5zQ==
X-Gm-Message-State: AOJu0YyVrgGctQZtUA94f/ZlS0iYdyxTmi/X1+8Pq32w96VpjUoovVC8
	mFVMzNr6NaINkqLkzos13qoP31RS3NIyYhkV2HTqjn1yxBCiBtn5ZJsBWI1AIO0sg5x2+5946HP
	F/rUkijEvA5IWTulH1oyiRuUYdXIm23vlZXXiNHry5ukphPWPc0/o7+CwlC6U8yY=
X-Received: by 2002:a17:903:32d1:b0:1fc:57b7:995c with SMTP id d9443c01a7336-20203e47f2fmr30247695ad.7.1723812961723;
        Fri, 16 Aug 2024 05:56:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTugN4/5Umd8M3bK1ZSdFqkslcu6HCM8ql5XHhRWIw5ZVD1CwDn9NHp1/5y313wwsYTqtyeQ==
X-Received: by 2002:a17:903:32d1:b0:1fc:57b7:995c with SMTP id d9443c01a7336-20203e47f2fmr30247335ad.7.1723812961037;
        Fri, 16 Aug 2024 05:56:01 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038a779sm25061475ad.188.2024.08.16.05.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 05:56:00 -0700 (PDT)
Date: Fri, 16 Aug 2024 20:55:57 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH fstests] generic/755: test that inode's ctime is updated
 on unlink
Message-ID: <20240816125557.yu7664riqf4gvckl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240813-master-v1-1-862678cc4000@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813-master-v1-1-862678cc4000@kernel.org>

On Tue, Aug 13, 2024 at 02:21:08PM -0400, Jeff Layton wrote:

Hi Jeff :)

Any description about this case test for?

> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> HCH suggested I roll a fstest for this problem that I found in btrfs the
> other day. In principle, we probably could expand this to other dir
> operations and to check the parent timestamps, but having to do all that
> in C is a pain.  I didn't see a good way to use xfs_io for this,
> however.

Is there a kernel commit or patch link about the bug which you found?

> ---
>  src/Makefile          |  2 +-
>  src/unlink-ctime.c    | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/755     | 26 ++++++++++++++++++++++++++
>  tests/generic/755.out |  2 ++
>  4 files changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/src/Makefile b/src/Makefile
> index 9979613711c9..c71fa41e4668 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -34,7 +34,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
>  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
>  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
> -	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault
> +	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault unlink-ctime

The .gitignore need updating too.

>  
>  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>  	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> diff --git a/src/unlink-ctime.c b/src/unlink-ctime.c
> new file mode 100644
> index 000000000000..7661e340eaba
> --- /dev/null
> +++ b/src/unlink-ctime.c
> @@ -0,0 +1,50 @@
> +#define _GNU_SOURCE 1
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <sys/stat.h>
> +
> +int main(int argc, char **argv)
> +{
> +	int fd, ret;
> +	struct statx before, after;
> +
> +	if (argc < 2) {
> +		fprintf(stderr, "Must specify filename!\n");
> +		return 1;
> +	}
> +
> +	fd = open(argv[1], O_RDWR|O_CREAT, 0600);
> +	if (fd < 0) {
> +		perror("open");
> +		return 1;
> +	}
> +
> +	ret = statx(fd, "", AT_EMPTY_PATH, STATX_CTIME, &before);
> +	if (ret) {
> +		perror("statx");
> +		return 1;
> +	}
> +
> +	sleep(1);
> +
> +	ret = unlink(argv[1]);
> +	if (ret) {
> +		perror("unlink");
> +		return 1;
> +	}
> +
> +	ret = statx(fd, "", AT_EMPTY_PATH, STATX_CTIME, &after);

So you need to keep the "fd" after unlink. If so, there might not be a
way through xfs_io to do that.

> +	if (ret) {
> +		perror("statx");
> +		return 1;
> +	}
> +
> +	if (before.stx_ctime.tv_nsec == after.stx_ctime.tv_nsec &&
> +	    before.stx_ctime.tv_sec == after.stx_ctime.tv_sec) {
> +		printf("No change to ctime after unlink!\n");
> +		return 1;
> +	}
> +	return 0;
> +}
> diff --git a/tests/generic/755 b/tests/generic/755
> new file mode 100755
> index 000000000000..500c51f99630
> --- /dev/null
> +++ b/tests/generic/755
> @@ -0,0 +1,26 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024, Jeff Layton <jlayton@kernel.org>
> +#
> +# FS QA Test No. 755
> +#
> +# Create a file, stat it and then unlink it. Does the ctime of the
> +# target inode change?
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
                             ^^^^^^
                             unlink

> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/dmerror

Why dmerror and filter are needed? If not necessary, remove these
3 lines.

Others looks good to me.

Thanks,
Zorro

> +
> +_require_test
> +_require_test_program unlink-ctime
> +
> +testfile="$TEST_DIR/unlink-ctime.$$"
> +
> +$here/src/unlink-ctime $testfile
> +
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/generic/755.out b/tests/generic/755.out
> new file mode 100644
> index 000000000000..7c9ea51cd298
> --- /dev/null
> +++ b/tests/generic/755.out
> @@ -0,0 +1,2 @@
> +QA output created by 755
> +Silence is golden
> 
> ---
> base-commit: f5ada754d5838d29fd270257003d0d123a9d1cd2
> change-id: 20240813-master-e3b46de630bd
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
> 


