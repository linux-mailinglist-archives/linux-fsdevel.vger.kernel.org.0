Return-Path: <linux-fsdevel+bounces-33362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72EE9B7FA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 17:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838C21F22A4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 16:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A3E1B5338;
	Thu, 31 Oct 2024 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Rp81pflZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB091A38C2
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390801; cv=none; b=CID5MhiOJ4kbNBtEm+4506fT6UIpov5RB5k7BPpoOVrLMNyBtVuENAmU1Mtvc93LeFe+pLeCC1QYnlrbm9W6zZFTBCWf2W0SY7p/AEpuufEvNBAC69R2nrZvWx1KblovN5aIiNRwBeZLRdY+L3lSYn+svKTJ5Esnvb//zmxyhgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390801; c=relaxed/simple;
	bh=3L16LhwJhmR5YVUl5G1cLEUacyJlZ/KxsP8N3vb0Qi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dezBIn/JVT9hA49LwsS+Y0VWDXNZC/XsHyAlCiJyCUKKoKDAVstQwuKQtY2CyFceZv6EjNFTAc6srh1hZ+nFpp0V7nY0bornt3VDgXQV9OkKw3lvekNxVzzgYSrzJo4unDdXy5AvTxlq7Qhe95yzMazy1hWa21n6gUTXe4g7l5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Rp81pflZ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460ad98b031so7273561cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 09:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730390798; x=1730995598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SO7v+RfZoLfypZ4KKZMOHUyo7JMuVsRRPoIxDWu9s38=;
        b=Rp81pflZkiAq1uY40rfspUrHNd3Y5gYKXtqfQuLjJxahBYKUaIAanunovQ2NG0vHYT
         194vXatq99nOfPYCRvLSw7sklpStP8Mt/XVacQlO2VRBJhOgSjghCcjYxO+22yEZdy/n
         8YwVqksefroZdtm9iny3ecDJ2X7AJyQXWemnSsK6/ft8eI1QmsWWPACQP+ZhyLUc7NQb
         jCl1odvbVRVAiamnS4Ef5BK5ZKTbnQV7VxpcN42GlZk5yMAXvm83lNxdQ7akRojO/XIY
         8wozGof9zy3up+/BeZTiypyYybcvdwA/D2F0/oBnaObWam+n3yK+orY9jb1olvV3UgFD
         yGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730390798; x=1730995598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SO7v+RfZoLfypZ4KKZMOHUyo7JMuVsRRPoIxDWu9s38=;
        b=IzEsr2mwVDf0DjofCyD31yuAUSXhA0Co/COuak2EyxSAdSv1jUMUGJJh69JHGir4GL
         5BKsb1GG8UtdlTmo26ElUFZNL/m9QzmlgOGKubvrKe98UiOhtsjo+fxDtBo3Ci/en3Hw
         CYjKi1ymY0NRNYezS2NuaE8dBf+549jgOnb37920bO+HHsPNtUnoxBuV3Yvvpy7YJNrw
         SXpd0Yjtmw3B02Z/TxBHSIB1cC1wcf/nHoKMUW0Vm9lGCD9Gdd2ScU5uHAVRMzcVsnqy
         PU1y4k7yzNLS2rYABmdY81VUdV4oYiSoJ1UYqk18a3oswewqcSxUiGnF6XMiPccZpZ9S
         uleg==
X-Forwarded-Encrypted: i=1; AJvYcCVrkxXMmJivEKQz6lJEPG7jtYO8w4ZVRlM71aq5NI1kYWeDn/gdHSnOBTB0On9GaOYCN1j6HU4kbuyCmVZa@vger.kernel.org
X-Gm-Message-State: AOJu0YzmIZmBrLBiIXeLXCZQpdUXfKNVO4m325CNq+1rQvaPME+yzh4A
	ITA8A7Mfq89vx2X7hAdPNMiJjGeCJparrB3eT13/pBioWhPlRYwH5yl0Ch7E5JA=
X-Google-Smtp-Source: AGHT+IED7ZEPsYL/J2+WAEkVhkkEbmae8OqhC99bUW9D4jOFLXnCuUGOPCgezgCfHDV8eABlx8kETQ==
X-Received: by 2002:a05:622a:144b:b0:461:15fc:7fe7 with SMTP id d75a77b69052e-462b86a6a75mr989681cf.28.1730390796638;
        Thu, 31 Oct 2024 09:06:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d354177d2fsm9043376d6.107.2024.10.31.09.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 09:06:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t6Xgx-00000000Ic7-0kQP;
	Thu, 31 Oct 2024 13:06:35 -0300
Date: Thu, 31 Oct 2024 13:06:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	"Durrant, Paul" <pdurrant@amazon.co.uk>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jack@suse.cz" <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>
Subject: Re: [PATCH 05/10] guestmemfs: add file mmap callback
Message-ID: <20241031160635.GA35848@ziepe.ca>
References: <20240805093245.889357-1-jgowans@amazon.com>
 <20240805093245.889357-6-jgowans@amazon.com>
 <20241029120232032-0700.eberman@hu-eberman-lv.qualcomm.com>
 <33a2fd519edc917d933517842cc077a19e865e3f.camel@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33a2fd519edc917d933517842cc077a19e865e3f.camel@amazon.com>

On Thu, Oct 31, 2024 at 03:30:59PM +0000, Gowans, James wrote:
> On Tue, 2024-10-29 at 16:05 -0700, Elliot Berman wrote:
> > On Mon, Aug 05, 2024 at 11:32:40AM +0200, James Gowans wrote:
> > > Make the file data usable to userspace by adding mmap. That's all that
> > > QEMU needs for guest RAM, so that's all be bother implementing for now.
> > > 
> > > When mmaping the file the VMA is marked as PFNMAP to indicate that there
> > > are no struct pages for the memory in this VMA. Remap_pfn_range() is
> > > used to actually populate the page tables. All PTEs are pre-faulted into
> > > the pgtables at mmap time so that the pgtables are usable when this
> > > virtual address range is given to VFIO's MAP_DMA.
> > 
> > Thanks for sending this out! I'm going through the series with the
> > intention to see how it might fit within the existing guest_memfd work
> > for pKVM/CoCo/Gunyah.
> > 
> > It might've been mentioned in the MM alignment session -- you might be
> > interested to join the guest_memfd bi-weekly call to see how we are
> > overlapping [1].
> > 
> > [1]: https://lore.kernel.org/kvm/ae794891-fe69-411a-b82e-6963b594a62a@redhat.com/T/
> 
> Hi Elliot, yes, I think that there is a lot more overlap with
> guest_memfd necessary here. The idea was to extend guestmemfs at some
> point to have a guest_memfd style interface, but it was pointed out at
> the MM alignment call that doing so would require guestmemfs to
> duplicate the API surface of guest_memfd. This is undesirable. Better
> would be to have persistence implemented as a custom allocator behind a
> normal guest_memfd. I'm not too sure how this would be actually done in
> practice, specifically: 
> - how the persistent pool would be defined
> - how it would be supplied to guest_memfd
> - how the guest_memfds would be re-discovered after kexec
> But assuming we can figure out some way to do this, I think it's a
> better way to go.

I think the filesystem interface seemed reasonable, you just want
open() on the filesystem to return back a normal guest_memfd and
re-use all of that code to implement it.

When opened through the filesystem guest_memfd would get hooked by the
KHO stuff to manage its memory, somehow.

Really KHO just needs to keep track of the addresess in the
guest_memfd when it serializes, right? So maybe all it needs is a way
to freeze the guest_memfd so it's memory map doesn't change anymore,
then a way to extract the addresses from it for serialization?

Jason

