Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB22705AFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 01:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjEPXHj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 19:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjEPXHc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 19:07:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0162535B5;
        Tue, 16 May 2023 16:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x8NCOC5dNuO+EeXO7vXVX1hNNhgjTbmodd02OhrRIPE=; b=46DEdGL7nKcLjwLiOUZcBe+ekZ
        GU31yD15KNjcweKnMTxXy//ryiuocE3/bzYP1Dzm5jCFKdjC+EvP/bqfeE4Eqzq3wP22GbdlKWMMq
        TburDrLdmpn8jQ5C8cxssVXl9ijTbZOPZNsNvQbok3yKXkYQ/tFEoUkZaRBc+CnsTOnXW7PD8uWPf
        0mmaJB7TYHfN2Bb8W77jBsT1sWMbIG6kN2/UV3mmWzlQ5Lxh7z8TYaYzLHREOnZ4fvp7JS+XSuWqi
        U44uI8vPdfcIIzNOLYgssAsGwaLtO3hOg132lQr23qor+57G570UVp3Yp1E5qsf7mCIj6L+eL7pR2
        HVo3TqDw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pz3lQ-007Oz5-2O;
        Tue, 16 May 2023 23:07:28 +0000
Date:   Tue, 16 May 2023 16:07:28 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v3 0/6] sysctl: Remove register_sysctl_table from parport
Message-ID: <ZGQMsKiZUZg+5mFb@bombadil.infradead.org>
References: <CGME20230516162915eucas1p2fdfc03a04f6fe55373e491b97660c8bc@eucas1p2.samsung.com>
 <20230516162903.3208880-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516162903.3208880-1-j.granados@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 06:28:57PM +0200, Joel Granados wrote:
> This is part of the general push to deprecate register_sysctl_paths and
> register_sysctl_table. Parport driver uses the "CHILD" pointer
> in the ctl_table structure to create its directory structure. We move to
> the newer register_sysctl call and remove the pointer madness.
> 
> I have separated the parport into 5 patches to clarify the different
> changes needed for the 3 calls to register_sysctl_paths. I can squash
> them together if need be.
> 
> We no longer export the register_sysctl_table call as parport was the
> last user from outside proc_sysctl.c. Also modified documentation slightly
> so register_sysctl_table is no longer mentioned.
> 
> V2:
> * Added a return error value when register fails
> * Made sure to free the memory on error when calling parport_proc_register
> * Added a bloat-o-meter output to measure bloat
> * Replaced kmalloc with kzalloc
> * Added comments about testing
> * Improved readability when using snprintf

Thanks, applied and pushed!

  Luis
