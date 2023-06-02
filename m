Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0A8720334
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 15:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbjFBN02 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 09:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbjFBN00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AA6132
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 06:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685712343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S1kpezRB7CtK3CiBr2GgVtaRFOHZgMOnCsOR8MuQTeU=;
        b=XosLe7uQDUOM3ui69tMcb4MfyZeUUuAdYOovCFk1PUka+JewqSvqB9Puinm0+is5KicZmi
        Bli4p8/VC8vA3qL+cLqviekDegFrV+dWvMEkmU/u8c1r2r7LDVbjAAZoEzOhTQEuZcZ+dj
        MA+3EYbUxlWiwEtgw7jQJBAvAg8uuDM=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-beMS8D3VM0uAvyUYsEt8aQ-1; Fri, 02 Jun 2023 09:25:42 -0400
X-MC-Unique: beMS8D3VM0uAvyUYsEt8aQ-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-786cceb2452so694245241.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jun 2023 06:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685712341; x=1688304341;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1kpezRB7CtK3CiBr2GgVtaRFOHZgMOnCsOR8MuQTeU=;
        b=Hv1D8dzrPvAjjcILCjFxKnXRzN487mbkwlLCJS1sOEGZF2jjnwMk4TrchPXR0uIuF5
         GmONiQP3wRM2SYkxMddZFNB+IhsYhqwlbjJ/dR2YFng9pYOyR66KGeZZXxc3ieVpAQvm
         j7yMD/4LuxvJVmtk+BlhPKVCItKsRlYOs8KWurbNsRIfYzwqMA1P16tOehSI2CZY1+ot
         +ljIrKiUwfJ93PNU61HPHZ0O4ZBzVBSr/QjGGbNiPDFF0EK1u1Km9uLCGVbUIIqkndbF
         3uQTTlDVF/QgZ6ZahJpX/A8EPBu7oTY4JxNvhvsT/CZGmqtGwgsMe/5UOUQnyIA67il5
         ZjLg==
X-Gm-Message-State: AC+VfDwNXYBRG4uV4EBn+K6tf4YSSA9KDW0a/RD2GhTW7ax9WoU/Cj7M
        yvRwRdnxBS0QP0eC3Z70vX+u2ELoFg+afvBGOJe3cowfiylPd8wX0sUCRAZSvNLP6zxpkmJ7v5l
        sOw199+LnhvRk9DtiRSCFAwYW+g==
X-Received: by 2002:a1f:3f83:0:b0:456:f9e5:5bcf with SMTP id m125-20020a1f3f83000000b00456f9e55bcfmr2232690vka.6.1685712341518;
        Fri, 02 Jun 2023 06:25:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ49e2Sk8d8XLQjjuDge6fiC6bO3G8/IDlZdt/o9nnTP0LIwiJHPdTe1xkT9Iwb8yNZhTpYwsw==
X-Received: by 2002:a1f:3f83:0:b0:456:f9e5:5bcf with SMTP id m125-20020a1f3f83000000b00456f9e55bcfmr2232679vka.6.1685712341281;
        Fri, 02 Jun 2023 06:25:41 -0700 (PDT)
Received: from [172.16.0.7] ([209.73.90.46])
        by smtp.gmail.com with ESMTPSA id pc1-20020a05620a840100b0075b196ae392sm614218qkn.104.2023.06.02.06.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 06:25:40 -0700 (PDT)
Message-ID: <16d964a4-755f-53c8-b7bf-43584acdd380@redhat.com>
Date:   Fri, 2 Jun 2023 08:25:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/6] gfs2/buffer folio changes
From:   Bob Peterson <rpeterso@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20230517032442.1135379-1-willy@infradead.org>
 <4530554c-c2b3-f93b-6c2c-c411e62d1e45@redhat.com>
Content-Language: en-US
In-Reply-To: <4530554c-c2b3-f93b-6c2c-c411e62d1e45@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/2/23 7:30 AM, Bob Peterson wrote:
> On 5/16/23 10:24 PM, Matthew Wilcox (Oracle) wrote:
>> This kind of started off as a gfs2 patch series, then became entwined
>> with buffer heads once I realised that gfs2 was the only remaining
>> caller of __block_write_full_page().  For those not in the gfs2 world,
>> the big point of this series is that block_write_full_page() should now
>> handle large folios correctly.
>>
>> It probably makes most sense to take this through Andrew's tree, once
>> enough people have signed off on it?
> Hi Willy,
> 
> I did some fundamental testing with this patch set in a five-node 
> cluster, as well as xfstests, and it seemed to work properly. The 
> testing was somewhat limited, but it passed basic cluster coherency 
> testing. Sorry it took so long.
> 
> If you want you can add:
> Tested-by: Bob Peterson <rpeterso@redhat.com>
> Reviewed-by: Bob Peterson <rpeterso@redhat.com>
> 
> Regards,
> 
> Bob Peterson

I was talking with Andreas G and he still has some concerns, so don't 
push this to a repo quite yet.

Regards,

Bob Peterson


