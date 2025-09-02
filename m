Return-Path: <linux-fsdevel+bounces-59965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A378B3FBB5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 12:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9505C7A4CDA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 10:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71AB2EF641;
	Tue,  2 Sep 2025 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpTNeKRR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAC81A288;
	Tue,  2 Sep 2025 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807379; cv=none; b=H5CzJm2sBqV7I0xxafsDwIliAx2jKwU3I/kJwxZkPF54IuP8SRcEvcmIfXQKhAyinB14ABLlQQmxJHr1fninyJ1QnkcisalUcOeebsHF1P8+b5lYmaL8cF01JqmIcwddkJtgRh/eImc/C4Ukawrdz6qGp5m6Sw/eMaQ1lhY7G30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807379; c=relaxed/simple;
	bh=//nqL4lLAfIxW165Zpqicim1COFnjYI7FmXj/nwXVQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZClzRzy6ruqB2OS6QSicUz0UPboqp8YLHJyHcbvK2E5MC+nMpx71p/rJV8ti+JGW2HMqms4v6tHOimc4pVKOn2v4+QiWC3zKzN1DzTAkoL+tLYgRwk6Sam8Qq2wF99wYkU6ivdNKglr4xKgtw2AlvCIEfHx1wdc5eZukp3Erqnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpTNeKRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC650C4CEED;
	Tue,  2 Sep 2025 10:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756807378;
	bh=//nqL4lLAfIxW165Zpqicim1COFnjYI7FmXj/nwXVQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bpTNeKRRpbEq4VuZA9LmqaueKiOGvizEA67DPfZXhNaue0n/VbK9mwN3yewtEUkhj
	 dwTHEzsYV8K0ilq+2qseVmZk2UnB64cBZkyS1Iadme1heTJtZAlzOCNkgOKbkF9ZvQ
	 CA43Jp0zfvu4rCxXoCKnZY5uNz80FEF5O1VO6f/iCq1h31bqeuvoEWrq+KwgCAY+Sw
	 TpBmawNe922+sDtauzRHPr4bqBQ8W00Q0ISUYAJkJXhdDAZwhB/x+V1+KssIBTIniF
	 0cOlfXlkNDfqZTneuG/Qkoh0h3IvtkKaFNSGcP4sPWy72/mfvsnGFSHWV4F8Jzz/Ss
	 nG5OfZbpoatPA==
Date: Tue, 2 Sep 2025 13:02:38 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
	yuanchu@google.com, willy@infradead.org, hughd@google.com,
	mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	surenb@google.com, vishal.moola@gmail.com, linux@armlinux.org.uk,
	James.Bottomley@hansenpartnership.com, deller@gmx.de,
	agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	weixugc@google.com, baolin.wang@linux.alibaba.com,
	rientjes@google.com, shakeel.butt@linux.dev, thuth@redhat.com,
	broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com,
	mpe@ellerman.id.au, nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 00/12] mm: establish const-correctness for pointer
 parameters
Message-ID: <aLbAvirCgCfpXaVK@kernel.org>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901205021.3573313-1-max.kellermann@ionos.com>

On Mon, Sep 01, 2025 at 10:50:09PM +0200, Max Kellermann wrote:
> For improved const-correctness in the low-level memory-management
> subsystem, which provides a basis for further const-ification further
> up the call stack (e.g. filesystems).
> 
> This patch series splitted into smaller patches was initially posted
> as a single large patch:
> 
>  https://lore.kernel.org/lkml/20250827192233.447920-1-max.kellermann@ionos.com/
> 
> I started this work when I tried to constify the Ceph filesystem code,
> but found that to be impossible because many "mm" functions accept
> non-const pointer, even though they modify nothing.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

