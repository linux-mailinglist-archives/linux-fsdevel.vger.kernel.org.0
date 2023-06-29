Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB0E7423B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 12:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjF2KGf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 06:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjF2KEa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52534203
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 03:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688032920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F09uj+UaHNEb8AMaOUGwCKDcEHZfFZHJu8wPUUcwCrI=;
        b=Su/RzV9hjVavr4r1zDSkVj2KE8pa1UImQIfgu0gb0IN/bEA6h5YTxj1y2+/ZoO7kv/qI4R
        6623eIWwULDPK6VpYPgZZntIHFVzSzQJCX42r+sNvAT7NSSyDTBWvzAL3ieNfzEG/uxWG3
        D8jKz24+F8uJGfxQeTC7zpPnav2G46w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-hEOLKqC3Pb-wi-RdxYgMGg-1; Thu, 29 Jun 2023 06:01:56 -0400
X-MC-Unique: hEOLKqC3Pb-wi-RdxYgMGg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-988907e1b15so53219266b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 03:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688032915; x=1690624915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F09uj+UaHNEb8AMaOUGwCKDcEHZfFZHJu8wPUUcwCrI=;
        b=P2KBqxaaKs7dxT/Bp9oH8AMcoAjyXJes0LdsAGGPotraCGhJc+PsFup809dAk+4npd
         D7i3VKZ4ikUj5aLBhiKflIBVmCYMYHBc+2o8tAWZw7GPxv6A5tQaguMbu2FzPjIpzOD1
         LKBvZsFvzuryQaunNIbFRYvDQUnW1soBWyHQuQ/frEZheoRT0ENtJ6hH8ZCRGD6iSVQc
         70FcPMPpyABqV1UYViGZ+adC4EUgLzSRKVGwvAJR+NLgdJcnDCglFek+sEJxdUw3Z/Kw
         0/NEy6BVWq1E9afSzhGXrlAKjeQgxQMZbenWrTCVRQ0ShJlxR4ya1PEmSUbeW6dtJjgp
         1fkw==
X-Gm-Message-State: AC+VfDwO+cKJbiwRJEbFWjf3gPrv1FkEwLz9uV9IHjQGtI0cbjfOnKfv
        uKiuw56l9Zmcbqlu4o/dzONda1ADkbZpuv/YMI72jTmf4a4EAFvvl6NX5TRRE5R7rzhPt5QQ54j
        gnSKRaq/FabbJe7+z2b/KdjT2fw==
X-Received: by 2002:a17:907:983:b0:94e:2db:533e with SMTP id bf3-20020a170907098300b0094e02db533emr37548544ejc.49.1688032915023;
        Thu, 29 Jun 2023 03:01:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6YkB+iJ0ctUTC2IMrX9Nm0uHG7Qpkh7XlPlyhDmxJMCGzE+kp1VSLYHBbiRoSPJeaNxqGDpA==
X-Received: by 2002:a17:907:983:b0:94e:2db:533e with SMTP id bf3-20020a170907098300b0094e02db533emr37548526ejc.49.1688032914761;
        Thu, 29 Jun 2023 03:01:54 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id rl14-20020a170907216e00b00992ab0262c9sm679883ejb.147.2023.06.29.03.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 03:01:54 -0700 (PDT)
Message-ID: <3105fb11-b599-73c9-5a7b-895ef384a2e3@redhat.com>
Date:   Thu, 29 Jun 2023 12:01:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
Content-Language: en-US
To:     Sumitra Sharma <sumitraartsy@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Fabio <fmdefrancesco@gmail.com>, Deepak R Varma <drv@mailo.com>
References: <20230627135115.GA452832@sumitra.com>
 <ZJxqmEVKoxxftfXM@casper.infradead.org> <20230629092844.GA456505@sumitra.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230629092844.GA456505@sumitra.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 6/29/23 11:28, Sumitra Sharma wrote:
> On Wed, Jun 28, 2023 at 06:15:04PM +0100, Matthew Wilcox wrote:
>> Here's a more comprehensive read_folio patch.  It's not at all
>> efficient, but then if we wanted an efficient vboxsf, we'd implement
>> vboxsf_readahead() and actually do an async call with deferred setting
>> of the uptodate flag.  I can consult with anyone who wants to do all
>> this work.
>>
>> I haven't even compiled this, just trying to show the direction this
>> should take.
>>
>> diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
>> index 2307f8037efc..f1af9a7bd3d8 100644
>> --- a/fs/vboxsf/file.c
>> +++ b/fs/vboxsf/file.c
>> @@ -227,26 +227,31 @@ const struct inode_operations vboxsf_reg_iops = {
>>  
>>  static int vboxsf_read_folio(struct file *file, struct folio *folio)
>>  {
>> -	struct page *page = &folio->page;
>>  	struct vboxsf_handle *sf_handle = file->private_data;
>> -	loff_t off = page_offset(page);
>> -	u32 nread = PAGE_SIZE;
>> -	u8 *buf;
>> +	loff_t pos = folio_pos(folio);
>> +	size_t offset = 0;
>>  	int err;
>>  
>> -	buf = kmap(page);
>> +	do {
>> +		u8 *buf = kmap_local_folio(folio, offset);
>> +		u32 nread = PAGE_SIZE;
>>  
>> -	err = vboxsf_read(sf_handle->root, sf_handle->handle, off, &nread, buf);
>> -	if (err == 0) {
>> -		memset(&buf[nread], 0, PAGE_SIZE - nread);
>> -		flush_dcache_page(page);
>> -		SetPageUptodate(page);
>> -	} else {
>> -		SetPageError(page);
>> -	}
>> +		err = vboxsf_read(sf_handle->root, sf_handle->handle, pos,
>> +				&nread, buf);
>> +		if (nread < PAGE_SIZE)
>> +			memset(&buf[nread], 0, PAGE_SIZE - nread);
>> +		kunmap_local(buf);
>> +		if (err)
>> +			break;
>> +		offset += PAGE_SIZE;
>> +		pos += PAGE_SIZE;
>> +	} while (offset < folio_size(folio);
>>  
>> -	kunmap(page);
>> -	unlock_page(page);
>> +	if (!err) {
>> +		flush_dcache_folio(folio);
>> +		folio_mark_uptodate(folio);
>> +	}
>> +	folio_unlock(folio);
>>  	return err;
>>  }
>>
> 
> Hi 
> 
> So, after reading the comments, I understood that the problem presented 
> by Hans and Matthew is as follows:
> 
> 1) In the current code, the buffers used by vboxsf_write()/vboxsf_read() are 
> translated to PAGELIST-s before passing to the hypervisor, 
> but inefficiently— it first maps a page in vboxsf_read_folio() and then 
> calls page_to_phys(virt_to_page()) in the function hgcm_call_init_linaddr(). 
> 
> The inefficiency in the current implementation arises due to the unnecessary 
> mapping of a page in vboxsf_read_folio() because the mapping output, i.e. the 
> linear address, is used deep down in file 'drivers/virt/vboxguest/vboxguest_utils.c'. 
> Hence, the mapping must be done in this file; to do so, the folio must be passed 
> until this point. It can be done by adding a new member, 'struct folio *folio', 
> in the 'struct vmmdev_hgcm_function_parameter64'. 

struct vmmdev_hgcm_function_parameter64 is defined in

include/uapi/linux/vbox_vmmdev_types.h

This is part of the userspace API of vboxguest which allows userspace
to make (some) VirtualBox hypervisor request through a chardev.

You can not just go and change this struct.

Note there already is a VMMDEV_HGCM_PARM_TYPE_PAGELIST type. So you
could do the conversion from folio to pagelist (see the vboxguest code
for how to do this) in the vboxsf_read() code (making it take a folio
pointer as arg) and then directly pass the pagelist to the vbg_hgcm_call().

> The unused member 'phys_addr' in this struct can also be removed.

Again no you can NOT just go and make changes to an uapi header.

Regards,

Hans

