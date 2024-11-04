Return-Path: <linux-fsdevel+bounces-33596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AE59BB1DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 11:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260BA1C22221
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 10:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734741CBE8B;
	Mon,  4 Nov 2024 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOrLiBsz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA26A1CB53A;
	Mon,  4 Nov 2024 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717524; cv=none; b=n3aRtM6b3D9ULQoN4XKRG21m3KrVmsi2Hbf8pvjalaPojWspXP8Xgc5PIZpLcGy0n++85xa0e2qWEC+YAoj95gHe/jKnv3rOZuKhHnHXWw1QLg4UsjAy+ue3kwXNDQzbpM5ZhcD+dhy/2QENgbbY3mbLZlZEOAd2KQcjD979tn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717524; c=relaxed/simple;
	bh=gVFvhx02Zz3L6ndxfFvbk0IQyrrritUS0mptzTG0vsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oa3Grq7IUIVmmvz2DCZjxTTBwx8m6zfz6epDNdx6aiv+zp0QaPhcwTFKa3Qj8dKidvPIf8nc5T2caRE7b76j9LF9H8+ah+BqLEA6A0KhvBKrrtqfcQFXewfMSZ2cWdwg9ySzqm3Jq95AleGyHcm1llGqwdeAHWaGv0Cu3O8fmQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOrLiBsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9149C4AF15;
	Mon,  4 Nov 2024 10:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717524;
	bh=gVFvhx02Zz3L6ndxfFvbk0IQyrrritUS0mptzTG0vsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qOrLiBszEKx/23biOQZk87zRhMJbA40mNWdnFLnvO+6ASmNShr9lvrPB+EI3DS62T
	 kSZVlihQi0B68GKMKPm4eItVYiIhxR0DqlCmT2g3IYfQVBqd/rtv+tqpP5+t+jPE8M
	 yZYA4wdBbqmg2Qdlt5h+t2T+Qq+zy/Olf7wXwxtq1sIktHqX3a8nkb5sPcz86WnYrr
	 BF9v34oINbsMKvRkxwf7EPwtkvT9CHBNz3Fjuqv0FmTXyTDprtgrUyhhAr1U0Vx6gJ
	 33c2QO8hhrYsdMupxmk47+Kx1dS8UI5koZTpjb/6I5veUv/KKsdonu4flrgeluQDa5
	 uolC1xPwyoy7w==
Date: Mon, 4 Nov 2024 12:49:24 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Gowans, James" <jgowans@amazon.com>,
	"quic_eberman@quicinc.com" <quic_eberman@quicinc.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"Durrant, Paul" <pdurrant@amazon.co.uk>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"jack@suse.cz" <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 05/10] guestmemfs: add file mmap callback
Message-ID: <ZyimtM-sQSmRblpm@kernel.org>
References: <20240805093245.889357-1-jgowans@amazon.com>
 <20240805093245.889357-6-jgowans@amazon.com>
 <20241029120232032-0700.eberman@hu-eberman-lv.qualcomm.com>
 <33a2fd519edc917d933517842cc077a19e865e3f.camel@amazon.com>
 <20241031160635.GA35848@ziepe.ca>
 <fe4dd4d2f5eb2209f0190d547fe29370554ceca8.camel@amazon.com>
 <20241101134202.GB35848@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101134202.GB35848@ziepe.ca>

On Fri, Nov 01, 2024 at 10:42:02AM -0300, Jason Gunthorpe wrote:
> On Fri, Nov 01, 2024 at 01:01:00PM +0000, Gowans, James wrote:
> 
> > Thanks Jason, that sounds perfect. I'll work on the next rev which will:
> > - expose a filesystem which owns reserved/persistent memory, just like
> > this patch.
> 
> Is this step needed?
> 
> If the guest memfd is already told to get 1G pages in some normal way,
> why do we need a dedicated pool just for the KHO filesystem?
> 
> Back to my suggestion, can't KHO simply freeze the guest memfd and
> then extract the memory layout, and just use the normal allocator?
> 
> Or do you have a hard requirement that only KHO allocated memory can
> be preserved across kexec?

KHO does not allocate memory, it gets the ranges to preserve, makes sure
they are not overwritten during kexec and can be retrieved by the second
kernel.
For KHO it does not matter if the memory comes from a normal or a special
allocator.
 
> Jason

-- 
Sincerely yours,
Mike.

