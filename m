Return-Path: <linux-fsdevel+bounces-33470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 633679B9234
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 14:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86AC31C208EE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 13:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE231A08A3;
	Fri,  1 Nov 2024 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YRF1Vn6k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9701D19AD5C
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Nov 2024 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468526; cv=none; b=AoLnFCv77YA0BbDm7mGk2KKqTkNXwf0tRmhm+QLG8Vuy9OIxWDEzdFDBZRJ1Wkil63YC+s+ni2xMLp2LW5eq55JctWsyY8+3V6cosiGBW39evD3zBchesoiUkawojeBrBBM20CLlKmv/3fhymzfFTUurEcnRFSNcQMk3o8WT4u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468526; c=relaxed/simple;
	bh=cJXYvW3abe/MNE3Xc2VsElqZLA7my5VNctTFJ04d030=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GS3pkNbcuIlqUsiPpuWqUnW4h0v36Fqlbdc490le9bBs9JkNJ+P0vhsS0CM8vixu97PLHmKLRtAJNj9E/XZIEZuP21+F3ML5cRjWss3F2W+gGgR7dDHrbZGzzJ8iSP+EuO7oBe2iTi2Yp9MuUthTTRSRVNwNrttywWp16e0+c2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YRF1Vn6k; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbe8119e21so11982716d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Nov 2024 06:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730468523; x=1731073323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cJXYvW3abe/MNE3Xc2VsElqZLA7my5VNctTFJ04d030=;
        b=YRF1Vn6kYj94b6Gof8NYIJIsnUMDd3N604tcBd46qC4CVySJK2JnSZSSPppzI6mYdL
         lCLSxpXkTldibD+PGragg18jFog1Gpd4AcxdZiAHdn+VmUbqQCJZ3x51tk4c5ksekelS
         NJkFHwLGD3E9B3KwqLl/q2TB7twPJ1NJoQu/I3QY/REPNoGWdeoIShPa3bU2f473geCo
         uRD6VIBUozP3rVEfxZIiBAuHygIFpSAMsPT3x8NlN38q/jxB5U0wi9VyEivBaHHiql8J
         tvbOhmF7rvfFaOxz816+sXq6TthHZ8aZV+HTUFjV99zsuhj35Wow637iJ16vpSVok7l1
         JwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730468523; x=1731073323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJXYvW3abe/MNE3Xc2VsElqZLA7my5VNctTFJ04d030=;
        b=gPcOALSBU7G1tbVPOs4TZE/io5rlUSMEmw/Cym+L224xXmlkBWRSU/T0Pl1b+eqiUS
         efQDmVuMdNvYSOZMym1/tJ74FO/2niL4GNY+unuB/PUASNUL77ovhOEc4iIN4JrFG2U7
         Mi5NvZLJTjxOGGeT2l5nDJJSK81yYjFtwUVLt+Z76G6nH92Ad8mN97K+n8Vcp1U1Tudf
         0Fj4CnBSWHwK7OFULeaM8DBQzTgD9Abu3Sf1KnmJR6sfDRzQ6QvFwoR4FBNeXqFNwFu/
         Udrk4N3csOhvfwar0mrFydTek/c2ATbZxMdSj+MdvEEf8QnGWVqNxr1O4NmZ1gFT1J70
         Nwzg==
X-Forwarded-Encrypted: i=1; AJvYcCW0bYJeI8TCEGEUWN0WfakRFIs12hYqaSsnpprcDTxuvLqk5Oe72Qr226E/kIKgS963U26JDilGbeHLADcP@vger.kernel.org
X-Gm-Message-State: AOJu0YzoRxDuxBB3iPT0TadWRwy1e8EWQyFAXuZoRBzKIb5oKq7+WDUt
	TqlFFMxTqMcm2tzYzBEUsp4UecQQstWFIGLkrUDVVFhZG1pud6xlc14SbrZwrPuMWlQLZpsrAGE
	J
X-Google-Smtp-Source: AGHT+IHKsnAIBL5bwiLhih6bmC6tVm4aSQJMldIeDtc2HksBE6g03HuX0ip2Xi6rBdXjkAjc21j7GA==
X-Received: by 2002:a05:6214:4a81:b0:6cb:bfb5:6fc with SMTP id 6a1803df08f44-6d1856fb9dcmr414876706d6.25.1730468523486;
        Fri, 01 Nov 2024 06:42:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d354178d31sm19306126d6.118.2024.11.01.06.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:42:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t6ruc-00000000SZq-12Ar;
	Fri, 01 Nov 2024 10:42:02 -0300
Date: Fri, 1 Nov 2024 10:42:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "quic_eberman@quicinc.com" <quic_eberman@quicinc.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>,
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
Message-ID: <20241101134202.GB35848@ziepe.ca>
References: <20240805093245.889357-1-jgowans@amazon.com>
 <20240805093245.889357-6-jgowans@amazon.com>
 <20241029120232032-0700.eberman@hu-eberman-lv.qualcomm.com>
 <33a2fd519edc917d933517842cc077a19e865e3f.camel@amazon.com>
 <20241031160635.GA35848@ziepe.ca>
 <fe4dd4d2f5eb2209f0190d547fe29370554ceca8.camel@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe4dd4d2f5eb2209f0190d547fe29370554ceca8.camel@amazon.com>

On Fri, Nov 01, 2024 at 01:01:00PM +0000, Gowans, James wrote:

> Thanks Jason, that sounds perfect. I'll work on the next rev which will:
> - expose a filesystem which owns reserved/persistent memory, just like
> this patch.

Is this step needed?

If the guest memfd is already told to get 1G pages in some normal way,
why do we need a dedicated pool just for the KHO filesystem?

Back to my suggestion, can't KHO simply freeze the guest memfd and
then extract the memory layout, and just use the normal allocator?

Or do you have a hard requirement that only KHO allocated memory can
be preserved across kexec?

Jason

