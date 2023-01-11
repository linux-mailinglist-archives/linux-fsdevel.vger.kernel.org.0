Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605DB665741
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 10:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjAKJUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 04:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbjAKJUU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:20:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AEF8FC6;
        Wed, 11 Jan 2023 01:20:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 002C4B819CB;
        Wed, 11 Jan 2023 09:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E71C433D2;
        Wed, 11 Jan 2023 09:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673428810;
        bh=IIpBxlU0L54DWke4zCReMXd6KogdrVXfkHzyJQ5ykD4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mjxlvowW9RrfOKcbOBRXfs+pO86ATZQXIAsDyv/o+87R7CjIWJqel5HdZjBYxe02k
         FRpKzLEvrpRVsh7ANAbn738SITntjHRbKyUgKmcjnLDrBurqmmJHg+Q1PD5sNhi65H
         /Gc6tfZHy9xGtKW4v817BHa2t4oI0qzHH5MAO1gdwsBqf0H4mrXhZcJ/ua411wob49
         c5tDgzcA2UL0+3AFHMEds0D10vrLembhx5HV9ZVZdOMbCNITeWri26UwggKFXmA/lF
         UG8cXHfV4k4tPGtMCBLJ4w878CQN+4jQ1gFdZ7jWFNCzRRLPUPukOSZ6nkkXucpvKh
         LlKTp8SDQrgZQ==
Message-ID: <0dca406a-e331-a8f7-da8d-95ba89705598@kernel.org>
Date:   Wed, 11 Jan 2023 17:20:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] proc: introduce proc_statfs()
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230110152003.1118777-1-chao@kernel.org> <Y72nPcDDC/+10lYK@p183>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Y72nPcDDC/+10lYK@p183>
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

On 2023/1/11 1:58, Alexey Dobriyan wrote:
> On Tue, Jan 10, 2023 at 11:20:03PM +0800, Chao Yu wrote:
>> Introduce proc_statfs() to replace simple_statfs(), so that
>> f_bsize queried from statfs() can be consistent w/ the value we
>> set in s_blocksize.
>>
>> stat -f /proc/
>>
>> Before:
>>      ID: 0        Namelen: 255     Type: proc
>> Block size: 4096       Fundamental block size: 4096
>> Blocks: Total: 0          Free: 0          Available: 0
>> Inodes: Total: 0          Free: 0
>>
>> After:
>>      ID: 0        Namelen: 255     Type: proc
>> Block size: 1024       Fundamental block size: 1024
>> Blocks: Total: 0          Free: 0          Available: 0
>> Inodes: Total: 0          Free: 0
> 
> 4096 is better value is in fact.
> 
> seq_files allocate 1 page and fill it, therefore reading less than
> PAGE_SIZE from /proc is mostly waste of syscalls.

Ah, thanks for correcting me, so, how about updating .s_blocksize and
.s_blocksize_bits to PAGE_SIZE and PAGE_SHIFT?

> 
> I doubt anything uses f_bsize.
> 
> BTW this patch is not self contained.

Oh, yes, my bad.

Thanks,

