Return-Path: <linux-fsdevel+bounces-45593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B99B5A79A9F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 05:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12586188B604
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 03:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A722519007F;
	Thu,  3 Apr 2025 03:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="0HBoscdF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3C55103F;
	Thu,  3 Apr 2025 03:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743652007; cv=none; b=kVWH4wdaGOz7ZTqC8KkIq7IT/BiRX85bzaIdXU1B4cJdr1BEkb0eV0mRBm/fY1BO85bMDOmlykFdvSP4RH88/RJ/AL5GFv1dfIqVHTrZ+bGa9YdXBBdltf+OjBjmKRASIUu24s/Wb9nA3VBGp5qINrg2BIEdoYL5vgf1cGZm6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743652007; c=relaxed/simple;
	bh=qst9VgxRGd0q8EAb17usxcFzrBpJMSqzamr6wE60npA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6PSsNdH/0EKJIjwZ9OaQ8R+233y99NpSboKpsWXw3Ifw++RI5MxLRzDPzG1pDbvznrlfNLQkdYGRjE0npbVHyKMROLrG3OR+RaERnbPdNJS1lHs83m+k3LsSFcpQFMSKcK3KuzYJvGQLB5ti9OHvrz68j3AMjk3VPodbZjoPzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=0HBoscdF; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 67B0E14C2DB;
	Thu,  3 Apr 2025 05:46:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1743651996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ITcMLIFP5tKAjz41ehoKWCF5eQQiDYMOb1fN5yVdzj8=;
	b=0HBoscdFpgxuQgZl92opSENbMA9Pk+zXKbOYbpRJnb2fOIuhEQ1bwZ5rGPvmlYb+8wVHw8
	wHc2273ChihnbkPMTZ1/DAooFHD2hJ+0yffsGhHC9Cy9veCKiE8j7cW1KdfmCPrBKGxCoy
	Qn3m8QJ0MYx70hWGhV57dz2ZTADFzPnA6CZqQO0W6iJCwIBiDSjDSOwrvW/d4+WTVhVAcH
	g6HcnkJSY+HEZzS8B0uR8bH0QBVA+A0ZU2VyhxlEvsqXe3FXAMaHh6g4yHfkceyrco8IVL
	7ipXZTHnksTxDqR7U3ceJDpBoPzzk84gVw3dN7X3aD3CMOZtc1b/HQqenuVM/Q==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 72519fa4;
	Thu, 3 Apr 2025 03:46:32 +0000 (UTC)
Date: Thu, 3 Apr 2025 12:46:17 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
	v9fs@lists.linux.dev
Subject: Re: [PATCH v2 1/9] 9p: Add a migrate_folio method
Message-ID: <Z-4EiVQ6klHkkMoy@codewreck.org>
References: <20250402150005.2309458-1-willy@infradead.org>
 <20250402150005.2309458-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250402150005.2309458-2-willy@infradead.org>

Matthew Wilcox (Oracle) wrote on Wed, Apr 02, 2025 at 03:59:55PM +0100:
> The migration code used to be able to migrate dirty 9p folios by writing
> them back using writepage.  When the writepage method was removed,
> we neglected to add a migrate_folio method, which means that dirty 9p
> folios have been unmovable ever since.  This reduced our success at
> defragmenting memory on machines which use 9p heavily.
> 
> Fixes: 80105ed2fd27 (9p: Use netfslib read/write_iter)
> Cc: stable@vger.kernel.org
> Cc: David Howells <dhowells@redhat.com>
> Cc: v9fs@lists.linux.dev
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Given I'm not in Cc of the whole series I'm lacking context but I assume
that means I'm not supposed to take this in.

I won't pretend I understand folios anyway, but commit messages makes
sense to me:
Acked-by: Dominique Martinet <asmadeus@codewreck.org>

Thanks,
-- 
Dominique Martinet | Asmadeus

