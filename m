Return-Path: <linux-fsdevel+bounces-10341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D3184A059
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 18:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DE21F234B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 17:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DAA44C66;
	Mon,  5 Feb 2024 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="POl5+JL/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CF24503B
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153154; cv=none; b=fbOt/WnlglN5pPTJ0SiyWzL4OZoCvPmhH7yKMZmicyOeDfh2qiOMyMrhxBwRb9S9LCAsd3z8HQHmEbhJZefz4fz2Sc+aE1LzuIJhjXYQYBQf2gwae9dRpl1okQ5GwmH9Pv+9n9T4WW3hr16UWa6mDFzIorz0A94HgjuwxcLqbDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153154; c=relaxed/simple;
	bh=m1QtL3ans36Yguk2A+1LNtWPxgFl5Ch0CUDhoxI8cj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbBlJXJEsIABSL55If7F2uTHBNZpUOGNEApyAlDKGEXz7oWrwSZ0MpPTnwaSI6UvPXqwmP9B2mmK7WDQ5X8cCYAHqmjRfbIS+OwnmuvbPfpyNpfQUADorcUKkQWWsp56AkBOfld/1tJ6uWPHMvzjaCTPNFpFwBCetqL9LNXdKQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=POl5+JL/; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-219122781a3so2431403fac.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 09:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707153151; x=1707757951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qDbIp2yNtXU1RzQ539qXvN5xu3jf0vrl0xdf7V68t0=;
        b=POl5+JL/hyS2mGa/py8JOz+c5qhrPsPBGkTGsNKOH6+qWyODZZT51zx3RE3b+810AD
         X9v12YqGRt002pb/YlBadKtMmmhn0wzZFBhcqculFPjxFfD5lUH7NiwIm/tmXibh+5aV
         1FVuEW7akqo8pKQXwZtSpLfuy/FnIfU6t4ZzljYpIqLqfZDopeEVaiA0MC4m3/hnz00C
         D/UWE5M1hQwvWCVu8lCWk2iQBdZLji3F6T0VHQg+pwVaQrMGEdlRQOstRxR4GEoBj03S
         l7lXn61Y++SZh+xqo2HrOBgTr0ITUETCYl3H4KGGFIaTU3t7X6G/Bi/XQqAbGhH5/1e/
         WOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707153151; x=1707757951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qDbIp2yNtXU1RzQ539qXvN5xu3jf0vrl0xdf7V68t0=;
        b=SHtsmYhmdEp7p7UYxHN87u7aTjKM+iztIsJWOe7ycOpMMijHtBL85E1k6tTeC6YUlC
         F0UzeXZEvg/PN3UyA37DgxFvj0iXb5ay3Qy9GriZDAwmvA60nJK2iJI9+ko9Oz+hMLK9
         6ArTWOG1apOqA4Psk1e2xo/pi3xWQw6bLUmN+5mdlZBPvf8zhFy7aNdnUs+vxyI893vg
         JYwXBrGjC0uBsca0wip14UEb18N1dI1+2WLlKtqP5GinwO2+/jOkFK7Paow11scRHvC/
         F0SlAWJ3J2rAyFrbdnki+nGItJcO0bXThBPivjl4frX0GQwznM4g5RfIX7kBOnzw9BfB
         B4Uw==
X-Gm-Message-State: AOJu0Yyxn43AZwXBtx/6wqQM2OpkU84jAqwx8j/Rxt7BiYspkZuycF8k
	/pBQQZXHlbJCTq93G6jtYO9MzuM9XHuEc78NW25Kdz+SOE1+c8uK6DS1NBtqDwA=
X-Google-Smtp-Source: AGHT+IFln/5f5G6GIeUtem4PLnGVB16+0C+2crVsZ05VhszKdHkv3XoMdgobGPR5lticlBVyoAC2eg==
X-Received: by 2002:a05:6871:5813:b0:215:68d7:461b with SMTP id oj19-20020a056871581300b0021568d7461bmr322778oac.23.1707153151179;
        Mon, 05 Feb 2024 09:12:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV/rPy91arwpYIwAojARklp6ZMF9K+LQVXtUZZ6YGhWdbSR41RR9S8S8caNOyg5Xw541tmu/KUnL1bRkwrLAWUFUQvIxBuAH86HrvajT0/XV7ievA8flm9zmbktlvTgPRA0yJDD3YeqEMbTqxaPHx78ygvrA/LdsiY6hjFAYx3hveMP1d6W/6K3k1EeoEzo90VzeDX4LNG2UcoIuzn8m6WZRZawwUNd+8QLX9XNbvyX+fxR3fyR2KkUPftZmPdowvRIAvlRhyHwjG1bgBeEvc7d3Im4bHyZ5LgWimpfq0AnUsJa49hcgqa18SGKfIDO357HXXSckB3H4VdxbBTR9I45dNsvSz2iUqZTjHAbpAgsGcljcsJXIYKsrhGG9FxLtW5p590R06d0vW4BCLwzh5MlbNqk4LSt2GTNcJcpmFo55Yyj1G/hlxQypUbHBJCZVzbbo7/FoWYMlsuz7iMv5EBzmfwGjNEvyEkU4+HAjiu9R7nOQl62M73DoGf/9IBMJILTI4CKJkoWgyKcr9LlTDO16Riw0X0a2+S/yupU46js8efVoG04val7Yb6gYBHIStR6H11fRi9OhWk0YB5VN6N5KYXugRjyOAxpVLg0Rtt8AvhK8Dykw3m3tmG3Yi6bseB6dR4OYaw0dXa8GiZ/u1/G7p4k8O6NLeS+iE8ypk+u0M5hspJ7wNhWTvsjpjHNt1xovNvCg/o0wX4tLIgyKy9BQQf8jiFAkcp8+tFunLmk7sxu
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ej8-20020ad45a48000000b0068c6789ce9csm162580qvb.6.2024.02.05.09.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:12:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rX2WE-000dJX-5F;
	Mon, 05 Feb 2024 13:12:30 -0400
Date: Mon, 5 Feb 2024 13:12:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Gowans <jgowans@amazon.com>
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Alexander Graf <graf@amazon.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Jan H . Schoenherr" <jschoenh@amazon.de>,
	Usama Arif <usama.arif@bytedance.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	madvenka@linux.microsoft.com, steven.sistare@oracle.com,
	yuleixzhang@tencent.com
Subject: Re: [RFC 14/18] intel-iommu: Allocate domain pgtable pages from
 pkernfs
Message-ID: <20240205171230.GB31743@ziepe.ca>
References: <20240205120203.60312-1-jgowans@amazon.com>
 <20240205120203.60312-15-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205120203.60312-15-jgowans@amazon.com>

On Mon, Feb 05, 2024 at 12:01:59PM +0000, James Gowans wrote:
> @@ -946,7 +946,13 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
>  		if (!dma_pte_present(pte)) {
>  			uint64_t pteval;
>  
> -			tmp_page = alloc_pgtable_page(domain->nid, gfp);
> +			if (domain->pgtables_allocator.vaddr)
> +				iommu_alloc_page_from_region(
> +						&domain->pgtables_allocator,
> +						&tmp_page,
> +						NULL);

I'm really worried about this change - I plan to redo all of this page
table handling code so it makes use of struct page members for things
like RCU free and more.

Does this end up making the entire struct page owned by the
filesystem?

Jason

