Return-Path: <linux-fsdevel+bounces-36650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 264AC9E750C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 17:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAAB2289288
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 16:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28E920CCFC;
	Fri,  6 Dec 2024 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVkqq+Cz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1895D1C3C1F
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500987; cv=none; b=ex8J0JI8s4NhOhWbMcKKc4ns9V5KlsdVYrJi2GQ9/v4zuA23mdFUPFtrUpiDQ6KsKFYMo7ElGc2xR4K7bDYnZGQunTqk5/paG0M9KSYFOPmOV0ESzmV+cV2tbSzIzw75XvnfCOjSBTPbd8XWRnmc9/zITkvqtiMoiBcrVl+NQeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500987; c=relaxed/simple;
	bh=u2nGuXTvAiNDxiqm2vlbf6FhIsJf9h+jEXPykc1IOjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckgslKvCt3P8xj18MNBrl+8x1vKlxzIYne4vhntfKLbQjQqBkewTWBZC54Hul8lDXvwwN+RDcxhI4sVSZJj9Aoo9dqUoGl56zPkLx+S9gDtLJ00FZ85BwGw8omCOxD7hHVZPhNhOOUk92JDZxKw4jeUXQruoF0rxX3MarVF/tFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVkqq+Cz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CC6C4CEDE;
	Fri,  6 Dec 2024 16:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733500986;
	bh=u2nGuXTvAiNDxiqm2vlbf6FhIsJf9h+jEXPykc1IOjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bVkqq+CztMMaEgq2jtQLeZywHkeDiueJO36jXEwuAcw6PxdPnbFgs3sfUALCuLYG7
	 jc7Oyn9Y5u9qBl/csWFcknKezJ7k0hWbUCw1V9NcgZEJFJRUfqDkIY1uZqskg/ndHS
	 0X7Op5QaDDR57KiVQ/usObaVl12cfuLEcj4PYNW97yeK5fBlhtY6G70nfyTwjexcoP
	 usyEXZjOONcy1+inO6E7SpI5bIMCy6LwlJwzgOXFwBEAmoAErVYOGrJzU6xN3zYIkZ
	 czi7goKmA96WJrzj1dnxDIEF9Ee/ZqEtUAiwWZBL+/Zr4FWvCx1JVoPUwxHTENFFBV
	 HASIaL8nCcsOw==
Date: Fri, 6 Dec 2024 17:03:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH RFC] pidfs: use maple tree
Message-ID: <20241206-experiment-ablegen-c88218942355@brauner>
References: <20241206-work-pidfs-maple_tree-v1-1-1cca6731b67f@kernel.org>
 <Z1McXVVPJf4HztHU@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1McXVVPJf4HztHU@casper.infradead.org>

On Fri, Dec 06, 2024 at 03:46:37PM +0000, Matthew Wilcox wrote:
> On Fri, Dec 06, 2024 at 04:25:13PM +0100, Christian Brauner wrote:
> > For the pidfs inode maple tree we use an external lock for add and
> 
> Please don't.  We want to get rid of it.  That's a hack that only exists
> for the VMA tree.

Hm, ok. Then I'll stick with idr for now because we can simply use
pidmap_lock. Otherwise we'd have to introduce more locking.

