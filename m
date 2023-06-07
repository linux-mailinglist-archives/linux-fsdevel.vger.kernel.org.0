Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619DC725946
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 11:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbjFGJD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 05:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239245AbjFGJDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:03:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C7E2D5F;
        Wed,  7 Jun 2023 02:01:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C5F6615D2;
        Wed,  7 Jun 2023 09:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FCDC4339E;
        Wed,  7 Jun 2023 09:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686128492;
        bh=g3r5rYOcZPuzhWXIH0bYKBRPgwc3E1p0pJA/TrUWYf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rP0+sQU05ytYS6k6BMHqTVzyKjsFFQ6Wnfz9kTwbzFygygaENxsZpLVLE+i0Qat/T
         H9xyY75epM433AvDHOzMGZ5nCVlaptMhX5S2jj2AOMVumZAKr75qlxAmdCSJnS6NUd
         7tqPBZriCMC3nI9evGotlI0qLb0BdyIVBS77Pfxw7PBbtd9IVfScHPRbniWMpCV7lR
         55VKlh0TF/3SRbWeQbPAZTyUSElyLojLOoq4PjR4jgVaJ3PzHPr6hWQJhpR6zvmzyU
         fgP8TlXGFzHd65cVjqzqqQynkH3SXjh0FCcoqjywuH9MLmxBXvOdpNSU1a7eORehO/
         8mV+t8uVMgcTQ==
Date:   Wed, 7 Jun 2023 11:01:24 +0200
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
Subject: Re: [PATCH 24/31] rnbd-srv: replace sess->open_flags with a "bool
 readonly"
Message-ID: <20230607-getadelt-pfauenauge-75adb3f04015@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-25-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-25-hch@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 06, 2023 at 09:39:43AM +0200, Christoph Hellwig wrote:
> Stop passing the fmode_t around and just use a simple bool to track if
> an export is read-only.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>
