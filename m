Return-Path: <linux-fsdevel+bounces-65747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E05F6C0F8EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 18:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952CC1889184
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAED32F693F;
	Mon, 27 Oct 2025 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3txy0tOv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB86305E2F
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585170; cv=none; b=VH3kI6M1jVUIey92Db18pSu09QSwOO8VP4UneiuN26sCDnktLghtBY18ZtopzNmAw0a4Mimru1bWwudCn8hoQdy3pfurmuxTxasn1CFKqooIZUroti9qksdHGOb2I/vCT3KJdFQFICg+urejsbqOtOk9cSf1LajiJA4B3UZo0qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585170; c=relaxed/simple;
	bh=eeCcaiB5m6mBMPE2QFVNav++Juuy6BY9qODhUaJkbbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcNrmQPfJhOv6HimMjiHHwq+1+Bn6HlDzQ8fd6DaG8UscO5ffixijOv2aaQe7Xm1D0hGsZDUhlK6uj5iUBYAjj2vT88VwJXL+GdTGqhOVuYC+ojgCR26WYK4zp/FITtAJgY/qrLfRrEraQ5bfeH3301VUJ/g/3eLpRQBX165BsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3txy0tOv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27d67abd215so13675ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 10:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761585168; x=1762189968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPy+FHVUTDlqo9kS8K0pwEoZsjWCLKbllIO0a4/trd8=;
        b=3txy0tOvQB9Zzi2DRCgScrD2MNOnRQqPwvbiqFKqkxk9OeWypvULXELoePexHM4xCb
         KzGlJ0QmT2WpG6h1F3tNfpRcbawVVVAUBQIwR5jV8f8ChtCq9L0jtMQOJmOfrhCObz9I
         C/4bjn+Qx+qoo4dJtoQgWN6+/Umt2pJInfypP9QhlxM1X0dEzPrwSPrnQY/+qT24cuEq
         1XRqEbT7a7zFFiC8vlaguLgq3INGB8roO3QVSfHSAdIu4EyUnQXqi9/LBdV31tY4CcBH
         +dGaTepAgZQbAfQ8+HL+tB+/6pxn2waTKnt38HF2kPZ9DrWhZ9/jq+lfLBC3flE44b7D
         H3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761585168; x=1762189968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPy+FHVUTDlqo9kS8K0pwEoZsjWCLKbllIO0a4/trd8=;
        b=t9pf8j9rkdn/OO9ll4YtjXvEl2dpnuOel21T51zQpieogVkluMLl6cp8PmwdNhahO0
         72TyN3yGZFzPJaU4EQsaVfN3n3VbCMMpVyckkIB4v53jE7RdBZPV7Xkcn9XZamiqnnaj
         s8iwF8lQxLntvO98/UAGK3z/hMpqGkclLWN0zSJ9or/kSKpgDSEh4mKoMEWPAdL1l2xK
         578fSv9THSoI/7IEYCI4wyaVq6M65B/Uu0UdvlEHar7sTHtkB25OEwjxU5BeoWvVZ55F
         nzZ12UTQKj47N4x9xasTnj9/lRVjdOv/CWIJ7Y4e743iNx8yv5t4nHZ2PTtC0B6AqsBr
         66NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSmB4rx4I9xdndBzrrOPN318gcpUvTacsVA62VxRUrsJgZ9J9PDyGId6e4NQ5pwCDm/1erp8IN81Aa+rvk@vger.kernel.org
X-Gm-Message-State: AOJu0YwZRsjirYzAoyctDTLsvC72ZhGNbP9RcZGguDk9JL9mqT7SrRqo
	qgI27ZVKSkubg0o1bQpxEC+rwshhv+LtSI+uZ0e1JsaKPANJsXWFbZvBM+khGLo/KQ==
X-Gm-Gg: ASbGncsAmX9P8rfMyh0YICrlKJVJrIJeQ22Oo/R12F9m+c8apWRcEoOPfkT7n4hkise
	EdPSd8q+yPwGl/5Y8SyNtlKs+Gzkcx0YWKHCH5VcyHhuDZ+dQOeIFpH8FjMejl+lzVGIUtB+DFB
	nNBdWRYp5ARFciXu0k5skYWTkmBUXBd4+D5w1Jk6m/e/D5MW66x6+zQ+ZuxGtnhxfiflt8JlxJA
	gUaOVQiErQ5AdPRIM8v4rMnN1xgxu2/9kHmzcyByS61bgWUgSuHUqaKHJeV3pb0gOUm5e4ZumQ8
	OGwCL/9xn1iQ1XCJqdfEmMbDAIK052cpOx7Z5fboCQL+Ri/2yG9XlVg511Nj+EPGDhW4T57E5Ch
	kfY9/ixLuq9ksCkFbTnnndYJMpfCHY89iEM+XVMtQKije7uFicOatd5BjXPs3+dJhwpYd5FfIKW
	Jbys8AXIag9MWM8fqFiB0Y1yPFl31UXLPyk4zg6bErBvJyaQ+GPaBTJXv0sg4YTSJD/OVdSaWYG
	9FOwAYfxI5sUj0UMHj+BJ4/BEGVWkv3rl0=
X-Google-Smtp-Source: AGHT+IFqnCggieYC70G3l4AysmlLY9PDhAFPBx/+0lwHkbnuWCU0qCp4R3nH9HyqPlC8U+RgBeixrw==
X-Received: by 2002:a17:902:e807:b0:290:c639:1897 with SMTP id d9443c01a7336-294cca88caemr184895ad.2.1761585167716;
        Mon, 27 Oct 2025 10:12:47 -0700 (PDT)
Received: from google.com (235.215.125.34.bc.googleusercontent.com. [34.125.215.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34028fc5cc5sm32860a91.0.2025.10.27.10.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 10:12:46 -0700 (PDT)
Date: Mon, 27 Oct 2025 17:12:41 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4 5/8] iomap: simplify direct io validity check
Message-ID: <aP-oCfjViaEIowQe@google.com>
References: <20250827141258.63501-1-kbusch@meta.com>
 <20250827141258.63501-6-kbusch@meta.com>
 <aP-c5gPjrpsn0vJA@google.com>
 <aP-hByAKuQ7ycNwM@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-hByAKuQ7ycNwM@kbusch-mbp>

On Mon, Oct 27, 2025 at 10:42:47AM -0600, Keith Busch wrote:
> On Mon, Oct 27, 2025 at 04:25:10PM +0000, Carlos Llamas wrote:
> > Hey Keith, I'be bisected an LTP issue down to this patch. There is a
> > O_DIRECT read test that expects EINVAL for a bad buffer alignment.
> > However, if I understand the patchset correctly, this is intentional
> > move which makes this LTP test obsolete, correct?
> > 
> > The broken test is "test 5" here:
> > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/read/read02.c
> > 
> > ... and this is what I get now:
> >   read02.c:87: TFAIL: read() failed unexpectedly, expected EINVAL: EIO (5)
> 
> Yes, the changes are intentional. Your test should still see the read
> fail since it looks like its attempting a byte aligned memory offset,
> and most storage controllers don't advertise support for byte aligned
> DMA. So the problem is that you got EIO instead of EINVAL? The block

Yes, that is the problem.

> layer that finds your misaligned address should have still failed with
> EINVAL, but that check is deferred to pretty low in the stack rather
> than preemptively checked as before. The filesystem may return a generic
> EIO in that case, but not sure. What filesystem was this using?

I see, so the check is to be deferred to the block implementation. I
don't really know what fs I was using, I throught it was ext4 but let me
double check.

