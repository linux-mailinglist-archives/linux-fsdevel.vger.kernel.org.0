Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C54A5EFB06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 18:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbiI2Qhi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 12:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbiI2Qhc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:37:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909AD14FE3C;
        Thu, 29 Sep 2022 09:37:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 384F8B8252B;
        Thu, 29 Sep 2022 16:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50188C433C1;
        Thu, 29 Sep 2022 16:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664469446;
        bh=hzaL69lrZXN9qsUmhHjQ061m+bkJjCOUB4MV0xP7wCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NF0XqcwGK/lIgQ/kE2OUjjjes4BzMsQnCzlQ5YRZcpgFvi0brjsfadZ7Hq/r7EtaW
         heDcFKfzGdZmNan1XFC1csss5Ht7wzgbAWAarPn/phu38MbsE/nuVQf8h8PvzKW/tI
         Pi68pDwViXBSctMYtvHBsFKAy/2TmP6UuIJ5KCbZp0IkBiCMWAVYIDVJcRX9hwCeor
         s8HkEsNaUSugaZdfNa/4xZ4nY9W4K+CmQYD6vtmlJpYDwGsoY2wXqbHBnKc2CUdB28
         kHMSri3CwFUrS5Wm7mmnzJ0mRNL6thMrkm+Q9iWSbhqxXISE/VL743etQ7SAGxYSwT
         AOyvtOIvp26LQ==
Date:   Thu, 29 Sep 2022 10:37:22 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, qemu-devel@nongnu.org,
        kvm@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: Commit 'iomap: add support for dma aligned direct-io' causes
 qemu/KVM boot failures
Message-ID: <YzXJwmP8pa3WABEG@kbusch-mbp.dhcp.thefacebook.com>
References: <fb869c88bd48ea9018e1cc349918aa7cdd524931.camel@redhat.com>
 <YzW+Mz12JT1BXoZA@kbusch-mbp.dhcp.thefacebook.com>
 <a2825beac032fd6a76838164d4e2753d30305897.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2825beac032fd6a76838164d4e2753d30305897.camel@redhat.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 07:16:29PM +0300, Maxim Levitsky wrote:
> On Thu, 2022-09-29 at 09:48 -0600, Keith Busch wrote:
> > I am aware, and I've submitted the fix to qemu here:
> > 
> >   https://lists.nongnu.org/archive/html/qemu-block/2022-09/msg00398.html
> > 
> 
> 
> Thanks for quick response!
> 
> Question is though, isn't this an kernel ABI breakage?

I don't think so. Memory alignment and length granularity are two completely
different concepts. If anything, the kernel's ABI had been that the length
requirement was also required for the memory alignment, not the other way
around. That usage will continue working with this kernel patch.
