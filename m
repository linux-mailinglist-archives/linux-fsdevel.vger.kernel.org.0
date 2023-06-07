Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5172572580D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 10:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbjFGIkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 04:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238524AbjFGIkv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:40:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B55B1720;
        Wed,  7 Jun 2023 01:40:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B91C063C4C;
        Wed,  7 Jun 2023 08:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A169C433EF;
        Wed,  7 Jun 2023 08:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686127249;
        bh=rzaXCmDshhO+LXHkp8rQmS2hilpXNGYeK30nLPS+yX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fdSp6N+EchetyNQ9ELQAK0k0bpXVcnAL/B1ILfEopTiSUxSrqA68P9/6Fq9lp/rvs
         0PdaFTqQtL7hh+98jKmzKvAI22ckdJ6mpUM7tqdfwc59mGXZfc2UZr3+kEZoNF9iCd
         rNsY4NJ5wPvPPksQ43AYSH5CsJ9ZZPwPKOSRaPn/FQxz7WMErUvxKsWGr8EuIBUbUv
         GCwjEeBpBb8r5ert952BDHGVamNUJ1fc0KErTkK5SXMdqq0Lpyjam5mGL+HGGvKta5
         OZuoqYdC2LP3lItmJ9t7Vn/pgmrJbGFIX1uT/KEmFPNjK+eme8JXQdHwUEcehzKecl
         PsM6nqwDiF4Hg==
Date:   Wed, 7 Jun 2023 10:40:40 +0200
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
Subject: Re: [PATCH 15/31] btrfs: don't pass a holder for non-exclusive
 blkdev_get_by_path
Message-ID: <20230607-dagegen-bandmitglieder-427b6130afcf@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-16-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 09:39:34AM +0200, Christoph Hellwig wrote:
> Passing a holder to blkdev_get_by_path when FMODE_EXCL isn't set doesn't
> make sense, so pass NULL instead and remove the holder argument from the
> call chains the only end up in non-FMODE_EXCL blkdev_get_by_path calls.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>
