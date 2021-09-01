Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3F73FD4F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 10:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242899AbhIAILR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 04:11:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39296 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242766AbhIAILR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 04:11:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ACB58224B8;
        Wed,  1 Sep 2021 08:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630483818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GHTY9I51VG4C7aTV8oDtjnPiG0Wf5YKwTyayXS/Ire4=;
        b=ILCGDl0sDjQqHhpMDxu05cHf7kKxPWynTyaTuP+hTxgRpsq4gZpONxzwWlqt958hOfg9WW
        9vnj3ooGOTm2ZAE/21dJtE2RsDuNMuymiwoJcMrmIwatyxasL1Pqg+qjh7d+lMJJUW5jKK
        tJv/0rqvwKPw4Kc9auN8DbvUSd+WRWo=
Received: from suse.cz (mhocko.udp.ovpn2.prg.suse.de [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 57C29A3B9B;
        Wed,  1 Sep 2021 08:10:18 +0000 (UTC)
Date:   Wed, 1 Sep 2021 10:10:17 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, dave.hansen@intel.com,
        keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, kaleshsingh@google.com, peterx@redhat.com,
        rppt@kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, chinwen.chang@mediatek.com,
        axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com,
        apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com,
        will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com,
        tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com,
        pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk,
        legion@kernel.org, eb@emlix.com, songmuchun@bytedance.com,
        viresh.kumar@linaro.org, thomascedeno@google.com,
        sashal@kernel.org, cxfcosmos@gmail.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com
Subject: Re: [PATCH v8 2/3] mm: add a field to store names for private
 anonymous memory
Message-ID: <YS81abHD8KZMrX8D@dhcp22.suse.cz>
References: <20210827191858.2037087-1-surenb@google.com>
 <20210827191858.2037087-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827191858.2037087-3-surenb@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 27-08-21 12:18:57, Suren Baghdasaryan wrote:
[...]
> +static void replace_vma_anon_name(struct vm_area_struct *vma, const char *name)
> +{
> +	if (!name) {
> +		free_vma_anon_name(vma);
> +		return;
> +	}
> +
> +	if (vma->anon_name) {
> +		/* Should never happen, to dup use dup_vma_anon_name() */
> +		WARN_ON(vma->anon_name == name);

What is the point of this warning?

> +
> +		/* Same name, nothing to do here */
> +		if (!strcmp(name, vma->anon_name))
> +			return;
> +
> +		free_vma_anon_name(vma);
> +	}
> +	vma->anon_name = kstrdup(name, GFP_KERNEL);
> +}
-- 
Michal Hocko
SUSE Labs
