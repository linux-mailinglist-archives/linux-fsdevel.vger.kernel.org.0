Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538381E9291
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 18:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgE3QUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 May 2020 12:20:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56079 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728797AbgE3QUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 May 2020 12:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590855610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Y07FflDlYJVMUyysoTwcpFsx8MSfGOT4BCyFdsShZo=;
        b=dnPe36dKTq6Is62q3s3jA57vZWNGY2whNJyoMC3vNyH+7TyUZLOr2hN2jbWiJmRZyapsbn
        PvArHB1Qb3Z6VKTeHxkS4+IVd16y777EGKgpizERLBsu60PxGs15IRuEoH1MbTJT8SAUML
        76fg9QQl/MRMt7Cd1to6tMDNGcakN8w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-jCL1vRhwNnCRDWabFLRF7Q-1; Sat, 30 May 2020 12:20:08 -0400
X-MC-Unique: jCL1vRhwNnCRDWabFLRF7Q-1
Received: by mail-wr1-f71.google.com with SMTP id r5so1947545wrt.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2020 09:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1Y07FflDlYJVMUyysoTwcpFsx8MSfGOT4BCyFdsShZo=;
        b=qjCAoIGQCAvJr8lBT5//virH7s/PlFQIhRIs4nUuU0ZY5+sJvCcIrOE+sZD95lSh7P
         M2fimYJxiNcgT87G1Y3PSmWr+qDBVMF4O6TVrn9s1k/EqlHIi4cvaXCQoObfSUaI3Lon
         DDySZUUC1E162tBfe4QvhhPwy80+8qvusYHJN/hzXCa97St+53tjtSWfS+DtmVsx2EbK
         TOFPSPqf5kTPCrquwTybf+ULMjIf1ucjTuzKkuRPLtEWPOul/j1ZRqh0IhJChb7b1/6C
         5cirtRHPoihY1png7KwZgsSTCS0ZJI3jqucMaFMkFC1RHI92bt9uii+BLehHSnBEsOze
         Wwgw==
X-Gm-Message-State: AOAM532CTAuirlMOby/MEp+dbjY+avWn6vYDezvNoVaB0u/0Nfynguat
        8r6ISvKf1DRuZEsqvXxAMuh+wfPRyyJZcxRzsKimaZpF4KX3JcfNYOebGpoYDa3T3zf5UboKmmQ
        GWRjyUsKw59+NGu5wnqiUP+Eg2Q==
X-Received: by 2002:adf:e68a:: with SMTP id r10mr13854869wrm.384.1590855607371;
        Sat, 30 May 2020 09:20:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXlElKTzRL6bFu/3rQrgfAs1k3BodxDyJgVmRXgSjiwdnIdN6gv3xiEGh0NHUK0QqpPIYfTw==
X-Received: by 2002:adf:e68a:: with SMTP id r10mr13854851wrm.384.1590855607156;
        Sat, 30 May 2020 09:20:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id b8sm14890619wrs.36.2020.05.30.09.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2020 09:20:06 -0700 (PDT)
Subject: Re: [PATCH 8/9] x86: kvm_hv_set_msr(): use __put_user() instead of
 32bit __clear_user()
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
 <20200529232723.44942-8-viro@ZenIV.linux.org.uk>
 <CAHk-=wgq2dzOdN4_=eY-XwxmcgyBM_esnPtXCvz1zStZKjiHKA@mail.gmail.com>
 <20200530143147.GN23230@ZenIV.linux.org.uk>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <81563af6-6ea2-3e21-fe53-9955910e303a@redhat.com>
Date:   Sat, 30 May 2020 18:20:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200530143147.GN23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Fri, May 29, 2020 at 04:52:59PM -0700, Linus Torvalds wrote:
>> It looks like the argument for the address being validated is that it
>> comes from "gfn_to_hva()", which should only return
>> host-virtual-addresses. That may be true.

Yes, the access_ok is done in __kvm_set_memory_region and gfn_to_hva()
returns a page-aligned address so it's obviously ok for a u32.

But I have no objections to removing the __ because if a read or write
is in the hot path it will use kvm_write_guest_cached and similar.

Paolo

>> But "should" is not "does", and honestly, the cost of gfn_to_hva() is
>> high enough that then using that as an argument for removing
>> "access_ok()" smells.



