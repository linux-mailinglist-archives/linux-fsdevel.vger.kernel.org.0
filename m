Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD12458982C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 09:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbiHDHKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Aug 2022 03:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiHDHKv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:10:51 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550862CE04;
        Thu,  4 Aug 2022 00:10:47 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id j17so2849222pgl.5;
        Thu, 04 Aug 2022 00:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Msx+MTdWqnPNVUHp+3FfvLfdSxDAnztRmbALqvTfmJc=;
        b=ee2B6ZmuD7w/b216B4sfnS7nxgF19nbbPD5seH0PzGR35P0l0m9VVe9qFY5joUzJwv
         iGIgbUoJeOoPnK8RYddMDCWsam2EAdTDUk+2AAnJFInausC/w4mQ2e9JWHj5oNqpLmJM
         ZmraEjxD8qh3F/SCH81nNk09N2xF+KP95AbrPc1phVtNBvj5AX3qcNeulUAWJ7Hymogk
         VqWvw5PYeg9pv95ntmSIiWZUY7COS9mMSx+VnBuEmtTMpgIUnMguWM3fOELjfqr08cB9
         YBCc9XKnWP8+/2JP25FF31wt0Z5iUujxqEQEuxCTiUrEDXf51d/LCk8VLAdiABIOIjqV
         3uTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Msx+MTdWqnPNVUHp+3FfvLfdSxDAnztRmbALqvTfmJc=;
        b=MT1h+TG2A44d4eNya5+1LTqanxdXxxTxNmEerBcgl7JFD9bC9Q75X89Yfb0Lvfmuml
         qTfgFiq8DTX73f1YH6q1rgqdvursgeQ3bZ9lNhfir1eK0PdLTJ7YkaUMCZSER93WhTSi
         oEOyDEgF9cyWSqNo4YrdBh/iOUfGGRJK6n80smwonPR/wzJIZhTjWCRSDkIKHHpalrw/
         VP5bGqjaN2tpfwrB0A4d2YoxLn2AJQgdU5bUeuiWmWDUhi2LfxpOsi+TLR6mQryo+FuG
         /33rK0j0lMQN1Y29cy+68KPXAkUZVxG2EF9jFsjNaf9xt8pDf4jIQ+yZxV+4/JJdtjFF
         GoPQ==
X-Gm-Message-State: ACgBeo3+WmETvhCNOpd8cbLkeWTKEUIVfAZjqWbDfwJWrqws9MwBYB84
        VQ3Xv9EGg91MSI3jdewWT1k=
X-Google-Smtp-Source: AA6agR4epr3dQoXSYo3tVKgoUy+uKNO2hxFagEdJ8l6v4De0QEoIfT716hYj4Pnm1/vc1DQPzChKgQ==
X-Received: by 2002:a63:e343:0:b0:41c:d5cd:a39 with SMTP id o3-20020a63e343000000b0041cd5cd0a39mr562084pgj.512.1659597046489;
        Thu, 04 Aug 2022 00:10:46 -0700 (PDT)
Received: from localhost ([192.55.54.49])
        by smtp.gmail.com with ESMTPSA id n15-20020a056a00212f00b0052deda6e3d2sm137803pfj.98.2022.08.04.00.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 00:10:45 -0700 (PDT)
Date:   Thu, 4 Aug 2022 00:10:44 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        isaku.yamahata@gmail.com
Subject: Re: [PATCH v7 07/14] KVM: Use gfn instead of hva for
 mmu_notifier_retry
Message-ID: <20220804071044.GA4091749@ls.amr.corp.intel.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-8-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220706082016.2603916-8-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 06, 2022 at 04:20:09PM +0800,
Chao Peng <chao.p.peng@linux.intel.com> wrote:

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 0bdb6044e316..e9153b54e2a4 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1362,10 +1362,8 @@ void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc);
>  void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
>  #endif
>  
> -void kvm_inc_notifier_count(struct kvm *kvm, unsigned long start,
> -				   unsigned long end);
> -void kvm_dec_notifier_count(struct kvm *kvm, unsigned long start,
> -				   unsigned long end);
> +void kvm_inc_notifier_count(struct kvm *kvm, gfn_t start, gfn_t end);
> +void kvm_dec_notifier_count(struct kvm *kvm, gfn_t start, gfn_t end);
>  
>  long kvm_arch_dev_ioctl(struct file *filp,
>  			unsigned int ioctl, unsigned long arg);

The corresponding changes in kvm_main.c are missing.

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b2c79bef61bd..0184e327f6f5 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -711,8 +711,7 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
        kvm_handle_hva_range(mn, address, address + 1, pte, kvm_set_spte_gfn);
 }
 
-void kvm_inc_notifier_count(struct kvm *kvm, unsigned long start,
-                                  unsigned long end)
+void kvm_inc_notifier_count(struct kvm *kvm, gfn_t start, gfn_t end)
 {
        /*
         * The count increase must become visible at unlock time as no
@@ -786,8 +785,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
        return 0;
 }
 
-void kvm_dec_notifier_count(struct kvm *kvm, unsigned long start,
-                                  unsigned long end)
+void kvm_dec_notifier_count(struct kvm *kvm, gfn_t start, gfn_t end)
 {
        /*
         * This sequence increase will notify the kvm page fault that


-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
