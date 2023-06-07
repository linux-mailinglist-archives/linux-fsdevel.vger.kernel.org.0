Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F788725937
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 11:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbjFGJCf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 05:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238874AbjFGJCE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:02:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20A926AF;
        Wed,  7 Jun 2023 02:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8137863C9B;
        Wed,  7 Jun 2023 09:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6B9C433D2;
        Wed,  7 Jun 2023 09:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686128424;
        bh=M5xM1l9LuXkX4mSzz59D4IdQFYmmNTr6OfgkeVyfa04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bkgRvGgC50EeuypHe3xl97j+bK6/ZhC9326XXBYH1ZIWYaQ5jbu1O85bi3HGmv9M+
         hZ2SFMqNmWRyraR3Jgx4RRg8awjy8xDqCx+4vNdQpqr+khy+3Nr2thG3oUeGWCmFLy
         XyvLCHm2vTS/PPKFg0NhX/7Rvav0gZ/EJtvHCBmt00R9oRm3Ttf4E19bdvBrMVREuf
         /zBjY37bjH2obx9yTShQpHDAYvGzclq+GoqwGhXKZinmsKkN75qgYYwu5ZHTg6eiYP
         J5jVActoZkfoLY/PBMoBsxKMx6RMvbVXquwF1Lct1mLaflpQuIgCkcbVYTKwI3tb6X
         079ePZ3MnBG6Q==
Date:   Wed, 7 Jun 2023 11:00:16 +0200
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
Subject: Re: [PATCH 23/31] mtd: block: use a simple bool to track open for
 write
Message-ID: <20230607-exakt-fahrzeit-31037992dd33@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-24-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-24-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 09:39:42AM +0200, Christoph Hellwig wrote:
> Instead of propagating the fmode_t, just use a bool to track if a mtd
> block device was opened for writing.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>
