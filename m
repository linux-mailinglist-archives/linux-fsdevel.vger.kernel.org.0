Return-Path: <linux-fsdevel+bounces-57975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 586FBB2749F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 03:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F765A1039
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 01:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC56E186284;
	Fri, 15 Aug 2025 01:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fL2nFq9/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F238C2629C;
	Fri, 15 Aug 2025 01:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220263; cv=none; b=UtFw+zht/y+sA+hBPstlzKY7PEdZWtfqgoHPRPLTNxTNxcNol0MKvHLA+mXXgbsWyz+Y0ulP6lvbARHfIEuZkXYvJ2OXH0eS9dsEtKpCG6pWEBOBT5RzbzwjuUxSU3X6biN0ae2gBhl4rIDjVtwCP3/uOMkLPj0HC5pWbDlV8jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220263; c=relaxed/simple;
	bh=z73WFDouE2luwIWEwjVYjCE/sTdxrrTGRHZK09LdMMs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FfQQCV9SRPlf+78Vn9TjjlHu/6lC/HrzGH279vsC6y/tMF9TgPtdUbVpO1QpTwobp9AY30YE+eyyFyar24YPIR8hBP8VRzbfxWKrDWzdyd4CIK6MX2wMQL7mcaQ6ze7i6YJtCyodqSZb4hKAL1m7ymrIy39bhgf3jdlKewCCAWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fL2nFq9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968F4C4CEED;
	Fri, 15 Aug 2025 01:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755220262;
	bh=z73WFDouE2luwIWEwjVYjCE/sTdxrrTGRHZK09LdMMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fL2nFq9/PNhIEwgZ2UQpPTz8+BNrFJncGrTSd+kKDGTwjmqVBezRlwLIoECD1R/qm
	 1h4wRYhhdy1BwSgucdu6Ws+cimUwZTmWXpbFwq5qVrcqwEYk3R2BirDLs6bknNQNUN
	 DOfp5foSBJH7D2JMfVko+PD2qPbVc++rqmCmIe4c=
Date: Thu, 14 Aug 2025 18:11:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, david@redhat.com,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
 baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com,
 ziy@nvidia.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com, Arnd Bergmann
 <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 2/7] mm/huge_memory: convert "tva_flags" to
 "enum tva_type"
Message-Id: <20250814181101.9e15c8c0202face2230ad1fb@linux-foundation.org>
In-Reply-To: <c8a47a7d-3810-426f-a2cf-7c020ce25c7d@gmail.com>
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
	<20250813135642.1986480-3-usamaarif642@gmail.com>
	<CALOAHbAe9Rbb2iC3Vnw29jxHEQiWA83jw72fb_CQKGDFHv6+FQ@mail.gmail.com>
	<c8a47a7d-3810-426f-a2cf-7c020ce25c7d@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 11:43:16 +0100 Usama Arif <usamaarif642@gmail.com> wrote:

> 
> 
> > Hello Usama,
> > 
> > This change is also required by my BPF-based THP order selection
> > series [0]. Since this patch appears to be independent of the series,
> > could we merge it first into mm-new or mm-everything if the series
> > itself won't be merged shortly?
> > 
> > Link: https://lwn.net/Articles/1031829/ [0]
> > 
> 
> Thanks for reviewing!
> 
> All of the patches in the series have several acks/reviews. Only a small change
> might be required in selftest, so hopefully the next revision is the last one.
> 
> Andrew - would it be ok to start including this entire series in the mm-new now?
> 

https://lkml.kernel.org/r/0879b2c9-3088-4f92-8d73-666493ec783a@gmail.com
led me to expect a v5 series?

