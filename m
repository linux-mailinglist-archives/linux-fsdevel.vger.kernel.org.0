Return-Path: <linux-fsdevel+bounces-22951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA30924145
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 16:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D15287ADF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 14:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DD51BA865;
	Tue,  2 Jul 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZnYdfBq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB40D1E48A;
	Tue,  2 Jul 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931817; cv=none; b=R4TFzthgbbZlxpKWd1v9lcUHjaxuv1lsp8+gOX1FPjYL50Uf8XDdtNwmJntHFQNX1IKENBgYjrnTp7jw5JWGK6WbpjD3FjDaGm4HyE6cGZj7N/53Zu8G+ArA2pHpSrenxPgHOov9q6mWlsSpzNWoi1Prpt3Jocb7aMXxp1o5VsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931817; c=relaxed/simple;
	bh=HqJSSoNKjIMDM+CJGgP+I5L5NB+rRz1kCBLAO8WJm7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5xKJdZ9Ad+TiSiHciSW2+xaWF02U5LGs3NqLpniOX1w12ZHGqw615nYigidC0h3IdAlT8RMRJAAGW1In4pTesMRjjL2DOUi0Yf9AXTWFX4WN+95Extv2N7v5YCuPj8SwqILesmhx1sdgz07pMEZS6yrk/LSY9k70JWjnxzrp5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZnYdfBq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719931815; x=1751467815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HqJSSoNKjIMDM+CJGgP+I5L5NB+rRz1kCBLAO8WJm7A=;
  b=ZZnYdfBqjnATfzG3CLFd1+0D861dlCKvpp1joaakoI42itan5bZ2WI/y
   OUYw1zr+sSHtDnXhPGsla/XroPG68GmiT57tXCHFxNt8PHDHNLO77ufxn
   yDdHly0Z21YnbGhN0YpilkzB7RBeC/IqW9ZOJO4wPZivWqSdqMQiAUyKE
   p7OeuMUeEPQy+J6OXvw58jvCrtutgSU9GXYx8Z58TIpVLKT2nlVEJzsAo
   /Si+DshtcExVY47HObhtsGvXDO9q0EEqaFdnBV8bxblEqyV2QPdh1elWB
   7uao7CIFTDULG60Lk1Osv70te2INKVI0/QfpDkla08YPnXXcJSQG48yRv
   Q==;
X-CSE-ConnectionGUID: V/UneS+cRamYEXHzI021bA==
X-CSE-MsgGUID: lAwSoQeMQx6akjydSKFlXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="34558299"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="34558299"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 07:50:00 -0700
X-CSE-ConnectionGUID: 6Vw0grZvTcSZ8AqT595Amg==
X-CSE-MsgGUID: JIBGLbcKT1SxXJQ4cNjqIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="51117023"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 07:49:59 -0700
Date: Tue, 2 Jul 2024 07:49:57 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org,
	liam.howlett@oracle.com, surenb@google.com, rppt@kernel.org,
	adobriyan@gmail.com
Subject: Re: [PATCH v6 3/6] fs/procfs: add build ID fetching to PROCMAP_QUERY
 API
Message-ID: <ZoQTlSLDwaX3u37r@tassilo>
References: <20240627170900.1672542-1-andrii@kernel.org>
 <20240627170900.1672542-4-andrii@kernel.org>
 <878qyqyorq.fsf@linux.intel.com>
 <CAEf4BzZHOhruFGinsRoPLtOsCzbEJyf2hSW=-F67hEHhvAsNZQ@mail.gmail.com>
 <Zn86IUVaFh7rqS2I@tassilo>
 <CAEf4Bzb3CnCKZi-kZ21F=qM0BHvJnexgajP0mHanRfEOzzES6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb3CnCKZi-kZ21F=qM0BHvJnexgajP0mHanRfEOzzES6A@mail.gmail.com>

> 1) non-executable file-backed VMA still has build ID associated with
> it. Note, build ID is extracted from the backing file's content, not
> from VMA itself. The part of ELF file that contains build ID isn't
> necessarily mmap()'ed at all

That's true, but there should be at least one executable mapping
for any useful ELF file.

Basically such a check guarantee that you cannot tell anything
about a non x mapping not related to ELF.

> 
> 2) What sort of exploitation are we talking about here? it's not
> enough for backing file to have correct 4 starting bytes (0x7f"ELF"),
> we still have to find correct PT_NOTE segment, and .note.gnu.build-id
> section within it, that has correct type (3) and key name "GNU".

There's a timing side channel, you can tell where the checks
stop. I don't think it's a big problem, but it's still better to avoid
such leaks in the first place as much as possible.

> 
> I'm trying to understand what we are protecting against here.
> Especially that opening /proc/<pid>/maps already requires
> PTRACE_MODE_READ permissions anyways (or pid should be self).

While that's true for the standard security permission model there might
be non standard ones where the relationship is more complicated.

-Andi

