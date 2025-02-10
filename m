Return-Path: <linux-fsdevel+bounces-41441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BF1A2F814
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 20:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922D7168C0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 19:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF19E1A5B97;
	Mon, 10 Feb 2025 19:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZy0IsbL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4897325E446;
	Mon, 10 Feb 2025 19:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739214090; cv=none; b=a2PhrqlmcNFMYx93CFCN9u1P+ajieFRFG1OqBf0Z4sfLS+byP6XqyHGfBwzq4wA6tBO9qXSisuZCx75n70HEeSu241GrxORt0d8Ee6CmbaABlDHzM5ZE7dkV/Lmd492NFWL1xPbpVjlcLEyx0SiF2wl6j91KQg/cDKNhUqVFxyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739214090; c=relaxed/simple;
	bh=23KDcD/j65oGW6866Bcw3xXNXwhUPxAoV5GMn7mD+Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoctxOEg26LvgzMx9R/WcLluX2RJF/+sA1gR77W8aEtLvZ/OvWLZ/rmqSBzeN4I0LNklJ+gciSMp3Gl5EynH/9h3DsJqEuP2G1kWkf5Xc5UgYcKWpt7aNFy5mhsQAXxoZerFtGybHpIDLvUE8CwDp39xWoPyaqbQddH70wfs54A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZy0IsbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D728C4CED1;
	Mon, 10 Feb 2025 19:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739214089;
	bh=23KDcD/j65oGW6866Bcw3xXNXwhUPxAoV5GMn7mD+Lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mZy0IsbLOkV6NzapTbhUN5/hH4zrpbKZKs9GHER1Rnl03HauXaru5+sCjkghd0wMJ
	 nisdNuznkuonBfuOF1kGrMXWXOVf3B2h408VTpwbFS67u8A/Sy4rbFUkTAEqTUIAj5
	 3kiRYEdG0xTLFRdJutjzMU2uxJiea7jxXaMwLSydaFwEC23dmdhgwHvQYrgV7Xhbjt
	 fbSQhW08E7QnQKPKzhhvZqYCjgw9t/7Za1T1rej3ZNOcRrKZPJEyI8LhJAsMB0RsVK
	 326tWbIwSqPX1jfWWMKLZYMSk5hWLaLI6iWFMkSw2tx/34YQqZJZDBAs/yVfTeUj2q
	 DcBo625c+YT2Q==
Date: Mon, 10 Feb 2025 19:01:27 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2 v6] add ioctl/sysfs to donate file-backed pages
Message-ID: <Z6pNBxgMKHTiHAnv@google.com>
References: <20250117164350.2419840-1-jaegeuk@kernel.org>
 <Z4qb9Pv-mEQZrrXc@casper.infradead.org>
 <Z4qmF2n2pzuHqad_@google.com>
 <Z4qpurL9YeCHk5v2@casper.infradead.org>
 <Z4q_cd5qNRjqSG8i@google.com>
 <Z6JAcsAOCCWp-y66@google.com>
 <Z6owv7koMsTWH1uM@google.com>
 <Z6o1TcS7mQ2POrc9@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6o1TcS7mQ2POrc9@casper.infradead.org>

On 02/10, Matthew Wilcox wrote:
> On Mon, Feb 10, 2025 at 05:00:47PM +0000, Jaegeuk Kim wrote:
> > On 02/04, Jaegeuk Kim wrote:
> > > On 01/17, Jaegeuk Kim wrote:
> > > > On 01/17, Matthew Wilcox wrote:
> > > > > On Fri, Jan 17, 2025 at 06:48:55PM +0000, Jaegeuk Kim wrote:
> > > > > > > I don't understand how this is different from MADV_COLD.  Please
> > > > > > > explain.
> > > > > > 
> > > > > > MADV_COLD is a vma range, while this is a file range. So, it's more close to
> > > > > > fadvise(POSIX_FADV_DONTNEED) which tries to reclaim the file-backed pages
> > > > > > at the time when it's called. The idea is to keep the hints only, and try to
> > > > > > reclaim all later when admin expects system memory pressure soon.
> > > > > 
> > > > > So you're saying you want POSIX_FADV_COLD?
> > > > 
> > > > Yeah, the intention looks similar like marking it cold and paging out later.
> > > 
> > > Kindly ping, for the feedback on the direction. If there's demand for something
> > > generalized api, I'm happy to explore.
> > 
> > If there's no objection, let me push the change in f2fs and keep an eye on
> > who more will need this in general.
> 
> I don't know why you're asking for direction.  I gave my direction: use
> fadvise().

Funny, that single question didn't mean like this at all. Will take a look
how the patch looks like.

> 
> Putting this directly in f2fs is a horrible idea.  NAK.

