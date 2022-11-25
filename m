Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C464363829A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 04:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiKYDGz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 22:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiKYDGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 22:06:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020802AC52;
        Thu, 24 Nov 2022 19:06:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D1DF6228D;
        Fri, 25 Nov 2022 03:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E788C433C1;
        Fri, 25 Nov 2022 03:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669345607;
        bh=llHY7MD0O4KbESr1IfNXkVxCsoqrf0x1miTbM2if/kA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uf+swNBqVug8dnkjGi6j5UuJv+OHqO452APhypTnl+OgAgmoG1eNJj6PQA/nx740l
         bDRO8mPlFQlAEgMrIqonf3SYk+ebcgd0HVpmilOxa/FlykLTL0CuA0cf529MnNZHUT
         F1QJC/Uf4LKJc+9GglTGXmqc3eiqAGc5adZ41SgUuAsFwFCy11GLEYIn82xSFNA2V2
         ODOPItWvuSlW0Z7vytudtYwqRgmAulY9ack9BPMsctSVjPoTgGEbzTM/YAtmDbvWa8
         w7nKZDg0sqSaH0MXwR35X0YjMZu8w4Er9mbgv0Ftws+wNn+rIk2koBy+iXUdCkbS87
         zYTcQc0QtymHg==
Message-ID: <4b0a548a-5b04-24a6-944d-348d15605dd2@kernel.org>
Date:   Fri, 25 Nov 2022 11:06:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] fsverity: stop using PG_error to track error status
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-f2fs-devel@lists.sourceforge.net
References: <20221028175807.55495-1-ebiggers@kernel.org>
 <Y2y0cspSZG5dt6c+@sol.localdomain> <Y36ccbZq9gsnbmWw@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y36ccbZq9gsnbmWw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/11/24 6:19, Eric Biggers wrote:
> On Thu, Nov 10, 2022 at 12:21:06AM -0800, Eric Biggers wrote:
>> On Fri, Oct 28, 2022 at 10:58:07AM -0700, Eric Biggers wrote:
>>> From: Eric Biggers <ebiggers@google.com>
>>>
>>> As a step towards freeing the PG_error flag for other uses, change ext4
>>> and f2fs to stop using PG_error to track verity errors.  Instead, if a
>>> verity error occurs, just mark the whole bio as failed.  The coarser
>>> granularity isn't really a problem since it isn't any worse than what
>>> the block layer provides, and errors from a multi-page readahead aren't
>>> reported to applications unless a single-page read fails too.
>>>
>>> f2fs supports compression, which makes the f2fs changes a bit more
>>> complicated than desired, but the basic premise still works.
>>>
>>> Signed-off-by: Eric Biggers <ebiggers@google.com>
>>> ---
>>>
>>> In v3, I made a small simplification to the f2fs changes.  I'm also only
>>> sending the fsverity patch now, since the fscrypt one is now upstream.
>>>
>>>   fs/ext4/readpage.c |  8 ++----
>>>   fs/f2fs/compress.c | 64 ++++++++++++++++++++++------------------------
>>>   fs/f2fs/data.c     | 48 +++++++++++++++++++---------------

Hi Eric,

Result of "grep PageError fs/f2fs/* -n"

...
fs/f2fs/gc.c:1364:      ClearPageError(page);
fs/f2fs/inline.c:177:   ClearPageError(page);
fs/f2fs/node.c:1649:    ClearPageError(page);
fs/f2fs/node.c:2078:            if (TestClearPageError(page))
fs/f2fs/segment.c:3406: ClearPageError(page);

Any plan to remove above PG_error flag operations? Maybe in a separated patch?

Thanks,

>>>   fs/verity/verify.c | 12 ++++-----
>>>   4 files changed, 67 insertions(+), 65 deletions(-)
>>
>> I've applied this to the fsverity tree for 6.2.
>>
>> Reviews would be greatly appreciated, of course.
>>
> 
> Jaegeuk and Chao, can I get a review or ack from one of you?
> 
> - Eric
