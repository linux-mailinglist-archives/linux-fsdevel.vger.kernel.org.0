Return-Path: <linux-fsdevel+bounces-58400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A26E0B2E471
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 19:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4EEAA25CE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 17:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E941B272E43;
	Wed, 20 Aug 2025 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtLF7o4T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBDE25A352;
	Wed, 20 Aug 2025 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755712238; cv=none; b=XBqLSywySmwFLbqfECaC/iO7vN6LUjAG+5bsnXZ/NjJI8mIWXpT1oVMeakDZjBRWxJ6XW8Wq2nhezBKVT5yGTZiBTKK95gneYx8B8DAUAGj8LXkQ+DhvkJTyqAWBl2So29bE2aCOCfRnX69m99AbNTT+cyH1EuEDgJS9hyVkjeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755712238; c=relaxed/simple;
	bh=WKGdVU7WkPGRn6n7Ocqx6xoiPc/q7PCmfXCFdh7Q86g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjtCFeIDNl1+VIw3ZKsRgHmOPfYteGe5ysfMD3fBnVQ69jes9MPVbmO7I0xm/dW7fPaqoU1w/TkBnCIPHyEMky/ND4X+McOlA2shRfQP+mkPz4mu3b7u+aDfyuI+OVaxe/8T71TjoLV0eNspsidF0QNykN+vlDBPeId30NDcnqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtLF7o4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3373C4CEE7;
	Wed, 20 Aug 2025 17:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755712237;
	bh=WKGdVU7WkPGRn6n7Ocqx6xoiPc/q7PCmfXCFdh7Q86g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JtLF7o4TD79tNlPUFPTyI9EfHMk1NzZ05ZM3oWrOCwq2b1WU7TOTFn97M3gTMZSDj
	 Fj4JAClIBRK75OBVY68pysedsYjgPY+41IN5EpNIECmBxFNlMbRgCllmTpLs+kjtAf
	 FNIrB8GvrMRTVEsjI2ozafuZIP0Tirse/3oOsBM9+uqk9nez/GF7v5Ri6sQeBrk6Q/
	 fXZwrNJZ1c8lw7VYKs8cd029TES4ET99Ly470cjXPxqlQ3QNsM2nwVeb++96UrreP9
	 Qb3aOdYuVyUkV1fCCSpBU0TdpLPQMys5IdaHwbYX65P4QFq5h/g4h5bx7vP7Hk6YmP
	 OudKDcUzpL57A==
Date: Wed, 20 Aug 2025 10:50:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	hch@lst.de, tytso@mit.edu, bmarzins@redhat.com,
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
	brauner@kernel.org, martin.petersen@oracle.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH util-linux v3] fallocate: add FALLOC_FL_WRITE_ZEROES
 support
Message-ID: <20250820175037.GN7981@frogsfrogsfrogs>
References: <20250820085632.1879239-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820085632.1879239-1-yi.zhang@huaweicloud.com>

On Wed, Aug 20, 2025 at 04:56:32PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The Linux kernel (since version 6.17) supports FALLOC_FL_WRITE_ZEROES in
> fallocate(2). Add support for FALLOC_FL_WRITE_ZEROES to the fallocate
> utility by introducing a new option -w|--write-zeroes.
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=278c7d9b5e0c
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
> v2->v3:
>  - Say less about what the filesystem actually implements as Darrick
>    suggested and clarify the reason why "--keep-size" cannot be used
>    together in the man page.
>  - Modify the verbose output message.
> v1->v2:
>  - Minor description modification to align with the kernel.
> 
>  sys-utils/fallocate.1.adoc | 11 +++++++++--
>  sys-utils/fallocate.c      | 20 ++++++++++++++++----
>  2 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/sys-utils/fallocate.1.adoc b/sys-utils/fallocate.1.adoc
> index 44ee0ef4c..a06cf7a50 100644
> --- a/sys-utils/fallocate.1.adoc
> +++ b/sys-utils/fallocate.1.adoc
> @@ -12,7 +12,7 @@ fallocate - preallocate or deallocate space to a file
>  
>  == SYNOPSIS
>  
> -*fallocate* [*-c*|*-p*|*-z*] [*-o* _offset_] *-l* _length_ [*-n*] _filename_
> +*fallocate* [*-c*|*-p*|*-z*|*-w*] [*-o* _offset_] *-l* _length_ [*-n*] _filename_
>  
>  *fallocate* *-d* [*-o* _offset_] [*-l* _length_] _filename_
>  
> @@ -28,7 +28,7 @@ The exit status returned by *fallocate* is 0 on success and 1 on failure.
>  
>  The _length_ and _offset_ arguments may be followed by the multiplicative suffixes KiB (=1024), MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB, and YiB (the "iB" is optional, e.g., "K" has the same meaning as "KiB") or the suffixes KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB, and YB.
>  
> -The options *--collapse-range*, *--dig-holes*, *--punch-hole*, *--zero-range* and *--posix* are mutually exclusive.
> +The options *--collapse-range*, *--dig-holes*, *--punch-hole*, *--zero-range*, *--write-zeroes* and *--posix* are mutually exclusive.
>  
>  *-c*, *--collapse-range*::
>  Removes a byte range from a file, without leaving a hole. The byte range to be collapsed starts at _offset_ and continues for _length_ bytes. At the completion of the operation, the contents of the file starting at the location __offset__+_length_ will be appended at the location _offset_, and the file will be _length_ bytes smaller. The option *--keep-size* may not be specified for the collapse-range operation.
> @@ -76,6 +76,13 @@ Option *--keep-size* can be specified to prevent file length modification.
>  +
>  Available since Linux 3.14 for ext4 (only for extent-based files) and XFS.
>  
> +*-w*, *--write-zeroes*::
> +Zeroes space in the byte range starting at _offset_ and continuing for _length_ bytes. Within the specified range, written blocks are preallocated for the regions that span the holes in the file. After a successful call, subsequent reads from this range will return zeroes and subsequent writes to that range do not require further changes to the file mapping metadata.
> ++
> +Zeroing is done within the filesystem. The filesystem may use a hardware-accelerated zeroing command or may submit regular writes. The behavior depends on the filesystem design and the available hardware.
> ++
> +Options *--keep-size* can not be specified for the write-zeroes operation because allocating written blocks beyond the inode size is not permitted.

Nit: s/can not/cannot/

With that fixed, this looks fine to me, so
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +
>  include::man-common/help-version.adoc[]
>  
>  == AUTHORS
> diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
> index 13bf52915..afd615537 100644
> --- a/sys-utils/fallocate.c
> +++ b/sys-utils/fallocate.c
> @@ -40,7 +40,7 @@
>  #if defined(HAVE_LINUX_FALLOC_H) && \
>      (!defined(FALLOC_FL_KEEP_SIZE) || !defined(FALLOC_FL_PUNCH_HOLE) || \
>       !defined(FALLOC_FL_COLLAPSE_RANGE) || !defined(FALLOC_FL_ZERO_RANGE) || \
> -     !defined(FALLOC_FL_INSERT_RANGE))
> +     !defined(FALLOC_FL_INSERT_RANGE) || !defined(FALLOC_FL_WRITE_ZEROES))
>  # include <linux/falloc.h>	/* non-libc fallback for FALLOC_FL_* flags */
>  #endif
>  
> @@ -65,6 +65,10 @@
>  # define FALLOC_FL_INSERT_RANGE		0x20
>  #endif
>  
> +#ifndef FALLOC_FL_WRITE_ZEROES
> +# define FALLOC_FL_WRITE_ZEROES		0x80
> +#endif
> +
>  #include "nls.h"
>  #include "strutils.h"
>  #include "c.h"
> @@ -94,6 +98,7 @@ static void __attribute__((__noreturn__)) usage(void)
>  	fputs(_(" -o, --offset <num>   offset for range operations, in bytes\n"), out);
>  	fputs(_(" -p, --punch-hole     replace a range with a hole (implies -n)\n"), out);
>  	fputs(_(" -z, --zero-range     zero and ensure allocation of a range\n"), out);
> +	fputs(_(" -w, --write-zeroes   write zeroes and ensure allocation of a range\n"), out);
>  #ifdef HAVE_POSIX_FALLOCATE
>  	fputs(_(" -x, --posix          use posix_fallocate(3) instead of fallocate(2)\n"), out);
>  #endif
> @@ -304,6 +309,7 @@ int main(int argc, char **argv)
>  	    { "dig-holes",      no_argument,       NULL, 'd' },
>  	    { "insert-range",   no_argument,       NULL, 'i' },
>  	    { "zero-range",     no_argument,       NULL, 'z' },
> +	    { "write-zeroes",   no_argument,       NULL, 'w' },
>  	    { "offset",         required_argument, NULL, 'o' },
>  	    { "length",         required_argument, NULL, 'l' },
>  	    { "posix",          no_argument,       NULL, 'x' },
> @@ -312,8 +318,8 @@ int main(int argc, char **argv)
>  	};
>  
>  	static const ul_excl_t excl[] = {	/* rows and cols in ASCII order */
> -		{ 'c', 'd', 'i', 'p', 'x', 'z'},
> -		{ 'c', 'i', 'n', 'x' },
> +		{ 'c', 'd', 'i', 'p', 'w', 'x', 'z'},
> +		{ 'c', 'i', 'n', 'w', 'x' },
>  		{ 0 }
>  	};
>  	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
> @@ -323,7 +329,7 @@ int main(int argc, char **argv)
>  	textdomain(PACKAGE);
>  	close_stdout_atexit();
>  
> -	while ((c = getopt_long(argc, argv, "hvVncpdizxl:o:", longopts, NULL))
> +	while ((c = getopt_long(argc, argv, "hvVncpdizwxl:o:", longopts, NULL))
>  			!= -1) {
>  
>  		err_exclusive_options(c, longopts, excl, excl_st);
> @@ -353,6 +359,9 @@ int main(int argc, char **argv)
>  		case 'z':
>  			mode |= FALLOC_FL_ZERO_RANGE;
>  			break;
> +		case 'w':
> +			mode |= FALLOC_FL_WRITE_ZEROES;
> +			break;
>  		case 'x':
>  #ifdef HAVE_POSIX_FALLOCATE
>  			posix = 1;
> @@ -429,6 +438,9 @@ int main(int argc, char **argv)
>  			else if (mode & FALLOC_FL_ZERO_RANGE)
>  				fprintf(stdout, _("%s: %s (%ju bytes) zeroed.\n"),
>  								filename, str, length);
> +			else if (mode & FALLOC_FL_WRITE_ZEROES)
> +				fprintf(stdout, _("%s: %s (%ju bytes) written as zeroes.\n"),
> +								filename, str, length);
>  			else
>  				fprintf(stdout, _("%s: %s (%ju bytes) allocated.\n"),
>  								filename, str, length);
> -- 
> 2.39.2
> 

