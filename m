Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C702679F27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 17:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjAXQrp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 11:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjAXQrn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:47:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5C5CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 08:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674578817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AzVI7y/XknPI0cUXSqe1BbmcfE0qXgoZKVccnfEMNGg=;
        b=GvuWkzkJLVSWTkcj9no1ip6641SEaDeZ7ttLVc4Cb9WiI5EsXju15q2n9KLgMOdvg3egdX
        uR8XK2T4TmxZB97k2LFT04NuHoa4A64IAkp8oVBfAEj9i0E8hWC1gJYqGPbxGHNU/ucJjn
        QgOqTStvjVWS3mykUcXHD63dRINdsGI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-548-6oFzbE6pNYax0_RQGxlv9g-1; Tue, 24 Jan 2023 11:46:56 -0500
X-MC-Unique: 6oFzbE6pNYax0_RQGxlv9g-1
Received: by mail-wm1-f71.google.com with SMTP id m10-20020a05600c3b0a00b003dafe7451deso9483303wms.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 08:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AzVI7y/XknPI0cUXSqe1BbmcfE0qXgoZKVccnfEMNGg=;
        b=zX+w8vyJ4ayzuCBpU4OtwLfwGxpk/tfhBtSaFZOg4vrTW1usskiRs+GOPboN4A4tTa
         rZHLxx2yfksay3pyVwPnFAqqTN9P68THk46DSkfWYqfm4zIhl/j8Y7VGURxWgUO26pty
         YsNhbi4pwsg7NvOm9luLOaXCDHpjFWmnxYUh1Uzcn8A/YwqvQjYSO36g9nhnMO6o2A5U
         szH89vPPi9UCUCsCiTBmjUK+FxvniAzPS8kKCovO6hJpeV9hSgQvtFCTnH+A2CZhwSck
         DuPp2h37cUds5sGLzf+H6m4NkDuXt1oLpYX6G0sK7GCbcB5tLbGEtbrUhINFxXsM7Brl
         Bm5w==
X-Gm-Message-State: AFqh2krJdmg50IpM8VctagJP6yf/kprSDUKDuFuCaHz3RsGHSdXhl1f2
        YkHJp3F6dSPIea1dmUazER0PLwtbm9rdWq4bhLa70xE8yyOPvzjDQZcZ1y60XWJHbwG8Lu8jUW8
        Dbt+v4hIPh5MuQL4F9q0hwuAGhA==
X-Received: by 2002:a05:600c:11:b0:3db:162f:3551 with SMTP id g17-20020a05600c001100b003db162f3551mr24694577wmc.21.1674578814951;
        Tue, 24 Jan 2023 08:46:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsuq8kMWZJOxuD81FxqWA2x0JPKsdYTiKSGjyZW4md/Vl44YCClZdGliDY2lYz6DFu4PeNHYA==
X-Received: by 2002:a05:600c:11:b0:3db:162f:3551 with SMTP id g17-20020a05600c001100b003db162f3551mr24694561wmc.21.1674578814690;
        Tue, 24 Jan 2023 08:46:54 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c3ac400b003daf7721bb3sm13735123wms.12.2023.01.24.08.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 08:46:54 -0800 (PST)
Message-ID: <2172496c-2cd2-a2c8-9ddb-cd7d56bcfc75@redhat.com>
Date:   Tue, 24 Jan 2023 17:46:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 07/10] block: Switch to pinning pages.
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <Y8/xApRVtqK7IlYT@infradead.org>
 <2431ffa0-4a37-56a2-17fa-74a5f681bcb8@redhat.com>
 <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-8-dhowells@redhat.com>
 <874829.1674571671@warthog.procyon.org.uk>
 <875433.1674572633@warthog.procyon.org.uk> <Y9AK+yW7mZ2SNMcj@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y9AK+yW7mZ2SNMcj@infradead.org>
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

On 24.01.23 17:44, Christoph Hellwig wrote:
> On Tue, Jan 24, 2023 at 03:03:53PM +0000, David Howells wrote:
>> Christoph Hellwig <hch@infradead.org> wrote:
>>
>>> It can't.  Per your latest branch:
>>
>> Yes it can.  Patch 6:
> 
> This never involves the cleanup mode as input.  And as I pointed out
> in the other mail, there is no need for the FOLL_ flags on the
> cleanup side.  You can just check the bio flag in bio_release_apges
> and call either put_page or unpin_user_page on that.  The direct
> callers of bio_release_page never mix them pin and get cases anyway.
> Let me find some time to code this up if it's easier to understand
> that way.

In case this series gets resend (which I assume), it would be great to 
CC linux-mm on the whole thing.

-- 
Thanks,

David / dhildenb

