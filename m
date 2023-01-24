Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CEE67951D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 11:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjAXKY5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 05:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjAXKY4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:24:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820333FF01
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 02:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674555850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aN9Czgm5CvGAuhzMkEVI/TT2p7pAyYcgvgmwqZIYz7k=;
        b=NDBN+hhgymM0t3NGCVzvIZYVedSIyPqaNdXmW9gzpd2btS4WH0T3X/IHRvdtCuqJA+2Cpl
        dK0eGnTmrjibl5tDmvwQYk38vQCHKhSjZ8okslrN+HChj6csxrW0EVpc41Mvq2TiHnCJoa
        ei7IElroXssZNLTgl2R+nAorbUzg8TA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-592-k_nr8GHkMoyrp_q1vZbpGQ-1; Tue, 24 Jan 2023 05:24:09 -0500
X-MC-Unique: k_nr8GHkMoyrp_q1vZbpGQ-1
Received: by mail-wr1-f69.google.com with SMTP id bj7-20020a0560001e0700b002bfb3c6ec00so63533wrb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 02:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aN9Czgm5CvGAuhzMkEVI/TT2p7pAyYcgvgmwqZIYz7k=;
        b=Ew2SBF7Exdk1HZ3wKMi6vGKboIOSDrP878poLn1EQlvtkeuv6vCPqRYj2ltDrO0Eao
         PpWvCPuJOIvKGqIwtT9mC8RVfMfHT03M9nP6cQPhMKkUREbvpRNgVbQF5g/6hU8uS6kV
         svklWSKBCLld1bpoXAHEpt5BVl2u/66Cd4wOibVel4NCztEB8kOvOyEQUCGanAiD0Gfn
         2cRyEkaECl1kLBwm+3FoSrmArewfo8R0eW1y7iW67aD4+0E1iOQiJR9GPwgNTah8cRxa
         Oynvw2ApgGijOCEjXjYjTR8cvHlRcy2k1vD6wRtg/0AiFcAEZZaeA3hxBwIhjkYH9mOn
         lElQ==
X-Gm-Message-State: AFqh2kookOGqXUevfQKVZj4hft95nxxv9R2Axycw+bxc0aYejs7hJy42
        gBiG7+EWfjkO90LvcYMQ3iuH+mF1soSlZqNVEDJ0AwjMc/hIFBnv34JMCXd1vnx6R0Fjj4neIhQ
        qATl1+5O4mIi+sPV6dw+6OozIXg==
X-Received: by 2002:adf:cd83:0:b0:2bd:d839:9918 with SMTP id q3-20020adfcd83000000b002bdd8399918mr24886320wrj.64.1674555848059;
        Tue, 24 Jan 2023 02:24:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvXXP7Tc/e17pSmW1GpJFeCPP5/mQ+K8WAe0128IKdfjGI9rBrCOa1/WAOJCs/1tWe8RBEGig==
X-Received: by 2002:adf:cd83:0:b0:2bd:d839:9918 with SMTP id q3-20020adfcd83000000b002bdd8399918mr24886301wrj.64.1674555847781;
        Tue, 24 Jan 2023 02:24:07 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id y15-20020adfdf0f000000b00236883f2f5csm1532407wrl.94.2023.01.24.02.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 02:24:07 -0800 (PST)
Message-ID: <e5eb9d67-dbbe-a0d9-1973-d6e6bee4db3a@redhat.com>
Date:   Tue, 24 Jan 2023 11:24:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 0/8] iov_iter: Improve page extraction (ref, pin or
 just list)
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <Y862ZL5umO30Vu/D@casper.infradead.org>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <318138.1674491927@warthog.procyon.org.uk>
 <Y865EIsHv3oyz+8U@casper.infradead.org>
 <20230123172529.woo34hnycrn7xhwk@quack3>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230123172529.woo34hnycrn7xhwk@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23.01.23 18:25, Jan Kara wrote:
> On Mon 23-01-23 16:42:56, Matthew Wilcox wrote:
>> On Mon, Jan 23, 2023 at 04:38:47PM +0000, David Howells wrote:
>>> Matthew Wilcox <willy@infradead.org> wrote:
>>> Also you only mention DIO read - but what about "start DIO write; fork(); touch
>>> buffer" in the parent - now the write buffer belongs to the child and they can
>>> affect the parent's write.
>>
>> I'm struggling to see the problem here.  If the child hasn't exec'd, the
>> parent and child are still in the same security domain.  The parent
>> could have modified the buffer before calling fork().
> 
> Sadly they are not. Android in particular starts applications by forking
> one big binary (zygote) that has multiple apps linked together and relies
> on the fact the child cannot influence the parent after the fork. We've
> already had CVEs with GUP & COW & fork due to this. David Hildebrand has a
> lot of memories regarding this I believe ;)

:)

Once FOLL_PIN is used most of the issues go away and we don't have to 
play any games with VM flags or similar ...

With FOLL_PIN, I consider anon a solved problem and not worth any new 
fancy ideas.

-- 
Thanks,

David / dhildenb

