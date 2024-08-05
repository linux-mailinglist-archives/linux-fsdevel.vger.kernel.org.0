Return-Path: <linux-fsdevel+bounces-25022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E08947CEE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 16:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB571F236A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 14:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C96155398;
	Mon,  5 Aug 2024 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="RNpaM8+L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFDA13C80A
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868527; cv=none; b=GpJKn2/rRfmD5WZrBzAa26fFD/pwGrnHfuelyeQNIvcTqyXmci2loHQMYkPmhQgQtmz41ZHTS4dsjZek67rGs055rOWAZLMzxRjcEiT6aIA2xASp3dkq68b3ITyeRaz1n0lTORepKKaoFblV2xzDmCbcxvqk7LWXFFpF/+tqhVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868527; c=relaxed/simple;
	bh=vXe8Xkug6TZxY5RcgrU7GWSnbNradf9MTr3q34K6reY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otslyJKtV+sKTsPPvL2TlOxthtmCB1YanBgPBuQXlafIeS76nAWchHS/N1NjnMUur6073HQ99hCmB6hCPdTpYZeYDyUB0eTirUntR7eJvEawKm8+Ymh+lUCTU2mOdcrLX0+/kngqVWpbk1ZzLt0VxJ1tmilJ7RaO1FojpsIDqF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=RNpaM8+L; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-165.bstnma.fios.verizon.net [173.48.111.165])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 475EWNxu014397
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 10:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1722868348; bh=HNqj/+/nTZPBR7gnswUv8CXGIulX1uayMeFA8elCAro=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=RNpaM8+LReWAzjQ9Dm7QmvAErWmf25f4v7g1cHyC0ximCdwvaie3O1uw/L0UC/Ha3
	 3EZixtlAk0i0FkX0gO9E/fOy59kc9S4xYIc5B7lHIylAPZnpWkqQ7UhF/EvXW6t0Nd
	 d0oHLXMqgdZ1lVjI03Xzyow23CxcE4PhM6u6KAQBoRpZNMM+r7NMUxf0zwW8gk17sP
	 mW9/fhfVMNlsO7Oih2lhCFVWvG6KNwLUPEwHF+TqIQDppb2sRw9QoHVhyL8cRdpltH
	 ob2SPahJ+IQEGaJk/zIphkoekpCPZ1qtf+VDFjPYNGveodbl4IEW2Gi2rsQyALqmPw
	 Aha9MK/CoTiiQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id AA0F515C0330; Mon, 05 Aug 2024 10:32:23 -0400 (EDT)
Date: Mon, 5 Aug 2024 10:32:23 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: James Gowans <jgowans@amazon.com>
Cc: linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steve Sistare <steven.sistare@oracle.com>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-fsdevel@vger.kernel.org,
        Usama Arif <usama.arif@bytedance.com>, kvm@vger.kernel.org,
        Alexander Graf <graf@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>,
        Paul Durrant <pdurrant@amazon.co.uk>,
        Nicolas Saenz Julienne <nsaenz@amazon.es>
Subject: Re: [PATCH 00/10] Introduce guestmemfs: persistent in-memory
 filesystem
Message-ID: <20240805143223.GA1110778@mit.edu>
References: <20240805093245.889357-1-jgowans@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805093245.889357-1-jgowans@amazon.com>

On Mon, Aug 05, 2024 at 11:32:35AM +0200, James Gowans wrote:
> Guestmemfs implements preservation acrosss kexec by carving out a
> large contiguous block of host system RAM early in boot which is
> then used as the data for the guestmemfs files.

Why does the memory have to be (a) contiguous, and (b) carved out of
*host* system memory early in boot?  This seems to be very inflexible;
it means that you have to know how much memory will be needed for
guestmemfs in early boot.

Also, the VMM update process is not a common case thing, so we don't
need to optimize for performance.  If we need to temporarily use
swap/zswap to allocate memory at VMM update time, and if the pages
aren't contiguous when they are copied out before doing the VMM
update, that might be very well worth the vast of of memory needed to
pay for reserving memory on the host for the VMM update that only
might happen once every few days/weeks/months (depending on whether
you are doing update just for high severity security fixes, or for
random VMM updates).

Even if you are updating the VMM every few days, it still doesn't seem
that permanently reserving contiguous memory on the host can be
justified from a TCO perspective.

Cheers,

						- Ted

