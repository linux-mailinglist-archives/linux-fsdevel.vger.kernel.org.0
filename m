Return-Path: <linux-fsdevel+bounces-49819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EE7AC33FA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 12:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4DDB7A77C1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 10:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B741E7C19;
	Sun, 25 May 2025 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVF7HtZG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E860B72605
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748170158; cv=none; b=o4t3/pRVdAybPeY85YHp5VBfSSjROp65AGUrrcCtmZk1LX6mGGj+/dJeM5YXpU0mB37kH2aQdTyw3pY43MlfORyNce5AQEILj1yno1qN/VcPwrHOiLIC3RxItYeNnRaOaylXNmSI7g5vnymHPCzpRHbBcL6iZQXD1pMDNuR18p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748170158; c=relaxed/simple;
	bh=fMsTsxceWIDjEEE58Qlav+biEOWyWAU3VNkqKqtOcEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnH5Hw9DhfDzSwE87w6r0lIdmchE6lNmSWEGHtYbz9ldUFIcJ1FYjqsWWojRp9B8JidAbNQI8jdA5RREYGAn7GVJG/eEhqVyztWF+yM6u/oV7JlYlcBJHz0KYbh3KGfx5ROyVxXtxCUAPyUCZzBDAMR6gwzbRpv2QQprJEEmjdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hVF7HtZG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748170154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CJ84WdnaKTRXymPrxlPombcUu50o2LKGI0cBQfuNosc=;
	b=hVF7HtZGBo8AsIgTLjg5Xi83YPmVtDkLM3ZMk0Xt7SB4oN0bxU7eoWfi2zzf0n+OgXdMi9
	rE2NFNuiqSkmS/kVBZcslbkxXCB//2XFRZc3xOX0bcVTJSqMZ4EV8sR1fzhgmTYJO5ravX
	MsInntIK4riBPYVpi71qRTZ3HSqCb6Y=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-4RIa0DoKO_KqjV1EWW_y1Q-1; Sun, 25 May 2025 06:49:13 -0400
X-MC-Unique: 4RIa0DoKO_KqjV1EWW_y1Q-1
X-Mimecast-MFC-AGG-ID: 4RIa0DoKO_KqjV1EWW_y1Q_1748170152
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23425b537aeso5622615ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 03:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748170152; x=1748774952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJ84WdnaKTRXymPrxlPombcUu50o2LKGI0cBQfuNosc=;
        b=KCWvxfBasGCUKh5UXmL3AnMfqS4cpd9zxcYsoolNcVJIaSeejJxCYDkDf2+KAxioZr
         Bi+BNSS69SWTDTTCjtcWO1dJRDezpA/AR3BL1u89n3TKmn00DL97tl+oypiaxCMnDhHp
         SCMxd2CWFYm0zZrAHkVYHmEt0DZVV3sP79AHqElrXSQBgWMtl4nxNO9i45cTMN22GHjt
         7xvjUYnEQKLEqXjy6lMU5bUUgSsua2XQFxHDo7eWo1nVwZh0PVnlXfiDSH9WNA5XP3As
         XNytd6BaYSq0OEa0MKKC+2wkjQq+cVgPY4/R72ofYGh7JHIMdxOwL66dLRNxLNujjNCo
         2RFA==
X-Forwarded-Encrypted: i=1; AJvYcCVndRcFOi8U+ATY9N39Qkulpw5lPvsdg1jd1URUTwrWOmopok3SuFJ4PY1WFV3VugcaKl60V0WE2RkmTE3G@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8OKyYYBullqLMjuc3TeHZIWrONcCdt7MP7q/L3c40vQYkTVb9
	QMHZyiSsGPJWOAlT39aEOJ+UOnbA7z5Ap5LVNY/9vGPD3j1CXZ1A/W59+HvC65iGwTA3jY3xAoC
	wdtRsYG4fgTDSl0b1pCt96Yc50grl16HivbW8FydYZHGgTTEA6FijjP3l1wG/4j8SpwLRA87KqD
	I=
X-Gm-Gg: ASbGncvm0+ZMp5cvL0NZZ3cxQF4WXo2EmcMT1v+Uj1iNPZeIEVGKw2+xLoOI+TPNsar
	EVywbv6+lYhu3hyEqyYy6MYya6zYrRRSkADSt2bkRSnlCRzNaz3AB6D683bJ4KahJrzIW178FH0
	59+F7NJGIDBCUUm7AteLAGc4NLhfTSTmYOyR2Qt+4EnUZsXBTZmMramRJWVcsR2vd8ldWgFC6wm
	87XEAQaTcPoiICWniQkt9m9EVGZYmcOPP/KBqCW8HKr1DSjNASiIq9hzy8rqw3nDGv4tvNyDJhS
	noRBDouoSOvPRPTNJ7qO8PH2tfUWWwLihW037cUJ5x5mcaX6KusL
X-Received: by 2002:a17:902:e842:b0:22e:4a2e:8ae7 with SMTP id d9443c01a7336-23414f7d0ebmr98264765ad.22.1748170152100;
        Sun, 25 May 2025 03:49:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl/Vkjp7o36RBv/+MAmji1bFdSLGDh1AjMCmwCZ3Ds2i38mppqlK9uoC6KU9I6m5KbPBo5Ig==
X-Received: by 2002:a17:902:e842:b0:22e:4a2e:8ae7 with SMTP id d9443c01a7336-23414f7d0ebmr98264595ad.22.1748170151739;
        Sun, 25 May 2025 03:49:11 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2340c505ec8sm28282405ad.109.2025.05.25.03.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 03:49:11 -0700 (PDT)
Date: Sun, 25 May 2025 18:49:06 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] open_by_handle: add support for testing
 connectable file handles
Message-ID: <20250525104906.fnsphgcjvlzcl23z@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250509170033.538130-1-amir73il@gmail.com>
 <20250509170033.538130-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509170033.538130-2-amir73il@gmail.com>

On Fri, May 09, 2025 at 07:00:32PM +0200, Amir Goldstein wrote:
> Test for kernel and filesystem support for conenctable file handles.
> 
> With -N flag, encode connectable file handles and fail the test if the
> kernel or filesystem do not support conenctable file handles.
> 
> Verify that decoding connectable file handles always results in a non
> empty path of the fd.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc            | 16 ++++++++++---
>  src/open_by_handle.c | 53 ++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 57 insertions(+), 12 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 6592c835..6407b744 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3829,8 +3829,14 @@ _require_freeze()
>  }
>  
>  # Does NFS export work on this fs?
> -_require_exportfs()
> +_require_open_by_handle()
>  {
> +	local what="NFS export"
> +	local opts="$1"
> +	if [ "$1" == "-N" ]; then
> +		what="connectable file handles"
> +	fi
> +
>  	_require_test_program "open_by_handle"
>  
>  	# virtiofs doesn't support open_by_handle_at(2) yet, though the syscall
> @@ -3841,10 +3847,14 @@ _require_exportfs()
>  		_notrun "$FSTYP doesn't support open_by_handle_at(2)"
>  
>  	mkdir -p "$TEST_DIR"/exportfs_test
> -	$here/src/open_by_handle -c "$TEST_DIR"/exportfs_test 2>&1 \
> -		|| _notrun "$FSTYP does not support NFS export"
> +	$here/src/open_by_handle $opts -c "$TEST_DIR"/exportfs_test 2>&1 \
> +		|| _notrun "$FSTYP does not support $what"
>  }
>  
> +_require_exportfs()
> +{
> +	_require_open_by_handle
> +}
>  
>  # Does shutdown work on this fs?
>  _require_scratch_shutdown()
> diff --git a/src/open_by_handle.c b/src/open_by_handle.c
> index a99cce4b..7b664201 100644
> --- a/src/open_by_handle.c
> +++ b/src/open_by_handle.c
> @@ -96,6 +96,9 @@ Examples:
>  #ifndef AT_HANDLE_MNT_ID_UNIQUE
>  #	define AT_HANDLE_MNT_ID_UNIQUE 0x001
>  #endif
> +#ifndef AT_HANDLE_CONNECTABLE
> +#	define AT_HANDLE_CONNECTABLE   0x002
> +#endif
>  
>  #define MAXFILES 1024
>  
> @@ -121,6 +124,7 @@ void usage(void)
>  	fprintf(stderr, "open_by_handle -d <test_dir> [N] - unlink test files and hardlinks, drop caches and try to open by handle\n");
>  	fprintf(stderr, "open_by_handle -m <test_dir> [N] - rename test files, drop caches and try to open by handle\n");
>  	fprintf(stderr, "open_by_handle -M <test_dir> [N] - do not silently skip the mount ID verifications\n");
> +	fprintf(stderr, "open_by_handle -N <test_dir> [N] - encode connectable file handles\n");
>  	fprintf(stderr, "open_by_handle -p <test_dir>     - create/delete and try to open by handle also test_dir itself\n");
>  	fprintf(stderr, "open_by_handle -i <handles_file> <test_dir> [N] - read test files handles from file and try to open by handle\n");
>  	fprintf(stderr, "open_by_handle -o <handles_file> <test_dir> [N] - get file handles of test files and write handles to file\n");
> @@ -130,14 +134,16 @@ void usage(void)
>  	fprintf(stderr, "open_by_handle -C <feature>      - check if <feature> is supported by the kernel.\n");
>  	fprintf(stderr, "  <feature> can be any of the following values:\n");
>  	fprintf(stderr, "  - AT_HANDLE_MNT_ID_UNIQUE\n");
> +	fprintf(stderr, "  - AT_HANDLE_CONNECTABLE\n");
>  	exit(EXIT_FAILURE);
>  }
>  
> -static int do_name_to_handle_at(const char *fname, struct file_handle *fh,
> -				int bufsz, bool force_check_mountid)
> +static int do_name_to_handle_at(const char *fname, struct file_handle *fh, int bufsz,
> +				bool force_check_mountid, bool connectable)
>  {
>  	int ret;
>  	int mntid_short;
> +	int at_flags;
>  
>  	static bool skip_mntid, skip_mntid_unique;
>  
> @@ -181,18 +187,24 @@ static int do_name_to_handle_at(const char *fname, struct file_handle *fh,
>  		}
>  	}
>  
> +	at_flags = connectable ? AT_HANDLE_CONNECTABLE : 0;
>  	fh->handle_bytes = bufsz;
> -	ret = name_to_handle_at(AT_FDCWD, fname, fh, &mntid_short, 0);
> +	ret = name_to_handle_at(AT_FDCWD, fname, fh, &mntid_short, at_flags);
>  	if (bufsz < fh->handle_bytes) {
>  		/* Query the filesystem required bufsz and the file handle */
>  		if (ret != -1 || errno != EOVERFLOW) {
>  			fprintf(stderr, "%s: unexpected result from name_to_handle_at: %d (%m)\n", fname, ret);
>  			return EXIT_FAILURE;
>  		}
> -		ret = name_to_handle_at(AT_FDCWD, fname, fh, &mntid_short, 0);
> +		ret = name_to_handle_at(AT_FDCWD, fname, fh, &mntid_short, at_flags);
>  	}
>  	if (ret < 0) {
> -		fprintf(stderr, "%s: name_to_handle: %m\n", fname);
> +		/* No filesystem support for encoding connectable file handles (e.g. overlayfs)? */
> +		if (connectable)
> +			fprintf(stderr, "%s: name_to_handle_at(AT_HANDLE_CONNECTABLE) not supported by %s\n",
> +					fname, errno == EINVAL ? "kernel" : "filesystem");
> +		else
> +			fprintf(stderr, "%s: name_to_handle: %m\n", fname);
>  		return EXIT_FAILURE;
>  	}
>  
> @@ -245,8 +257,17 @@ static int check_feature(const char *feature)
>  			return EXIT_FAILURE;
>  		}
>  		return 0;
> +	} else if (!strcmp(feature, "AT_HANDLE_CONNECTABLE")) {
> +		int ret = name_to_handle_at(AT_FDCWD, ".", NULL, NULL, AT_HANDLE_CONNECTABLE);
> +		/* If AT_HANDLE_CONNECTABLE is supported, we get EFAULT. */
> +		if (ret < 0 && errno == EINVAL) {
> +			fprintf(stderr, "name_to_handle_at(AT_HANDLE_CONNECTABLE) not supported by running kernel\n");
> +			return EXIT_FAILURE;
> +		}
> +		return 0;
>  	}
>  
> +
>  	fprintf(stderr, "unknown feature name '%s'\n", feature);
>  	return EXIT_FAILURE;
>  }
> @@ -270,13 +291,13 @@ int main(int argc, char **argv)
>  	int	create = 0, delete = 0, nlink = 1, move = 0;
>  	int	rd = 0, wr = 0, wrafter = 0, parent = 0;
>  	int	keepopen = 0, drop_caches = 1, sleep_loop = 0;
> -	int	force_check_mountid = 0;
> +	bool	force_check_mountid = 0, connectable = 0;
>  	int	bufsz = MAX_HANDLE_SZ;
>  
>  	if (argc < 2)
>  		usage();
>  
> -	while ((c = getopt(argc, argv, "cC:ludmMrwapknhi:o:sz")) != -1) {
> +	while ((c = getopt(argc, argv, "cC:ludmMNrwapknhi:o:sz")) != -1) {
>  		switch (c) {
>  		case 'c':
>  			create = 1;
> @@ -313,6 +334,9 @@ int main(int argc, char **argv)
>  		case 'M':
>  			force_check_mountid = 1;
>  			break;
> +		case 'N':
> +			connectable = 1;
> +			break;
>  		case 'p':
>  			parent = 1;
>  			break;
> @@ -445,7 +469,8 @@ int main(int argc, char **argv)
>  				return EXIT_FAILURE;
>  			}
>  		} else {
> -			ret = do_name_to_handle_at(fname, &handle[i].fh, bufsz, force_check_mountid);
> +			ret = do_name_to_handle_at(fname, &handle[i].fh, bufsz,
> +						   force_check_mountid, connectable);
>  			if (ret)
>  				return EXIT_FAILURE;
>  		}
> @@ -475,7 +500,8 @@ int main(int argc, char **argv)
>  				return EXIT_FAILURE;
>  			}
>  		} else {
> -			ret = do_name_to_handle_at(test_dir, &dir_handle.fh, bufsz, force_check_mountid);
> +			ret = do_name_to_handle_at(test_dir, &dir_handle.fh, bufsz,
> +						   force_check_mountid, connectable);
>  			if (ret)
>  				return EXIT_FAILURE;
>  		}
> @@ -589,6 +615,15 @@ int main(int argc, char **argv)
>  		errno = 0;
>  		fd = open_by_handle_at(mount_fd, &handle[i].fh, wrafter ? O_RDWR : O_RDONLY);
>  		if ((nlink || keepopen) && fd >= 0) {
> +			char linkname[PATH_MAX];
> +			char procname[64];
> +			sprintf(procname, "/proc/self/fd/%i", fd);
> +			int n = readlink(procname, linkname, PATH_MAX);
> +
> +			/* check that fd is "connected" - that is has a non empty path */
> +			if (connectable && n <= 1) {
> +				printf("open_by_handle(%s) returned a disconnected fd!\n", fname);
> +			}
>  			if (rd) {
>  				char buf[4] = {0};
>  				int size = read(fd, buf, 4);
> -- 
> 2.34.1
> 


