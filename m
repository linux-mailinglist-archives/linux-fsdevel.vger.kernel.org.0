Return-Path: <linux-fsdevel+bounces-64068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07167BD72DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 05:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DD81897C89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 03:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BC4269CE8;
	Tue, 14 Oct 2025 03:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="NP42bns8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F9A2AD2C
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 03:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760412077; cv=none; b=pPUvJ8wqoi4GDSdWMpzvLbhYy0biJTSUIAF0QU1f+Ro8nKtnbQFwV4cMHHzBvxXomkljn1BsUmQehgDTn5GHvBV8nOq70zGDZ+YIG6042bC+m52Pv9MJCqG7Y840D2pJ1lLuFxvEcBdyUJKDd2GmMxuONy03pAa0393BDLdti1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760412077; c=relaxed/simple;
	bh=nar2PWi0AZr5nNb6qn1v8+eAngFzZpHCB1uMRhBtrIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfsmvjLy5hriYLb3/zvLfsYeQGYievfeu7yZC9yndZBfFkGW0SP9i1CFEaXPGjEHZXJjKGYZ1Ltlob6NrCShlo+XQxsFLTa8OKrZox4BLs4vx/byZg2n5nKJsQ1ZN5hV92tzSDS5nf44QYzKD0VwkhNyYOhq3K54Vs9SNw05sB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=NP42bns8; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-170.bstnma.fios.verizon.net [173.48.82.170])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 59E3KsU7014549
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1760412057; bh=41OSkq8dhVlpXFlmK5VxSYY/DHIKRiJto96FUVix4L0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=NP42bns88QjT/FW6rfonREwhQSPUJN/eEvD0QNw7h90hB0l6EU3SqotxLxWIh39gx
	 4WN08/IPuTGAdNzZ8lW/YtHoMKHfCjyhBp2uRqu1RzFJ3JtWbBak1IFjHfn9KsY3jT
	 UUGKFJAHfY/uffvWEBHySfOF+iZxkpLDZu+VpHlYVP6onFReFKJ9rat2CYVTAezQvl
	 IBrJaTZZQh3ytQqP7FHxUa69mh9lDXdrxhYKgG2GpMugZa7jBPfcQcG7yvFYT2EbxZ
	 XLFK2BT6XotlVagaec9EKrn7Ty8eTdPwO+tjezP4hRBf3rwtqTTRAHge8BUCVPh9Ly
	 ndpVqQup1Ahgg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id BE7E32E00D9; Mon, 13 Oct 2025 23:20:54 -0400 (EDT)
Date: Mon, 13 Oct 2025 23:20:54 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Optimizing small reads
Message-ID: <20251014032054.GP354523@mit.edu>
References: <CAHk-=wgbQ-aS3U7gCg=qc9mzoZXaS_o+pKVOLs75_aEn9H_scw@mail.gmail.com>
 <ik7rut5k6vqpaxatj5q2kowmwd6gchl3iik6xjdokkj5ppy2em@ymsji226hrwp>
 <CAHk-=wghPWAJkt+4ZfDzGB03hT1DNz5_oHnGL3K1D-KaAC3gpw@mail.gmail.com>
 <CAHk-=wi42ad9s1fUg7cC3XkVwjWFakPp53z9P0_xj87pr+AbqA@mail.gmail.com>
 <nhrb37zzltn5hi3h5phwprtmkj2z2wb4gchvp725bwcnsgvjyf@eohezc2gouwr>
 <CAHk-=wi1rrcijcD0i7V7JD6bLL-yKHUX-hcxtLx=BUd34phdug@mail.gmail.com>
 <qasdw5uxymstppbxvqrfs5nquf2rqczmzu5yhbvn6brqm5w6sw@ax6o4q2xkh3t>
 <CAHk-=wg0r_xsB0RQ+35WPHwPb9b9drJEfGL-hByBZRmPbSy0rQ@mail.gmail.com>
 <jzpbwmoygmjsltnqfdgnq4p75tg74bdamq3hne7t32mof4m5xo@lcw3afbr4daf>
 <20251013172654.GI354523@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013172654.GI354523@mit.edu>

On Mon, Oct 13, 2025 at 01:26:54PM -0400, Theodore Ts'o wrote:
> On Mon, Oct 13, 2025 at 04:35:17PM +0100, Kiryl Shutsemau wrote:
> > I also need to run xfstests. Unless someone can help me with this?
> > I don't have ready-to-go setup.
> 
> Sure, I've kicked off xfstests with your patch for ext4 and xfs.
> Results should be available in 2-3 hours.

No xfstests regressions were noted for ext4; the xfs test run didn't
get started due to hiccup.  I've restarted it, and can let you know
tomorrow morning.

						- Ted

