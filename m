Return-Path: <linux-fsdevel+bounces-23277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F5A92A146
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 13:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C97A1F21FBF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 11:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6197F7D3;
	Mon,  8 Jul 2024 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsDoAPbD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E2A101E2;
	Mon,  8 Jul 2024 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720438534; cv=none; b=rMtvLvHfDZuy2QKdzSjWgf3x4wsSLdifFPctKND5vRswnjbDScJN+2iWXv8Mf+e3/49HDM09N1RdB6QGJ/zIGeo75wYYAzmR4rW2Vf3NoDYQH9HMuAFTHx7D+CWILNeZYWZwjgaaBs9d2ThcHqAbsExYpjCgpqb7S3Gim3W4Wq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720438534; c=relaxed/simple;
	bh=0q5Ds8WIeOv5Y3nTVZNg0tKqv7bBejypl3Rg0QFJqmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9WPUCZY0oh592sGKdXVmYB6fysso1qerFhGIAPUJh4200o+E8PqYUocBDGYAYM6hCDUuEZ8HBowjmDAE7wMy55GCmRT8/lB0SaQHuBfaPv5GGtjdzfexNiVY9UH50adyBn8yjEMZJASz8MnInqoHhL6xqYE32nYXBs0Rf1rZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsDoAPbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDD9C116B1;
	Mon,  8 Jul 2024 11:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720438534;
	bh=0q5Ds8WIeOv5Y3nTVZNg0tKqv7bBejypl3Rg0QFJqmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XsDoAPbDuJawip0mO7VPHOcAtC8umkEX+3mruYsdiHMQTMSnCjk6khCQQhBFOVU2q
	 szsII3oJXeXPXn/TD1fBgYjrRriwN7ffC0ijh8PvFS/JWshQeFdlZKBesvFDDo5JNp
	 ebFxkePURnK0zM1B3jsYHT4MNNEkTpuSUbDOJ0wqE7eJfaQfSWxRo0vWoC5QTabCIW
	 I9ZALOcwRGl2VBpOZP15lKg6qpE8NWgViVA291vGz6q0ajZOlvg0o3swDvw0f3PyCc
	 eOMz086l52tHH0De4Ngoa9ZI+DYKXoJrjaUifAz9HtEFirAu5kGY4AnRE4k3HNrj2S
	 wF50L1Ci27E9g==
Date: Mon, 8 Jul 2024 12:35:25 +0100
From: Will Deacon <will@kernel.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
	jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com,
	ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org,
	tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com,
	peterx@redhat.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
	david@fromorbit.com
Subject: Re: [PATCH 13/13] mm: Remove devmap related functions and page table
 bits
Message-ID: <20240708113524.GD11567@willie-the-truck>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com>
 <47c26640cd85f3db2e0a2796047199bb984d1b3f.1719386613.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47c26640cd85f3db2e0a2796047199bb984d1b3f.1719386613.git-series.apopple@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jun 27, 2024 at 10:54:28AM +1000, Alistair Popple wrote:
> Now that DAX and all other reference counts to ZONE_DEVICE pages are
> managed normally there is no need for the special devmap PTE/PMD/PUD
> page table bits. So drop all references to these, freeing up a
> software defined page table bit on architectures supporting it.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  Documentation/mm/arch_pgtable_helpers.rst     |  6 +--
>  arch/arm64/Kconfig                            |  1 +-
>  arch/arm64/include/asm/pgtable-prot.h         |  1 +-
>  arch/arm64/include/asm/pgtable.h              | 24 +--------

Not only do you exclusively remove code, but you also give us back a
pte bit! What's not to like?

Acked-by: Will Deacon <will@kernel.org> # arm64

Will

