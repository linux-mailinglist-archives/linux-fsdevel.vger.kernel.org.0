Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B89B73F3B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjF0Eq4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjF0EqL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:46:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA51F1718;
        Mon, 26 Jun 2023 21:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BC1C60DB7;
        Tue, 27 Jun 2023 04:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C320DC433C0;
        Tue, 27 Jun 2023 04:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687841140;
        bh=ucn6HRgtgdO1FP92IX0w0I9MwtEw6R0qU4AqPCXSKg8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SSBl11VixydpZ6zBAm7jwaZhhuM4bHk/UzNt1UOzzbj03gC5Nq77bwyBqIfXcjBnw
         6HCALvPcIhNBf+LMdrSAIaXRKBwzz4pJ3CorLTcCBADVoOdS2GOqBZsdI0ZTmaqfxB
         j40PNw9doeECWjz5jO26F7WOhDyTmPbC8pUW/NGeORc5XPOyCEajRbXY3iOigNvX3f
         SukJqB/thOtnC0uF+edmjzye5EWCZA4f6gMQ7RJ5zuXqusirdsARlO/47HOMaaLxht
         bpT5Qrw/VUZIJFLE0VD+pfwDRto4UFD+sE4E/Jya6ZW9gJ/lo3OUAzNTNGWNPedTnj
         gEZbcmEHvh8+Q==
Message-ID: <31ceba83-9d06-8fc6-4688-d568a698a4cc@kernel.org>
Date:   Tue, 27 Jun 2023 13:45:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] zonefs: do not use append if device does not support it
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Andreas Hindborg <nmi@metaspace.dk>
Cc:     "open list:ZONEFS FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        gost.dev@samsung.com, Andreas Hindborg <a.hindborg@samsung.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230626164752.1098394-1-nmi@metaspace.dk>
 <ZJpbUShJUL788r7u@infradead.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZJpbUShJUL788r7u@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/27/23 12:45, Christoph Hellwig wrote:
> On Mon, Jun 26, 2023 at 06:47:52PM +0200, Andreas Hindborg wrote:
>> From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
>>
>> Zonefs will try to use `zonefs_file_dio_append()` for direct sync writes even if
>> device `max_zone_append_sectors` is zero. This will cause the IO to fail as the
>> io vector is truncated to zero. It also causes a call to
>> `invalidate_inode_pages2_range()` with end set to UINT_MAX, which is probably
>> not intentional. Thus, do not use append when device does not support it.
> 
> How do you even manage to hit this code?  Zone Append is a mandatory
> feature and driver need to check it is available.

ublk driver probably is missing that check ? I have not looked at the code for
zone support.

But thinking of it, we probably would be better off having a generic check for
"q->limits.max_zone_append_sectors != 0" in blk_revalidate_disk_zones().

-- 
Damien Le Moal
Western Digital Research

