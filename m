Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A78E602BCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 14:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiJRMaj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 08:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiJRMac (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:30:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C19BB8C21;
        Tue, 18 Oct 2022 05:30:31 -0700 (PDT)
Received: from [192.168.10.9] (unknown [39.45.244.84])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9A9C96602363;
        Tue, 18 Oct 2022 13:30:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666096229;
        bh=XrK7UDKQ26rBS+50UH9ViTCAxUXkpLoN+e1Isa94oQo=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=QbVvAvx10uxuWUCVHvhs1nQxY/ad3dXtF4UyVrCk2MXOXAuSEVbcXs9cd73OP4YXr
         wM7H8NGGpGLD4oUdIseZ3LsUAczfdh9qzrMWaCbkQbmcnKieBM0DVnZ3wQle7DmiXF
         cHVxJilap0ln6QEcpOPzeNAdG8Q+u/lxwPW6gG6cD+ylvCpiVZa1lESAk4jC9MN3z1
         4f4af2QTKx/nh7uN7WV1BOygZH2Ic8NOjJXf+0058dY9Y1l98r/u3jhfDziKEAh1rj
         ho4jNAbFe87KcNnQ9eNp6OzphKzopvg37e9G4FppvyqmfaYkWKQYqHfaN/FjiJWeoE
         KymKxN3Z6ZMFQ==
Message-ID: <2f95ed2d-6dba-850c-7ae9-5c0ebc05191c@collabora.com>
Date:   Tue, 18 Oct 2022 17:30:20 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Danylo Mocherniuk <mdanylo@google.com>, avagin@gmail.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, corbet@lwn.net,
        david@redhat.com, kernel@collabora.com, krisman@collabora.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        peter.enderborg@sony.com, shuah@kernel.org,
        viro@zeniv.linux.org.uk, willy@infradead.org, emmir@google.com,
        figiel@google.com, kyurtsever@google.com,
        Paul Gofman <pgofman@codeweavers.com>, surenb@google.com
Subject: Re: [PATCH v3 0/4] Implement IOCTL to get and clear soft dirty PTE
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
References: <Y0T2l3HaH2MU8M9m@gmail.com>
 <20221014134802.1361436-1-mdanylo@google.com>
 <474513c0-4ff9-7978-9d77-839fe775d04c@collabora.com>
 <Y06EZNAkLtigZi25@kroah.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y06EZNAkLtigZi25@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/18/22 3:48 PM, Greg KH wrote:
> On Tue, Oct 18, 2022 at 03:36:24PM +0500, Muhammad Usama Anjum wrote:
>> /**
>>   * struct pagemap_sd_args - Soft-dirty IOCTL argument
>>   * @start:		Starting address
>>   * @len:		Length of the region
>>   * @vec:		Output page_region struct array
>>   * @vec_len:		Length of the page_region struct array
>>   * @max_out_page:	Optional max output pages (It must be less than vec_len if
>> specified)
>>   * @flags:		Special flags for the IOCTL
>>   * @rmask:		Special flags for the IOCTL
>>   * @amask:		Special flags for the IOCTL
>>   * @emask:		Special flags for the IOCTL
> 
> What do you mean exactly by "special flags"?
Sorry typo in the comments above. Optional flag can be specified in the 
flag. At the moment, there is only one flag(PAGEMAP_NO_REUSED_REGIONS).

/**
  * struct pagemap_sd_args - Soft-dirty IOCTL argument
  * @start:		Starting address
  * @len:		Length of the region
  * @vec:		Output page_region struct array
  * @vec_len:		Length of the page_region struct array
  * @max_out_page:	Optional max output pages (It must be less than 
vec_len if specified)
  * @flags:		Special flags for the IOCTL
  * @rmask:		Required mask - All of these bits have to be set
  * @amask:		Any mask - Any of these bits are set
  * @emask:		Exclude mask - None of these bits are set
  * @rmask:		Bits that have to be reported to the user in page_region
  */
struct pagemap_scan_args {
	__u64 __user start;
	__u64 len;
	__u64 __user vec;
	__u64 vec_len;
	__u32 max_out_page;
	__u32 flags;
	__u32 rmask;
	__u32 amask;
	__u32 emask;
	__u32 rmask;
};

> 
>>   * @__reserved:		Reserved member to preserve data alignment. Must be 0.
>>   */
>> struct pagemap_sd_args {
>> 	__u64 __user start;
>> 	__u64 len;
>> 	__u64 __user vec; // page_region
> 
> __user is a marking for a pointer, not a u64, right?  Now the fact that
> you treat it like a pointer later in the kernel is different, but that
> shouldn't be on the uapi header file.  You can put it in the kerneldoc,
> which you did not do.
I'll update.

> 
> thanks,
> 
> greg k-h
