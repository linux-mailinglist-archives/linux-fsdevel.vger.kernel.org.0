Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2200547E99E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 00:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240684AbhLWXJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 18:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhLWXJz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 18:09:55 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33609C061401;
        Thu, 23 Dec 2021 15:09:55 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id e5so4186714wmq.1;
        Thu, 23 Dec 2021 15:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dgbT8DN+Tw3GNuf5KJthTWpp6lDkFZBiYQzZimRcuRE=;
        b=ehxbIBRAS2aXNbnGgB0k0x6R5UnwGvaUuLQwHieKejHDCyBTff1JOdaDIPIckgtJou
         8hYkLoqNGiii4+iF8QW2us8YgNv9kljvbT4qGb/bQUff9DbRMmIrP0045w7Uw3CUCOK8
         TTwrauAIdVxgec9tqmZeT0ABn4zy0J9Ld1K8K1eW8x56QfvdoJ4Dm/BexqyjR/YwzPZw
         lDqlfT6bv88bZRj1nDoITdfdxhxwY3gc40PVSTqhV1FQbyf1IA5N0iLVeBCj3xHVVZgn
         NV7mk5eCxTD4+SUpFaDQwPqH182VQ8mtL51XgD/+4dSE1ey1EoQe53Wn8U4cWrQUgaMC
         9neA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dgbT8DN+Tw3GNuf5KJthTWpp6lDkFZBiYQzZimRcuRE=;
        b=o4y2wHRFmnHEptWe2GP8e3dul2mqXrLlB31CwsgAlX4QnaS5Ch7MJdhHYpAkIoam5P
         SGB37Fx5ZGN186NbY2INJurdUedBCX4rgL5SmUaXfOhIb+sXHJfKPGu5S5cSRVBsNbEM
         296rGoCDgMLmpsU93hhW8ApHF9AQt6JItlo8q8vIeTPhNw6DiacNwlfUiz0jbVSmp/6n
         K/pKg4wjn5EQ7lUJ852IgEnq0/3ZRjg3oJCW3fiX/otRF2x17VHk1i350qJsB1JwcqS6
         beQ6GKkzM+lhYgsl2oH0dS71j8rd62DiuOvsuhaiVvGRrxpfrwCQ2LxkHiE3d2fm0ei5
         Zf/A==
X-Gm-Message-State: AOAM533nsrGrWtZpRG8X65WjrW1Am5/mdhgEGNx3lAxJQmt28ZCsdbAa
        XOOyar0cQhMt7NWkdoVHPfea91WY7f8=
X-Google-Smtp-Source: ABdhPJxl1U9OmTr5nW/WPKnQ66/Eyo9O1/bfTZjkkZoBY6qhl1LyNXjyknMXkm7SCe/TuBNlpdLL3A==
X-Received: by 2002:a05:600c:c7:: with SMTP id u7mr3032584wmm.85.1640300993673;
        Thu, 23 Dec 2021 15:09:53 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id c11sm10989913wmq.48.2021.12.23.15.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 15:09:53 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <e3fe04eb-1a01-bea4-f1ea-cb9ee98ee216@redhat.com>
Date:   Fri, 24 Dec 2021 00:09:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 kvm/queue 06/16] KVM: Implement fd-based memory using
 MEMFD_OPS interfaces
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-7-chao.p.peng@linux.intel.com>
 <YcTBLpVlETdI8JHi@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YcTBLpVlETdI8JHi@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/23/21 19:34, Sean Christopherson wrote:
>>   	select HAVE_KVM_PM_NOTIFIER if PM
>> +	select MEMFD_OPS
> MEMFD_OPS is a weird Kconfig name given that it's not just memfd() that can
> implement the ops.
> 

Or, it's kvm that implements them to talk to memfd?

Paolo
