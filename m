Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A5C70B2F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 03:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjEVByb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 21:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjEVBy3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 21:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CCED7
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 May 2023 18:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684720422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LjpVYliWYmLsp+7DmHIQ6WIiz69+8hAntxXwMv/K+0o=;
        b=bZu6B6XqpQa0rbKaAbhHd69+KgJUVHnv8V0cqKO4TGgE9+2a8yDj1M3MYGPbJvjA1HbpCq
        Dymi0sIc1GDowULSS09GEoris7uPGlrHgOqHsrjEPcj2weD790rxiv9UzEbA/T/6uY61H/
        NWTsWknk5+a94yiO2Bu55GBCdkqPjPc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-teki4Tj8NxiIwNtTEDZIdg-1; Sun, 21 May 2023 21:53:40 -0400
X-MC-Unique: teki4Tj8NxiIwNtTEDZIdg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-64d1cbfb240so2307746b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 May 2023 18:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684720419; x=1687312419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjpVYliWYmLsp+7DmHIQ6WIiz69+8hAntxXwMv/K+0o=;
        b=Da6NZBAmc4y3iOsSFfKyoHDXwCew3BGso9Wr6lx4QQPtnqngoEWsmHTBoPel0BTVWN
         OCB+Tbx1h+NgzENHFkaajok+2nRE8pQC4FNS9GiBN48IUZavBqAqLk5Mv4/da9mEeyDi
         BLezJwt6vk28gRiFDh3u6FM75NNe0Lb92f7VWhfhbYfY9NjgmtgCdxq8YiO6kJyYeljD
         W7o8U0GwxJ6jKKnQqCSrnUa25JVIRL2qW7j0mYINUm/ovCrUfPjoTHVaxsJ5LWuX+g2V
         5AYBjD3B5CwOXf9jZqze4Hf4JzV3t8+jcee6GkbAeUypkYjgWYhXwD9V+bpAZUw8w/Fx
         on+w==
X-Gm-Message-State: AC+VfDxZBJEqHZCPsPHxRNUdfQlAcuhZqyfca5QHVtXDKbpxOKJt62cw
        3qNffgI1cjjcL93qycnJq3sc7DbxEg8/x/nV06k7sNLUGTrii6KcTkImr+Lz22KPOvQvpLQn16N
        TR+TCT/n7Wkn8UWulwj+v2voD/Q==
X-Received: by 2002:a05:6a00:2314:b0:63b:6149:7ad6 with SMTP id h20-20020a056a00231400b0063b61497ad6mr11651205pfh.34.1684720419698;
        Sun, 21 May 2023 18:53:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Mn7xT7CCI+yBGqvco+AvK/IKOxX++Ib2iwxBd4veVXnB4vaLlF/dnAev/HMla5PSUAUk2RQ==
X-Received: by 2002:a05:6a00:2314:b0:63b:6149:7ad6 with SMTP id h20-20020a056a00231400b0063b61497ad6mr11651198pfh.34.1684720419429;
        Sun, 21 May 2023 18:53:39 -0700 (PDT)
Received: from [10.72.12.68] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s9-20020aa78289000000b0063f2e729127sm3121905pfm.144.2023.05.21.18.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 18:53:38 -0700 (PDT)
Message-ID: <ef4cc431-4cc4-eb39-735d-0b3b3759abed@redhat.com>
Date:   Mon, 22 May 2023 09:53:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v20 13/32] ceph: Provide a splice-read stub
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
References: <c1fd63b9-42ea-fa83-ecb1-9af715e37ffa@redhat.com>
 <20230519074047.1739879-1-dhowells@redhat.com>
 <20230519074047.1739879-14-dhowells@redhat.com>
 <1743656.1684488288@warthog.procyon.org.uk>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <1743656.1684488288@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/19/23 17:24, David Howells wrote:
> Xiubo Li <xiubli@redhat.com> wrote:
>
>>> +	ret = ceph_get_caps(in, CEPH_CAP_FILE_RD, want, -1, &got);
>>> +	if (ret < 0) {
>>> +		ceph_end_io_read(inode);
>>> +		return ret;
>>> +	}
>>> +
>>> +	if ((got & (CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO)) == 0) {
>>> +		dout("splice_read/sync %p %llx.%llx %llu~%zu got cap refs on %s\n",
>>> +		     inode, ceph_vinop(inode), *ppos, len,
>>> +		     ceph_cap_string(got));
>>> +
>>> +		ceph_end_io_read(inode);
>>> +		return direct_splice_read(in, ppos, pipe, len, flags);
>> Shouldn't we release cap ref before returning here ?
> Ummm...  Even if we got no caps?

No, at least we have got the 'need' caps: CEPH_CAP_FILE_RD once here.

I saw you have updated this and will check it.

Thanks

- Xiubo

>
> David
>

