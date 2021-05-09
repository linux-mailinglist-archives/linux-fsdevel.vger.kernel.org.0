Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA63377702
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 May 2021 16:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhEIOhL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 May 2021 10:37:11 -0400
Received: from out20-86.mail.aliyun.com ([115.124.20.86]:56583 "EHLO
        out20-86.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhEIOhL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 May 2021 10:37:11 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436305|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.143236-0.00230577-0.854458;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.KAhWqba_1620570965;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KAhWqba_1620570965)
          by smtp.aliyun-inc.com(10.147.41.143);
          Sun, 09 May 2021 22:36:06 +0800
Date:   Sun, 9 May 2021 22:36:05 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, Kent Overstreet <kmo@daterainc.com>
Subject: Re: [PATCH 1/3] Initial bcachefs support
Message-ID: <YJfzVSGu2BbE4oMY@desktop>
References: <20210427164419.3729180-1-kent.overstreet@gmail.com>
 <20210427164419.3729180-2-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427164419.3729180-2-kent.overstreet@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 12:44:17PM -0400, Kent Overstreet wrote:
> From: Kent Overstreet <kmo@daterainc.com>

Better to add commit logs at least to give an example about how to setup
fstests to test bcachefs.

> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
>  common/attr        |  6 ++++++
>  common/config      |  3 +++
>  common/dmlogwrites |  7 +++++++
>  common/quota       |  4 ++--
>  common/rc          | 31 +++++++++++++++++++++++++++++++
>  tests/generic/042  |  3 ++-
>  tests/generic/425  |  3 +++
>  tests/generic/441  |  2 +-
>  tests/generic/482  | 27 ++++++++++++++++++++-------
>  tests/generic/558  |  2 ++
>  10 files changed, 77 insertions(+), 11 deletions(-)
> 
> diff --git a/common/attr b/common/attr
> index 669909d600..42ceab9233 100644
> --- a/common/attr
> +++ b/common/attr
> @@ -33,6 +33,9 @@ _acl_get_max()
>  			echo 506
>  		fi
>  		;;
> +	bcachefs)
> +		echo 251
> +		;;
>  	*)
>  		echo 0
>  		;;
> @@ -273,6 +276,9 @@ pvfs2)
>  9p|ceph|nfs)
>  	MAX_ATTRVAL_SIZE=65536
>  	;;
> +bcachefs)
> +	MAX_ATTRVAL_SIZE=1024
> +	;;
>  *)
>  	# Assume max ~1 block of attrs
>  	BLOCK_SIZE=`_get_block_size $TEST_DIR`
> diff --git a/common/config b/common/config
> index a47e462c77..8153301483 100644
> --- a/common/config
> +++ b/common/config
> @@ -415,6 +415,9 @@ _mkfs_opts()
>  	btrfs)
>  		export MKFS_OPTIONS="$BTRFS_MKFS_OPTIONS"
>  		;;
> +	bcachefs)
> +		export MKFS_OPTIONS="--errors=panic"

I think this might be useful for bcachefs developers to find bugs
earlier, but not suitable for people like QA, as this may crash their
test machines and stop the whole test.

You could always set MKFS_OPTIONS to "--errors=panic" explicitly when
needed.

> +		;;
>  	*)
>  		;;
>  	esac
> diff --git a/common/dmlogwrites b/common/dmlogwrites
> index 573f4b8a56..668d49e995 100644
> --- a/common/dmlogwrites
> +++ b/common/dmlogwrites
> @@ -111,6 +111,13 @@ _log_writes_replay_log()
>  	[ -z "$_blkdev" ] && _fail \
>  	"block dev must be specified for _log_writes_replay_log"
>  
> +	if [ "$FSTYP" = "bcachefs" ]; then
> +		# bcachefs gets confused if we're replaying the history out of
> +		# order, and we see writes on the device from a newer point in
> +		# time than what the superblock points to:
> +		dd if=/dev/zero of=$SCRATCH_DEV bs=1M oflag=direct >& /dev/null

I don't know bcachefs internals, I'm not sure I understand this,
clearing the first 1M of SCRATCH_DEV seems to clear superblock, but I'm
still not sure why it's needed. Does wipefs work?

> +	fi
> +
>  	$here/src/log-writes/replay-log --log $LOGWRITES_DEV --find \
>  		--end-mark $_mark >> $seqres.full 2>&1
>  	[ $? -ne 0 ] && _fail "mark '$_mark' does not exist"
> diff --git a/common/quota b/common/quota
> index 32a9a55593..883a28a20d 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -17,7 +17,7 @@ _require_quota()
>  	    _notrun "Installed kernel does not support quotas"
>  	fi
>  	;;
> -    gfs2|ocfs2)
> +    gfs2|ocfs2|bcachefs)
>  	;;
>      xfs)
>  	if [ ! -f /proc/fs/xfs/xqmstat ]; then
> @@ -278,7 +278,7 @@ _check_quota_usage()
>  
>  	VFS_QUOTA=0
>  	case $FSTYP in
> -	ext2|ext3|ext4|ext4dev|f2fs|reiserfs|gfs2)
> +	ext2|ext3|ext4|ext4dev|f2fs|reiserfs|gfs2|bcachefs)
>  		VFS_QUOTA=1
>  		quotaon -f -u -g $SCRATCH_MNT 2>/dev/null
>  		;;
> diff --git a/common/rc b/common/rc
> index 2cf550ec68..0e03846aeb 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -334,6 +334,7 @@ _try_scratch_mount()
>  		return $?
>  	fi
>  	_mount -t $FSTYP `_scratch_mount_options $*`
> +	return

Seems not necessary.

>  }
>  
>  # mount scratch device with given options and _fail if mount fails
> @@ -667,6 +668,9 @@ _test_mkfs()
>      ext2|ext3|ext4)
>  	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
>  	;;
> +    bcachefs)
> +	$MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
> +	;;

I think we could just use the default mkfs command below. The only
difference is dropping the "yes | " part, but that does nothing if mkfs
doesn't read "yes" or "no" from stdin.

>      *)
>  	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
>  	;;
> @@ -706,6 +710,10 @@ _mkfs_dev()
>  	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $* \
>  		2>$tmp.mkfserr 1>$tmp.mkfsstd
>  	;;
> +    bcachefs)
> +	$MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* \
> +		2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
> +	;;

Same as above.

>      *)
>  	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* \
>  		2>$tmp.mkfserr 1>$tmp.mkfsstd
> @@ -803,6 +811,10 @@ _scratch_mkfs()
>  		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
>  		mkfs_filter="grep -v -e ^mkfs\.ocfs2"
>  		;;
> +	bcachefs)
> +		mkfs_cmd="$MKFS_PROG -t $FSTYP --"
> +		mkfs_filter="cat"
> +		;;

Same here.

>  	*)
>  		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
>  		mkfs_filter="cat"
> @@ -1065,6 +1077,9 @@ _scratch_mkfs_sized()
>  		fi
>  		export MOUNT_OPTIONS="-o size=$fssize $TMPFS_MOUNT_OPTIONS"
>  		;;
> +	bcachefs)
> +		$MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS --fs_size=$fssize --block_size=$blocksize $SCRATCH_DEV
> +		;;
>  	*)
>  		_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
>  		;;
> @@ -1133,6 +1148,9 @@ _scratch_mkfs_blocksized()
>      ocfs2)
>  	yes | ${MKFS_PROG} -t $FSTYP -F $MKFS_OPTIONS -b $blocksize -C $blocksize $SCRATCH_DEV
>  	;;
> +    bcachefs)
> +	${MKFS_PROG}.$FSTYP $MKFS_OPTIONS --block_size=$blocksize $SCRATCH_DEV
> +	;;

Better to be consistent and use "${MKFS_PROG} -t $FSTYP ..." instead of
${MKFS_PROG}.$FSTYP

>      *)
>  	_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_blocksized"
>  	;;
> @@ -1179,6 +1197,19 @@ _repair_scratch_fs()
>  	fi
>  	return $res
>          ;;
> +    bcachefs)
> +	fsck -t $FSTYP -n $SCRATCH_DEV 2>&1

_repair_scratch_fs() is supposed to actually fix the errors, does
"fsck -n" fix errors for bcachefs?

> +	res=$?
> +	case $res in
> +	0)
> +		res=0
> +		;;
> +	*)
> +		_dump_err2 "fsck.$FSTYP failed, err=$res"
> +		;;
> +	esac
> +	return $res
> +	;;
>      *)
>  	local dev=$SCRATCH_DEV
>  	local fstyp=$FSTYP
> diff --git a/tests/generic/042 b/tests/generic/042
> index 35727bcbc6..42919e2313 100755
> --- a/tests/generic/042
> +++ b/tests/generic/042
> @@ -63,7 +63,8 @@ _crashtest()
>  
>  	# We should /never/ see 0xCD in the file, because we wrote that pattern
>  	# to the filesystem image to expose stale data.
> -	if hexdump -v -e '/1 "%02X "' $file | grep -q "CD"; then
> +	# The file is not required to exist since we didn't sync before going down:
> +	if [[ -f $file ]] && hexdump -v -e '/1 "%02X "' $file | grep -q "CD"; then
>  		echo "Saw stale data!!!"
>  		hexdump $file
>  	fi

Updates for individual test should be in a separate patch.

> diff --git a/tests/generic/425 b/tests/generic/425
> index 51cbe1c67d..be2bc1b02e 100755
> --- a/tests/generic/425
> +++ b/tests/generic/425
> @@ -30,6 +30,9 @@ _cleanup()
>  
>  # real QA test starts here
>  _supported_fs generic
> +
> +[ $FSTYP = bcachefs ] && _notrun "bcachefs does not store xattrs in blocks"
> +
>  _require_scratch
>  _require_attrs
>  _require_xfs_io_command "fiemap" "-a"
> diff --git a/tests/generic/441 b/tests/generic/441
> index bedbcb0817..814387b2a9 100755
> --- a/tests/generic/441
> +++ b/tests/generic/441
> @@ -40,7 +40,7 @@ case $FSTYP in
>  	btrfs)
>  		_notrun "btrfs has a specialized test for this"
>  		;;
> -	ext3|ext4|xfs)
> +	ext3|ext4|xfs|bcachefs)
>  		# Do the more thorough test if we have a logdev
>  		_has_logdev && sflag=''
>  		;;
> diff --git a/tests/generic/482 b/tests/generic/482
> index 86941e8468..3cbe187f2e 100755
> --- a/tests/generic/482
> +++ b/tests/generic/482
> @@ -77,16 +77,29 @@ prev=$(_log_writes_mark_to_entry_number mkfs)
>  cur=$(_log_writes_find_next_fua $prev)
>  [ -z "$cur" ] && _fail "failed to locate next FUA write"
>  
> +if [ "$FSTYP" = "bcachefs" ]; then
> +    _dmthin_cleanup
> +    _dmthin_init $devsize $devsize $csize $lowspace
> +fi
> +
>  while [ ! -z "$cur" ]; do
>  	_log_writes_replay_log_range $cur $DMTHIN_VOL_DEV >> $seqres.full
>  
> -	# Here we need extra mount to replay the log, mainly for journal based
> -	# fs, as their fsck will report dirty log as error.
> -	# We don't care to preserve any data on the replay dev, as we can replay
> -	# back to the point we need, and in fact sometimes creating/deleting
> -	# snapshots repeatedly can be slower than replaying the log.
> -	_dmthin_mount
> -	_dmthin_check_fs
> +	if [ "$FSTYP" = "bcachefs" ]; then
> +	    # bcachefs will get confused if fsck does writes to replay the log,
> +	    # but then we replay writes from an earlier point in time on the
> +	    # same fs - but  fsck in -n mode won't do any writes:
> +	    _check_scratch_fs -n $DMTHIN_VOL_DEV
> +	else
> +	    # Here we need extra mount to replay the log, mainly for journal based
> +	    # fs, as their fsck will report dirty log as error.
> +	    # We don't care to preserve any data on the replay dev, as we can replay
> +	    # back to the point we need, and in fact sometimes creating/deleting
> +	    # snapshots repeatedly can be slower than replaying the log.
> +
> +	    _dmthin_mount
> +	    _dmthin_check_fs
> +	fi
>  
>  	prev=$cur
>  	cur=$(_log_writes_find_next_fua $(($cur + 1)))
> diff --git a/tests/generic/558 b/tests/generic/558
> index 4bed90e2a7..2eaa8f7686 100755
> --- a/tests/generic/558
> +++ b/tests/generic/558
> @@ -55,6 +55,8 @@ _scratch_mount
>  i=0
>  free_inode=`_get_free_inode $SCRATCH_MNT`
>  file_per_dir=1000
> +[ $FSTYP = bcachefs ] && file_per_dir=10000
> +

Some comments would be good.

Thanks,
Eryu

>  loop=$((free_inode / file_per_dir + 1))
>  mkdir -p $SCRATCH_MNT/testdir
>  
> -- 
> 2.31.1
