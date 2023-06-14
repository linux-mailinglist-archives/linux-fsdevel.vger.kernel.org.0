Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00257304D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 18:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjFNQYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 12:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFNQYN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:24:13 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F19D109;
        Wed, 14 Jun 2023 09:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tL93bI0jCWhGF3WG58T3OaJIDMhjtKg7c9c3OsvljCg=; b=qpvSUqzkIvq2pf6t36jXKr2o0P
        1Bb6JiMkPcXkWHbaeticZajm/w8h5A8KKPUZjGIRbHW1DdbuoG5p+MfHoSC4KyGHTCJbyBZ9suO+Y
        l3/uYhPVsVfLBLNYjylwXFXfZHY644VQ5UpytE3b/DsndFToTAGZr5m2Fao8tNA2x4KTW/eg8XS2m
        obtH625jiwihlTyS/r+/aJBLQSmUpUfWPSPEAqhgxgEIOMyMO/VjPTTlWxg+8flWGQIVe1ZsawW89
        v6JZszuL/Hepl08MvDDCE1E/v81nXvJ0s5ZhpW4WsMhzRvVkRTyADmSpQ/jCS3jUEdnRV7fo6roLT
        eoZnZJ4g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40838)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q9THx-0001yP-1A; Wed, 14 Jun 2023 17:24:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q9THu-0000Z3-LM; Wed, 14 Jun 2023 17:24:02 +0100
Date:   Wed, 14 Jun 2023 17:24:02 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Wei Chin Tsai <Wei-chin.Tsai@mediatek.com>
Cc:     lkp@intel.com, angelogioacchino.delregno@collabora.com,
        ivan.tseng@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        mel.lee@mediatek.com, oe-kbuild-all@lists.linux.dev,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v3 1/1] memory: Fix export symbol twice compiler error
 for "export symbols for memory related functions" patch
Message-ID: <ZInpooYdKnhdm3SW@shell.armlinux.org.uk>
References: <202306142030.GjGWnIkY-lkp@intel.com>
 <20230614153902.26206-1-Wei-chin.Tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614153902.26206-1-Wei-chin.Tsai@mediatek.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 11:39:02PM +0800, Wei Chin Tsai wrote:
> User could not add the export symbol "arch_vma_name"
> in arch/arm/kernel/process.c and kernel/signal.c both.
> It would cause the export symbol twice compiler error
> Reported-by: kernel test robot <lkp@intel.com>
> 
> Signed-off-by: Wei Chin Tsai <Wei-chin.Tsai@mediatek.com>

I'm sorry, but this patch is silly.

> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index df91412a1069..d71a9bafb584 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -343,7 +343,10 @@ const char *arch_vma_name(struct vm_area_struct *vma)
>  {
>  	return is_gate_vma(vma) ? "[vectors]" : NULL;
>  }
> +
> +#ifdef CONFIG_ARM
>  EXPORT_SYMBOL_GPL(arch_vma_name);
> +#endif

CONFIG_ARM will always be set here, so adding this ifdef is useless.

> diff --git a/kernel/signal.c b/kernel/signal.c
> index a1abe77fcdc3..f7d03450781e 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -4700,7 +4700,10 @@ __weak const char *arch_vma_name(struct vm_area_struct *vma)
>  {
>  	return NULL;
>  }
> +
> +#ifdef CONFIG_ARM64
>  EXPORT_SYMBOL_GPL(arch_vma_name);
> +#endif

Sorry, but no.

Please do the research I've now twice asked for.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
