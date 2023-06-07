Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FCB725A40
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 11:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239944AbjFGJZa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 05:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240036AbjFGJZI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:25:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179BC1712;
        Wed,  7 Jun 2023 02:25:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FD2363396;
        Wed,  7 Jun 2023 09:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA78C433EF;
        Wed,  7 Jun 2023 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686129904;
        bh=PVPEiqQnbOrHGRENvLEdaR/nzeey8b8ZshNSuWbTzrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ALdNOSLUKbyG4MtN9g4NY65h2phNBq7vkw8myPQgpJG2PzaM8f/SVslVCmF/QOc3T
         Bwp8JuH17KAppuZAf9ArpxZTmb2lgZ7cED8j2ebPZYTj2IOo1Pq/kE6GkpjP2srCxN
         XuLDkhy5x7omz7gFdxwTAPV7lc6Gdyrkd5NATTyExP7JIaWtEnHvRju/P8W1jwC/ZQ
         pgr661S3TGnNa0/R8XJs7I9augkFB3fO/k2xICj9Rw66l5DVIPYSNCIJVnNMEfjw+Z
         gguliFEjC8Gq4dp0LyuKCQZnO9AA7rkPsqLnWoRqyaIZ4YpfwuJwZivsVp2KmUYvZJ
         O4+xhtnOR9qOw==
Date:   Wed, 7 Jun 2023 11:24:55 +0200
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
Subject: Re: [PATCH 30/31] block: store the holder in file->private_data
Message-ID: <20230607-verjagen-weise-4fb3d76a6313@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-31-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-31-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 09:39:49AM +0200, Christoph Hellwig wrote:
> Store the file struct used as the holder in file->private_data as an
> indicator that this file descriptor was opened exclusively to  remove
> the last use of FMODE_EXCL.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Feels a bit odd to store the object itself but anyway,
Acked-by: Christian Brauner <brauner@kernel.org>
