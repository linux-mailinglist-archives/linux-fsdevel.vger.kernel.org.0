Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F6C711AD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 01:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241819AbjEYXqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 19:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241710AbjEYXqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 19:46:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2374135;
        Thu, 25 May 2023 16:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 442376453E;
        Thu, 25 May 2023 23:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54892C433D2;
        Thu, 25 May 2023 23:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685058406;
        bh=rjbndO/LAuL+bviGPDqErD8/rV2wobnhP+qhDHN9E4Q=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=lmUBO/G8cDI/xJ0BHixdkUE4jvqYFoP8+qUtkYNCqKbMFgAjdB7r4y/y9JO15Q3n7
         H34uqGeMvqEChTuUqYQaR9Mf5FUFO5Y65W4Ayy84AutEeNfaPufa6tYhre4LxwSJ+Y
         g9NAtEiUQu1YP0LQwo1OVt9pp8QPXGxoqjp9BQw4GsdeAJrxbX5N/l6BJBiV2binEa
         2CDIoi+WlxnqUTqvvnDZ1zjWq7YhwD6ccz71I3vuZ1VnFEVDHPSRhEmdq5vifp0s5S
         wAaNTvVdxPzncebRJBciwvgJO7voJ7aFxqrwuoq1gP4nBV8nSlUN1xp0eunLBMg/44
         kw8Dr5VkXKtqg==
Message-ID: <8b803ab8-f8ee-259f-8d30-1d14d34dc1e4@kernel.org>
Date:   Fri, 26 May 2023 08:46:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] zonefs: Call zonefs_io_error() on any error from
 filemap_splice_read()
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@kvack.org
References: <3788353.1685003937@warthog.procyon.org.uk>
 <ZG99DRyH461VAoUX@casper.infradead.org>
 <9d1a3d1a-b726-5144-4911-de6b77d9bf02@kernel.org>
Organization: Western Digital Research
In-Reply-To: <9d1a3d1a-b726-5144-4911-de6b77d9bf02@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/26/23 08:04, Damien Le Moal wrote:
> On 5/26/23 00:21, Matthew Wilcox wrote:
>> On Thu, May 25, 2023 at 09:38:57AM +0100, David Howells wrote:
>>>     
>>> Call zonefs_io_error() after getting any error from filemap_splice_read()
>>> in zonefs_file_splice_read(), including non-fatal errors such as ENOMEM,
>>> EINTR and EAGAIN.
>>>
>>> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
>>> Link: https://lore.kernel.org/r/5d327bed-b532-ad3b-a211-52ad0a3e276a@kernel.org/
>>
>> This seems like a bizarre thing to do.  Let's suppose you got an
>> -ENOMEM.  blkdev_report_zones() is also likely to report -ENOMEM in
>> that case, which will cause a zonefs_err() to be called.  Surely
>> that can't be the desired outcome from getting -ENOMEM!
> 
> Right... What I want to make sure here is that the error we get is not the
> result of a failed IO. Beside EIO, are there any other cases ?
> I can think of at least:
> 1) -ETIMEDOUT -> the drive is not responding. In this case, calling
> zonefs_io_error() may not be useful either.
> 2) -ETIME: The IO was done with a duration limit (e.g. active time limit) and
> was aborted by the drive because it took too long. Calling zonefs_io_error() for
> this case is also not useful.
> 
> But I am thinking block layer (blk_status_t to errno conversion) here. Does the
> folio code *always* return EIO if it could not get a page/folio, regardless of
> the actual bio status ?

Replying to myself :)

iomap_read_folio() or iomap_finish_folio_read() -> folio_set_error(), which sets
PG_error. Then filemap_read_folio() will see !folio_test_uptodate(folio) and end
up returning -EIO. So if there was an IO and it failed, we always get EIO,
regardless of the actual reason for the IO failure. Right ?

-- 
Damien Le Moal
Western Digital Research

