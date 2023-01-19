Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1746742A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 20:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjASTUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 14:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjASTUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:20:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C616C9AA91
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 11:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674155891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YATicmREZ+7hBulqV///P49Tpvz3JAexF3cwhSVqvZw=;
        b=MHrCPDsLX2ZKSgjz9V0iBHbLGJND3njQRNIbhGnY4iUBQi1tl/eF/ZXzvDB1myKNansTp2
        ykF5bxgk2Db2XUTTqn11jaa27YMoJHkzRTJcJ8v3wXPT+cUbetGYnfO5G68ld3r/1LmVGw
        CTvYfME5kfMscW59icgqFVK2kJzCHGc=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-325-82vwkGxINWaJ8obmQbBS1Q-1; Thu, 19 Jan 2023 14:18:09 -0500
X-MC-Unique: 82vwkGxINWaJ8obmQbBS1Q-1
Received: by mail-pg1-f198.google.com with SMTP id 193-20020a6305ca000000b004cece0d0d64so1436933pgf.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 11:18:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YATicmREZ+7hBulqV///P49Tpvz3JAexF3cwhSVqvZw=;
        b=IJziEmGh2UaEpDD1Vqwhe4CIknYjej6PqA5KLQ8GK0vYizhc8QW3Cb3bGJ/z3+y/VL
         47Gj1oFFeWbiJ9jT9hTr17F1SjwGWLwwnNmR99pwO1eRBMWvFtSwlMhRufPYkn3ikDaE
         mniGi55O5k2VbdRqo8u2zTjPs4bamz/DFzZLJ7/N+rNvMkGtYrt7LoFpBpaTYPsh6Cyn
         0nNiuYf3w6NBMrDW6VewZoynIvtnEATp7JDx5O+CqGIoenH20nk6DoXEbi8Dbrb6b+DC
         LH3arvMs3nnADCcGwshWkqbpwAtcSW3FIGLVAhKIKtLY1aryrrPyvuwnp1dQpmKHZEBe
         1W8A==
X-Gm-Message-State: AFqh2krC0+pOC1mrKhOGbU3GP7EqHXD0k/JnywiN/COKKjd8TTAcI0xN
        YBP2JJt/iKjKkVS7jdrn4JtPAv53hLqtua5fbgEF4euEmG6n+caK5X8r4RcOApCcOCgY5pzShi0
        m9GQI+o3kxKy7Rvxfc/iee3Gy+Q==
X-Received: by 2002:a17:902:cec7:b0:191:3993:801e with SMTP id d7-20020a170902cec700b001913993801emr16234561plg.56.1674155888731;
        Thu, 19 Jan 2023 11:18:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtBjGJF1dsMSWhoXTd7u+m08fWODNygWMruoC7vJ7fp/LBVk93THNTUFM1QgX08aQU2T2AadA==
X-Received: by 2002:a17:902:cec7:b0:191:3993:801e with SMTP id d7-20020a170902cec700b001913993801emr16234538plg.56.1674155888374;
        Thu, 19 Jan 2023 11:18:08 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j14-20020a170903024e00b0019101215f63sm25582375plh.93.2023.01.19.11.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 11:18:07 -0800 (PST)
Date:   Fri, 20 Jan 2023 03:18:03 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jakob Unterwurzacher <jakobunt@gmail.com>
Cc:     guaneryu@gmail.com, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH] xfstests: add fuse support
Message-ID: <20230119191803.uekrd4azayp35r2b@zlang-mailbox>
References: <20200217100800.GH2697@desktop>
 <20230104193932.984531-1-jakobunt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104193932.984531-1-jakobunt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 04, 2023 at 08:39:33PM +0100, Jakob Unterwurzacher wrote:
> From: Miklos Szeredi <miklos@szeredi.hu>
> 
> This allows using any fuse filesystem that can be mounted with
> 
>   mount -t fuse.$FUSE_SUBTYP ...
> 
> Changelog:
> 
> v2: Jan 3, 2022, Jakob Unterwurzacher
> * Rebased to master
> * Instructions updated
> ** To not fail with libfuse version mismatch on passthrough_ll exe
>    on Fedora
> ** To use sudo
> * Review comments from Eryu Guan addressed:
> ** Comment updated to mention fuse
> ** Renamed SUBTYP to FUSE_SUBTYP
> ** Removed $SCRATCH_MNT/bin/sh check before "rm -rf"
> ** _require_scratch_nocheck for fuse also checks for $SCRATCH_MNT
> ** _require_test for fuse also checks for $TEST_DIR
> 
> v1: Jan 8, 2020, Miklos Szeredi
> * Initial submission
> * https://patchwork.kernel.org/project/linux-fsdevel/patch/20200108192504.GA893@miu.piliscsaba.redhat.com/
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Jakob Unterwurzacher <jakobunt@gmail.com>
> ---
>  README.fuse       | 26 ++++++++++++++++++++++++++
>  check             |  3 ++-
>  common/config     |  9 +++++++--
>  common/rc         | 24 ++++++++++++++++++------
>  tests/generic/020 |  4 ++--
>  5 files changed, 55 insertions(+), 11 deletions(-)
>  create mode 100644 README.fuse
> 
> diff --git a/README.fuse b/README.fuse
> new file mode 100644
> index 00000000..35ad9c46
> --- /dev/null
> +++ b/README.fuse
> @@ -0,0 +1,26 @@
> +Here are instructions for testing fuse using the passthrough_ll example
> +filesystem provided in the libfuse source tree:
> +
> +git clone git://github.com/libfuse/libfuse.git
> +cd libfuse
> +meson build
> +cd build
> +ninja
> +cat << EOF | sudo tee /sbin/mount.fuse.passthrough_ll
> +#!/bin/bash
> +ulimit -n 1048576
> +exec $(pwd)/example/passthrough_ll -ofsname="\$@"
> +EOF
> +sudo chmod +x /sbin/mount.fuse.passthrough_ll
> +mkdir -p /mnt/test /mnt/scratch /home/test/test /home/test/scratch
> +
> +Use the following local.config file:
> +
> +export TEST_DEV=non1
> +export TEST_DIR=/mnt/test
> +export SCRATCH_DEV=non2
> +export SCRATCH_MNT=/mnt/scratch
> +export FSTYP=fuse
> +export FUSE_SUBTYP=.passthrough_ll
> +export FUSE_MOUNT_OPTIONS="-osource=/home/test/scratch,allow_other,default_permissions"
> +export TEST_FS_MOUNT_OPTS="-osource=/home/test/test,allow_other,default_permissions"

Hi,

Long time ago I added glusterfs supporting, for testing kernel fuse module.
Now we'll have general fuse supporting, that's good news. More and more things
start to use fuse, I'm glad to see fstests support the fuse test :)

This version looks good to me, just a tiny problem on the README.fuse. Generally
if we want to set mount options for both TEST_DEV and SCRATCH_DEV, we use the
the parameter likes FUSE_MOUNT_OPTIONS (refer to _mount_opts(), _test_mount_opts()
and _common_mount_opts()). If you just want to set mount options for SCRATCH_DEV
particularly, you might want:

  export MOUNT_OPTIONS="-osource=/home/test/scratch,allow_other,default_permissions"
  export TEST_FS_MOUNT_OPTS="-osource=/home/test/test,allow_other,default_permissions"

Others looks good to me, I'll give it a little testing, and merge it if can't
find any issue.

Thanks,
Zorro


> diff --git a/check b/check
> index 1ff0f44a..e25037f1 100755
> --- a/check
> +++ b/check
> @@ -60,6 +60,7 @@ check options
>      -glusterfs		test GlusterFS
>      -cifs		test CIFS
>      -9p			test 9p
> +    -fuse		test fuse
>      -virtiofs		test virtiofs
>      -overlay		test overlay
>      -pvfs2		test PVFS2
> @@ -279,7 +280,7 @@ while [ $# -gt 0 ]; do
>  	case "$1" in
>  	-\? | -h | --help) usage ;;
>  
> -	-nfs|-glusterfs|-cifs|-9p|-virtiofs|-pvfs2|-tmpfs|-ubifs)
> +	-nfs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs)
>  		FSTYP="${1:1}"
>  		;;
>  	-overlay)
> diff --git a/common/config b/common/config
> index e2aba5a9..6c8cb3a5 100644
> --- a/common/config
> +++ b/common/config
> @@ -341,6 +341,9 @@ _common_mount_opts()
>  	9p)
>  		echo $PLAN9_MOUNT_OPTIONS
>  		;;
> +	fuse)
> +		echo $FUSE_MOUNT_OPTIONS
> +		;;
>  	xfs)
>  		echo $XFS_MOUNT_OPTIONS
>  		;;
> @@ -511,6 +514,8 @@ _source_specific_fs()
>  		;;
>  	9p)
>  		;;
> +	fuse)
> +		;;
>  	ceph)
>  		. ./common/ceph
>  		;;
> @@ -583,8 +588,8 @@ _check_device()
>  	fi
>  
>  	case "$FSTYP" in
> -	9p|tmpfs|virtiofs)
> -		# 9p and virtiofs mount tags are just plain strings, so anything is allowed
> +	9p|fuse|tmpfs|virtiofs)
> +		# 9p, fuse and virtiofs mount tags are just plain strings, so anything is allowed
>  		# tmpfs doesn't use mount source, ignore
>  		;;
>  	ceph)
> diff --git a/common/rc b/common/rc
> index 23530413..c17e3f6e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -274,7 +274,7 @@ _try_scratch_mount()
>  		_overlay_scratch_mount $*
>  		return $?
>  	fi
> -	_mount -t $FSTYP `_scratch_mount_options $*`
> +	_mount -t $FSTYP$FUSE_SUBTYP `_scratch_mount_options $*`
>  	mount_ret=$?
>  	[ $mount_ret -ne 0 ] && return $mount_ret
>  	_idmapped_mount $SCRATCH_DEV $SCRATCH_MNT
> @@ -458,7 +458,7 @@ _test_mount()
>      fi
>  
>      _test_options mount
> -    _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> +    _mount -t $FSTYP$FUSE_SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
>      mount_ret=$?
>      [ $mount_ret -ne 0 ] && return $mount_ret
>      _idmapped_mount $TEST_DEV $TEST_DIR
> @@ -584,6 +584,9 @@ _test_mkfs()
>      9p)
>  	# do nothing for 9p
>  	;;
> +    fuse)
> +	# do nothing for fuse
> +	;;
>      virtiofs)
>  	# do nothing for virtiofs
>  	;;
> @@ -624,6 +627,9 @@ _mkfs_dev()
>      9p)
>  	# do nothing for 9p
>  	;;
> +    fuse)
> +	# do nothing for fuse
> +	;;
>      virtiofs)
>  	# do nothing for virtiofs
>  	;;
> @@ -691,7 +697,7 @@ _scratch_mkfs()
>  	local mkfs_status
>  
>  	case $FSTYP in
> -	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|virtiofs)
> +	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|fuse|virtiofs)
>  		# unable to re-create this fstyp, just remove all files in
>  		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
>  		# created in previous runs
> @@ -1587,7 +1593,7 @@ _require_scratch_nocheck()
>  			_notrun "this test requires a valid \$SCRATCH_MNT"
>  		fi
>  		;;
> -	9p|virtiofs)
> +	9p|fuse|virtiofs)
>  		if [ -z "$SCRATCH_DEV" ]; then
>  			_notrun "this test requires a valid \$SCRATCH_DEV"
>  		fi
> @@ -1787,7 +1793,7 @@ _require_test()
>  			_notrun "this test requires a valid \$TEST_DIR"
>  		fi
>  		;;
> -	9p|virtiofs)
> +	9p|fuse|virtiofs)
>  		if [ -z "$TEST_DEV" ]; then
>  			_notrun "this test requires a valid \$TEST_DEV"
>  		fi
> @@ -2986,7 +2992,7 @@ _mount_or_remount_rw()
>  
>  	if [ $USE_REMOUNT -eq 0 ]; then
>  		if [ "$FSTYP" != "overlay" ]; then
> -			_mount -t $FSTYP $mount_opts $device $mountpoint
> +			_mount -t $FSTYP$FUSE_SUBTYP $mount_opts $device $mountpoint
>  			_idmapped_mount $device $mountpoint
>  		else
>  			_overlay_mount $device $mountpoint
> @@ -3124,6 +3130,9 @@ _check_test_fs()
>      9p)
>  	# no way to check consistency for 9p
>  	;;
> +    fuse)
> +	# no way to check consistency for fuse
> +	;;
>      virtiofs)
>  	# no way to check consistency for virtiofs
>  	;;
> @@ -3185,6 +3194,9 @@ _check_scratch_fs()
>      9p)
>  	# no way to check consistency for 9p
>  	;;
> +    fuse)
> +	# no way to check consistency for fuse
> +	;;
>      virtiofs)
>  	# no way to check consistency for virtiofs
>  	;;
> diff --git a/tests/generic/020 b/tests/generic/020
> index b91bca34..be5cecad 100755
> --- a/tests/generic/020
> +++ b/tests/generic/020
> @@ -56,7 +56,7 @@ _attr_get_max()
>  {
>  	# set maximum total attr space based on fs type
>  	case "$FSTYP" in
> -	xfs|udf|pvfs2|9p|ceph|nfs)
> +	xfs|udf|pvfs2|9p|ceph|fuse|nfs)
>  		max_attrs=1000
>  		;;
>  	ext2|ext3|ext4)
> @@ -134,7 +134,7 @@ _attr_get_maxval_size()
>  	pvfs2)
>  		max_attrval_size=8192
>  		;;
> -	xfs|udf|9p)
> +	xfs|udf|9p|fuse)
>  		max_attrval_size=65536
>  		;;
>  	bcachefs)
> -- 
> 2.38.1
> 

