Return-Path: <linux-fsdevel+bounces-45844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76CDA7D904
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 11:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A2B18878EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 09:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B45622FE08;
	Mon,  7 Apr 2025 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FimAJhvK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E4F22E41D;
	Mon,  7 Apr 2025 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016935; cv=none; b=B2XxcXxYXixCHobIZiihqHBEwi4t2zDsqlOPFUzxc85F8wzvOj/lyUKGeWnYnhx4V001eAzJgI6QE9QmB0wCGJk+V/wfrdELeNJ48UbxluEPkOjn/ZxWIvX2ZpqY9JiGSbFTX8BbKvuFlqNo+iSi+pltY5hzwjVpbj2Ew0LYySI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016935; c=relaxed/simple;
	bh=NA23vhUttLHVenuptP8n3w38fIMwxrbF/awe8gtEvbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyqfEQbpP8icNp84P80vkZaU/NhDRgw4adr64T/wXC17UpilsS9tudH2jGIchOW31E2dmOJGHkSXSq1JKU9PSLQGF1C6/LmPirP5ZSUFyH3qijFYHbk2CFbeWgAiUlcitxE5+j373QISxKFZz6hHIO4uFiBiXYS4Vo6cErlsX9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FimAJhvK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M61jlF/ve4QmSmhTeUmdNVmwIGJ2BP/aOzBU5BP/5nE=; b=FimAJhvKRx7qL+2muuG5DRbZyl
	izD4CHwBq92yCQeCaqH8U0gIeKnEdzYt7owvrgWPiypVqnBGhpho6CyKqbJbwqcF3fzLkojeW+7Ij
	aa/VYQIFkY0DNRE3XYhituaUpcu3f2cpV+XYp/Xa8NTYTAVjFTdJlCDXwRPDvwah31/b/2CMArhbj
	641Uvb/UkK+sxZFuNAIcOqI3IkTb+qJIDXlaJJF9Cibd69LWVNCaDVaVhIpedG88fqbeZo2zM+Zd1
	+mKnlrZVTDchjTWboKtktw2Fg0q2rSIifkubQYsek2YT/U1q8pfT7bIcSYPXZzhLhR/FcpaQHv3Kj
	+sbwkh3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1iTO-0000000H8D8-1I3x;
	Mon, 07 Apr 2025 09:08:54 +0000
Date: Mon, 7 Apr 2025 02:08:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com,
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org,
	peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	boqun.feng@gmail.com
Subject: Re: [PATCH] fs: allow nesting with FREEZE_EXCL
Message-ID: <Z_OWJqiOyVPWGq1a@infradead.org>
References: <ilwyxf34ixfkhbylev6d76tz5ufzg2sdxxhy6i3tr4ko5dbefr@57yuviqrftzr>
 <20250404-work-freeze-v1-1-31f9a26f7bc9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404-work-freeze-v1-1-31f9a26f7bc9@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 04, 2025 at 12:24:09PM +0200, Christian Brauner wrote:
> If hibernation races with filesystem freezing (e.g. DM reconfiguration),
> then hibernation need not freeze a filesystem because it's already
> frozen but userspace may thaw the filesystem before hibernation actually
> happens.
> 
> If the race happens the other way around, DM reconfiguration may
> unexpectedly fail with EBUSY.
> 
> So allow FREEZE_EXCL to nest with other holders. An exclusive freezer
> cannot be undone by any of the other concurrent freezers.

What is FREEZE_EXCL?  I can't find it anywhere including in linux-next.


