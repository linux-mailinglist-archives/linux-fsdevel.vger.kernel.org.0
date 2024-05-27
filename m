Return-Path: <linux-fsdevel+bounces-20281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316648D0F65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 23:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7CB1F21B7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 21:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33FE16133E;
	Mon, 27 May 2024 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iF5zjpvs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE2717E8F6;
	Mon, 27 May 2024 21:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716845130; cv=none; b=lsBCuPWl0uw4zu3GUlL5sLJtXDgxPqrXxf99vRN8DFQUrNM7iG68QzZFceqxlzTjIwtFXyKHOPs5Y/sjBXa11VaTFbH6M3NlXzPKRw6NndLSW+h2cBIllYUiw7JmWNHS/2alzHgtf7ePQrRPUKP4fvAPT5nemtZQOmUg29RILzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716845130; c=relaxed/simple;
	bh=rDZtXIXfIn/Exbr6rLpyBskD9yCUPaTIM6abcjPD+ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHLwM/oCo7zfIrBSRGGfpvxrHkCe3bwTj8s9SRZWtA8N3f5PFN2tw28a8gsrBsq4pcmg4enhydsHW1lbZ+v8V8kna17IsA818x6zydt6Wk8LRhVo3IqK9gEaErupNME0OgnQnX4OKUacCGjXK2V7o9nbiRD23oR8C+SlGb2JyeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iF5zjpvs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hkVCQJNkG3ChzFHH99253cfyT0+lG6xEy2Ix/WO+1eg=; b=iF5zjpvsa/xU821Dnp4Ts3R6qD
	zZSuBCwkUSBxgD98n93TWi/geoE/5iMbEnky0i728ExFBxhuyWjySFI61zTRsPSzduljORpqI4VRt
	bwg+Ls2pgQTbYxO2elqQWdzBlMj+cS3u6TSZl/PLfBgNNMbnoRigBm7A2z+txcPMpLW3cZm4JiFvi
	fPvbnW3HuZKlHiBM0MRE+fLYPZ27fSvteYz5LCw5KXlZnkMHNaVIkibAfheNMRK7zJUlYkRpcBO0F
	hAXyZNZimgrWIphUV6+lbl1nWrT76bhDdQOB7auo7B7gM9hK0SyjjqVnD42/FkQ5fPBGWg+pwGu2x
	KMzrGrNw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sBhqP-00EaXM-1x;
	Mon, 27 May 2024 21:25:25 +0000
Date: Mon, 27 May 2024 22:25:25 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][CFT][experimental] net/socket.c: use straight
 fdget/fdput (resend)
Message-ID: <20240527212525.GF2118490@ZenIV>
References: <20240526034506.GZ2118490@ZenIV>
 <CAHk-=wjWFM9iPa8a+0apgvBoLv5PsYeQPViuf-zmkLiCGVQEww@mail.gmail.com>
 <20240526192721.GA2118490@ZenIV>
 <CAHk-=wixYUyQcS9tDNVvnCvEi37puqqpQ=CN+zP=a9Q9Fp5e-Q@mail.gmail.com>
 <20240526231641.GB2118490@ZenIV>
 <20240527163116.GD2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527163116.GD2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, May 27, 2024 at 05:31:16PM +0100, Al Viro wrote:

> Hell knows; let me play with that a bit and let's see what falls out...

gcc optimizer is... interesting:

if (v & 1)
        if (!(v & 3))
                foo();

is *NOT* collapsed into a no-op.  Not even

if (v & 1)
        if (!(v & 1) && !(v & 2))
                foo();

is good enough for it.

if (v & 1)
        if (!(v & 1))
                if (!(v & 2))
                        foo();

is recognized, thankfully, but... WTF?  As far as I can tell,
        if (!(v & 1) && !(v & 2))
gets turned into if (!(v & 3)), and then gcc gets stuck on that.
        if (!(v & 1)) if (!(v & 2))
is turned into the same, but apparently only after it actually
looks at both parts in context of what it knows about the earlier
checks.

clang handles all forms just fine, but gcc does not ;-/

