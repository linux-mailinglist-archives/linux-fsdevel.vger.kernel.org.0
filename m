Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D6378DA72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbjH3SgW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245274AbjH3PBc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:01:32 -0400
X-Greylist: delayed 128 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 08:01:28 PDT
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD151A2;
        Wed, 30 Aug 2023 08:01:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B94EB81F6E;
        Wed, 30 Aug 2023 15:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4001C433CA;
        Wed, 30 Aug 2023 15:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693407686;
        bh=87aEVuBrF/H10/kaMMmVFs6bcYX3GUgxGXnoLaWtaKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ov+sft8ymsD/kXM5W4cvYAVXjIWibo4LxH9+Xz5393G1ENgxKrfrzYtUIP4EH5njv
         VXEZu1Kn2asQGuTa4etAB3g8LZVkm6AOdjSCYY4dZWjcY/bOXu69CTZcTZ5zjXuvq1
         5qGr/Q/sY5rrHrQd4wdiIPxsF39SxqKjTzSnfEQPJpW/IwDaSnwATDOFcPw6gcOAOr
         BejZ9xuy/pBGvsXw4jiJlGFLPxgUDBLKbFaIGnsiSa605tIGUnMnFVoFMbfrYp4atz
         7gsPWkzIO6OPRlgcqqs5IQ3tcZRYHylgnygMM8peKWvLtJAW7VnlydSG7++8zrDgaf
         wbYwOuIc9SfmA==
Date:   Wed, 30 Aug 2023 08:01:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH fstests v4 3/3] generic/*: add a check for security attrs
Message-ID: <20230830150125.GD28202@frogsfrogsfrogs>
References: <20230830-fixes-v4-0-88d7b8572aa3@kernel.org>
 <20230830-fixes-v4-3-88d7b8572aa3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830-fixes-v4-3-88d7b8572aa3@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 30, 2023 at 06:58:52AM -0400, Jeff Layton wrote:
> There are several generic tests that require "setcap", but don't check
> whether the underlying fs supports security attrs. Add the appropriate
> checks.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/270 | 2 ++
>  tests/generic/513 | 2 ++
>  tests/generic/675 | 2 ++
>  tests/generic/688 | 2 ++
>  tests/generic/727 | 2 ++
>  5 files changed, 10 insertions(+)
> 
> diff --git a/tests/generic/270 b/tests/generic/270
> index 8a6a2822b76b..e7329c2f3280 100755
> --- a/tests/generic/270
> +++ b/tests/generic/270
> @@ -13,6 +13,7 @@ _begin_fstest auto quota rw prealloc ioctl enospc stress
>  # Import common functions.
>  . ./common/filter
>  . ./common/quota
> +. ./common/attr
>  
>  # Disable all sync operations to get higher load
>  FSSTRESS_AVOID="$FSSTRESS_AVOID -ffsync=0 -fsync=0 -ffdatasync=0"
> @@ -58,6 +59,7 @@ _require_user
>  _require_scratch
>  _require_command "$KILLALL_PROG" killall
>  _require_command "$SETCAP_PROG" setcap
> +_require_attrs security
>  
>  _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
>  _scratch_mount "-o usrquota,grpquota"
> diff --git a/tests/generic/513 b/tests/generic/513
> index dc082787ae4e..7ff845cea35b 100755
> --- a/tests/generic/513
> +++ b/tests/generic/513
> @@ -12,12 +12,14 @@ _begin_fstest auto quick clone
>  # Import common functions.
>  . ./common/filter
>  . ./common/reflink
> +. ./common/attr
>  
>  # real QA test starts here
>  _supported_fs generic
>  _require_scratch_reflink
>  _require_command "$GETCAP_PROG" getcap
>  _require_command "$SETCAP_PROG" setcap
> +_require_attrs security
>  
>  _scratch_mkfs >>$seqres.full 2>&1
>  _scratch_mount
> diff --git a/tests/generic/675 b/tests/generic/675
> index 189251f20c0d..cc4309e45a04 100755
> --- a/tests/generic/675
> +++ b/tests/generic/675
> @@ -12,6 +12,7 @@ _begin_fstest auto clone quick
>  # Import common functions.
>  . ./common/filter
>  . ./common/reflink
> +. ./common/attr
>  
>  # real QA test starts here
>  
> @@ -21,6 +22,7 @@ _require_user
>  _require_command "$GETCAP_PROG" getcap
>  _require_command "$SETCAP_PROG" setcap
>  _require_scratch_reflink
> +_require_attrs security
>  
>  _scratch_mkfs >> $seqres.full
>  _scratch_mount
> diff --git a/tests/generic/688 b/tests/generic/688
> index 426286b6c6ce..e2bf12b4457d 100755
> --- a/tests/generic/688
> +++ b/tests/generic/688
> @@ -18,6 +18,7 @@ _cleanup()
>  
>  # Import common functions.
>  . ./common/filter
> +. ./common/attr
>  
>  # real QA test starts here
>  
> @@ -29,6 +30,7 @@ _require_command "$SETCAP_PROG" setcap
>  _require_xfs_io_command falloc
>  _require_test
>  _require_congruent_file_oplen $TEST_DIR 65536
> +_require_attrs security
>  
>  junk_dir=$TEST_DIR/$seq
>  junk_file=$junk_dir/a
> diff --git a/tests/generic/727 b/tests/generic/727
> index 58a89e3eda70..2cda49eadab3 100755
> --- a/tests/generic/727
> +++ b/tests/generic/727
> @@ -19,6 +19,7 @@ _begin_fstest auto fiexchange swapext quick
>  
>  # Import common functions.
>  . ./common/filter
> +. ./common/attr
>  
>  # real QA test starts here
>  
> @@ -30,6 +31,7 @@ _require_command "$SETCAP_PROG" setcap
>  _require_xfs_io_command swapext '-v vfs -a'
>  _require_xfs_io_command startupdate
>  _require_scratch
> +_require_attrs security
>  
>  _scratch_mkfs >> $seqres.full
>  _scratch_mount
> 
> -- 
> 2.41.0
> 
