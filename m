Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C622574290B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 17:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjF2PCt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 11:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjF2PCr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:02:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B747130C4
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 08:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688050914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7TagWYkIx09Iw+gbpjDsNk+epNEazk8amf//OqWTu8E=;
        b=X1uRQbsaTU05UNMs5SVpQAINRqxCM0uA+8jiGr1t7H34x9xbnEhSDAW7N5iUa9TErxXIMs
        lradUPjYMflrq3KkkbtrKY81tDxgkPowsIR+Ev/QunW2zZlN5/1X8bomzCldT3+sYauMUU
        As1WZrzcvj5LdaiM0I6S832zGDfmksQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-p09LIaNqOIeeQxd20D2vFQ-1; Thu, 29 Jun 2023 11:01:53 -0400
X-MC-Unique: p09LIaNqOIeeQxd20D2vFQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-98890dda439so62337866b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 08:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688050912; x=1690642912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TagWYkIx09Iw+gbpjDsNk+epNEazk8amf//OqWTu8E=;
        b=OKhCO093YbJWbZd9HFvZK4YSadKNIiZ8AFEGacJvLJQrT9jyyFWOxOPJmoNKjwjcW9
         yhAxaA9JFQkDHErUyFVBAye/yvq0GcwrriBqeee+kWrxgQDk4dYsit64xeY7szrFW+tt
         qmCakq0D7kRBAY+hhBMTRE9f7wkbWDNLjst+epVXzpJ2udCg/2SrRVIweEWa6/Rq7kxJ
         fODodfGVth+GQ9xJ4B72QvHAk1YzxnYqfaCYKeixzURKc6TF2BlpkcHTSnHB7W/LdQQ+
         I1nlNDzl2812jgUxjM47nHydvKuFj6rBkJDh0V9RmbA0ozRa4ttG1d9oaXQiyXX1R83N
         /+mg==
X-Gm-Message-State: AC+VfDz9cWqU43LQjGOyRwfferwDpg9sh2wrMsQxNKYMRKGJaiC6HMfU
        wUF7KQmPXsPrF1r8Eh2+ACNwQdlIMauYk/o4HpMf8QLrKZLYvV1w0jo6aRVmm4ybfxhNG7UIumT
        pWKTz+3p4uxftLD/zrkxkO+IzyA==
X-Received: by 2002:a17:907:36c2:b0:965:fb87:4215 with SMTP id bj2-20020a17090736c200b00965fb874215mr33557520ejc.15.1688050911846;
        Thu, 29 Jun 2023 08:01:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7+8rDitga7zWbpxe+denviTv8miXqX+MrKFoCjHDQ8dIH+n35G5Sde/5XaM2b1NOpdYwJHPg==
X-Received: by 2002:a17:907:36c2:b0:965:fb87:4215 with SMTP id bj2-20020a17090736c200b00965fb874215mr33557493ejc.15.1688050911458;
        Thu, 29 Jun 2023 08:01:51 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id v21-20020a170906565500b00991bba473e1sm4920866ejr.3.2023.06.29.08.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 08:01:50 -0700 (PDT)
Message-ID: <c24577db-80ca-8682-c7f8-466cf9dab0c9@redhat.com>
Date:   Thu, 29 Jun 2023 17:01:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
To:     Matthew Wilcox <willy@infradead.org>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Fabio <fmdefrancesco@gmail.com>, Deepak R Varma <drv@mailo.com>
References: <20230627135115.GA452832@sumitra.com>
 <ZJxqmEVKoxxftfXM@casper.infradead.org> <20230629092844.GA456505@sumitra.com>
 <ZJ2Yb8YOpakO7SbY@casper.infradead.org>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZJ2Yb8YOpakO7SbY@casper.infradead.org>
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

On 6/29/23 16:42, Matthew Wilcox wrote:
> On Thu, Jun 29, 2023 at 02:28:44AM -0700, Sumitra Sharma wrote:
>> On Wed, Jun 28, 2023 at 06:15:04PM +0100, Matthew Wilcox wrote:
>>> Here's a more comprehensive read_folio patch.  It's not at all
>>> efficient, but then if we wanted an efficient vboxsf, we'd implement
>>> vboxsf_readahead() and actually do an async call with deferred setting
>>> of the uptodate flag.  I can consult with anyone who wants to do all
>>> this work.
>>
>> So, after reading the comments, I understood that the problem presented 
>> by Hans and Matthew is as follows:
>>
>> 1) In the current code, the buffers used by vboxsf_write()/vboxsf_read() are 
>> translated to PAGELIST-s before passing to the hypervisor, 
>> but inefficiently— it first maps a page in vboxsf_read_folio() and then 
>> calls page_to_phys(virt_to_page()) in the function hgcm_call_init_linaddr(). 
> 
> It does ... and I'm not even sure that virt_to_page() works for kmapped
> pages.  Has it been tested with a 32-bit guest with, say, 4-8GB of memory?
> 
>> The inefficiency in the current implementation arises due to the unnecessary 
>> mapping of a page in vboxsf_read_folio() because the mapping output, i.e. the 
>> linear address, is used deep down in file 'drivers/virt/vboxguest/vboxguest_utils.c'. 
>> Hence, the mapping must be done in this file; to do so, the folio must be passed 
>> until this point. It can be done by adding a new member, 'struct folio *folio', 
>> in the 'struct vmmdev_hgcm_function_parameter64'. 
> 
> That's not the way to do it (as Hans already said).
> 
> The other problem is that vboxsf_read() is synchronous.  It makes the
> call to the host, then waits for the outcome.  What we really need is
> a vboxsf_readahead() that looks something like this:
> 
> static void vboxsf_readahead(struct readahead_control *ractl)
> {
> 	unsigned int nr = readahead_count(ractl);
> 	req = vbg_req_alloc(... something involving nr ...);
> 	... fill in the page array ...
> 	... submit the request ...
> }
> 
> You also need to set up a kthread that will sit on the hgcm_wq and handle
> the completions that come in (where you'd call folio_mark_uptodate() if
> the call is successful, folio_unlock() to indicate the I/O has completed,
> etc, etc).
> 
> Then go back to read_folio() (which can be synchronous), and maybe factor
> out the parts of vboxsf_readahead() that can be reused for filling in
> the vbg_req.
> 
> Hans might well have better ideas about this could be structured; I'm
> new to the vbox code.

I think that moving to directly passing vbox PAGELIST structs on
read is something which should not be too much work.

Moving to an async model is a lot more involved and has a much
larger chance of causing problems. So we need not only someone
to step up to not only make the change to async, but that person
also need to commit to help with maintaining vboxsf going forward,
esp. wrt debug + fix any problems stemming from the move to async
which are likely to only pop up much later as more and more
distros move to the new code.

Regards,

Hans

