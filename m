Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F385A562938
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 04:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiGACkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 22:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbiGACkv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:40:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B3C61D71;
        Thu, 30 Jun 2022 19:40:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81CD9621E6;
        Fri,  1 Jul 2022 02:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3014CC34115;
        Fri,  1 Jul 2022 02:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656643249;
        bh=5CG6PQNhFAVSniQ+OiaKwGEwxvQrcazv+VzD2hwP9Bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAJ7IVXDFORay0N5IbRdF31i77wtc1E8/FSV4BLVdfWuH+HKuPDsOKgSO5W2+A0Kk
         p033exPTScRkdNMu+hIeVvnAerqis/+bzWIMxJMx0B9oUTE5HQNo0ym6plmwkBAREl
         Tf4QrMWG2ctr76pxY7LcSXDoiPTX8amzrYeCYAejfA1/+5/eL5MgO8f1nsPyCQ3zwv
         fn6P3DhKBEhjGTAh5wovPzMcxXudoLQv6qWvHT7GDxDOiwXkoK4quJA/MRMuZ0yWxL
         /mG7Q3LNxRKSE30RWn+XbcbETuhiOxfL0J37ykeZib9hcCLeDcXNpP7NrCO4AQwAsF
         wj5XmPxXFeyYw==
Date:   Thu, 30 Jun 2022 20:40:46 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        willy@infradead.org, sagi@grimberg.me
Subject: Re: [PATCH 07/12] block: allow copying pre-registered bvecs
Message-ID: <Yr5erjAN/NTdIG78@kbusch-mbp.dhcp.thefacebook.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
 <20220630204212.1265638-8-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630204212.1265638-8-kbusch@fb.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 30, 2022 at 01:42:07PM -0700, Keith Busch wrote:
>  void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
>  {
>  	size_t size = iov_iter_count(iter);
>  
>  	WARN_ON_ONCE(bio->bi_max_vecs);
>  
> +	if (bio->bi_max_vecs) {
> +		bio_copy_bvec(bio, iter);
> +		return;
> +	}

Obviously the WARN_ON_ONCE needs to go away with this.

And with the follow on users in this series, there's also a bug with putting
page references on these at bio_endio, so don't try testing pre-registered
buffers with this series. I'll send a fix in the v2 if we get that far.
