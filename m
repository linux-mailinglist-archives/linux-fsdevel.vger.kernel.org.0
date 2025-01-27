Return-Path: <linux-fsdevel+bounces-40150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22599A1DB61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 18:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4134B1884A44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 17:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8803B18A93C;
	Mon, 27 Jan 2025 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Uz8EtpJn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C78291E;
	Mon, 27 Jan 2025 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737999399; cv=none; b=govwneahS1XuJT10zjgW6wO3t57Ehu5pyx7/iJcKLFMZDC6UG9NvWnl70PCAxgYXolsyNLNbxNvdwj5vutfZnCjbS4VZxaJAuS/V1Jq1/bZgLbiPh4bpmEZLFjOc6YwrM6ig39ba2g3yEQE96zSKk0Ss23QXLOgpy2Nnc2NBadY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737999399; c=relaxed/simple;
	bh=AHc4eD7O1ciHsESXQYMnaaySPhFGHeoCdpqaeV47eik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nvo0+Cx6yKfbEuvwEYc+To4JDrHgQPyY0lsF6GEsAXyi18uC6queiEHuHmPmg8XTpvIU1bmEIIzoykjK5OoVUTA3UR74Xt607oq/ZLjL6/KlbOlTXPAn26CoKdxBdsoKMVBuMfWolQWliuC+2QfRXNGdWcB3zjDrgsg7it95JZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Uz8EtpJn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u8zd0rAEpYNbIe0JgVol/Q0dCeAKGrFCPMa2OXMsmU8=; b=Uz8EtpJnHB5GjohDxMyGVhnkOe
	Bmy3op2JcWkVeceq+0KndDFSct3C49fjYQ/ucRuHNYbx7nMnsXchsjOJG6bBePhX8ktYrhX0nDMFF
	KZwEOLIQ/iaYxhaxEj9tNv3Xoe3YnfxZQAH7cauTVx/rLeq4cd7RIA+Qf3fUZACv3AnI7LzbpalSy
	/v4J3MWRRIVy5EBllhpEcxYySNtV9TJZ4+ajbVYgj9mbJH0starmKfDZ0qYzYeimw8hW1C1rhx1h7
	WwmXqFCb8mf5j4VOONW6w1Dd6eiUDrZ/nyWE9X2oEV03XbsfYEeg0enQ0n1+L6rMOvlMjHNCr2wHG
	uvVvAIVA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tcT2I-0000000DTna-0zn5;
	Mon, 27 Jan 2025 17:36:34 +0000
Date: Mon, 27 Jan 2025 17:36:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Sasha Levin <sashal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git pull] d_revalidate pile
Message-ID: <20250127173634.GF1977892@ZenIV>
References: <20250127044721.GD1977892@ZenIV>
 <Z5fAOpnFoXMgpCWb@lappy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5fAOpnFoXMgpCWb@lappy>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jan 27, 2025 at 12:19:54PM -0500, Sasha Levin wrote:

> The full log is at: https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.13-rc7-8584-gd4639f3659ae/testrun/27028572/suite/log-parser-test/test/kfence-bug-kfence-out-of-bounds-read-in-d_same_name/log
> 
> LMK if I should attempt a bisection.

Could you try your setup on 58cf9c383c5c "dcache: back inline names
with a struct-wrapped array of unsigned long"?

