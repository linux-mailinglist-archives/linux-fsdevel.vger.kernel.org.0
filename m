Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876C8564A4E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jul 2022 00:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiGCWeG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 18:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiGCWeG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 18:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0829C55B9
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 Jul 2022 15:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656887644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=39QFaLKYr5qxeP42J8w+H78lIoXIr96vwZ8EPM/8bU0=;
        b=MhTrIEFYWXTGCNv0J8/P/Ht8AtcusbTBaDTs/wfkybnf4sieoJzyVWwdHZ4QzQ/WcYJlz4
        BobmY/wZxFnXRWhKYFDVJ1fySlULimIKZxVP28Ddqb5CGkzZA/Oj6+lNkcIV1WA/B6a2QV
        m7+EBTeVmRD7GA62BPYAd5A6BBYilQI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-hh6IIp2gNVy-3lFzyJHmuw-1; Sun, 03 Jul 2022 18:34:00 -0400
X-MC-Unique: hh6IIp2gNVy-3lFzyJHmuw-1
Received: by mail-ed1-f71.google.com with SMTP id h16-20020a05640250d000b00435bab1a7b4so5902071edb.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Jul 2022 15:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=39QFaLKYr5qxeP42J8w+H78lIoXIr96vwZ8EPM/8bU0=;
        b=ZA8XVRgXuIF+NmtLi0De8alqnW01zdc3u9cegDFBpc9SC8Fe0JbOeYxKkrWDFKw/AN
         e7kkqqC2j10oEogfcLvqdb6v7hbYwXmXGNjhHc5/MfqMWJ1LlS5BQI7QXU0SuaUETT8K
         dzVk9RcCuTXp111ybLcDsRxZbXtG0f8aLCaZWifESH6RwZVTDpc4ZAyjR2rxo1Z8rnuk
         1I3cA9No5PC9loNW+pP2+u9PYzqNLymExMsmcuosJp6/juIjQ3/dCNqNru23CDmbwUFx
         9uzwovbVUWDlrdSp/rn1HUsV6XvNuzRYbGHctkiKWbJxHGn8ObYzCZ2erfUkG/cGoYLV
         UD+A==
X-Gm-Message-State: AJIora/J2IODBWSou4Zct6jbg5a9VL36GxXnXqK8P5My3fHV7EpP348T
        bjB9P7at1FegeBnMdJx9P6Goa0ytPQBM/odE64zbNTR3iot7PtnEI0jD92iAjUXvX7Fpxs1uOGR
        ZvQuUbjDq2bf6VTf/1CETNDRUHg==
X-Received: by 2002:a17:906:5047:b0:710:456a:695e with SMTP id e7-20020a170906504700b00710456a695emr26049338ejk.433.1656887639388;
        Sun, 03 Jul 2022 15:33:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uyclZZNbDVRJhQkp0QbTypFqli4p3UhsSD3lVtrQbnzeNOWBTx/w1SVo8QTzTGvV2cpVJGNA==
X-Received: by 2002:a17:906:5047:b0:710:456a:695e with SMTP id e7-20020a170906504700b00710456a695emr26049327ejk.433.1656887639237;
        Sun, 03 Jul 2022 15:33:59 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b40:2ee8:642:1aff:fe31:a15c? ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id f8-20020a056402150800b0043578cf97d0sm19441503edw.23.2022.07.03.15.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 15:33:58 -0700 (PDT)
Message-ID: <06e3ba23-edfe-bcea-3afe-8a748fc2b5e6@redhat.com>
Date:   Mon, 4 Jul 2022 00:33:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] treewide: idr: align IDR and IDA APIs
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220703181739.387584-1-dakr@redhat.com>
 <YsIAypeKXFg97xbG@casper.infradead.org>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <YsIAypeKXFg97xbG@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/3/22 22:49, Matthew Wilcox wrote:
> On Sun, Jul 03, 2022 at 08:17:38PM +0200, Danilo Krummrich wrote:
>> For allocating IDs the ID allocator (IDA) provides the following
>> functions: ida_alloc(), ida_alloc_range(), ida_alloc_min() and
>> ida_alloc_max() whereas for IDRs only idr_alloc() is available.
>>
>> In contrast to ida_alloc(), idr_alloc() behaves like ida_alloc_range(),
>> which takes MIN and MAX arguments to define the bounds within an ID
>> should be allocated - ida_alloc() instead implicitly uses the maximal
>> bounds possible for MIN and MAX without taking those arguments.
>>
>> In order to align the IDR and IDA APIs this patch provides
>> implementations for idr_alloc(), idr_alloc_range(), idr_alloc_min() and
>> idr_alloc_max(), which are analogue to the IDA API.
> 
> I don't really want to make any changes to the IDR API.  I want to get
> rid of the IDR API.  I'm sorry you did all this work, but you should
> probaby talk to the maintainer before embarking on such a big project.
No problem at all - didn't really took long.
> 
> If you're interested, converting IDR users to the XArray API is an
> outstanding project that I'd be interested in encouraging.
> 
Yes, I might have a look!

- Danilo

