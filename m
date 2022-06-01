Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC0A53AAC0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 18:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355298AbiFAQMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 12:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354085AbiFAQMb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:12:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CC52F03F;
        Wed,  1 Jun 2022 09:12:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B6636158B;
        Wed,  1 Jun 2022 16:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22701C385A5;
        Wed,  1 Jun 2022 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654099950;
        bh=jSnrwYSVVVvv/EVLj+vJtrVjvZIMaAqiU7n/yR71jag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BcO4g5pMQyTvHAaJh0kq+ldttn7ioefubEEGsAsNtV9459J87cLQEvJ2AuWleSaF4
         IeoJlH5F5Mvjt+mX9KLQfIKuRcqmALpsVyPaypdfk1XtjMibbVwx9zKbxEg7eUfv43
         AeHz55hf49N5ylHSX4CBa2CRdpp9psYWINWSSIZrnzFvuj+z46v/CUfElQ6v2ahIXg
         1nEd+ogKt6kj+4wQpBdN8hRuVPC4lKAGHRqXSFO1xN/O/oOEuH/fUbP0lqDRxPmLjt
         aQa5C2NBQsJ/SuUZgWXJEXv7vbnUDarSFJ/5vvzsdnQ8WBEsUQdzw1NKAYenzKBmiu
         wrcC3meP4XWrA==
Date:   Wed, 1 Jun 2022 10:12:26 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com
Subject: Re: [PATCHv5 00/11] direct-io dma alignment
Message-ID: <YpeP6u0XXAPra3MV@kbusch-mbp.dhcp.thefacebook.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
 <YpcRLKwZpN+NQRxn@sol.localdomain>
 <Ypd3j9ABXhIuQDbt@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ypd3j9ABXhIuQDbt@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 01, 2022 at 08:28:31AM -0600, Keith Busch wrote:
> On Wed, Jun 01, 2022 at 12:11:40AM -0700, Eric Biggers wrote:
> > I still don't think you've taken care of all the assumptions that bv_len is a
> > multiple of logical block size, or at least SECTOR_SIZE.  Try this:
> > 
> > 	git grep -E 'bv_len (>>|/)'
> 
> There are only 8 drivers that set the request_queue's dma alignment, which are
> the only ones that could be affected from this patch series.

It's actually even simpler to audit than that. Of the 8 drivers that explicitly
set dma alignment, only 3 set it to something smaller than a sector size. None
of them assume any particular bv_len, so I think we're fine.
