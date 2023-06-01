Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42E8719702
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 11:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjFAJdS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 05:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjFAJdR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:33:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44769AA
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 02:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDB006427F
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 09:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7685C433D2;
        Thu,  1 Jun 2023 09:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685611995;
        bh=AUBlHfOzHiU5meV5IwHR4CnjMYsTVCOylLqmSop60Po=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Yr/fmBb0u5ulGJ3RaVChJlgJYWNWmaXKubc1AABNzauQ/SB/qzoDOd9jRlZKGrNze
         VGeNcMjlgFVCEkofrdAkAykVDovxbFpW1l47wUwNt9mxBWYNyHCYbrRNnDWjcM79un
         OmxOTEM0738/yy7R6ighydjZzOJsFXh935hwTo9aEX0t/ayHHvrO0OtJrzxR9ZLoUM
         ojTFkIKdAJ6dvAbBufbcsq1qVLhHVUOUcWxAKJ0hs55FTKFCDiOeyi0nhxRadoDpi6
         AV9mtqXD3wtzDoPACPoakThYXDUf71GbKllUqpswVNQRNL6+A/NK0kF9Gr4pCtfu7q
         PHLZhC+RGXRaw==
Message-ID: <98aa3e4a-e84d-b66b-a7df-42a41961183c@kernel.org>
Date:   Thu, 1 Jun 2023 18:33:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] zonefs: use iomap for synchronous direct writes
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230601082652.181695-1-dlemoal@kernel.org>
 <20230601092719.GA5774@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230601092719.GA5774@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/1/23 18:27, Christoph Hellwig wrote:
>> +struct zonefs_bio {
>> +	/* The target inode of the BIO */
>> +	struct inode *inode;
>> +
>> +	/* For sync writes, the target write offset */
>> +	u64 woffset;
> 
> Maybe spell out write_offset?

Yep. will do as I need to send a v2 anyway as I am seeing random test failure of
the case handling writes to offline zones. Not sure why. Debugging.

> 
>> +
>> +static void zonefs_file_sync_write_dio_bio_end_io(struct bio *bio)
>> +{
>> +	struct zonefs_bio *zbio;
>> +	struct zonefs_zone *z;
>> +	sector_t wsector;
>> +
>> +	if (bio->bi_status != BLK_STS_OK)
>> +		goto bio_end;
>> +
>> +	/*
>> +	 * If the file zone was written underneath the file system, the zone
>> +	 * append operation can still succedd (if the zone is not full) but
>> +	 * the write append location will not be where we expect it to be.
>> +	 * Check that we wrote where we intended to, that is, at z->z_wpoffset.
>> +	 */
>> +	zbio = zonefs_bio(bio);
>> +	z = zonefs_inode_zone(zbio->inode);
> 
> I'd move thses to the lines where the variables are declared.

OK

> 
>> +	wsector = z->z_sector + (zbio->woffset >> SECTOR_SHIFT);
>> +	if (bio->bi_iter.bi_sector != wsector) {
>> +		zonefs_warn(zbio->inode->i_sb,
>> +			    "Invalid write sector %llu for zone at %llu\n",
>> +			    bio->bi_iter.bi_sector, z->z_sector);
>> +		bio->bi_status = BLK_STS_IOERR;
>> +	}
> 
> Seems like all this is actually just debug code and could be conditional
> and you could just use the normal bio pool otherwise?

Without this, the zonefs_bio struct and bio_end_io op are not even needed. That
would simplify things but I really would like to keep this around to be able to
detect file corruptions.

> 
>> +static struct bio_set zonefs_file_write_dio_bio_set;
>>  

-- 
Damien Le Moal
Western Digital Research

