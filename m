Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA399775C78
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 13:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjHIL1r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 07:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbjHIL1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:27:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7932127
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 04:27:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1DBD632C2
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Aug 2023 11:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71591C433C7;
        Wed,  9 Aug 2023 11:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691580454;
        bh=t5yz09PDBlVRxMAKora8JAMsfeSnC1sppEW8A4+VfMk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LD1yHBpJy8EooiWkrwpnIVcERfGtAKnz8PrSzAuMi8hox4lWmHxQPBUYPl9zIOYRq
         m/lVaP2NFsC8nLPw2a0KPulCyku5kup2PPpCV5I4AWjvwPGHPZ3+OxA0LRIQ/0BzfG
         fhI1WGRqEhskNhB4xJlAfLPMObzwlyaZAN4/4hTuu5BtDvNS1W1iRVFVEXky6gl4n/
         ubC8H8oDof3aGSJPyGtCn2QXwTCkvrrfzCdEIlMD3SHqQaif59XT1hjY2ftmCjl1K0
         CwInUUgx363nF0Dti15cE5p09RthxprTyrCgpMDmrrzsJQk5mhxBBLm0o2g/PTrYVz
         A4BUWOW8GDTxg==
Message-ID: <40ebebd8-f352-54a5-0f25-5091fc4dde79@kernel.org>
Date:   Wed, 9 Aug 2023 20:27:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] zonefs: fix synchronous direct writes to sequential files
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <20230809030400.700093-1-dlemoal@kernel.org>
 <vrxildteooj62kofwbjofygl3wnot7p5vf23fjohgxfphw6zgj@4jeykkfpgk6z>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <vrxildteooj62kofwbjofygl3wnot7p5vf23fjohgxfphw6zgj@4jeykkfpgk6z>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/9/23 18:08, Shinichiro Kawasaki wrote:
> On Aug 09, 2023 / 12:04, Damien Le Moal wrote:
>> Commit 16d7fd3cfa72 ("zonefs: use iomap for synchronous direct writes")
>> changes zonefs code from a self-built zone append BIO to using iomap for
>> synchronous direct writes. This change relies on iomap submit BIO
>> callback to change the write BIO built by iomap to a zone append BIO.
>> However, this change overlloked the fact that a write BIO may be very
> 
> I found some typos in the commit message. I guess you forgot to run spell
> checker. FYI, here I note the typos found.

Hmmm... I did run checkpatch... Weird. Anyway, thansk, I will send v2 with
corrections.

> 
> s/overlloked/overlooked/
> 
>> large as it is split when issued. The change from a regular write to a
>> zone append operation for the built BIO can result in a block layer
>> warning as zone append BIO are not allowed to be split.
>>
> [...]
>>
>> Manually splitting the zone append BIO using bio_split_rw() can solve
>> this issue but also requires issuing the fragment BIOs sunchronously
> 
> s/sunchronously/synchronously/
> 
>> with submit_bio_wait(), to avoid potential reordering of the zone append
>> BIO fragments, which would lead to data corruption. That is, this
>> solution is not better than using regular write BIOs which are subject
>> to serialization using zone write locking at the IO scheduler level.
>>
>> Given this, fix the issue by removing zone append support and uisng
> 
> s/uisng/using/
> 
>> regular write BIOs for synchronous direct writes. This allows preseving
> 
> s/preserving/preserving/
> 
>> the use of iomap and having iidentical synchronous and asynchronous
> 
> s/iidentical/identical/
> 
>> sequential file write path. Zone append support will be reintroduced
>> later through io_uring commands to ensure that the needed special
>> handling is done correctly.
>>
>> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> I confirmed that this patch avoids the issue that I reported [*]. Thanks!
> 
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> [*] https://lore.kernel.org/linux-nvme/20230731114632.1429799-1-shinichiro.kawasaki@wdc.com/

-- 
Damien Le Moal
Western Digital Research

