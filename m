Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9D35EFC18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 19:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbiI2Rfx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 13:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiI2Rfv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289C112B4B1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Sep 2022 10:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664472947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6QvssFP6fElsinFmtORISS+XoH9LM/qj79vCQgHmORo=;
        b=NU82S2u3GGINBAwtGDEXxYnqVTUkybJMIn8W7vXEnZrBGx7A5WkgNszGANGMB6bXtKLYWU
        1TiwNq+OGEo9CkjFIOQjRWj9qOogo0d0D0JVvjZMXfrV6kt6kYYJN4HcZgIpNWcbXbK1+l
        Sy/N+rXOs/covVy9LLqm3y3uQjtLpTM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-537-DglMdOhXO2CzAJUyAcw-lQ-1; Thu, 29 Sep 2022 13:35:46 -0400
X-MC-Unique: DglMdOhXO2CzAJUyAcw-lQ-1
Received: by mail-ej1-f70.google.com with SMTP id hs31-20020a1709073e9f00b00782b009c505so1023394ejc.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Sep 2022 10:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6QvssFP6fElsinFmtORISS+XoH9LM/qj79vCQgHmORo=;
        b=7wimFSL6QV18nWSI/UyR+akaY+G38SXJDepj8XELXur77mvwotLs6WKid67LnPFrmV
         P44dyjJyokv42vpP8D6OYK2fGAwXtSW+mUv/iGd0Rh3FEa10/iPpK40nS1ugBLyhG3u4
         fc+3DD1+ghuKLguOshxaYwIpGcTbnCZXAUFJDYW7Cs0ao5061BS+2sw8c3niUEx6UUXM
         zDvJ1IuR8dofxtCL7rpCTtD8qjVZTf0W0uuvsA564/C6GKoX2ltAcROVwFQktZI41V4G
         bxUhaYwrZTZ40QZvYa95GjqMqIFZB0MWdi0O4n7E6xmgWD7bFA/xnveuKk4tcj0tpaGx
         KLpg==
X-Gm-Message-State: ACrzQf201jRe6bTcY88+CCl+C7oXJVJX8nh6Xbd6hDgHPzisQFF0Qrzc
        pyRyd+0sb72/UEgzskn+enRspDvGE9MJt+z0zTuedJLlxrFJMhbDSmdc9G6qCmA1QRjcmQvvUzX
        P2mVJosGGEvZoqnD+smjjPH7vew==
X-Received: by 2002:a05:6402:5110:b0:450:c196:d7b1 with SMTP id m16-20020a056402511000b00450c196d7b1mr4360245edd.117.1664472945480;
        Thu, 29 Sep 2022 10:35:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4A74v/Mt3k+wNZ3JdUTgnnAt+nGzICSWWKg87i5m1tJ9DRruLO3VYyV2zBao0y66SzFcmaDw==
X-Received: by 2002:a05:6402:5110:b0:450:c196:d7b1 with SMTP id m16-20020a056402511000b00450c196d7b1mr4360230edd.117.1664472945244;
        Thu, 29 Sep 2022 10:35:45 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id l13-20020a056402124d00b00456e98b7b7asm67429edw.56.2022.09.29.10.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 10:35:44 -0700 (PDT)
Message-ID: <32db4f89-a83f-aac4-5d27-0801bdca60bf@redhat.com>
Date:   Thu, 29 Sep 2022 19:35:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Commit 'iomap: add support for dma aligned direct-io' causes
 qemu/KVM boot failures
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
        kvm@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>,
        Michael Roth <mdroth@linux.vnet.ibm.com>
References: <fb869c88bd48ea9018e1cc349918aa7cdd524931.camel@redhat.com>
 <YzW+Mz12JT1BXoZA@kbusch-mbp.dhcp.thefacebook.com>
 <a2825beac032fd6a76838164d4e2753d30305897.camel@redhat.com>
 <YzXJwmP8pa3WABEG@kbusch-mbp.dhcp.thefacebook.com>
 <20220929163931.GA10232@lst.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220929163931.GA10232@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/29/22 18:39, Christoph Hellwig wrote:
> On Thu, Sep 29, 2022 at 10:37:22AM -0600, Keith Busch wrote:
>>> I am aware, and I've submitted the fix to qemu here:
>>> 
>>>   https://lists.nongnu.org/archive/html/qemu-block/2022-09/msg00398.html
>>
>> I don't think so. Memory alignment and length granularity are two completely
>> different concepts. If anything, the kernel's ABI had been that the length
>> requirement was also required for the memory alignment, not the other way
>> around. That usage will continue working with this kernel patch.
> 
> Well, Linus does treat anything that breaks significant userspace
> as a regression.  Qemu certainly is significant, but that might depend
> on bit how common configurations hitting this issue are.

Seeing the QEMU patch, I agree that it's a QEMU bug though.  I'm 
surprised it has ever worked.

It requires 4K sectors in the host but not in the guest, and can be 
worked around (if not migrating) by disabling O_DIRECT.  I think it's 
not that awful, but we probably should do some extra releases of QEMU 
stable branches.

Paolo

