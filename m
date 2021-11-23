Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328CB459EE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 10:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbhKWJMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 04:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhKWJMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 04:12:51 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2A2C061574;
        Tue, 23 Nov 2021 01:09:43 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b12so37684731wrh.4;
        Tue, 23 Nov 2021 01:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=EXjLq27uLPPwTfA6AVps4YfQwfYtoD5QB3WDXMP9avc=;
        b=VQpajBwcKuhcQjhlfCRYaCEPr3KvnCcA5Ih+sgVXncsJXlKSw74iRRii+5fS6bli2l
         KtFWmUca+J/l9XwEvj7CkfYgyJs/PbK/88dBzW5Sr4vYLhsZ/P6dRWsSV0dA4LjrNZNR
         AQIuw4Y3+tsAsszXSUvHAxpHcOYNKQ0kNly3sRhn9vI7re6S+hXr2Qf/O1X5o2b+lcT8
         i7mNaroeCwT3gqv//CO6AYxwGlqY2w1f7EHxgi+skJRyuy22XRWLdvPuULUgRIxg1H4D
         V0Bw9p2jST4AMgrnxUOgMvXrRE5FcT7pUEuY9kQ1AfBLuz8mSasigRr6uPlCUcvE4jCk
         RVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=EXjLq27uLPPwTfA6AVps4YfQwfYtoD5QB3WDXMP9avc=;
        b=COdWYmX51hy3OdM4Vb82aZKUQzqXDvrp84wWBBlLxM0yXKITCHI3lScz5gj+XCJkn3
         ZW8Dfc5ndZdeORWnFSsYszpIW8RfiLbZF43voM+HsFfUMbWSc8IMEs3JG3ULdA4CcASV
         yQ9ddG+AtAkKyggQruFG0ybiEZ1OM+9TmEa/yH+fL/fJPVzn0QR71OG7ySrjzTEibWRY
         Eoh+L8H4/IQd92wI/ViunFto5hoWwOvsn0lHtDeTuRmaG9Wsp7sDMc8Jx+XKaaFFw9pg
         t6npGU8GGm6U520Q9mtHg8Wwi8jzrkho5JkM0TQXp7EytBU+l0RTMcu6Mfr4Zu3cchuM
         Bw8g==
X-Gm-Message-State: AOAM532gQykkusLFfRLTZ2oynC1GqKORh54a1s6LRxFmHANc2mPZEpAp
        YXSqSOv4S5f559ALaOOLLRA=
X-Google-Smtp-Source: ABdhPJwy1AzQRo/b3ioO4YgKfTSHULKRa4G3QiCYJTl72yZ7edFn0WP/0Q5lVgW3dJZi8IC+A1P4hA==
X-Received: by 2002:a5d:6da2:: with SMTP id u2mr4870376wrs.273.1637658581691;
        Tue, 23 Nov 2021 01:09:41 -0800 (PST)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id m36sm522420wms.25.2021.11.23.01.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 01:09:41 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <2f3e9d7e-ce15-e47b-54c6-3ca3d7195d70@redhat.com>
Date:   Tue, 23 Nov 2021 10:09:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Wanpeng Li <wanpengli@tencent.com>, jun.nakajima@intel.com,
        kvm@vger.kernel.org, david@redhat.com, qemu-devel@nongnu.org,
        "J . Bruce Fields" <bfields@fieldses.org>, dave.hansen@intel.com,
        "H . Peter Anvin" <hpa@zytor.com>, ak@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        luto@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Mattson <jmattson@google.com>, linux-mm@kvack.org,
        Sean Christopherson <seanjc@google.com>, susie.li@intel.com,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        john.ji@intel.com, Yu Zhang <yu.c.zhang@linux.intel.com>,
        linux-fsdevel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-14-chao.p.peng@linux.intel.com>
 <20211122141647.3pcsywilrzcoqvbf@box.shutemov.name>
 <20211123010639.GA32088@chaop.bj.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC v2 PATCH 13/13] KVM: Enable memfd based page
 invalidation/fallocate
In-Reply-To: <20211123010639.GA32088@chaop.bj.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/23/21 02:06, Chao Peng wrote:
>> Maybe the kvm has to be tagged with a sequential id that incremented every
>> allocation. This id can be checked here.
> Sounds like a sequential id will be needed, no existing fields in struct
> kvm can work for this.

There's no need to new concepts when there's a perfectly usable 
reference count. :)

Paolo
