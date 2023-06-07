Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD426725A49
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 11:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239978AbjFGJ0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 05:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239985AbjFGJ0c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:26:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C05173B;
        Wed,  7 Jun 2023 02:26:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB93161549;
        Wed,  7 Jun 2023 09:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74033C433D2;
        Wed,  7 Jun 2023 09:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686129968;
        bh=90WN1yUXLJUe3ExTCrm+9/jICeRfh1xqidoess9eZgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G11EvijrXOft/4fKmPbcLsj96l6rzLAMnuaIxMBioke+aBkOZjX0wCH/9fvhIEjex
         bWiAASMid1pQ95ExZeH4vBW5SM8ilf/NZQVWxNMB0WOYPM9glBZMCr5Ac+of7EpC67
         IUolHFn7wPq/SIHTgNke/TvkzfU5n52aulKZAQmc9SU6wqZjH3wTf5zcRlPc+Be0ZI
         tjYNjFG0WWy5oyTijsqkj/wvHS1IkYB4WeHa/KebFhUJ8MLJna0IALZB24dyM/p5Fl
         3AtWIIUlxdg9dCBor+iOy3BYRPzpRSoLmgc+mM3rrS6ylvh7XsRdf+ZYu3eLpchVoc
         BEZRzrMhzDVIg==
Date:   Wed, 7 Jun 2023 11:25:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 31/31] fs: remove the now unused FMODE_* flags
Message-ID: <20230607-lehne-marken-17b031dd9165@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-32-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-32-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 09:39:50AM +0200, Christoph Hellwig wrote:
> FMODE_NDELAY, FMODE_EXCL and FMODE_WRITE_IOCTL were only used for
> block internal purposed and are now entirely unused, so remove them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Love it,
Reviewed-by: Christian Brauner <brauner@kernel.org>
