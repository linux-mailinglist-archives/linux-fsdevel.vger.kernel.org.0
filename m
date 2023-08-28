Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA7D78A3DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 03:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjH1BT6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Aug 2023 21:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjH1BTx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Aug 2023 21:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D0E116
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Aug 2023 18:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693185549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/wFdUhBYiorLNxPNX9d+o/zR7/OUp2COeFx2CRBT114=;
        b=MCGc3g1QNGRvkLxpkurtJ38dOZXZ546Yhxcv2DxwirhGm0vuADZR6BL/oddB4DklS6g37X
        gd3DEHVcmY0GlS1D51CA7sqYlec0cz6/z3lt0f096wWMpltWa+QWTM/7Q+2uNqTQGDliDK
        3umDSn5/Xqx3kUayKNPrh2SrIuDjPwc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-Dr40XSzFMuqdvRH1Dft4PA-1; Sun, 27 Aug 2023 21:19:08 -0400
X-MC-Unique: Dr40XSzFMuqdvRH1Dft4PA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-563ab574cb5so1751057a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Aug 2023 18:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693185547; x=1693790347;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/wFdUhBYiorLNxPNX9d+o/zR7/OUp2COeFx2CRBT114=;
        b=WEXUPxoYnRKw7ZoNNKMvwwoAwNptwBNoJ/SFNjTYf32/E/s94v0jN5fwXFQbqmbai3
         0GFDd71w5UAGP+5m3btd4oiYogpOjn/52urLIUPD7fvvvXhiguQwNpH6CscNfkaVpyVv
         SegftV5Q4GUAbvZN4s4b12irHNfdbuRk1SlN6Z9iiO46gbAap04rOI+07OzwpYc6v6e6
         Qirc4iIPcctSGMOljixXKZe9mgUMfFhJ45EKrQ+3LrEHOr/b7J9DShewiKEehzfbMlaw
         ZkcDwTb/RWTIjerFWCmP/8ngqc4d1i3541BcCI1xtp4fnaHF/ubwsizZkrWkv3eY+RgI
         0hqw==
X-Gm-Message-State: AOJu0Yxk+48fQ7ysZ2GdaBU6y7U08WphEiug/6i2fjYEp9L7dvaXm8do
        SD2BmPZipwt9kgpL1AzzsPlEMKWqyO0CiOFYD7AVBonJnYtKkoYPD2Imh3z/oyR9UenaUWYXsxb
        VIwtXVgf2fWxsKfW0WGxqjOxJSqvw/md1lR2o
X-Received: by 2002:a05:6a20:8f28:b0:14c:d0c0:d4f8 with SMTP id b40-20020a056a208f2800b0014cd0c0d4f8mr3437835pzk.33.1693185547190;
        Sun, 27 Aug 2023 18:19:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSA0kB06YJcBI+5dbAzpb9/aRJNA24KHg/SWSWSst0JOhseoXN14tBLCXMMLz9M+yc0Rb8Uw==
X-Received: by 2002:a05:6a20:8f28:b0:14c:d0c0:d4f8 with SMTP id b40-20020a056a208f2800b0014cd0c0d4f8mr3437824pzk.33.1693185546912;
        Sun, 27 Aug 2023 18:19:06 -0700 (PDT)
Received: from [10.72.112.71] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d50100b001adf6b21c77sm5898584plg.107.2023.08.27.18.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 18:19:06 -0700 (PDT)
Message-ID: <2f1e16e5-1034-b064-7a92-e89f08fd2ac1@redhat.com>
Date:   Mon, 28 Aug 2023 09:19:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH 09/15] ceph: Use a folio in ceph_filemap_fault()
To:     Matthew Wilcox <willy@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
References: <20230825201225.348148-1-willy@infradead.org>
 <20230825201225.348148-10-willy@infradead.org>
 <ZOlq5HmcdYGPwH2i@casper.infradead.org>
Content-Language: en-US
In-Reply-To: <ZOlq5HmcdYGPwH2i@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/26/23 11:00, Matthew Wilcox wrote:
> On Fri, Aug 25, 2023 at 09:12:19PM +0100, Matthew Wilcox (Oracle) wrote:
>> +++ b/fs/ceph/addr.c
>> @@ -1608,29 +1608,30 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
>>   		ret = VM_FAULT_SIGBUS;
>>   	} else {
>>   		struct address_space *mapping = inode->i_mapping;
>> -		struct page *page;
>> +		struct folio *folio;
>>   
>>   		filemap_invalidate_lock_shared(mapping);
>> -		page = find_or_create_page(mapping, 0,
>> +		folio = __filemap_get_folio(mapping, 0,
>> +				FGP_LOCK|FGP_ACCESSED|FGP_CREAT,
>>   				mapping_gfp_constraint(mapping, ~__GFP_FS));
>> -		if (!page) {
>> +		if (!folio) {
> This needs to be "if (IS_ERR(folio))".  Meant to fix that but forgot.
>
Hi Matthew,

Next time please rebase to the latest ceph-client latest upstream 
'testing' branch, we need to test this series by using the qa 
teuthology, which is running based on the 'testing' branch.

Thanks

- Xiubo

