Return-Path: <linux-fsdevel+bounces-33598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A3D9BB352
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 12:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11EDEB23A01
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 11:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833FF1D63CC;
	Mon,  4 Nov 2024 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGl1cZd3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D894C1B21BC;
	Mon,  4 Nov 2024 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718868; cv=none; b=UqmogAaRHlx6Xg1TzTArDXV9i+Utigzd3RRsR+AgAXfzLEL5C0FBk21KLzR+gN9KhpOMGEofNA2L+BrybM8I8vgcno86c3Tm+w5n8LqAz3L+pbOBhtwT/BFEJwXilDS99AajLxfHCT5z+K9A5nYUAmmkeRVrOkfySevtRtd6lHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718868; c=relaxed/simple;
	bh=xSEGve5ZFz4au7Yl8PLV8lKxWgq5DKLCVU2jOAHKCKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPrSMDB9/WJBaWHH6T9YbqM0C0NTirOqeONAfj6Wdkz1z3NQe+7Br85FqSBMyiTi4WdYvyMAnN0HNw+E7PY5gdNB/Lx7dNn9Cho1eaLU53REDCH6qNwGuQpdwPufd6ZMvzsI1rJdCzC4BrKMrGLMXgeK2eOxsZJqcmuySMQMgP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGl1cZd3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F61C4CED1;
	Mon,  4 Nov 2024 11:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730718868;
	bh=xSEGve5ZFz4au7Yl8PLV8lKxWgq5DKLCVU2jOAHKCKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hGl1cZd3iaMgJCJ0/0ArZbRgNthLliN4uJws/RHWqxjaCbGmnZHTSYDHo7gbxqSec
	 P5gsX6qE03b7FGK3UcTSKRenBiyiNGZIW0NPOZAVtGE1yrLl2LnGGzG6ovwMjB7yGP
	 i5SWiyRa2np2MXGbDSQ7u2V2LsICbC+4j18IypOmPucU9lUYEvtzdS+o6aLxSN+KYe
	 Irgw3CLemG2S4CDLZUvsp//4DiP2NaFIJ35xdX3LfocpeBNp+3rNohxRlCRU2eZyFM
	 8knwCRsXM6HS9jEcTe25E6EXRdlZNeNIpnFwB4nTxex3/NkYtC0BEFI3It8PeGvmeh
	 NRvWGAhgwbgaQ==
Date: Mon, 4 Nov 2024 13:11:48 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"quic_eberman@quicinc.com" <quic_eberman@quicinc.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Durrant, Paul" <pdurrant@amazon.co.uk>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jack@suse.cz" <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 05/10] guestmemfs: add file mmap callback
Message-ID: <Zyir9FOnMJoSJreD@kernel.org>
References: <20240805093245.889357-1-jgowans@amazon.com>
 <20240805093245.889357-6-jgowans@amazon.com>
 <20241029120232032-0700.eberman@hu-eberman-lv.qualcomm.com>
 <33a2fd519edc917d933517842cc077a19e865e3f.camel@amazon.com>
 <20241031160635.GA35848@ziepe.ca>
 <fe4dd4d2f5eb2209f0190d547fe29370554ceca8.camel@amazon.com>
 <20241101134202.GB35848@ziepe.ca>
 <9df04c57f9d5f351bb1b4eeef764bf9ccc6711b1.camel@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9df04c57f9d5f351bb1b4eeef764bf9ccc6711b1.camel@amazon.com>

On Sat, Nov 02, 2024 at 08:24:15AM +0000, Gowans, James wrote:
> On Fri, 2024-11-01 at 10:42 -0300, Jason Gunthorpe wrote:
> > 
> > On Fri, Nov 01, 2024 at 01:01:00PM +0000, Gowans, James wrote:
> > 
> > > Thanks Jason, that sounds perfect. I'll work on the next rev which will:
> > > - expose a filesystem which owns reserved/persistent memory, just like
> > > this patch.
> > 
> > Is this step needed?
> > 
> > If the guest memfd is already told to get 1G pages in some normal way,
> > why do we need a dedicated pool just for the KHO filesystem?
> > 
> > Back to my suggestion, can't KHO simply freeze the guest memfd and
> > then extract the memory layout, and just use the normal allocator?
> > 
> > Or do you have a hard requirement that only KHO allocated memory can
> > be preserved across kexec?
> 
> KHO can persist any memory ranges which are not MOVABLE. Provided that
> guest_memfd does non-movable allocations then serialising and persisting
> should be possible.
> 
> There are other requirements here, specifically the ability to be
> *guaranteed* GiB-level allocations, have the guest memory out of the
> direct map for secret hiding, and remove the struct page overhead.
> Struct page overhead could be handled via HVO. But considering that the
> memory must be out of the direct map it seems unnecessary to have struct
> pages, and unnecessary to have it managed by an existing allocator.

Having memory out of direct map does not preclude manipulations of struct
page unless that memory is completely out of the kernel control (e.g.
excluded by mem=X) and this is not necessarily the case even for VM hosts.

It's not not necessary to manage the memory using an existing allocator,
but I think a specialized allocator should not be a part of guestmemfs.`
 
> JG

-- 
Sincerely yours,
Mike.

