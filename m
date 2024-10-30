Return-Path: <linux-fsdevel+bounces-33216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D67F9B5990
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 02:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040F81F241DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 01:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030EABE46;
	Wed, 30 Oct 2024 01:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SN7vNQiQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C3A5028C;
	Wed, 30 Oct 2024 01:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252905; cv=none; b=fXLiNErDlopzd52l0p5NmrTs7KQPX/XeOqvUXapSUzHijncD8g92JS4iWAQjL+Eul9F/nQaewNGuEOTzOnfPLxiczQD5wplrYbrTruRS/jRerFiWjtNKR1YQcPr5bfLnPEQVNWZt0xydcPpI0He3aZoEQ5FXOqpDmZRr4Gbe9hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252905; c=relaxed/simple;
	bh=TZPH/zNqFtR4xXRIshHvWGqYHhD8L1r1/j0m4unen38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnhoyAvDeoW9beWuF223ODzcsfEXTHApOkgV3BTbP6/h50fY2etTOC/ZFjozfBVIwth/nOWXwcpO/RgRtujgzCJZehkzrHjkMJGQe+glqM91Mfonn/2kkhEtiLRuchxouV6dN3XEYCfL0SG08e8rg+lOq4EXFQY4hRnfX9fuJCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SN7vNQiQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o4nR9AN/uRb+rAFJHdVHs06gtrg0kMkPiQgM1up+0jg=; b=SN7vNQiQ1RpepN8Ls9r/trUPuH
	N2A4WonkT5YCwHdDdgzYis2aql1AHMRLMc3srQoN+OY3cqYyZytIT1f/nj/NfSbcP6kiw1+NCyWQi
	io44XRcFYv2SZL6Shl9bT6R9K1htj0MJIljjU+ufqnUnu9BzBqwXno5QUHqWiMjbEd0c0Kp/bnNX8
	Via8SB35fbz2oWfPIplGTb03cTSTmmPHhvmhUsxNGXJflybpbGBk22B+60FECYqafsdREw4XlLSd5
	/POUxj8X4DBLpFnd7iKBu/9FF0nQT06VRPZYSIs3/qjMILBTPhjWUr4q4G8c0cYQb2JThJcoWk/x9
	3xXsa4cA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t5xoo-00000009Jfb-3aW8;
	Wed, 30 Oct 2024 01:48:18 +0000
Date: Wed, 30 Oct 2024 01:48:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org,
	jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com,
	amir73il@gmail.com, repnop@google.com, jlayton@kernel.org,
	josef@toxicpanda.com
Subject: Re: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample
 fanotify fastpath handler
Message-ID: <20241030014818.GG1350452@ZenIV>
References: <20241029231244.2834368-1-song@kernel.org>
 <20241029231244.2834368-3-song@kernel.org>
 <20241030001155.GF1350452@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030001155.GF1350452@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Oct 30, 2024 at 12:11:55AM +0000, Al Viro wrote:
> On Tue, Oct 29, 2024 at 04:12:41PM -0700, Song Liu wrote:
> > +		if (strstr(file_name->name, item->prefix) == (char *)file_name->name)
> 
> 	Huh?  "Find the first substring (if any) equal to item->prefix and
> then check if that happens to be in the very beginning"???
> 
> 	And you are placing that into the place where it's most likely to cause
> the maximal braindamage and spread all over the tree.  Wonderful ;-/
> 
> 	Where does that "idiom" come from, anyway?  Java?  Not the first time
> I see that kind of garbage; typecast is an unusual twist, though...

	After some coproarchaeology: it's probably even worse than java - in
javashit indexOf() predates startsWith() by quite a few years; java itself
had both methods from the very beginning.  So that's probably where it had
been cargo-culted from...

	The thing is, performance requirements of some garbage script from
a javascript-infested webshite are somewhat different from what you want
to see anywhere near the kernel-side filesystem event handling...

