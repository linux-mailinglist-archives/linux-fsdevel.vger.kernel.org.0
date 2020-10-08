Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5025E287D43
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 22:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgJHUe2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 16:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJHUe1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 16:34:27 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5A4C0613D2;
        Thu,  8 Oct 2020 13:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=p+sWvwr5fj3pIZ69PzilhbvvjIg6DA9KEI2Chppr5F4=; b=bbnVi60TUED7FdFwXGm/6JNPKU
        IOEkniGGLwDwcUwfAWG2L/C0kH6MDFl2XNbtMO16r/cTZMxx2xjKTJpKg9/Xh0TU5UOvLlx/8o8/R
        EJTO/Hz2jeRC1Nl7Kv7bZa/cv/AO0kRX6AnGzrw/nFvLbRVMxh0CS4mje/auiqQSLCNtaZZNxFmYx
        svPDfWytLKSQskS6r4KvBsM6nBHLk8VUNkNoNHfqlqiafeiQ6W7tSasegcd52nB7fMsysKopaCiln
        o8GyaF0Ujr9b+7sHjkp98rSuv19gpCvCRUptueg/EG8YCBvbAJFs28kr3pTWyRz1BDMqPlkIweEjm
        phJU3bhA==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQccC-0001ZY-49; Thu, 08 Oct 2020 20:34:16 +0000
Subject: Re: [PATCH 02/35] mm: support direct memory reservation
To:     yulei.kernel@gmail.com, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, viro@zeniv.linux.org.uk,
        pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
 <2fbc347a5f52591fc9da8d708fef0be238eb06a5.1602093760.git.yuleixzhang@tencent.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b1703e32-052a-e56b-a4d3-ddd361953f6d@infradead.org>
Date:   Thu, 8 Oct 2020 13:34:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2fbc347a5f52591fc9da8d708fef0be238eb06a5.1602093760.git.yuleixzhang@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/20 12:53 AM, yulei.kernel@gmail.com wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a1068742a6df..da15d4fc49db 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -980,6 +980,44 @@
>  			The filter can be disabled or changed to another
>  			driver later using sysfs.
>  
> +	dmem=[!]size[KMG]
> +			[KNL, NUMA] When CONFIG_DMEM is set, this means
> +			the size of memory reserved for dmemfs on each numa

			                                               NUMA

> +			memory node and 'size' must be aligned to the default
> +			alignment that is the size of memory section which is
> +			128M on default on x86_64. If set '!', such amount of

			     by default

> +			memory on each node will be owned by kernel and dmemfs
> +			own the rest of memory on each node.

			owns

> +			Example: Reserve 4G memory on each node for dmemfs
> +				dmem = 4G

IIRC, you don't want spaces in this example.
Or did you check? Does the kernel's command line parser accept & ignore spaces like these?


> +
> +	dmem=[!]size[KMG]:align[KMG]
> +			[KNL, NUMA] Ditto. 'align' should be power of two and
> +			it's not smaller than the default alignment. Also

	drop "it's"

> +			'size' must be aligned to 'align'.
> +			Example: Bad dmem parameter because 'size' misaligned
> +				dmem=0x40200000:1G
> +
> +	dmem=size[KMG]@addr[KMG]
> +			[KNL] When CONFIG_DMEM is set, this marks specific
> +			memory as reserved for dmemfs. Region of memory will be
> +			used by dmemfs, from addr to addr + size. Reserving a
> +			certain memory region for kernel is illegal so '!' is
> +			forbidden. Should not assign 'addr' to 0 because kernel
> +			will occupy fixed memory region begin at 0 address.

			                                beginning

> +			Ditto, 'size' and 'addr' must be aligned to default
> +			alignment.
> +			Example: Exclude memory from 5G-6G for dmemfs.
> +				dmem=1G@5G
> +
> +	dmem=size[KMG]@addr[KMG]:align[KMG]
> +			[KNL] Ditto. 'align' should be power of two and it's

		Drop "it's"

> +			not smaller than the default alignment. Also 'size'
> +			and 'addr' must be aligned to 'align'. Specially,
> +			'@addr' and ':align' could occur in any order.
> +			Example: Exclude memory from 5G-6G for dmemfs.
> +				dmem=1G:1G@5G
> +
>  	driver_async_probe=  [KNL]
>  			List of driver names to be probed asynchronously.
>  			Format: <driver_name1>,<driver_name2>...


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
