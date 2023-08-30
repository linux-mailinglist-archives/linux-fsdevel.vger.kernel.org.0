Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B25178DAC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbjH3ShE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245277AbjH3PCK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:02:10 -0400
X-Greylist: delayed 168 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 08:02:07 PDT
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED22AC;
        Wed, 30 Aug 2023 08:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CBB8B81F69;
        Wed, 30 Aug 2023 15:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BE6C433C8;
        Wed, 30 Aug 2023 15:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693407725;
        bh=DkyAnBJYU1X3RuDPRKTTh3ZWlq88A51VNKODLt3Plkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KWBuigGVj2TwLMnivQ6jgXE38R3DKovxO254CXz/izuQkAHfy6hcUyjeXmT9KbKmw
         kXc2eFVF+ds9oDe9SRT0mYkDdpbpdlljwzeXts60+UfuzUHQ/fwiknWzM9nvdzX0yn
         RI36m1bz4bSAT+myzKXvC2pO+EIgZnsI2BSRW9NDQqa79TBcYronlWhj/dkCuF+/GL
         VLm1bBfmy5LP97mty/WQyRfKtXCt6lnW8yKZsI+3ff0thhDkWlRBjbyzD+AW2T3S+y
         TFPhS78Eiqw6QXphR2xun6a/7N+vcp18ufNksDVX+hvuKc7eT8icRgJ9ARf/324l+K
         DNlAXiGf1jE7g==
Date:   Wed, 30 Aug 2023 08:02:04 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH fstests v4 1/3] common/attr: fix the _require_acl test
Message-ID: <20230830150204.GE28202@frogsfrogsfrogs>
References: <20230830-fixes-v4-0-88d7b8572aa3@kernel.org>
 <20230830-fixes-v4-1-88d7b8572aa3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830-fixes-v4-1-88d7b8572aa3@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 30, 2023 at 06:58:50AM -0400, Jeff Layton wrote:
> _require_acl tests whether you're able to fetch the ACL from a file
> using chacl, and then tests for an -EOPNOTSUPP error return.
> Unfortunately, filesystems that don't support them (like NFSv4) just
> return -ENODATA when someone calls getxattr for the POSIX ACL, so the
> test doesn't work.
> 
> Fix the test to have chacl set an ACL on the file instead, which should
> reliably fail on filesystems that don't support them.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Seems logical,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/attr | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/common/attr b/common/attr
> index cce4d1b201b2..3ebba682c894 100644
> --- a/common/attr
> +++ b/common/attr
> @@ -163,13 +163,12 @@ _require_acls()
>      [ -n "$CHACL_PROG" ] || _notrun "chacl command not found"
>  
>      #
> -    # Test if chacl is able to list ACLs on the target filesystems.  On really
> -    # old kernels the system calls might not be implemented at all, but the
> -    # more common case is that the tested filesystem simply doesn't support
> -    # ACLs.
> +    # Test if chacl is able to set an ACL on a file.  On really old kernels
> +    # the system calls might not be implemented at all, but the more common
> +    # case is that the tested filesystem simply doesn't support ACLs.
>      #
>      touch $TEST_DIR/syscalltest
> -    chacl -l $TEST_DIR/syscalltest > $TEST_DIR/syscalltest.out 2>&1
> +    chacl 'u::rw-,g::---,o::---' $TEST_DIR/syscalltest > $TEST_DIR/syscalltest.out 2>&1
>      cat $TEST_DIR/syscalltest.out >> $seqres.full
>  
>      if grep -q 'Function not implemented' $TEST_DIR/syscalltest.out; then
> 
> -- 
> 2.41.0
> 
