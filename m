Return-Path: <linux-fsdevel+bounces-46263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E93A85FF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AEC3B4A7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615301F3D50;
	Fri, 11 Apr 2025 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pilFz60U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C791F0E32;
	Fri, 11 Apr 2025 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380221; cv=none; b=K5PkueYYtcxCUlz8sgCUADpS9ZQxrkNi7Vc3trVL7fRxeDMpbyvo6IFXZhtgDOIC2jEiQQOpAFqVhJDHEojD9/eg+pXt3sD3ItXAc0ARaomXdXek5YoC6R1t8sCmqMn5jL8IVnDrumdcEGURQYLi76Vc952pU5tx5GV0BuUqMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380221; c=relaxed/simple;
	bh=A9uWHZeLASAeqV3pcSaRLVnFs8sczJhLPZO/60JuIrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFUufGyu2I4nz+3QXzorYg5QvSviI4UIjSSq68DE/UPXq2ClKwlx+IbchCQjdMiTtbTuFtB/sr5s8+UEB5qRjSFCn6VErdOhIj0KhmmGk5epxc5SABA9IIym7kqdVpCatKtZY5hd6sTlEic4lTezNd0sSl7FZZ8QW9qs8/2PFhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pilFz60U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD64C4CEE2;
	Fri, 11 Apr 2025 14:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744380221;
	bh=A9uWHZeLASAeqV3pcSaRLVnFs8sczJhLPZO/60JuIrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pilFz60UlyKzY1WZZ9dfMwWMkW+uicFjF2tMAeTdYrC0y/DBhCyS12drndRX8Ypnt
	 htzM95GA7M+5XIXlyee3xXx/e43qK82np0I/bWLssRM0IORmnMZ0rwKb93jMcJWZmM
	 /yxKYIe2JuARQCYCosK2zVhZajBH0K+VQM+w3lxIUz4djrkPyzUqOM3fXDMMm6RfDE
	 8H1KKJH5Hhxk8DQWy1vGjI30yYSWPYdQui4eFwdnUjuDDBfVjc5nUoCwuPZEl+acdB
	 M6QVof35nhfs3XgBbkwfvsvHb7mOgbe+OKdeEOznQ8er0iTQtvCDOMyVT5JcQQ2OYv
	 HGhE+xMz/deZg==
Date: Fri, 11 Apr 2025 16:03:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Alistair Popple <apopple@nvidia.com>, 
	kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Dan Williams <dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Asahi Lina <lina@asahilina.net>, 
	Balbir Singh <balbirs@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Christoph Hellwig <hch@lst.de>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	David Hildenbrand <david@redhat.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, linmiaohe <linmiaohe@huawei.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Matthew Wilcow <willy@infradead.org>, 
	Michael Camp Drill Sergeant Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Peter Xu <peterx@redhat.com>, Sven Schnelle <svens@linux.ibm.com>, Ted Ts'o <tytso@mit.edu>, 
	Vasily Gorbik <gor@linux.ibm.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Vivek Goyal <vgoyal@redhat.com>, WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>, 
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [linus:master] [fs/dax]  bde708f1a6:
 WARNING:at_mm/truncate.c:#truncate_folio_batch_exceptionals
Message-ID: <20250411-sehgewohnheiten-blicken-7830519934ab@brauner>
References: <202504101036.390f29a5-lkp@intel.com>
 <v66t3szdfsfwyl4lw6ns2ykmxrfqecba2nb5wa64l5qqq2kfpb@x7zxzuijty7d>
 <uiu7rcmtooxgbscaiiim7czqsca52bgrt6aiszsafq7jj4n3e7@ge6mfzcmnorl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <uiu7rcmtooxgbscaiiim7czqsca52bgrt6aiszsafq7jj4n3e7@ge6mfzcmnorl>

> didn't lift off and DAX ended up being kind of niche, I think the effort
> to maintain DAX in ext2 is not justified and we should just drop it (and
> direct existing users to use ext4 driver instead for the cases where they
> need it). I'll have a look into it.

+1

