Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4626EC2EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 00:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjDWW3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Apr 2023 18:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDWW3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Apr 2023 18:29:47 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2616910D3
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Apr 2023 15:29:45 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a92369761cso31817995ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Apr 2023 15:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1682288984; x=1684880984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WCA3zsna6vFeV798erY3+vSi/BvHgoXGHGGpFGJHBjM=;
        b=CSv4RH6SXo/8LhDuQi8y+f+aMDFvLryZeZLhrGCIHJ76AP0hsBy9FXFG82OCSDXpdw
         w8F2b+EujbdmHkHGv/Yp2eXHQ1Q2MYfO8Vu1ERFY1LXyjQpIg0lB+5VlMI/ocJwxnhdc
         Xr7ocs5kYhWzgrbsToVMuFqmxnhx9PMp/1Es7VJKZagcRT2c06hsYHc4SKreGkyREEPk
         mCg+asSla1YXUzn1ZIV7XG9Mcyje8X207NucVVd2pMhQOzQUptnWXdlOsGXi/9ALcAP/
         iq+8gIFu9tNpqRG1e620R+RCQL23t/f9n43Ntbw7lzsRcOiSQ4oQmZOQImEBwjpawJpm
         dy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682288984; x=1684880984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCA3zsna6vFeV798erY3+vSi/BvHgoXGHGGpFGJHBjM=;
        b=kUI5WfOmN6gPycuWZvuj6Brpj/8beyVHmco2JpsnX92eCKy5LSjUjZ++I/FifEPsSE
         M1Qnt5iEr3DkGDanNJm4RTJ8QhRNwA8YLW5maImoUPMB5wOTSBLmb9Ue3+F5kMpCE6/y
         B+CStquL8WYfhw+AFQH31gdKMfE681fDsJ1aVS40l+XpPvtXSvIajt6awuPbBIM2zhaD
         kX7LRxFIrLygUHKjInTvMEo7+iub3H0AnbEkTAAfRrDKQPbGtF5mwdNM3C7itCZu88Hz
         FcHjUq/4YF7xIdqYwFnUuANZKNUFJtUbtYdareqyfrE9hye0YEWckaemA9hMhm5UHno+
         DT9g==
X-Gm-Message-State: AAQBX9dxZlFoCsVGEJa1RexER81fiGkVvcPllmfInw9oZoLwFBKXzFEk
        zKvheK7eE+is8X8sNAKdsQ61Iw==
X-Google-Smtp-Source: AKy350ZR4n3yiJ8OSE0TQKFE8uJrXQJX3r2CnA0Tf9NWbUzvYbwag62F1wj/UfIK9SSx06miuG3AKw==
X-Received: by 2002:a17:902:e849:b0:1a6:dba5:2e3e with SMTP id t9-20020a170902e84900b001a6dba52e3emr14801275plg.25.1682288984544;
        Sun, 23 Apr 2023 15:29:44 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-41-174.pa.nsw.optusnet.com.au. [49.180.41.174])
        by smtp.gmail.com with ESMTPSA id bh8-20020a170902a98800b001a641ea111fsm5444609plb.112.2023.04.23.15.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 15:29:44 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pqiDF-0074Ij-4U; Mon, 24 Apr 2023 08:29:41 +1000
Date:   Mon, 24 Apr 2023 08:29:41 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Topel <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] mm/gup: disallow GUP writing to file-backed mappings by
 default
Message-ID: <20230423222941.GR447837@dread.disaster.area>
References: <f86dc089b460c80805e321747b0898fd1efe93d7.1682168199.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f86dc089b460c80805e321747b0898fd1efe93d7.1682168199.git.lstoakes@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 22, 2023 at 02:37:05PM +0100, Lorenzo Stoakes wrote:
> +/*
> + * Writing to file-backed mappings using GUP is a fundamentally broken operation
> + * as kernel write access to GUP mappings may not adhere to the semantics
> + * expected by a file system.
> + *
> + * In most instances we disallow this broken behaviour, however there are some
> + * exceptions to this enforced here.
> + */
> +static inline bool can_write_file_mapping(struct vm_area_struct *vma,
> +					  unsigned long gup_flags)
> +{
> +	struct file *file = vma->vm_file;
> +
> +	/* If we aren't pinning then no problematic write can occur. */
> +	if (!(gup_flags & (FOLL_GET | FOLL_PIN)))
> +		return true;
> +
> +	/* Special mappings should pose no problem. */
> +	if (!file)
> +		return true;

Ok...

> +
> +	/* Has the caller explicitly indicated this case is acceptable? */
> +	if (gup_flags & FOLL_ALLOW_BROKEN_FILE_MAPPING)
> +		return true;
> +
> +	/* shmem and hugetlb mappings do not have problematic semantics. */
> +	return vma_is_shmem(vma) || is_file_hugepages(file);
> +}

This looks backwards. We only want the override to occur when the
target won't otherwise allow it. i.e.  This should be:

	if (vma_is_shmem(vma))
		return true;
	if (is_file_hugepages(vma)
		return true;

	/*
	 * Issue a warning only if we are allowing a write to a mapping
	 * that does not support what we are attempting to do functionality.
	 */
	if (WARN_ON_ONCE(gup_flags & FOLL_ALLOW_BROKEN_FILE_MAPPING))
		return true;
	return false;

i.e. we only want the warning to fire when the override is
triggered - indicating that the caller is actually using a file
mapping in a broken way, not when it is being used on
file/filesystem that actually supports file mappings in this way.

>  static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>  {
>  	vm_flags_t vm_flags = vma->vm_flags;
>  	int write = (gup_flags & FOLL_WRITE);
>  	int foreign = (gup_flags & FOLL_REMOTE);
> +	bool vma_anon = vma_is_anonymous(vma);
>  
>  	if (vm_flags & (VM_IO | VM_PFNMAP))
>  		return -EFAULT;
>  
> -	if (gup_flags & FOLL_ANON && !vma_is_anonymous(vma))
> +	if ((gup_flags & FOLL_ANON) && !vma_anon)
>  		return -EFAULT;
>  
>  	if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
> @@ -978,6 +1008,10 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>  		return -EFAULT;
>  
>  	if (write) {
> +		if (!vma_anon &&
> +		    WARN_ON_ONCE(!can_write_file_mapping(vma, gup_flags)))
> +			return -EFAULT;

Yeah, the warning definitely belongs in the check function when the
override triggers allow broken behaviour to proceed, not when we
disallow a write fault because the underlying file/filesystem does
not support the operation being attempted.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
