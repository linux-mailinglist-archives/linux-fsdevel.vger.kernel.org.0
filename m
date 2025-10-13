Return-Path: <linux-fsdevel+bounces-64002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A68DBD582B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 19:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83D33E4E74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 17:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFC925392A;
	Mon, 13 Oct 2025 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dDgi/2UT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19222367CE
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760376438; cv=none; b=BWhp6nWL98mxXhrWR7OFS2jbDXQmfyB5x4XpjM2LCHtj+JKyW4RaO4H7IlymllYdKEeHEnv3kfS6AwQr7bkfEM24XHWHRsJ7jjWcaIooqUEJHJSAYfJR9nQOA4Ct+pu4favn2XTRzEx6zFPaWPyJhoEmmXWL+h+QE331hldXD4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760376438; c=relaxed/simple;
	bh=R4rtz+Or3FDZVFsYJ013PHqojgOyuL+2qYxexVtk3vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSleozd8CjFFL3YJ7/4uRPdMK9lt9FBhTPkaya8+rd/c9C+E2Dv153ejVKLPRu+6hKAS2CnFz+yLx9g0fmo9f1YLUA2a+rSCIBGCsf5j7ny34o9QB9NAsGS4qCVp346i4wZcMG/HchoxkNMAZ5P6rQ4nPMWgGS6JoqYkSQOCyaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dDgi/2UT; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-170.bstnma.fios.verizon.net [173.48.82.170])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 59DHQsoi022727
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 13:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1760376416; bh=mlBh04JlAEJRK1BdDBgwaOiFlx027z2aLnENKnusXLc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=dDgi/2UTmAMlprvgiN153Sh0qSgcuiuaYPj/HPuP5f0AS3kQwDJRfXiRYRP5sB/zq
	 1zLGDoUuH+FJW+weAaM0BYBuDA5PCcZo4iZO1UNSayJgdDVJ0fFZnMXICI93gie8KR
	 jjlut8MV0bh6sCyz3mznhuHeuTiz/KdIIGoLob6oUCmd18hvNohiELQbXILh5AwXVV
	 f7zSliNE/AdkPnIM+INwzgFo2AVjCooskKxPpDmdDlkNTD1hw17NHt5dDZUw6mxqoF
	 kuhrdDXTFo7rc62FSCnlGZSwXZ3yT3OFVV/hJnt5Iu1SnPgoFCnoF/cj+tpwH+oSDG
	 n6t6UlrQJ6QtA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 4332E2E00D9; Mon, 13 Oct 2025 13:26:54 -0400 (EDT)
Date: Mon, 13 Oct 2025 13:26:54 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Optimizing small reads
Message-ID: <20251013172654.GI354523@mit.edu>
References: <CAHk-=wgzXWxG=PCmi_NQ6Z50_EXAL9vGHQSGMNAVkK4ooqOLiA@mail.gmail.com>
 <CAHk-=wgbQ-aS3U7gCg=qc9mzoZXaS_o+pKVOLs75_aEn9H_scw@mail.gmail.com>
 <ik7rut5k6vqpaxatj5q2kowmwd6gchl3iik6xjdokkj5ppy2em@ymsji226hrwp>
 <CAHk-=wghPWAJkt+4ZfDzGB03hT1DNz5_oHnGL3K1D-KaAC3gpw@mail.gmail.com>
 <CAHk-=wi42ad9s1fUg7cC3XkVwjWFakPp53z9P0_xj87pr+AbqA@mail.gmail.com>
 <nhrb37zzltn5hi3h5phwprtmkj2z2wb4gchvp725bwcnsgvjyf@eohezc2gouwr>
 <CAHk-=wi1rrcijcD0i7V7JD6bLL-yKHUX-hcxtLx=BUd34phdug@mail.gmail.com>
 <qasdw5uxymstppbxvqrfs5nquf2rqczmzu5yhbvn6brqm5w6sw@ax6o4q2xkh3t>
 <CAHk-=wg0r_xsB0RQ+35WPHwPb9b9drJEfGL-hByBZRmPbSy0rQ@mail.gmail.com>
 <jzpbwmoygmjsltnqfdgnq4p75tg74bdamq3hne7t32mof4m5xo@lcw3afbr4daf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jzpbwmoygmjsltnqfdgnq4p75tg74bdamq3hne7t32mof4m5xo@lcw3afbr4daf>

On Mon, Oct 13, 2025 at 04:35:17PM +0100, Kiryl Shutsemau wrote:
> I also need to run xfstests. Unless someone can help me with this?
> I don't have ready-to-go setup.

Sure, I've kicked off xfstests with your patch for ext4 and xfs.
Results should be available in 2-3 hours.

	       	  	       	   - Ted

