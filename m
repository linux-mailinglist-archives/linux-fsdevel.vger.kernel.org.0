Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32AD7B2231
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 18:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjI1QYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 12:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjI1QYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84BD193
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 09:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695918215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X3MbseqfofQuHt4pLHARDa7jXnUI0dOG+j1Sy7M9elo=;
        b=TMUlpF1ty890qukjEQKkovrhOWeBwtje5hRP12mV5V3p9QoQ2uug2viB0nS7VD1DOm9XxG
        kcnWKLKj95ZcnAE3AHlC4qThiAB6QnB/ML7j/a0CqAUf90DrZNmjjcjpZEPY7FvfuykSLs
        Q1M90NU/Hpvu+bEPCSrmfguvyznTsag=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-cT42Vp7oM7acwSIJYapi7g-1; Thu, 28 Sep 2023 12:23:33 -0400
X-MC-Unique: cT42Vp7oM7acwSIJYapi7g-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-417c06c459cso34999811cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 09:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695918213; x=1696523013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3MbseqfofQuHt4pLHARDa7jXnUI0dOG+j1Sy7M9elo=;
        b=WL75gBHNcWYUMw29bVtCxIzotNSSTWWBkEtF2g0EmLECuQqz9zbbT5BlvtIn2JhHCE
         ZRPxZOYWUlvscfjFmZds0AfZOHq4f9sp/YBU/3s9ckbq1nGC2kVegTy8VEgo6iJR3iy5
         sqNod5uojrquf8+75DdxVXy9rjCWvRXGgWKl7AHaV4Re9aHRqNioH7frjMoU9sdDNtLF
         XSUTRHjUQ0a2IXMc8C3NG/ZhkNOwXnpD/hREN/tFoHrFt8QZ5OWOcdxdNrqDAIEjjngO
         AQIuNMqExjmivuMc4NilwDubenlRH4WV6NFzLu2VOxSQn+rxONsuOMVnNJ1zKtVBlOTP
         qMjw==
X-Gm-Message-State: AOJu0YwnrpF7cZkcWAzj1aDqYh5XyB2zV6li5Bg83u6G8HUJh82/qrkO
        UV0Q5HHGNhMKsapWx1lcvBibMPYAk6waMmGyTaCo2DeFV5shlRPCwsQdINuU2oK9Au9CA4D1kl5
        ITYIVJn7GyuOH21R0ZiXiwt1KxA==
X-Received: by 2002:a05:622a:1a0b:b0:411:ff8f:d5aa with SMTP id f11-20020a05622a1a0b00b00411ff8fd5aamr1620282qtb.3.1695918212866;
        Thu, 28 Sep 2023 09:23:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhws7KLpQsxWmAY8E3zXcIKtOKrYQ/GpK2ItdQp8TYckvr8XWrXOC2qrQiNhX2yyfLB1f44g==
X-Received: by 2002:a05:622a:1a0b:b0:411:ff8f:d5aa with SMTP id f11-20020a05622a1a0b00b00411ff8fd5aamr1620257qtb.3.1695918212563;
        Thu, 28 Sep 2023 09:23:32 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id l11-20020ac84ccb000000b004181441cb2dsm3585433qtv.34.2023.09.28.09.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 09:23:32 -0700 (PDT)
Date:   Thu, 28 Sep 2023 12:23:28 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, david@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/3] userfaultfd: UFFDIO_REMAP: rmap preparation
Message-ID: <ZRWogK5s5/giHuGu@x1n>
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230923013148.1390521-2-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Suren,

Sorry to review so late.

On Fri, Sep 22, 2023 at 06:31:44PM -0700, Suren Baghdasaryan wrote:
> diff --git a/mm/rmap.c b/mm/rmap.c
> index ec7f8e6c9e48..c1ebbd23fa61 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -542,6 +542,7 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
>  	struct anon_vma *root_anon_vma;
>  	unsigned long anon_mapping;
>  
> +repeat:
>  	rcu_read_lock();
>  	anon_mapping = (unsigned long)READ_ONCE(folio->mapping);
>  	if ((anon_mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
> @@ -586,6 +587,18 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
>  	rcu_read_unlock();
>  	anon_vma_lock_read(anon_vma);
>  
> +	/*
> +	 * Check if UFFDIO_REMAP changed the anon_vma. This is needed
> +	 * because we don't assume the folio was locked.
> +	 */
> +	if (unlikely((unsigned long) READ_ONCE(folio->mapping) !=
> +		     anon_mapping)) {
> +		anon_vma_unlock_read(anon_vma);
> +		put_anon_vma(anon_vma);
> +		anon_vma = NULL;
> +		goto repeat;
> +	}

We have an open-coded fast path above this:

	if (down_read_trylock(&root_anon_vma->rwsem)) {
		/*
		 * If the folio is still mapped, then this anon_vma is still
		 * its anon_vma, and holding the mutex ensures that it will
		 * not go away, see anon_vma_free().
		 */
		if (!folio_mapped(folio)) {
			up_read(&root_anon_vma->rwsem);
			anon_vma = NULL;
		}
		goto out;
	}

Would that also need such check?

> +
>  	if (atomic_dec_and_test(&anon_vma->refcount)) {
>  		/*
>  		 * Oops, we held the last refcount, release the lock
> -- 
> 2.42.0.515.g380fc7ccd1-goog
> 

-- 
Peter Xu

