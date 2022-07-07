Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537B456A768
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 18:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiGGQGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 12:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbiGGQGv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:06:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4F5313AA;
        Thu,  7 Jul 2022 09:06:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9595BB8229B;
        Thu,  7 Jul 2022 16:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F89FC3411E;
        Thu,  7 Jul 2022 16:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657210008;
        bh=oPBwVTVUTBS4gk+6cwOddlL8JaBrmv0EYfh3pizuiGg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SH4PvLTcKL4XlgKChSv8Bjzcl7z3/oPrHT5tHUJ1nCC54KKrGZfuY9cGH3OnRXc+a
         CfPv5ZpHFxJEITwjSndmKooeT6IU1Msw7FaqlBHtM7V5r8tx9l5wAhRby/JnJTFhum
         SEkdiXlCWeaMYqL1LeNlCFIZVJhx9pTsA0nMP59mVzr9hfGNGD+KwELdmeAJsXL7up
         xVskuo8JR++AKNy57oqAlE4+qf6CqRfnSryxFmlysFWhwXkjv1w1uQKCjYVBz3H1Za
         p4CaSap5Q2PmFjnGwFky5oNdcBcgNC61SVL7BMBLEF2Jza3phKLakrO93NlpivhIBL
         5o6Vh/nJWAkqQ==
Date:   Thu, 7 Jul 2022 11:06:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] pci/doe: Use devm_xa_init()
Message-ID: <20220707160646.GA306751@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705232159.2218958-3-ira.weiny@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 05, 2022 at 04:21:58PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The XArray being used to store the protocols does not even store
> allocated objects.

I guess the point is that the doe_mb->prots XArray doesn't reference
any other objects that would need to be freed when destroying
doe_mb->prots?  A few more words here would make the commit log more
useful to non-XArray experts.

s|pci/doe|PCI/DOE| in subject to match the drivers/pci convention.

> Use devm_xa_init() to automatically destroy the XArray when the PCI
> device goes away.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/pci/doe.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 0b02f33ef994..aa36f459d375 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -386,13 +386,6 @@ static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
>  	return 0;
>  }
>  
> -static void pci_doe_xa_destroy(void *mb)
> -{
> -	struct pci_doe_mb *doe_mb = mb;
> -
> -	xa_destroy(&doe_mb->prots);
> -}
> -
>  static void pci_doe_destroy_workqueue(void *mb)
>  {
>  	struct pci_doe_mb *doe_mb = mb;
> @@ -440,11 +433,8 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
>  	doe_mb->pdev = pdev;
>  	doe_mb->cap_offset = cap_offset;
>  	init_waitqueue_head(&doe_mb->wq);
> -
> -	xa_init(&doe_mb->prots);
> -	rc = devm_add_action(dev, pci_doe_xa_destroy, doe_mb);
> -	if (rc)
> -		return ERR_PTR(rc);
> +	if (devm_xa_init(dev, &doe_mb->prots))
> +		return ERR_PTR(-ENOMEM);
>  
>  	doe_mb->work_queue = alloc_ordered_workqueue("DOE: [%x]", 0,
>  						     doe_mb->cap_offset);
> -- 
> 2.35.3
> 
