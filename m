Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABAE3FA3E6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Aug 2021 07:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhH1Fx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Aug 2021 01:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbhH1Fx1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Aug 2021 01:53:27 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DE3C06179A
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 22:52:37 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 7so7582417pfl.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 22:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z+HuhAltfukR5DxGM9D9CIqPHDVhtycCenUu1P74d+E=;
        b=bdORIgQRO5qTEimiwy5kQivohDvUrEODFuEj423+D/FNgtSgGvj8uD9iZHQrUldlSS
         O63NVS+iWTa88tkTbrR4TJWYtTf9ibq33RPNQj6JqBAhpbCCwSeYv8urfqL0N15UKfTx
         L+o3L2rl2wmR1kzngsKz5V8FbDNbRcZBFP+eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z+HuhAltfukR5DxGM9D9CIqPHDVhtycCenUu1P74d+E=;
        b=pTaWlYAETQDj3pC7nQf944nwRWP1YYfLtAsH5OgQWYq/abOEfkGOrcrUiQjsy5NCk+
         /XmpdBVy2nAVaU2PYjajBBU8uWUGzRfupZVWr/FjUfhiVWvLZm3eHLftUNPqM0ayXrKG
         O0zJLstoTxARjEH0ylSb8l0AU7awxA/lu0ACTkeDbvOuhcHjXqpNMbJ3VJjNZkLqqA2g
         xXdtun7FVNXtJdD6Qp1oF8dOfOrKCqfozZDrZPV/bZdfnIB4GEW9XauPf6kyg9IgviMd
         klkPbC0VlCDLNQDy07kuVuVK+WTMEvu0yrSFHjClyU5jfS1qPbEig2wFnifned9PNI1w
         fJ0A==
X-Gm-Message-State: AOAM533d6XtVcnGql0Okyu3asKsBGpW0B5GFj2M66ZLwXBqw3aa5Tv8D
        Kaeu6yxmPP2PH4AcBZIf0CJn8w==
X-Google-Smtp-Source: ABdhPJztO6T36nxEsQz8Izbq5fu8IF66OpnFss/1uDM4zaqqmIHtaBASu0RjxeYiEvzXd06oguZhcw==
X-Received: by 2002:aa7:9218:0:b0:3ef:5618:6b02 with SMTP id 24-20020aa79218000000b003ef56186b02mr12092111pfo.45.1630129956591;
        Fri, 27 Aug 2021 22:52:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y19sm8342507pfr.137.2021.08.27.22.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 22:52:36 -0700 (PDT)
Date:   Fri, 27 Aug 2021 22:52:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        ccross@google.com, sumit.semwal@linaro.org, mhocko@suse.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
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
Message-ID: <202108272228.7D36F0373@keescook>
References: <20210827191858.2037087-1-surenb@google.com>
 <20210827191858.2037087-3-surenb@google.com>
 <YSmVl+DEPrU6oUR4@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSmVl+DEPrU6oUR4@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 28, 2021 at 02:47:03AM +0100, Matthew Wilcox wrote:
> On Fri, Aug 27, 2021 at 12:18:57PM -0700, Suren Baghdasaryan wrote:
> > +		anon_name = vma_anon_name(vma);
> > +		if (anon_name) {
> > +			seq_pad(m, ' ');
> > +			seq_puts(m, "[anon:");
> > +			seq_write(m, anon_name, strlen(anon_name));
> > +			seq_putc(m, ']');
> > +		}

Maybe after seq_pad, use: seq_printf(m, "[anon:%s]", anon_name);

> 
> ...
> 
> > +	case PR_SET_VMA_ANON_NAME:
> > +		name = strndup_user((const char __user *)arg,
> > +				    ANON_VMA_NAME_MAX_LEN);
> > +
> > +		if (IS_ERR(name))
> > +			return PTR_ERR(name);
> > +
> > +		for (pch = name; *pch != '\0'; pch++) {
> > +			if (!isprint(*pch)) {
> > +				kfree(name);
> > +				return -EINVAL;
> 
> I think isprint() is too weak a check.  For example, I would suggest
> forbidding the following characters: ':', ']', '[', ' '.  Perhaps
> isalnum() would be better?  (permit a-zA-Z0-9)  I wouldn't necessarily
> be opposed to some punctuation characters, but let's avoid creating
> confusion.  Do you happen to know which characters are actually in use
> today?

There's some sense in refusing [, ], and :, but removing " " seems
unhelpful for reasonable descriptors. As long as weird stuff is escaped,
I think it's fine. Any parser can just extract with m|\[anon:(.*)\]$|

For example, just escape it here instead of refusing to take it. Something
like:

	name = strndup_user((const char __user *)arg,
			    ANON_VMA_NAME_MAX_LEN);
	escaped = kasprintf(GFP_KERNEL, "%pE", name);
	if (escaped) {
		kfree(name);
		return -ENOMEM;
	}
	kfree(name);
	name = escaped;

-- 
Kees Cook
