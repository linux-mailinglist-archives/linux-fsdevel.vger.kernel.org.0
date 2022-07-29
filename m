Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48FD584A82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 06:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbiG2EFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jul 2022 00:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiG2EFQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jul 2022 00:05:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477CD9FEC;
        Thu, 28 Jul 2022 21:05:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C73A361E56;
        Fri, 29 Jul 2022 04:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03711C433D6;
        Fri, 29 Jul 2022 04:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659067513;
        bh=ofgShsxKJjEgBT4YGnIXMhwt3/3vB9KC0x+eRLwQNWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/L1NkBBJ5NVOT0DkX64CmIxM/Vp64O8LwGu9win753VWDKz0kn8rqcqNoNILMkcj
         ArSvAOGwwVwipMgOPJ5gIcXhwPAxgAYc03xPaAZF3HG0fMYiyspnBmOgGe1aasDfAE
         OLxbR2XR4jHUxH7HPr97r4T1CpeeKy0B5dXya4rKvctoYPr5ENgqpAcUlnKyv/74+w
         RMEXJ/qmgc8LRSYkQRC3+qgQptYudSjzv89CxmL4aHTKvX9uY30FIrMvoYyYQRTww3
         e37i+tkFntVkGW1FehWIVKkX6HlTYeZICg7vcfwygTEcH9qJ1jf9EkBSt9sXjDjLLX
         9w45YSiRTbdBg==
Date:   Thu, 28 Jul 2022 21:05:11 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, jlayton@kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: record I_DIRTY_TIME even if inode already has
 I_DIRTY_INODE
Message-ID: <YuNcd7q6a33tqkAf@sol.localdomain>
References: <20220728133914.49890-1-lczerner@redhat.com>
 <20220728133914.49890-2-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728133914.49890-2-lczerner@redhat.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 28, 2022 at 03:39:14PM +0200, Lukas Czerner wrote:
> Currently the I_DIRTY_TIME will never get set if the inode already has
> I_DIRTY_INODE with assumption that it supersedes I_DIRTY_TIME.  That's
> true, however ext4 will only update the on-disk inode in
> ->dirty_inode(), not on actual writeback. As a result if the inode
> already has I_DIRTY_INODE state by the time we get to
> __mark_inode_dirty() only with I_DIRTY_TIME, the time was already filled
> into on-disk inode and will not get updated until the next I_DIRTY_INODE
> update, which might never come if we crash or get a power failure.
> 
> The problem can be reproduced on ext4 by running xfstest generic/622
> with -o iversion mount option. Fix it by setting I_DIRTY_TIME even if
> the inode already has I_DIRTY_INODE.
> 
> Also clear the I_DIRTY_TIME after ->dirty_inode() otherwise it may never
> get cleared.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

If you're going to change the meaning of I_* flags, please update the comment in
include/linux/fs.h that describes what they mean.

- Eric
