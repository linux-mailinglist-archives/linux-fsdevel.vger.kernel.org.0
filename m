Return-Path: <linux-fsdevel+bounces-48670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8B4AB23B6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 May 2025 14:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95EA74A24CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 May 2025 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DF2257441;
	Sat, 10 May 2025 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TEEsqYdE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0B12A8C1;
	Sat, 10 May 2025 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746878921; cv=none; b=JsRhTKPEq0W4s/8W1oq3Srm8GnChhN1Cz3kRrnRbPIIti1MAeGrqnllSt00t4yiVAThTtpJSPekDoxkiuBT7NMv+EH/LUJiyqRQPartDHILnjUqGFTx88kygaK0gVeFvmGlLjohJzJCOI0KvVtqagVun5kYeMZu8PLHKJxeHMtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746878921; c=relaxed/simple;
	bh=xBd/zAF4i/r6uRGONkKmaoNPYvw4V+FHoBBfCqBFsRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DG2ZD+QqtG2wSMdItPVz6QSA4mxTQY3aOg/9+9KBIFCaK5K2AoMWI0Gdt3YSKgScs53eXppEo8JUyEgpGvK/D2uhvc8HbilOc39XONms/GbjlfTy+dPttBztsDEFqErfJ0RmBj7L5Vg+fNLr3FkjWQzzl754MoCmVG9MRFBT1Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TEEsqYdE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ywqfkOGC0A0JbjqJjDS3iB4Gn4Ol15NSD/PCVlno1xw=; b=TEEsqYdEoKkYP3ELzBcRHxMRSq
	nlVDitUjWGg0OqCo2y+km17mnmsWJyCwZFAdW84/rHI8bj/08ZyeULecT+b/XASHnhpXd5OnuHEXg
	G+1T/D6hw7Skws9fg6nSZZG2I8+5wrh5Br52c9Mg0t+F5aby0sKbBPMN80NgRX9NHMWfGyd9aiyIw
	7CG0IpA8CL9QzDoImOoplxph6zgnAUFKrX1pO0+4pDmIUlAJNoOqqWA3f+vj6EKQYZqCR4caxDW3K
	E3obznWMSsMeB0muknsDMykvesXRBoNi4kFU0TTFMMb9bgsA+T4RApGI9ANh1H4CFEZMP7mE7mza/
	UoeWKl7g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDj0N-00000000sLp-3xC4;
	Sat, 10 May 2025 12:08:36 +0000
Date: Sat, 10 May 2025 13:08:35 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] fs: Fix typo in comment of link_path_walk()
Message-ID: <20250510120835.GY2023217@ZenIV>
References: <20250510104632.480749-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510104632.480749-1-richard120310@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, May 10, 2025 at 06:46:32PM +0800, I Hsin Cheng wrote:
> Fix "NUL" to "NULL".
> 
> Fixes: 200e9ef7ab51 ("vfs: split up name hashing in link_path_walk() into helper function")

Not a typo.  And think for a second about the meaning of
so "fixed" sentence - NUL and '/' are mutually exclusive
alternatives; both are characters.  NULL is a pointer and
makes no sense whatsoever in that context.

