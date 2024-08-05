Return-Path: <linux-fsdevel+bounces-25051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A33DE9485EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 01:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA99283B71
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 23:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A134C16EB63;
	Mon,  5 Aug 2024 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MUjxSBCC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902D61547FB
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 23:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900552; cv=none; b=hNsK2bxf+tcLM4G5IOJYBXAABkRXaeKY8wssmcYD78qITNUoYz3l+9rFW0H31/AKqVYDWf1HPSY8xfWnf28EP2ptOfOOizUQs7RZlwxyMjunhgnp1FuPNalKmAvzXk7/QQKV7WsNiuKDfqnRNwp90Y/iFPY1z6SCbAXxz7+dQ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900552; c=relaxed/simple;
	bh=Ud+vs2yn6sXlpWsYL0inF2KS4QwbN9S8Dxwgfx2J134=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msk9apIPp9QNpM7MFhwnR9NVEH4+jTW2otVOtcGkz9PFeo2bJQt1Yhm0uD5e8unicOQR5Le+BQD4pIE9IqSdu7um68DrjxbJIa5KM1S/2UHyhNyXqqHpJbOpF3mt3nnfuHxJ88DqmS9CXeKxw/5RkCG/LIaZ0L/prU3JcpzQerY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MUjxSBCC; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b78c980981so406506d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2024 16:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722900549; x=1723505349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ud+vs2yn6sXlpWsYL0inF2KS4QwbN9S8Dxwgfx2J134=;
        b=MUjxSBCCZ4a/cVUr5whOihgnOhTIYXF0aEXKzqmkYPINjr2E2onX+wwDkAu+tt2jae
         vSjt3pDf+aBqVfC6dxFEHZ4svDH4LrmEjCYAZQmduXCp8vXix+jxlUBHhKYHgGaW1/yW
         l1qN0qq+usNSXvQSyq+Tp+0B7x0NEuXEqscpTUhcgY78HAWu031Us+eLGQZeS/W1bgpN
         XrGWKsKl/uBIBeA52qi4Oe88x5h/I0Kru6lucgexVGr11pbUeyTKRCcPPxk3rluDsfcY
         cnpLlQy/ciP3+sS+qh9bugNx+UutmpyKVOmDR10/tFV4LnHprPI+JcbOi1lfrY9xRfAU
         pKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722900549; x=1723505349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ud+vs2yn6sXlpWsYL0inF2KS4QwbN9S8Dxwgfx2J134=;
        b=PvUwxgLLLZbxTv/b62gz5xdC5XDkOQdxZ+FahkUI15+x17EfvmG3Z4cxF+cUXJ/4go
         1kyT2xf5B2U9lkhe+vdpJadyRPrRE2X6TWKjh6fYIDD6LAWzW69eA0/OaW8VBNXJIBCj
         s2+j6s04vmeJonovJ+ypXMQ+GzIj+igggQeMxN+Kh9XVP9zBqwGpf7/qDLE0JvwS1NBJ
         2Ovk8jKkH45bnXk226q7KweeWqD3/66qhpuWzbZy1EDUMe9s2N1cB2OiKIzvTbsTukix
         w5rita0WNR6UsCBMVb5mRreDPSLZN4cqJ+2IRKqw4iJ/iBpkYtWySDBhp3rDuWrXAmtx
         Hdbg==
X-Forwarded-Encrypted: i=1; AJvYcCUz36y4quTfUxFI0vvyEIJY8ivaR8YkqNZ9WCWkWDgayF4kJC2KLTrroKg3ogU75WjMKseYufS0yS+/RbailfgUM+HJqq/0sKsHyylnaA==
X-Gm-Message-State: AOJu0Yxwb+dkpyYcBbDdzHmNgyn+g3tclTHXAKRDvBfOS+w1ehICweUX
	hu9UHIx37IGsaNzp4oOMxvL5vn7lkBrfvFP5yzrLsf6Ht4Hy/+S1/Jvqs1qRYBQ=
X-Google-Smtp-Source: AGHT+IEUqd6hIg9HDyEzlke8VzqWmU4TFD6nLDglYJ354O5s+08g370xcdmQz9qNHG00XmeufXnXGg==
X-Received: by 2002:a0c:f209:0:b0:6bb:b478:52fd with SMTP id 6a1803df08f44-6bbb4785327mr1712666d6.31.1722900549464;
        Mon, 05 Aug 2024 16:29:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c83cc30sm39451646d6.101.2024.08.05.16.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 16:29:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sb78W-00BvtY-0n;
	Mon, 05 Aug 2024 20:29:08 -0300
Date: Mon, 5 Aug 2024 20:29:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jan Kara <jack@suse.cz>
Cc: James Gowans <jgowans@amazon.com>, linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Steve Sistare <steven.sistare@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Usama Arif <usama.arif@bytedance.com>, kvm@vger.kernel.org,
	Alexander Graf <graf@amazon.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Paul Durrant <pdurrant@amazon.co.uk>,
	Nicolas Saenz Julienne <nsaenz@amazon.es>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH 00/10] Introduce guestmemfs: persistent in-memory
 filesystem
Message-ID: <20240805232908.GD676757@ziepe.ca>
References: <20240805093245.889357-1-jgowans@amazon.com>
 <20240805200151.oja474ju4i32y5bj@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805200151.oja474ju4i32y5bj@quack3>

On Mon, Aug 05, 2024 at 10:01:51PM +0200, Jan Kara wrote:

> > 4. Device assignment: being able to use guestmemfs memory for
> > VFIO/iommufd mappings, and allow those mappings to survive and continue
> > to be used across kexec.

That's a fun one. Proposals for that will be very interesting!

> To me the basic functionality resembles a lot hugetlbfs. Now I know very
> little details about hugetlbfs so I've added relevant folks to CC. Have you
> considered to extend hugetlbfs with the functionality you need (such as
> preservation across kexec) instead of implementing completely new filesystem?

In mm circles we've broadly been talking about splitting the "memory
provider" part out of hugetlbfs into its own layer. This would include
the carving out of kernel memory at boot and organizing it by page
size to allow huge ptes.

It would make alot of sense to have only one carve out mechanism, and
several consumers - hugetlbfs, the new private guestmemfd, this thing,
for example.

Jason

