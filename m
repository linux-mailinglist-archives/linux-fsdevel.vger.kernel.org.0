Return-Path: <linux-fsdevel+bounces-40185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DF9A20299
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 01:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7EC164BF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 00:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9C8101F2;
	Tue, 28 Jan 2025 00:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OrNrehtl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A0E2746A;
	Tue, 28 Jan 2025 00:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738024319; cv=none; b=eW815B7GNjFJtoHs40ZmjIAUgnrYhfh6l+LFXhG5C9rB4mVC+7/kf3sr2SV6zt4mnwFfcuKcQEYqZFHDdYf5sGMHn4Bxzu1iUD1+jSPyX8DwvVbCg6u3ja9Ia6mbeXg/uivkgWd3eT67O0O/FQe0N5iza+tOOiz/K9j3WnVA/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738024319; c=relaxed/simple;
	bh=Bqg38ha9oD6+cVIaJLYJuvGSbLOu+OWnp8PKH4k8Ugc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvya+hcbKrfV3meG2MxpzNeFqEf+iUW7F6akSq7kJNCteYBy6ywQMuvedTCOdYEl/ZJg2O9d789I4fTLjB2ColCyfRL8Dy3bjyfEZN0Cf6dWJB8ADTldDMYMAMyS3vV4cAS62P/eRl7cPlRc1N1YbpxNrDER15RPNAKL5GqSKs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OrNrehtl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N2dtJva6yyHGCqIxSt/IUVh+8WEdKKkN7bkY1yl1Ih4=; b=OrNrehtlG2hWSStReLH3j5MJIg
	MndnKgI+n38vXLqUtATSmE01Knrvsloo2eE/G+2Lb4a4xRUa6eCSXAVcCY+B59fULtyoIAzCm5wJP
	cDbSkI7dx1T91spCVlEwyyslZ+TuNmral2YPlYGEKbapTiv+lC/+PQ58TG7g1G5REq9xhILkORvzG
	HK1YHZldyJSdhgm4dYVQyTRKFRUozipd88fsWOQkzafMSuaEMSyzMXTKmaiNNYLDuspL6eGP7cFz9
	2GonmZZu5YQElWFBTMsU7x9E0qSMUiM06bxV6WNq1oDBgeFQvbHN/8MhLgc2WhsaE1MnIuRwvSRUN
	BN+33N2Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tcZWF-0000000Dogs-2fhA;
	Tue, 28 Jan 2025 00:31:55 +0000
Date: Tue, 28 Jan 2025 00:31:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Sasha Levin <sashal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git pull] d_revalidate pile
Message-ID: <20250128003155.GK1977892@ZenIV>
References: <20250127044721.GD1977892@ZenIV>
 <Z5fAOpnFoXMgpCWb@lappy>
 <20250127173634.GF1977892@ZenIV>
 <Z5fyAPnvtNPPF5L3@lappy>
 <20250127213456.GH1977892@ZenIV>
 <20250127224059.GI1977892@ZenIV>
 <Z5gWQnUDMyE5sniC@lappy>
 <20250128002659.GJ1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128002659.GJ1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 28, 2025 at 12:26:59AM +0000, Al Viro wrote:

> Could you recheck that one (23e8b451dea4)?  I'll send an update pull request

s/update/updated/...

