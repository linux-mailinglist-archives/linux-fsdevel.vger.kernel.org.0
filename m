Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550534E4C82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 07:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiCWGG7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 02:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbiCWGG6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:06:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E606E8DB;
        Tue, 22 Mar 2022 23:05:28 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 44F9768AFE; Wed, 23 Mar 2022 07:05:26 +0100 (CET)
Date:   Wed, 23 Mar 2022 07:05:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/40] btrfs: simplify scrub_recheck_block
Message-ID: <20220323060526.GC24302@lst.de>
References: <20220322155606.1267165-1-hch@lst.de> <20220322155606.1267165-10-hch@lst.de> <2e4640cc-4b21-bbcb-9ba3-23267efb582a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e4640cc-4b21-bbcb-9ba3-23267efb582a@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 08:10:51AM +0800, Qu Wenruo wrote:
>>   		}
>>
>>   		WARN_ON(!spage->page);
>> -		bio = btrfs_bio_alloc(1);
>> -		bio_set_dev(bio, spage->dev->bdev);
>> -
>> -		bio_add_page(bio, spage->page, fs_info->sectorsize, 0);
>> -		bio->bi_iter.bi_sector = spage->physical >> 9;
>> -		bio->bi_opf = REQ_OP_READ;
>> +		bio_init(&bio, spage->dev->bdev, &bvec, 1, REQ_OP_READ);
>> +		__bio_add_page(&bio, spage->page, fs_info->sectorsize, 0);
>
> Can we make the naming for __bio_add_page() better?
>
> With more on-stack bio usage, such __bio_add_page() is really a little
> embarrassing.

__bio_add_page is really just a micro-optimize version of
__bio_add_page for sinle page users like this.  To be honest we should
probably just stop using it and I should not have added it here.
