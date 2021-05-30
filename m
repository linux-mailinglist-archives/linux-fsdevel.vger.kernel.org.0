Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACBF395109
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 May 2021 15:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhE3NUc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 May 2021 09:20:32 -0400
Received: from out20-98.mail.aliyun.com ([115.124.20.98]:37229 "EHLO
        out20-98.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE3NUb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 May 2021 09:20:31 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07440292|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0401097-0.00176082-0.958129;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.KKw8YYQ_1622380730;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KKw8YYQ_1622380730)
          by smtp.aliyun-inc.com(10.147.40.7);
          Sun, 30 May 2021 21:18:51 +0800
Date:   Sun, 30 May 2021 21:18:49 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 3/4] generic/{455,457,482}: make dmlogwrites tests
 work on bcachefs
Message-ID: <YLOQuagLB3LhKPOl@desktop>
References: <20210525221955.265524-1-kent.overstreet@gmail.com>
 <20210525221955.265524-7-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525221955.265524-7-kent.overstreet@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 06:19:54PM -0400, Kent Overstreet wrote:
> bcachefs has log structured btree nodes, in addition to a regular
> journal, which means that unless we replay to markers in the log in the
> same order that they happened and are careful to avoid writing in
> between replaying to different events - we need to wipe and start fresh
> each time.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
>  tests/generic/455 | 14 ++++++++++++++
>  tests/generic/457 | 14 ++++++++++++++
>  tests/generic/482 | 27 ++++++++++++++++++++-------
>  3 files changed, 48 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/generic/455 b/tests/generic/455
> index 5b4b242e74..6dc46c3c72 100755
> --- a/tests/generic/455
> +++ b/tests/generic/455
> @@ -35,6 +35,17 @@ _require_dm_target thin-pool
>  
>  rm -f $seqres.full
>  
> +_reset_dmthin()
> +{
> +    # With bcachefs, we need to wipe and start fresh every time we replay to a
> +    # different point in time - if we see metadata from a future point in time,
> +    # or an unrelated mount, bcachefs will get confused:
> +    if [ "$FSTYP" = "bcachefs" ]; then
> +	_dmthin_cleanup
> +	_dmthin_init $devsize $devsize $csize $lowspace
> +    fi
> +}

I think we probably could make it a common helper, and currently only
bcachefs needs reset, and more log structured filesystems may be
supported in the future.

Thanks,
Eryu

> +
>  check_files()
>  {
>  	local name=$1
> @@ -44,6 +55,7 @@ check_files()
>  		local filename=$(basename $i)
>  		local mark="${filename##*.}"
>  		echo "checking $filename" >> $seqres.full
> +		_reset_dmthin
>  		_log_writes_replay_log $filename $DMTHIN_VOL_DEV
>  		_dmthin_mount
>  		local expected_md5=$(_md5_checksum $i)
> @@ -101,6 +113,7 @@ _dmthin_check_fs
>  
>  # check pre umount
>  echo "checking pre umount" >> $seqres.full
> +_reset_dmthin
>  _log_writes_replay_log last $DMTHIN_VOL_DEV
>  _dmthin_mount
>  _dmthin_check_fs
> @@ -111,6 +124,7 @@ done
>  
>  # Check the end
>  echo "checking post umount" >> $seqres.full
> +_reset_dmthin
>  _log_writes_replay_log end $DMTHIN_VOL_DEV
>  _dmthin_mount
>  for j in `seq 0 $((NUM_FILES-1))`; do
> diff --git a/tests/generic/457 b/tests/generic/457
> index ddbd90cf0c..f17d4e4430 100755
> --- a/tests/generic/457
> +++ b/tests/generic/457
> @@ -37,6 +37,17 @@ _require_dm_target thin-pool
>  
>  rm -f $seqres.full
>  
> +_reset_dmthin()
> +{
> +    # With bcachefs, we need to wipe and start fresh every time we replay to a
> +    # different point in time - if we see metadata from a future point in time,
> +    # or an unrelated mount, bcachefs will get confused:
> +    if [ "$FSTYP" = "bcachefs" ]; then
> +	_dmthin_cleanup
> +	_dmthin_init $devsize $devsize $csize $lowspace
> +    fi
> +}
> +
>  check_files()
>  {
>  	local name=$1
> @@ -46,6 +57,7 @@ check_files()
>  		local filename=$(basename $i)
>  		local mark="${filename##*.}"
>  		echo "checking $filename" >> $seqres.full
> +		_reset_dmthin
>  		_log_writes_replay_log $filename $DMTHIN_VOL_DEV
>  		_dmthin_mount
>  		local expected_md5=$(_md5_checksum $i)
> @@ -105,6 +117,7 @@ _dmthin_check_fs
>  
>  # check pre umount
>  echo "checking pre umount" >> $seqres.full
> +_reset_dmthin
>  _log_writes_replay_log last $DMTHIN_VOL_DEV
>  _dmthin_mount
>  _dmthin_check_fs
> @@ -115,6 +128,7 @@ done
>  
>  # Check the end
>  echo "checking post umount" >> $seqres.full
> +_reset_dmthin
>  _log_writes_replay_log end $DMTHIN_VOL_DEV
>  _dmthin_mount
>  for j in `seq 0 $((NUM_FILES-1))`; do
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
> -- 
> 2.32.0.rc0
