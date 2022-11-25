Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE97C63903E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 20:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiKYTWG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 14:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKYTWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 14:22:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4342CDC5;
        Fri, 25 Nov 2022 11:22:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3861E60C1F;
        Fri, 25 Nov 2022 19:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B799C433D6;
        Fri, 25 Nov 2022 19:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669404124;
        bh=KrOiWwXDrPvGkEAn2LB7RpjRNfGbTiRZkWJjSt4RC8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CPFBZj5sInDrrO6haYS/sTWeJTkias4f/BcMHkF1L6JEUbgV5mWsbFMpvn5uMpF6f
         TJCnD0bXT/sY56bIRES8+yrqZ7+UoL9yb8CJa2JSsowup80KWFEOqutG4GkoQFi9If
         ZEWKNQXRszfPq618gUgsErEv5+XY2kLZ4HsJF3A+zNWT2okwAN0bcZpqrRHfV9qPHy
         Co2V1+1DiFXVqtvUbb1JHb2+iynCjzRL8m0Z2GezOg6bI6V0vatPT9INxGT7m6Kx3Q
         e+B8UyDMRIR64AAzx61Pn2wdwiXD3/DwB88uMsGNkfZ684U+NuNKNA++dHr8Gjki4J
         kNXPahX58Lx1Q==
Date:   Fri, 25 Nov 2022 11:22:02 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3] fsverity: stop using PG_error to track error status
Message-ID: <Y4EV2rNfdNWfzF9+@sol.localdomain>
References: <20221028175807.55495-1-ebiggers@kernel.org>
 <6bce9afb-2561-7937-caea-8aadaa5a21cd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bce9afb-2561-7937-caea-8aadaa5a21cd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 25, 2022 at 11:36:14AM +0800, Chao Yu wrote:
> On 2022/10/29 1:58, Eric Biggers wrote:
> > @@ -116,43 +116,51 @@ struct bio_post_read_ctx {
> >   	struct f2fs_sb_info *sbi;
> >   	struct work_struct work;
> >   	unsigned int enabled_steps;
> > +	bool decompression_attempted;
> 
> How about adding some comments for decompression_attempted? Otherwise it
> looks good to me.
> 

I added the following:

	/*
 	 * decompression_attempted keeps track of whether
 	 * f2fs_end_read_compressed_page() has been called on the pages in the
 	 * bio that belong to a compressed cluster yet.
 	 */

- Eric
