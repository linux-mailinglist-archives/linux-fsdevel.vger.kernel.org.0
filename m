Return-Path: <linux-fsdevel+bounces-52835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA98AE746B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 03:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E18D17A7D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 01:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04E218A6DF;
	Wed, 25 Jun 2025 01:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="p9FyyRTQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963893D76;
	Wed, 25 Jun 2025 01:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750816034; cv=none; b=J5n0mFQ704X9F4sBOg/4E4RWKMvFwivMGFzGVpvaLzfqkb8nOdnz0nET0dvIGideKYUVPD7pjCA0WXKsPBs1Zj5T975ePa6cpE2dzouQDqxOgI5a6rDnfV+PDs/7lWGNt/mKG1zRfait1d4LrkcGp/lV1wpN758oKZ9TPsXxfNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750816034; c=relaxed/simple;
	bh=sQvIdYmPuxQ+uOX0W2UxZjN4fj9yMQMbDq52o6eSYO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vt8p9UoH3grE5DkTlQ9hztmDOu6BptG4yCh3c1P3jbF8eL+VuoyovMT7CLBs07RcFRgDR06rC9pfKgON9ooi+6j/4SYSOB4SO67ABZVWdSQlFYw3Iif66rdl4yW5nprrSg//79svhSEtokuCAWtpXlquSfDChnjE6WbXNU84Pgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=p9FyyRTQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1ZDQWzSMhI/Ws1MIJKwRRexhHYDoOWfZuAqhDpR3Iao=; b=p9FyyRTQ4Jr5ws9AGXo+h5oMgB
	KW92+0ZAe25xn3kNMeio3lYgl2sxIn4XpSnBTjyQ6nXM3q39dEtdOQpW9DRhOT2HQmHLkWT7zNvEo
	DACS4AMibaXOi3ssDL23o4MLeiPtICExbCu1uUJb6KHEEUKet2QCoSi+ibOeEprTm/v8XlD5rL6Qz
	xZflZ0BLJbtXMPvC0aGOTJma+xsxurj/nbo/yDDTMri4PZfAZIZBQijMDRHRvlQYkuboPoPK5MZoc
	lCU6eNuEWGca5QaXmZ9HCFm/6hiaiYFHErDuACFtz0r01LoiUxurto1v2mxizdTh+9u2LN3kX7YIS
	eeHDX+VQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUFEE-000000073aY-00uh;
	Wed, 25 Jun 2025 01:47:10 +0000
Date: Wed, 25 Jun 2025 02:47:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-security-module@vger.kernel.org
Cc: linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHES][CFR][CFT] securityfs cleanups and fixes
Message-ID: <20250625014709.GQ1880847@ZenIV>
References: <20250612030951.GC1647736@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612030951.GC1647736@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jun 12, 2025 at 04:09:51AM +0100, Al Viro wrote:

> Branch (6.16-rc1-based) lives in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.securityfs
> Individual patches in followups.
> 
> Help with testing and review would be very welcome.

Seeing that no complaints have materialized, into -next it goes (with
Acked-by/Tested-by attached)...

