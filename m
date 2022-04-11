Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236084FC09C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348046AbiDKP2R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 11:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348430AbiDKP2E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:28:04 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F881A3AB
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 08:25:17 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id b21so1082883ljf.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rFr6s0nrZU/l/rYSbRMVpOLqR853sTAxGnl/eB7rqRM=;
        b=vqJYdIQWv8WkNNNn9dPXtN92UFDTRrKywzC32jqHUXQPd0+vkYBmnq9rZ4NZXVIxFT
         qFZtKKzAXyLtgRUtZW0cMECXBtK3dk3Wyx0Mmsh8UZ/OzlNIFCM15Boa0s9MFTZnFSN3
         8zObizgXQHcCLVp6LDk/Jzo1jR2NDPvFFPY4ogEXWUB70897ie3SGoK0vWAAx5unyy9n
         6j5A9PCMQnyGGwVeSCqGXUcxMULTqx2b4wpel2RMEuBXrpI2Je1yyPDmgKNutqRQhKPF
         E3eAJ4YsBCcURT61ntTfs2vYmJhK1nZzXt1rqLkINEtuod8EjW60nrtXooL3LRDyK+/7
         0TjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rFr6s0nrZU/l/rYSbRMVpOLqR853sTAxGnl/eB7rqRM=;
        b=anfu4fsjX9ImFuhsYbYuGmA65lCCAeO3mNBgT8S1tbuAz5P6ame/QHD54A/dJlCrwe
         tJmi0HglfV8+lJN6OlUOOI9rRcyQk8I1L6T1akNkeU0Nq1QQIEzmGl3p3SU7TGX75FM8
         CYrvqyBiGHgkWarEL+iBrEoZOjrEfu63lEmFtnWw00r+uFy2w83HKvBofbr4pB5PzyBX
         WVAg97B/knFFzFhM3V/5LFTtWsAQQyjzcGe9Ylyg77U0NxO1PjZ6XWxPI+5GBjr4g8qN
         BTCR2Zrs7N8ixyW4D9ef8Qbu4FXyRS+51jez3kk3iIUk+FZD5S1lsz8Lm3wC60oQskMJ
         UWgA==
X-Gm-Message-State: AOAM5314yaMNQfM5cJx/aYRq4koehOn6ktAmjGAtsK5eskVY2ADksZqe
        w6cYzwFYULo90fb0J2CMddBH4Q==
X-Google-Smtp-Source: ABdhPJxUo+KOo46oZZC8/G3tHjCARN4FX+eDd1+/GBegGd9jDdlQ537rMvPHZViYY23J0dOhGwiqZg==
X-Received: by 2002:a2e:80d7:0:b0:24b:bd8:b89e with SMTP id r23-20020a2e80d7000000b0024b0bd8b89emr20019551ljg.174.1649690715205;
        Mon, 11 Apr 2022 08:25:15 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z6-20020a056512308600b0044af5ea2be1sm2837295lfd.274.2022.04.11.08.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:25:14 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 189A9103CE0; Mon, 11 Apr 2022 18:26:47 +0300 (+03)
Date:   Mon, 11 Apr 2022 18:26:47 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Wanpeng Li <wanpengli@tencent.com>, jun.nakajima@intel.com,
        david@redhat.com, "J . Bruce Fields" <bfields@fieldses.org>,
        dave.hansen@intel.com, "H . Peter Anvin" <hpa@zytor.com>,
        ak@linux.intel.com, Jonathan Corbet <corbet@lwn.net>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Hugh Dickins <hughd@google.com>,
        Steven Price <steven.price@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Borislav Petkov <bp@alien8.de>, luto@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Annapurve <vannapurve@google.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v5 03/13] mm/shmem: Support memfile_notifier
Message-ID: <20220411152647.uvl2ukuwishsckys@box.shutemov.name>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-4-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310140911.50924-4-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022 at 10:09:01PM +0800, Chao Peng wrote:
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 9b31a7056009..7b43e274c9a2 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -903,6 +903,28 @@ static struct folio *shmem_get_partial_folio(struct inode *inode, pgoff_t index)
>  	return page ? page_folio(page) : NULL;
>  }
>  
> +static void notify_fallocate(struct inode *inode, pgoff_t start, pgoff_t end)
> +{
> +#ifdef CONFIG_MEMFILE_NOTIFIER
> +	struct shmem_inode_info *info = SHMEM_I(inode);
> +
> +	memfile_notifier_fallocate(&info->memfile_notifiers, start, end);
> +#endif

All these #ifdefs look ugly. Could you provide dummy memfile_* for
!MEMFILE_NOTIFIER case?

-- 
 Kirill A. Shutemov
