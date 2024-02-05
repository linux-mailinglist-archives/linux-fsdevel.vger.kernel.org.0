Return-Path: <linux-fsdevel+bounces-10339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F5384A037
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 18:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B70D281235
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 17:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BA140BEB;
	Mon,  5 Feb 2024 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pThueR9t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFAB2C699
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 17:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152923; cv=none; b=vFBR77Be6nfxKDHbq8h2Z9i0rXKhAk0ywMduwOIcYUK4YRfEsVV1zSCxF18Vk0bLblePX7t6rrJvSfdBoicFEVJiwskClH4BLZhSOJHmALDMj4s4etkCy3K3U5up0syNm0wVpdTJ3QVMNI6XGiIktKpKRZ/paWubhrWyJ+4CqOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152923; c=relaxed/simple;
	bh=8gBlKfQm3vRprhFc0/QpnWE8p96XYPuWr7rTbz4Ejy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTlbY43S+ZveNo8AaIU3M53GP0pWrt8gmg7oUkkyp3qQl624LqX93DkRLF5/RtFbyFa9RqQ+mb9vwHWFloENDsXgjR0BSo8jj6oA6FiPprKKwdIWZhQc0/1O4h3nhYBoCBbU/UopWzk9yKeI5rxeMUZqrXUibW5KEzqVZ+oNV7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pThueR9t; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42a9c21f9ecso27677381cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 09:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707152920; x=1707757720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gBlKfQm3vRprhFc0/QpnWE8p96XYPuWr7rTbz4Ejy4=;
        b=pThueR9tS4++4Ak+63QKJD5ztu0stiKwKjMYm8GGi9NWP+lqt1uz0Qk1hMqaGZ0sTr
         fPWtCd+6Er9idhCPt1WvCPSvXTC9fC9GPLMkj6ZNKYLoknf0CPuLke9GltXcdBZOvuxr
         QMbWzMqbX4BQAQm2Z4Fyl/Qm2YXQ+PH33fP3J0bLXIXGackyhFW0peHrgVFTIWQu+rab
         SfQohNzSaxb3Gg7BUYxxs5LK+Hrs4oWJbn7fVhubCyLl3Iw3uTx17WKAQxtiqxVPH4pm
         Ie1MIxErmkxewE9orbvfB1z2fHDsEB4SYyMoVokL/kYAP+1AsEFk4YK+1kNm7OOB2JzR
         oKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707152920; x=1707757720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gBlKfQm3vRprhFc0/QpnWE8p96XYPuWr7rTbz4Ejy4=;
        b=jhK1J0+je6HQG5qMPBCHcjnbWHGqWTYf07lQ3oLEAPHjKFxLlKHGj3HRE7dwF8EL4R
         gPSI7fYyOihz7kfzMzVNySeqg2Srp1NBx6q9WqF1/sb41GZcOYqR77EHkJsho+Par9Rt
         V+Vzl2lQSsdBpWmXf3Wmhyif/AX8aHYxRKFSwAIzGRpazRyJCExa1Emxyb1BOGirsoyh
         y5b9lFe5RP+MZfS3oi43yvKhBU5xFHVkfYZshypuoSVvzP3Yw7mEDjSlxYN4mi3hZ5X7
         pmzoIS2f+NtxmvJi9KYDO8OfE1UJgIsQmQdB21ehOB5E2Q8wWijL2MRFgTohbg52/gX9
         kEDQ==
X-Gm-Message-State: AOJu0Yx1TsI2JNxVUNdU+1X6siWs/KgtST+7yKD6KiT0BVqvHoa9K3Jz
	4zroMJiDeS96zGxDogmJidOS6yQT5S0D+U+VfZMLM9wRZheOTKB224xcNYIq78M=
X-Google-Smtp-Source: AGHT+IFRr68RJWhr55aAuCOmm/7ig7Z946GhQZxCWJnXpgTkXxQZq9u9NN3DdLuHLeVoxwlh1gajUQ==
X-Received: by 2002:ac8:6bcb:0:b0:42a:48bc:f69 with SMTP id b11-20020ac86bcb000000b0042a48bc0f69mr7977973qtt.35.1707152920631;
        Mon, 05 Feb 2024 09:08:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWFnZsn/+oaH85mYCSnpv4YgXZiAdaRH0+Rq60h3VhSx80V/GhIDkgZR10vmkuwF1N3jhhz9aRo8LLD4ff5OgXLimlfMXcSIPuyfjqJcxPxDRiouB5DndZ1kQz5dDjvpSVf2qZnwpdmYLKdUUiGGPxIlHQiPas89V0qswdC6497cElumvLrngGqTJkZscqv6ouG2f0OrpG6Ei2Zn4TY19Lk9NbJPoaaQZIBZSq0XCtZUA7d3PA2XkCWjmZueMp2A4tCAorCWj6i6E3kIrdi2y7VdUXMK5IQwL1ODMaERiIbTXBJbVrhlVGqhDyHvDIuotZrahRKcH/dGKlHT6GOh0AiVMK8Tzohvd/1DqWSOsUrv6/uL6cpoulHtaNasUn2g1+as+1/aN3+PukRM38uB/fouGVfLgmdpOE3dunZMoCAT8ZvWsyLQq5HJzPKp8dnEjpdvCDijtK2oY+4Fte+c9yCkKSI9o3pZZZEGbyVB7g/qoYjmnzB6UvMvTFVVXtvqMnEmcwOaYKyi0HF6aat2Ve6C6mKE8L/YuQwof83w3Z5XmIHwIZ2oGMal/R+I06RZSVRWXaOUkQuB8sHRlexzojF3AdtuOI7nq6sqs2lcG4+ML2g+c2ZAxM9tnpLd69JMkvGu7iMwJ1692U5EjqV1QDP6l+mc+OUUzf8X6XSuc3UdFj+vXovcLlbwYzYR22mSvd+Sld4DusAh+aVZhGTkOMpJe7mDCGP0YbiYqikir3ZKx0d
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id f22-20020ac84996000000b0042c22902ca2sm112941qtq.81.2024.02.05.09.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:08:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rX2SV-000d2w-7N;
	Mon, 05 Feb 2024 13:08:39 -0400
Date: Mon, 5 Feb 2024 13:08:39 -0400
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
Subject: Re: [RFC 13/18] vfio: add ioctl to define persistent pgtables on
 container
Message-ID: <20240205170839.GA31743@ziepe.ca>
References: <20240205120203.60312-1-jgowans@amazon.com>
 <20240205120203.60312-14-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205120203.60312-14-jgowans@amazon.com>

On Mon, Feb 05, 2024 at 12:01:58PM +0000, James Gowans wrote:
> The previous commits added a file type in pkernfs for IOMMU persistent
> page tables. Now support actually setting persistent page tables on an
> IOMMU domain. This is done via a VFIO ioctl on a VFIO container.

Please no changes to VFIO in the iommu area, new features need to be
implemented on top of iommufd instead.

We already have the infrastructure there to customize iommu_domain
allocations that this can be implemented on top of.

Jason

