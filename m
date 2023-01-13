Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B48D66A6CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 00:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjAMXOU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 18:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjAMXNv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:13:51 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3774C6C04F
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 15:13:49 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cx21-20020a17090afd9500b00228f2ecc6dbso2505493pjb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 15:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aD430Gm5/BH6KWfU6qRjnAcPFnRFXzypIgZQD78Cq8M=;
        b=J9kbXeAr7RzKUj6xWqpWYyasnI938iccbuzYevy5Kw8J6dsLK90aA073MlhfbQX7Zx
         g+GrHw5HrAqoynqitIFYrifwNYgqPzRdTko8sXY7wDB8RJJof1k0kQ/MRRNQ1eqRjcYi
         cbhX/+Qd94yu+tAum1D9Oo9mUsR4zLbdFcHsJdqJmJRogfNxVk3ex3FGBS1rfDubEwnO
         DQIlWYFYlqkXqrPcX5Qd0OI0aVEQJGn/j/r9wH/dLXSAJHp0J55zTJcP36Dgsxja9PEp
         0qQjV1iaoAynY5Qk8zGqkPmE5xPbzsoqo7Jv4RuAEZ5C2vIa1vBQUrmm/x2y5EB/PJFI
         jyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aD430Gm5/BH6KWfU6qRjnAcPFnRFXzypIgZQD78Cq8M=;
        b=Sq5POa7wR/rKXQQXxL0ndscfT74UjjRue8bM7VnHhefgaC0GcdoVB2knSuZdl5S73Y
         VcxbWd+948Pb+vY0tw6CW321ac+R8WaeerBPNGW66ruzESCzS8mLX9MW179UgnY1Oe+p
         TDv54w0vPQvk0SM27p+qggQM7VTYAq27SMqjE4wKzsK6/l5NAzFSLxTAFPp1jxbbArHw
         UBwey3P/9aTsvkg2CvEk9TVBn9O5iNW9tERf0lrLKqmQhtIhpOM58vnP/3GT9BN0pPjb
         2ZsV5knBS+Bl8sICrRNDpsXbMQXiZsMNlFu+v15OiravAXCgiqNRmFTDGqyciYeQUXyM
         HnnA==
X-Gm-Message-State: AFqh2krzDXyYfQSftPV4U2fnAkrXzNhHjzXEXe9JWQ4SqVCMv47V+i6c
        IedFuJ5+qTCD8GQDdH6Fthy3aQ==
X-Google-Smtp-Source: AMrXdXt6FsRHB2cphm8pjBSHUu2uqj9MrjnIMJc5jrgFlJeiijosoKXpar/7LHkVP4cLD34SofgrKQ==
X-Received: by 2002:a05:6a20:4284:b0:9d:b8e6:d8e5 with SMTP id o4-20020a056a20428400b0009db8e6d8e5mr1901073pzj.2.1673651628605;
        Fri, 13 Jan 2023 15:13:48 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id k16-20020a170902c41000b00178b77b7e71sm7936571plk.188.2023.01.13.15.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:13:48 -0800 (PST)
Date:   Fri, 13 Jan 2023 23:13:44 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 4/9] KVM: Add KVM_EXIT_MEMORY_FAULT exit
Message-ID: <Y8HlqMtgPACAN1i2@google.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-5-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202061347.1070246-5-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 02, 2022, Chao Peng wrote:
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 99352170c130..d9edb14ce30b 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6634,6 +6634,28 @@ array field represents return values. The userspace should update the return
>  values of SBI call before resuming the VCPU. For more details on RISC-V SBI
>  spec refer, https://github.com/riscv/riscv-sbi-doc.
>  
> +::
> +
> +		/* KVM_EXIT_MEMORY_FAULT */
> +		struct {
> +  #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 0)

Unless there's a reason not to, we should use bit 3 to match the attributes.
