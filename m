Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36CA725EDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 14:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240677AbjFGMU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 08:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240536AbjFGMU4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:20:56 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7501BE6;
        Wed,  7 Jun 2023 05:20:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C229F6732D; Wed,  7 Jun 2023 14:20:41 +0200 (CEST)
Date:   Wed, 7 Jun 2023 14:20:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Richard Weinberger <richard@nod.at>,
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
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 05/31] cdrom: track if a cdrom_device_info was opened
 for data
Message-ID: <20230607122041.GA14579@lst.de>
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-6-hch@lst.de> <a7524776-f4c3-147a-cfa5-da92d2f877bb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7524776-f4c3-147a-cfa5-da92d2f877bb@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 07, 2023 at 02:13:33PM +0200, Hannes Reinecke wrote:
>> +++ b/include/linux/cdrom.h
>> @@ -64,6 +64,7 @@ struct cdrom_device_info {
>>   	int (*exit)(struct cdrom_device_info *);
>>   	int mrw_mode_page;
>>   	__s64 last_media_change_ms;
>> +	bool opened_for_data;
>>   };
>>     struct cdrom_device_ops {
>
> Do we care about alignment here?
> integer followed by a 64 bit value followed by a bool seems
> like an automatic padding to me ...

I don't think the structure matter much here, but placing it before
last_media_change_ms still seems better.  I'll change it.

