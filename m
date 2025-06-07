Return-Path: <linux-fsdevel+bounces-50909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F730AD0DF5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 16:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D68E7A723D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 14:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120551A841A;
	Sat,  7 Jun 2025 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OWwSzy+G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A9C1B040B;
	Sat,  7 Jun 2025 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749307225; cv=none; b=DMsMAwhlRI3q+CxbrZq3WO/6QsyRKZJH6WJ0m9jeC2rx2f79wp1t7AtJ5ESvibv7G1t/sb9L8+82Kg/AuQPmAFfY7yGos+lkV16xVdYzrno5573xKmycmucep+i2XxQxX9db307nzJkVxb99S0iRS2jHrvWjrC8dcngL6xDsDYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749307225; c=relaxed/simple;
	bh=5VolnRO61Za8S7y0JMKrqdDUEEvmN+IauyhDVM+vW0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTGRSITW1+IABDXazMtSSn+Nfk1h5ddZM/TI+yJVUfmBF8+UwGxbJjn61CgXsY/1DtnuSjBuwYa9mkDoB5TeSMgGS66+BHYvwVyZ08UnwgZzR8WO7SopJSB5iFnP1llD6w6u4qisb+ZQWTpVOtWFz3IwU/lHPlt/Wu1T4szo99s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=OWwSzy+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF05C4CEE4;
	Sat,  7 Jun 2025 14:40:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OWwSzy+G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1749307220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kq41Ond10mXUHWVV/vnahXJAC8HnwJxzy4Wdqc+zAVc=;
	b=OWwSzy+G/TwmeEFLU5ro4fU/JkjaYJImSIS6NF39LxjoYpH8t/GbwTaTCh0m7Dwu6qXHL4
	ETAF0onYqtUwYWf3Jxo/egSURAGAmAeFj37SDswL3aH1vyZyffarqRmHOoVREP0Ea5o7il
	3SPTTyr0oqkqBKvcMrcuyakjOCMdmOU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id eef4a3a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 7 Jun 2025 14:40:20 +0000 (UTC)
Date: Sat, 7 Jun 2025 08:40:14 -0600
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] userfaultfd: correctly prevent registering
 VM_DROPPABLE regions
Message-ID: <aERPTlivjt16jCVH@zx2c4.com>
References: <20250607-uffd-fixes-v2-0-339dafe9a2fe@columbia.edu>
 <20250607-uffd-fixes-v2-1-339dafe9a2fe@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250607-uffd-fixes-v2-1-339dafe9a2fe@columbia.edu>

On Sat, Jun 07, 2025 at 02:40:00AM -0400, Tal Zussman wrote:
> vma_can_userfault() masks off non-userfaultfd VM flags from vm_flags.
> The vm_flags & VM_DROPPABLE test will then always be false, incorrectly
> allowing VM_DROPPABLE regions to be registered with userfaultfd.
> 
> Additionally, vm_flags is not guaranteed to correspond to the actual
> VMA's flags. Fix this test by checking the VMA's flags directly.
> 
> Link: https://lore.kernel.org/linux-mm/5a875a3a-2243-4eab-856f-bc53ccfec3ea@redhat.com/
> Fixes: 9651fcedf7b9 ("mm: add MAP_DROPPABLE for designating always lazily freeable mappings")
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Nice catch and thanks for fixing this.

Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>

