Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E460A2AAA3E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 10:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgKHJR4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 04:17:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728011AbgKHJRy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 04:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604827073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u+SyHTLXvA92ERGNZfFFmss47jMa+rGIK1ltcexiZx8=;
        b=MTTrWfgLA3OvU+vI+OICrKFS5VcoHNr1YDdL3OiqW3maxXW6DxpHAYudUG8+UoQOs1o1xt
        o0txZdKCdWw2+X1CjdKjV+/zGF2BU1jR7i41qkVyffqEk0WOujD/My3RRT+TLWnCFh3PBp
        RtKyAVbmfz+17u4bW3lkXvSOnAgBHp8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-_b7QixhJN_uV91QUvknsTw-1; Sun, 08 Nov 2020 04:17:52 -0500
X-MC-Unique: _b7QixhJN_uV91QUvknsTw-1
Received: by mail-wr1-f71.google.com with SMTP id x16so2755620wrg.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2020 01:17:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u+SyHTLXvA92ERGNZfFFmss47jMa+rGIK1ltcexiZx8=;
        b=EWzhB0mbnr1iYoaKtzjhtfaTGTVhrys0aX5OsaQhz7aej2NfHaW+rg6seFo8NIrWT8
         iiEvDu/bm6CMCkfiPQiLYUm7AK9gG8myxShGzou8As4tkF5qkO6ia2b0/LMnST+YyNF2
         TVEb46b0jlGerw/lyFV6RovtGx4Ee7u0bMsmcczYcN/Cr3Rob7SpHYRw8dX93aBChRCQ
         waUFj8VJfDXv3J+Y6kRIA4HIBidRZ5o/ZBRBtx3RnKED5sC3Qo7lFOosrASUH1kSY1jI
         kbPOdfe1WX7TOkX6iQjfq8EcRa0hYYqxdYfeRtJhJCWZcFiVLMF6u+gQVUraBOXvYpM6
         3xpw==
X-Gm-Message-State: AOAM533XS+RIGNp/X4AK5+ZTiZtoNtBrK+w3WivorbNc91NYNxRwv7p/
        9hXWrEePbjExLA1XjPPjVpaYANdcsdjy19/emDgZ0zx9NgbVxoPkbSEIsx0ut+Ot2KKaSiLIAbB
        h1yjPPJon1A8iJ/zspcmDfMpyQg==
X-Received: by 2002:adf:97dd:: with SMTP id t29mr12224612wrb.185.1604827070536;
        Sun, 08 Nov 2020 01:17:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy08lVb2EwMSaKb1c4rkEPpz4MxNziRJKopK1G2CeEdBzdBA7Q3j2i80FOCbZqEHTSG3V8yXQ==
X-Received: by 2002:adf:97dd:: with SMTP id t29mr12224595wrb.185.1604827070386;
        Sun, 08 Nov 2020 01:17:50 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id y4sm8747871wmj.2.2020.11.08.01.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2020 01:17:49 -0800 (PST)
Subject: Re: [PATCH 2/3] vfio/virqfd: Drain events from eventfd in
 virqfd_wakeup()
To:     Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1faa5405-3640-f4ad-5cd9-89a9e5e834e9@redhat.com>
 <20201027135523.646811-1-dwmw2@infradead.org>
 <20201027135523.646811-3-dwmw2@infradead.org>
 <20201106162956.5821c536@x1.home>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f45eeeba-2060-45cc-b5f5-140c3a83afd0@redhat.com>
Date:   Sun, 8 Nov 2020 10:17:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106162956.5821c536@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/11/20 00:29, Alex Williamson wrote:
>> From: David Woodhouse<dwmw@amazon.co.uk>
>>
>> Don't allow the events to accumulate in the eventfd counter, drain them
>> as they are handled.
>>
>> Signed-off-by: David Woodhouse<dwmw@amazon.co.uk>
>> ---
> Acked-by: Alex Williamson<alex.williamson@redhat.com>
> 
> Paolo, I assume you'll add this to your queue.  Thanks,
> 
> Alex
> 

Yes, thanks.

Paolo

