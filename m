Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664F16DC22D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Apr 2023 02:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjDJAjd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Apr 2023 20:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDJAjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Apr 2023 20:39:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274EF3593
        for <linux-fsdevel@vger.kernel.org>; Sun,  9 Apr 2023 17:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681087123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JoipxyuFINXgUm44ia8nIP1Z7voF8xXNR8jbsieNzXY=;
        b=OvucV4c3DKO5y4EszT1TCBvEORBR7FYyV622+BKvVqCSZg52dG/pMpXpnfJI3WxACLlCXz
        XkVguzqZcNLPjl927Dtvf9Pp1lgSZHaza8PKR37gX2zwLrY15bT/1YlF7EL5GgOa/Tp8mi
        K3LxfiCbvNX60ZCuDf/7EhuJSlfjzIY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-p1hk5LmyPTKxs5pz6UaaPw-1; Sun, 09 Apr 2023 20:38:41 -0400
X-MC-Unique: p1hk5LmyPTKxs5pz6UaaPw-1
Received: by mail-pj1-f71.google.com with SMTP id oj8-20020a17090b4d8800b0023fa854ec76so2166703pjb.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Apr 2023 17:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681087120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JoipxyuFINXgUm44ia8nIP1Z7voF8xXNR8jbsieNzXY=;
        b=AuC84SBerGBVKM3dvPhE21B58omkLcBgZq04KBD5CyJrBnMkiLsNNSfokY1E5c2fo6
         B1dpMBfwEgNvB3WuTecaePlf8O9cUnO8NP59l+sK2HIzyYmcTqGINsqX2L3/tZz17iT0
         UE8bcDwOzQKN0xS2mrDByax1+y4LqxkFuTbm3kuL2JuIANiXC+brbxRrxziiS5ib5CKA
         ijMVWAhKzkwt4nZPHLug7gXzw/GhNoiFAtEvKC/jqLSk/nSzmgd11G1G5GNTbI/WdT4/
         WPs2u5gEb7xutw95YOT7NhF3wYcoASAGi1EU+6igL/rW1ZnZf6e/RDbhuEZQ0rb822ST
         NMpQ==
X-Gm-Message-State: AAQBX9dEe0tFhp/ZSsb28bdADB158S9vlPzrgvw3wJ9vRgGfLQqscWYB
        qC8buWkG/Xxx8sA1PH1oC6BEFb1abngOqkH0RhENPFn+CGrH+rrlwhrBVIxYeAdh1c5qHUm1OxA
        SCLvyg/S7xRe943umy0mNk5eLnQ==
X-Received: by 2002:a17:903:2309:b0:1a0:4fb2:6623 with SMTP id d9-20020a170903230900b001a04fb26623mr13634381plh.40.1681087120699;
        Sun, 09 Apr 2023 17:38:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350bBhI9mfvIxmgS3HdFTr0TeJ85lYetpQhXwNJ7ayezRXC3PbhU01R+aemZYHD/yCMAoEoKv5w==
X-Received: by 2002:a17:903:2309:b0:1a0:4fb2:6623 with SMTP id d9-20020a170903230900b001a04fb26623mr13634356plh.40.1681087120361;
        Sun, 09 Apr 2023 17:38:40 -0700 (PDT)
Received: from [10.72.12.179] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s4-20020a170902988400b0019cd1ee1523sm6420247plp.30.2023.04.09.17.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 17:38:39 -0700 (PDT)
Message-ID: <5019ac6e-6871-9439-b24f-6bcb24bd89d8@redhat.com>
Date:   Mon, 10 Apr 2023 08:38:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH v2 37/48] ceph: Use sendmsg(MSG_SPLICE_PAGES) rather
 than sendpage()
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
References: <c99f1f3d-25ac-6f5c-b5f1-26f7bfa513e8@redhat.com>
 <7f7947d6-2a03-688b-dc5e-3887553f0106@redhat.com>
 <20230329141354.516864-1-dhowells@redhat.com>
 <20230329141354.516864-38-dhowells@redhat.com>
 <709552.1680158901@warthog.procyon.org.uk>
 <1814785.1680510766@warthog.procyon.org.uk>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <1814785.1680510766@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/3/23 16:32, David Howells wrote:
> Xiubo Li <xiubli@redhat.com> wrote:
>
>> On 3/30/23 14:48, David Howells wrote:
>>> Xiubo Li <xiubli@redhat.com> wrote:
>>>
>>>> BTW, will this two patch depend on the others in this patch series ?
>>> Yes.  You'll need patches that affect TCP at least so that TCP supports
>>> MSG_SPLICE_PAGES, so 04-08 and perhaps 09.  It's also on top of the
>>> patches that remove ITER_PIPE on my iov-extract branch, but I don't think
>>> that should affect you.
>> Why I asked this is because I only could see these two ceph relevant patches
>> currently.
> Depends on how you defined 'relevant', I guess.  Only two patches modify ceph
> directly, but there's a dependency: to make those work, TCP needs altering
> also.

Okay. Will run the test today. I was reinstalling my laptop last week.

Thanks

- Xiubo

> David
>

