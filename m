Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9984C742BC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 20:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjF2SON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 14:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjF2SOL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:14:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3982D4E
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 11:14:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B3F1615C9
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 18:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F84C433C0;
        Thu, 29 Jun 2023 18:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688062448;
        bh=YqjeheK14xrTAud7lGUq8VtiU82Jme3QHcbKssCzLIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uEYTJ4VEH8V1W7R36Tm8+Z884QIlaVGE93Tdm8mh99J3WqMXnsRxS98dL4ihWFbyC
         R3jsdR49K92WTKAy41nTKdrjh4npCnl4eQXRqez/IYEjXOSZbJCIxssme806sv776H
         Obk/fj0jjpYenShaEXpYYynhpZ7m9jHDFfo0nSUXqpsQ9/nWz2F3V/ZPoWJQpJnyrM
         ihM1UUB4wh/Ku5zp5Mp9S7C/5UTV1Xjmfl7o1sTx8ZmQNgMrd8E26O47/B7F+V+11d
         AtV7UuKSDEYVor/OOTnkl3uES43ki+G1LsDV3x5K3+SMhlr4Fpa197T45Zd1Q10g7A
         qYD/0m7v1jaeA==
Date:   Thu, 29 Jun 2023 11:14:08 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Daniel Dao <dqminh@cloudflare.com>,
        Dave Chinner <david@fromorbit.com>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-fsdevel@vger.kernel.org,
        Chandan Babu R <chandanrlinux@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Leah Rumancik <lrumancik@google.com>
Subject: Re: Backporting of series xfs/iomap: fix data corruption due to
 stale cached iomap
Message-ID: <20230629181408.GM11467@frogsfrogsfrogs>
References: <CA+wXwBRdcjHW2zxDABdFU3c26mc1u+g6iWG7HrXJRL7Po3Qp0w@mail.gmail.com>
 <ZJ2yeJR5TB4AyQIn@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJ2yeJR5TB4AyQIn@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[add the xfs lts maintainers]

On Thu, Jun 29, 2023 at 05:34:00PM +0100, Matthew Wilcox wrote:
> On Thu, Jun 29, 2023 at 05:09:41PM +0100, Daniel Dao wrote:
> > Hi Dave and Derrick,
> > 
> > We are tracking down some corruptions on xfs for our rocksdb workload,
> > running on kernel 6.1.25. The corruptions were
> > detected by rocksdb block checksum. The workload seems to share some
> > similarities
> > with the multi-threaded write workload described in
> > https://lore.kernel.org/linux-fsdevel/20221129001632.GX3600936@dread.disaster.area/
> > 
> > Can we backport the patch series to stable since it seemed to fix data
> > corruptions ?
> 
> For clarity, are you asking for permission or advice about doing this
> yourself, or are you asking somebody else to do the backport for you?

Nobody's officially committed to backporting and testing patches for
6.1; are you (Cloudflare) volunteering?

--D
