Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E1F787663
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 19:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbjHXRJu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 13:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjHXRJe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 13:09:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B79199D;
        Thu, 24 Aug 2023 10:09:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58B42650C1;
        Thu, 24 Aug 2023 17:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB34C433C7;
        Thu, 24 Aug 2023 17:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692896971;
        bh=wPcP08GzUhVpeHcQ4xdOOt53tZW2z91rbgdJ7hkjNWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gYJezWGXNiZmBVnjptMkwndSs0GgcWCu7dgRVk3v442hKR7ttFvi4n5zJdnVvXO/x
         oinlvtyMyZWbS+exUJ5dfgNgw9kImOCaQpGu8cLV8FgSGS4DJmGGF+RaR2XmexRDkF
         AkZnqVdN7oEWunxTx/27KCpCDAW/WTGA3asUcgy1U2BW7rusXiIX/nfsJ602oRVdtT
         bbtA80r3Fum/9Ma02DmBzqdA9NGatb6F1zmIp49ytB8EmM05+F7FTKhGWpMhvw47Mj
         RFrqbcSySgjNhY3olsGFB4bbIUf59659LU775Fi6rvGL28AiDqj9jlFuklmK8jYElN
         JolXdz0CIJXXg==
Date:   Thu, 24 Aug 2023 10:09:31 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH fstests v2 3/3] generic/578: only run on filesystems that
 support FIEMAP
Message-ID: <20230824170931.GC11251@frogsfrogsfrogs>
References: <20230824-fixes-v2-0-d60c2faf1057@kernel.org>
 <20230824-fixes-v2-3-d60c2faf1057@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824-fixes-v2-3-d60c2faf1057@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 24, 2023 at 12:44:19PM -0400, Jeff Layton wrote:
> Some filesystems (e.g. NFS) don't support FIEMAP. Limit generic/578 to
> filesystems that do.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  common/rc         | 13 +++++++++++++
>  tests/generic/578 |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 33e74d20c28b..98d27890f6f7 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3885,6 +3885,19 @@ _require_metadata_journaling()
>  	fi
>  }
>  
> +_require_fiemap()
> +{
> +	local testfile=$TEST_DIR/fiemaptest.$$
> +
> +	touch $testfile
> +	$XFS_IO_PROG -r -c "fiemap" $testfile 1>$testfile.out 2>&1
> +	if grep -q 'Operation not supported' $testfile.out; then
> +	  _notrun "FIEMAP is not supported by this filesystem"
> +	fi
> +
> +	rm -f $testfile $testfile.out
> +}

_require_xfs_io_command "fiemap" ?

--D

> +
>  _count_extents()
>  {
>  	$XFS_IO_PROG -r -c "fiemap" $1 | tail -n +2 | grep -v hole | wc -l
> diff --git a/tests/generic/578 b/tests/generic/578
> index b024f6ff90b4..903055b2ca58 100755
> --- a/tests/generic/578
> +++ b/tests/generic/578
> @@ -26,6 +26,7 @@ _require_test_program "mmap-write-concurrent"
>  _require_command "$FILEFRAG_PROG" filefrag
>  _require_test_reflink
>  _require_cp_reflink
> +_require_fiemap
>  
>  compare() {
>  	for i in $(seq 1 8); do
> 
> -- 
> 2.41.0
> 
