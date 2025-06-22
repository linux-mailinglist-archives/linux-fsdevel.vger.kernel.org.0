Return-Path: <linux-fsdevel+bounces-52427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A11AE32BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 00:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708A918906AA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 22:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6682021CA02;
	Sun, 22 Jun 2025 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UnkMEMVn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF3A28EA;
	Sun, 22 Jun 2025 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750630588; cv=none; b=cW+r/YBNqFlEa4GI52fZOgJIHSs2SJyhTraJzxFw3MxOf+lzXB7ZjcGwHt6TW6kjUJzLix6ZGmAzufUMSlx98g7QD8cY7G86eUArxqfq2LTeAQPOZt5Hpn5ZNvh8n7dKLRHmA6syxUrDPZPT5LZeJZz1x3DX+MvYbskhCOb0Zec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750630588; c=relaxed/simple;
	bh=tLByNlqUAJAlwrRiurqr1Tlca7v3+MRaflGdBfGFrh4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kyRb8nnsfkV6FZuKbU8vwyWuWS/indVAvljQeJhjgMm1PV2j/qWThaFenVgqzVS6U/zocgQ0ZgLwkFLxk2w4az4pvcBjjGgKgAqeGgyM3D9tT7ymjrQ7QfnHu4HRKtABPOKlYzJLls2r9vwaMSMBCXBHMF/PSDgzT9ENdvsykrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UnkMEMVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38383C4CEE3;
	Sun, 22 Jun 2025 22:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1750630588;
	bh=tLByNlqUAJAlwrRiurqr1Tlca7v3+MRaflGdBfGFrh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UnkMEMVnPEVFZ/TxLkdkQxWUL8j100frOJstemv+j6qBeTRD2ky7OBir7vvHPnDxU
	 ymtWmkFNLPhS+5J1oheVqlqb2kITNwDebPJCYbA4HxBEXkTU7RxEQh56IlEPOJv9I4
	 EVWc61+GmVWxZEQpnxD95rkcfhnT2nbXjczFwLXE=
Date: Sun, 22 Jun 2025 15:16:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shivank Garg <shivankg@amd.com>
Cc: Matthew Wilcox <willy@infradead.org>, seanjc@google.com,
 david@redhat.com, vbabka@suse.cz, shuah@kernel.org, pbonzini@redhat.com,
 brauner@kernel.org, viro@zeniv.linux.org.uk, ackerleytng@google.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz,
 bfoster@redhat.com, tabba@google.com, vannapurve@google.com,
 chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com,
 peterx@redhat.com, jack@suse.cz, rppt@kernel.org, hch@infradead.org,
 cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com,
 roypat@amazon.co.uk, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, kent.overstreet@linux.dev, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, chao.p.peng@intel.com, amit@infradead.org,
 ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com,
 gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com,
 papaluri@amd.com, yuzhao@google.com, suzuki.poulose@arm.com,
 quic_eberman@quicinc.com, aneeshkumar.kizhakeveetil@arm.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
Subject: Re: [PATCH 2/2] filemap: Add __filemap_get_folio_mpol()
Message-Id: <20250622151625.fb5d23362c2c3d1af22878d2@linux-foundation.org>
In-Reply-To: <d1d7feed-c450-4b88-ab73-a673f4029433@amd.com>
References: <20250618112935.7629-4-shivankg@amd.com>
	<20250620143502.3055777-2-willy@infradead.org>
	<aFWR-2WAQ283SZvg@casper.infradead.org>
	<20250622114322.c6c35800e01e4cc4007a0f89@linux-foundation.org>
	<d1d7feed-c450-4b88-ab73-a673f4029433@amd.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 23 Jun 2025 00:32:05 +0530 Shivank Garg <shivankg@amd.com> wrote:

> > -EXPORT_SYMBOL(__filemap_get_folio);
> > +EXPORT_SYMBOL(__filemap_get_folio_mpol);
> >  
> >  static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
> >  		xa_mark_t mark)
> > _
> > 
> 
> Hi Andrew,
> 
> Thank you for addressing this.
> 
> If you don’t mind me asking,
> I was curious why we used EXPORT_SYMBOL instead of EXPORT_SYMBOL_GPL here.
> I had previously received feedback recommending the use of EXPORT_SYMBOL_GPL
> to better align with the kernel’s licensing philosophy, which made sense to me.

Making this _GPL would effectively switch __filemap_get_folio() from
non-GPL to GPL.  Leaving it at non-GPL is less disruptive and Matthew's
patch did not have the intention of changing licensing.

Also,

hp2:/usr/src/25> grep "EXPORT_SYMBOL(" mm/filemap.c|wc -l
48
hp2:/usr/src/25> grep "EXPORT_SYMBOL_GPL(" mm/filemap.c|wc -l 
9



