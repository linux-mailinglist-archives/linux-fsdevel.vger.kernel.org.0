Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBB454C9DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 15:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbiFONdd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 09:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348894AbiFONdb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:33:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B513124F32
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 06:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655300009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ElUN8T1cq4s61Ms7BHHS//RviJNChfZk2AevhepNuYw=;
        b=h92EeXjqIOQc5YHSXVrRtbhSaOZ0W2s7t5zAFcUSCBvWXpXarAIV1lbjhMagZ88fpkVfCV
        +3KHEKqImIKNRMg5+qO8KYtebzY+H6nSknsJcIxuPxa/bgDuu+LAanwv19+oRCS9wvOy1l
        NWEA9tQ+1Ze1ubWP5BfCl9E7KkhX1uk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-JnRbVpibPdSZMINKkvMknA-1; Wed, 15 Jun 2022 09:33:28 -0400
X-MC-Unique: JnRbVpibPdSZMINKkvMknA-1
Received: by mail-pl1-f199.google.com with SMTP id s10-20020a170902a50a00b00162359521c9so6567084plq.23
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 06:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ElUN8T1cq4s61Ms7BHHS//RviJNChfZk2AevhepNuYw=;
        b=z40jvKVka/zdZU0jWViP76LepGJ2Q/SgwrF+kbnmPQzsNA3o6QjkM9j2mch4cUk4Ud
         JPcT3//0RhWlnzIJN+dTUXGfuBpUmV5uJTXGwYILNh0QU4ewfjvNTHM3VR86eKwOhkki
         FOrk/cEpHgzXVgwa66Nfa0Gi3pld+gexJupkdawlsBz1tpck+QzGKn9AwfjPwWj+e9un
         bGlhK+YNbRUjQK6GdlbIzmDm0EugSD8Nj41OhMokllapDSr5DaErgxzScrlyUXa/xpfL
         RtHnla8XpOPH/LOu9sldeb1Rn1eb117O1Q+EsejfmHO602p1Hk06uZEBfHbfoT7a1yVA
         Koog==
X-Gm-Message-State: AJIora8G8zRp0dU8cmZrZwS7+hZB2xhmhrlg2gPVmHpdkxAO+1AHExdp
        XcF56UyQUVfa3abpnaJ5HBi2oJyJoJrJkhQgdWaqQKdHhsbsaDepNQQkC9z/pQ7QS94VlIiH4lh
        Ztug202yspdbiFmAsIK6j9YXQlA==
X-Received: by 2002:a17:90b:3805:b0:1e6:85aa:51b with SMTP id mq5-20020a17090b380500b001e685aa051bmr10306063pjb.182.1655300007349;
        Wed, 15 Jun 2022 06:33:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tb4/p2f7hRkF6jlREKWV12KxvmfuJQQVpA3aDNFZ/uwNnmlZ5qNGCW6kdfHFSMs79ONcrXXg==
X-Received: by 2002:a17:90b:3805:b0:1e6:85aa:51b with SMTP id mq5-20020a17090b380500b001e685aa051bmr10306047pjb.182.1655300007115;
        Wed, 15 Jun 2022 06:33:27 -0700 (PDT)
Received: from [192.168.1.219] (180-150-90-198.b4965a.per.nbn.aussiebb.net. [180.150.90.198])
        by smtp.gmail.com with ESMTPSA id l21-20020a17090a409500b001e85f38bc79sm1742359pjg.41.2022.06.15.06.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 06:33:26 -0700 (PDT)
Message-ID: <f032daae-3820-9ded-9865-69b35e6b2cad@redhat.com>
Date:   Wed, 15 Jun 2022 21:33:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/3] radix-tree: propagate all tags in idr tree
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        onestero@redhat.com
References: <20220614180949.102914-1-bfoster@redhat.com>
 <20220614180949.102914-2-bfoster@redhat.com> <Yqm+jmkDA+um2+hd@infradead.org>
From:   Ian Kent <ikent@redhat.com>
In-Reply-To: <Yqm+jmkDA+um2+hd@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 15/6/22 19:12, Christoph Hellwig wrote:
> On Tue, Jun 14, 2022 at 02:09:47PM -0400, Brian Foster wrote:
>> The IDR tree has hardcoded tag propagation logic to handle the
>> internal IDR_FREE tag and ignore all others. Fix up the hardcoded
>> logic to support additional tags.
>>
>> This is specifically to support a new internal IDR_TGID radix tree
>> tag used to improve search efficiency of pids with associated
>> PIDTYPE_TGID tasks within a pid namespace.
> Wouldn't it make sense to switch over to an xarray here rather
> then adding new features to the radix tree?
>
Might be a dumb question but ...


How would the, essentially sparse, pid type PIDTYPE_TGID pids

traversal get benefits from an xarray?


 From what I have seen the searching isn't the real problem, it's the

traversal (that, at the moment, does a search 'and' a traversal over

a lot of pids to get a relatively small number of them).

Ian

