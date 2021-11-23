Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E44459E92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 09:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhKWIzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 03:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhKWIzL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:55:11 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F45AC061574;
        Tue, 23 Nov 2021 00:52:03 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id t5so89225918edd.0;
        Tue, 23 Nov 2021 00:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZlSGmgK04sSRdzce60rca16DF7pHY7R8mkHLd+e2EtI=;
        b=ITSbDLvVQF5Pys3yfnDfjJPsOOVVYvoLjUSScohcTrvaJdHl/9EHS8d9i2S5R8Uf/K
         4s2WMJQDwnIFw+lX6/BqKFRfbyJP6lGaNpaGJfzlYYrY9KqADfho7+J+Sc+eKEeB4gQM
         jNQovETzFOv4K7+TmCcvlFvC2Y6H2Kp/3ilLyt+hPn88AWWXvoNtfld/FvPJKoV+jfNQ
         aUdhg6DabReEPo7FO8FG2sjodRYZNH6wlYAuThcxUHpIjKmLyTWqB+b7b/1S5Hn0S7LA
         e7b6tKbcqf9trxQvprbQwmW8C54tdEuqQd+T2O/lOxhqx/ntiNtEeCL1c4i9+S6iIh5Z
         FjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZlSGmgK04sSRdzce60rca16DF7pHY7R8mkHLd+e2EtI=;
        b=e2HH3BFhWmHtvcYfij46Ft6FPindaHSFssimsRXQq7vHCgVNt9AqZChNHWVeUGvP5N
         7qnNyBR4EjYkSxhmjnrTRaLEJpO/bo3Coad/r6GJg5bV/WTCbXYzd4FUzUDOX1gZ478P
         kVRNQ82cCQjD4amFteyt4VlptnZQEqeN+WevGzh5o6OmowIjOmSx/SgPorlPbfzd2ECl
         184glEwcrp8foJvbUrWn/8+6qKU3d+bRTV0VrRrHi+2C3Vc4KzWwBOVMkCDYvLaO4sZ0
         GuOVimEFokkGRaLscuHV2eIPtXmm97ppPET9laynvrYGqadnwvA0CrRRb+WVG8bA32Th
         hOFQ==
X-Gm-Message-State: AOAM532USfQWzVLAazKQJN7Fz0rZts3d02oir3+qm+D4rpkNYKg9+WJq
        RrOVWIQWicaCA3BtU8ivcooJbvIjIsI=
X-Google-Smtp-Source: ABdhPJyvvvQQvkGIxCW0eOgt8FiihExxUTGI/KDUle/HeZ8ErdGrPrU0t0a4F1hxpkf//prQqRAmew==
X-Received: by 2002:a17:906:961a:: with SMTP id s26mr5477877ejx.494.1637657522264;
        Tue, 23 Nov 2021 00:52:02 -0800 (PST)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id hv17sm5182114ejc.66.2021.11.23.00.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 00:52:01 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <edd15117-def0-71b6-6422-66490155448d@redhat.com>
Date:   Tue, 23 Nov 2021 09:51:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 PATCH 13/13] KVM: Enable memfd based page
 invalidation/fallocate
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
 <20211119134739.20218-14-chao.p.peng@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211119134739.20218-14-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/19/21 14:47, Chao Peng wrote:
> +	list_for_each_entry(kvm, &vm_list, vm_list) {
> +		if (kvm == vm)
> +			return false;
> +	}
> +
> +	return true;

This would have to take the kvm_lock, but see my reply to patch 1.

Paolo
