Return-Path: <linux-fsdevel+bounces-28756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ED696DE01
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 17:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7723B282D81
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 15:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F174519AD6C;
	Thu,  5 Sep 2024 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bC90hOhN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB67629E4
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549939; cv=none; b=UO2Cl7C/aeOj4rFkokYQIITBXejQ5zmFVwcZTYEeZEdoSbCOTq05oJDt4gbWoSbmKHYk7zsb6XuTNCq/plCIekDbL5UGFWMc3KDeyRnKWEASU1fxbWlTuTX1ce3gi5s9ZEPMN8ctv8DaHFywJ1uUK6e9YbqUFvbjBntRCTHUlnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549939; c=relaxed/simple;
	bh=tRDExfH+y9+CgN5f/5JvA9eKbZD5FR0+/v//qGc1pb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCBeZfK7ep20XOntjuDFX9sJn/rRMFS9L/Fl9VKb6fNz5sUJnNx4R1xUSLNbOL0s7KIdS9bWUSLbOfuVFycoQgHNxOomYVGju87sPt1t/ULiTdiYIVchfypla3Q2/y4H9PeGb0ewMP2uzBrFyh7c6khPUD0yt6ZzHU5hdtWKnQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bC90hOhN; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 485FOuO8022670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 11:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725549900; bh=ZMAwb0TTSWq5wGxMOGxbhqvtzOXca35VpaiLmpGkZyk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=bC90hOhNVtGBzISUHWFA+vIPMEGufqK81VfNH++gBMimSDmzUIT2PO9/60HtmWG/C
	 ay6hQ5QICOiWGGLsW++Qk+XPO3OldLATfDxqLz0EpmlN3ctQ5rw318he2Nk5dSMcKL
	 FXiLh524vPNJlMTH3JGUWLeOG6XGKmsZF9o6WJfzVZb2kWHQJmzyeXRqFcXbHEkW4D
	 twc1UWEWXcapIVFpNUXjqA/vX/Nc2Y50RydPKQW7Wv7RrZKqLJpWw7rsYHyhzfb36n
	 iwTYS4i3eF2n2EQtqjNjZDEltZvduFIX1ojyg2BtOfg8vhq+pVi0sDqjEv6spTD3Sx
	 w51KAAhY8aqrA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 5C30415C02C6; Thu, 05 Sep 2024 11:24:56 -0400 (EDT)
Date: Thu, 5 Sep 2024 11:24:56 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
        jack@suse.cz, Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <dchinner@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-ID: <20240905152456.GW9627@mit.edu>
References: <20240902145252.1d2590dbed417d223b896a00@linux-foundation.org>
 <yewfyeumr2vj3o6dqcrv6b2giuno66ki7vzib3syitrstjkksk@e2k5rx3xbt67>
 <qlkjvxqdm72ijaaiauifgsnyzx3mw4edl2hexfabnsdncvpyhd@dvxliffsmkl6>
 <ZtgI1bKhE3imqE5s@tiehlicka>
 <xjtcom43unuubdtzj7pudew3m5yk34jdrhim5nynvoalk3bgbu@4aohsslg5c5m>
 <ZtiOyJ1vjY3OjAUv@tiehlicka>
 <pmvxqqj5e6a2hdlyscmi36rcuf4kn37ry4ofdsp4aahpw223nk@lskmdcwkjeob>
 <ZtmVej0fbVxrGPVz@tiehlicka>
 <20240905135326.GU9627@mit.edu>
 <4ty2psn26sergqax6yhcs3htt2tsg3wuvrfyvfdvseom22zhqk@yppva6vxpmjz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ty2psn26sergqax6yhcs3htt2tsg3wuvrfyvfdvseom22zhqk@yppva6vxpmjz>

On Thu, Sep 05, 2024 at 10:05:15AM -0400, Kent Overstreet wrote:
> > That may be the currrent state of affiars; but is it
> > ****guaranteed**** forever and ever, amen, that GFP_KERNEL will never
> > fail if the amount of memory allocated was lower than a particular
> > multiple of the page size?  If so, what is that size?  I've checked,
> > and this is not documented in the formal interface.
> 
> Yeah, and I think we really need to make that happen, in order to head
> off a lot more sillyness in the future.

I don't think there's any "sillyness"; I hear that you believe that
it's silly, but I think what we have is totally fine.

I've done a quick check of ext4, and we do check the error returns in
most if not all of the calls where we pass in __GFP_NOFAIL and/or are
small allocations less than the block size.  We won't crash if someone
sends a patch which violates the documented guarantee of __GFP_NOFAIL.

So what's the sillynesss?

In any case, Michal has said ix-nay on making GFP_KERNEL == GFP_NOFAIL
for small allocations as documented guarantee, as opposed to the way
things work today, so as far as I'm concerned, the matter is closed.

	       	    	      	     	- Ted

