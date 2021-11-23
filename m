Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCE9459E66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 09:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhKWIpA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 03:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbhKWIoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:44:54 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640C8C061574;
        Tue, 23 Nov 2021 00:41:46 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s13so37609483wrb.3;
        Tue, 23 Nov 2021 00:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g0d3QqsCZsAQe09AQzK3FGjRTfaWx8wJ4QGwqSaUY0s=;
        b=Mw62+XRWvlT8qzBeQZ/h0IBf67LqzhudM5xDapZFn6GgfYhCFcPBmka7Oj1ocwxvUQ
         /cNvmDmqTcYcrSyuuxeDgHc0xFZUqCTComJMB86gBn2KEDpFumMcEqIXhxSwB6YMjubD
         lt3NXPRM2NtOwMMqJs0LE8AhzdddiT36Z6qT5lxRIodNyCjTuauigZnaHO1DCx5GVDql
         epdOGzox9iGOjYi+i7ugyfur4oshX7Ze5oXbADgUgZ+gz+Z0B8y4Vn5a0HN+V8Nh+J7S
         HwMyR5sLcNaGdSCjB99j7FaSlB31s+kjOffJkUhXlpnG/VQ5xi3wdnNC3HpGS7PAxaV6
         VRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g0d3QqsCZsAQe09AQzK3FGjRTfaWx8wJ4QGwqSaUY0s=;
        b=z3sVFWlto2vqr5DwC+4iNR8XabDA+3t4X1hxRaWuiUgGZ+8WTfTt6x+VBwv0OyzVg0
         xHZeouoYSORw4bw96r9NoSatgI6giFezHBM+4S01jRFlat46lEP/g4XiOzRN5vtjpUhA
         yFqpa2KnwS18a0sNA39d+uNHRfzqi5x7ZPzo9rSq9Nxn5h+7m+T+M2G9VwMeghSPqyZw
         3aLQGa4pWydcf5MY2pniskypysKjTeRcozVqbSU3hznXXP1T5WNwye/tJp0PqBkvx0FS
         M5FIKDOdcJzJLO6POppCOyw8Lb4vRMPdP0rcxqs6V+WgMy3Cof9NvzOlFGkiNVu/6a3u
         BZrA==
X-Gm-Message-State: AOAM530ZSa4607msqE/j1ivHeh0bdrBAF9moTDvRsYYUyCRNl1M+5T8H
        qCX6gqMLYJT6rtApuo8pz/k=
X-Google-Smtp-Source: ABdhPJwvHgZSqW8ZEVCAO/5N69oBusE0Bm0f9EvZzy4r53G0pOj/QfdnMwTLqTwvVRJp7btLIQMB3Q==
X-Received: by 2002:adf:cd02:: with SMTP id w2mr5046687wrm.269.1637656904964;
        Tue, 23 Nov 2021 00:41:44 -0800 (PST)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id p27sm348736wmi.28.2021.11.23.00.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 00:41:44 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <d54d58a4-3cd0-5fa3-3a81-b4bb27a7f511@redhat.com>
Date:   Tue, 23 Nov 2021 09:41:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 PATCH 04/13] KVM: Add fd-based memslot data structure and
 utils
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-5-chao.p.peng@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211119134739.20218-5-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/19/21 14:47, Chao Peng wrote:
> For fd-based memslot store the file references for shared fd and the
> private fd (if any) in the memslot structure. Since there is no 'hva'
> concept we cannot call hva_to_pfn() to get a pfn, instead kvm_memfd_ops
> is added to get_pfn/put_pfn from the memory backing stores that provide
> these fds.
> 
> Signed-off-by: Yu Zhang<yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng<chao.p.peng@linux.intel.com>
> ---

What about kvm_read/write_guest?  Maybe the proposal which kept 
userspace_addr for the shared fd is more doable (it would be great to 
ultimately remove the mandatory userspace mapping for the shared fd, but 
I think KVM is not quite ready for that).

Paolo
