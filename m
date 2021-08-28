Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834BD3FA2FD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Aug 2021 03:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhH1ByH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 21:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhH1ByH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 21:54:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5822C0613D9;
        Fri, 27 Aug 2021 18:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IsOWHDvQ5UtBgx5GUnlq5SRzmvM9jdYHOtvAIirRgnY=; b=RnyBfCp8iYnHF+XA6o6OW2x3fz
        Zvj5cz8BfOeyy9VVeHFPOIaqZk19bwAnHXtDG6e3xJc4xvEcik5a5A2rGPorYkuQJqTp+soj2njts
        BuJOyCb7eZNSdWO91Dzo/7xI1fE5aOatYdV4AMusf/xo8vp74fDnLRjH2ZxTcIV8qAcFyf9AQcD1M
        RpUkC7GG0ovTBOz7qmRUyJR+eAMrKqeHWG4UwR+3gJjhxjr3GiO03QSEr6ZZQoXHg0LuS3+Csb/hL
        6ai6gsEe+02oQYmsvhhmIxvz/Ugg/SnYCI6GD9+L3cJgfQAO6XNVmXYVsH3HEsUOCuLMM+JO7GUpF
        WUcD1PEw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJnR1-00FC17-3x; Sat, 28 Aug 2021 01:47:12 +0000
Date:   Sat, 28 Aug 2021 02:47:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, mhocko@suse.com, dave.hansen@intel.com,
        keescook@chromium.org, kirill.shutemov@linux.intel.com,
        vbabka@suse.cz, hannes@cmpxchg.org, corbet@lwn.net,
        viro@zeniv.linux.org.uk, rdunlap@infradead.org,
        kaleshsingh@google.com, peterx@redhat.com, rppt@kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com,
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
Message-ID: <YSmVl+DEPrU6oUR4@casper.infradead.org>
References: <20210827191858.2037087-1-surenb@google.com>
 <20210827191858.2037087-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827191858.2037087-3-surenb@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 12:18:57PM -0700, Suren Baghdasaryan wrote:
> +		anon_name = vma_anon_name(vma);
> +		if (anon_name) {
> +			seq_pad(m, ' ');
> +			seq_puts(m, "[anon:");
> +			seq_write(m, anon_name, strlen(anon_name));
> +			seq_putc(m, ']');
> +		}

...

> +	case PR_SET_VMA_ANON_NAME:
> +		name = strndup_user((const char __user *)arg,
> +				    ANON_VMA_NAME_MAX_LEN);
> +
> +		if (IS_ERR(name))
> +			return PTR_ERR(name);
> +
> +		for (pch = name; *pch != '\0'; pch++) {
> +			if (!isprint(*pch)) {
> +				kfree(name);
> +				return -EINVAL;

I think isprint() is too weak a check.  For example, I would suggest
forbidding the following characters: ':', ']', '[', ' '.  Perhaps
isalnum() would be better?  (permit a-zA-Z0-9)  I wouldn't necessarily
be opposed to some punctuation characters, but let's avoid creating
confusion.  Do you happen to know which characters are actually in use
today?

