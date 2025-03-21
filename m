Return-Path: <linux-fsdevel+bounces-44730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 765AFA6C11A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 18:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FC6189C076
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 17:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1209D22E3FF;
	Fri, 21 Mar 2025 17:17:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE36A22AE59;
	Fri, 21 Mar 2025 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577434; cv=none; b=umrVFStq9vOz7jz+1UmRU1XVcqV+5f47Aoa0Vlv1/hm8t6vTcN9wwOqmYvM4h9YwSEl4Ic8ww+DduNwuj++1XmkL3GEpPIUA5HXl7N5vuSP85VgBSZ9zmuDvFqQrXgVhHaIJfXjjRJkp1/CiAxzcuTjYBQ9aXYV4LVx0Jev7rRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577434; c=relaxed/simple;
	bh=YYBdt5WN1pJezvLOhmldNlQEkmqgCtCkXT3LdgjlpLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meCyfpl2QUk963LBIS0wSlmPRN+6OIj7ug47DYw0gaxwfhq161FMsn0yNnPwPGb8O2pINXphnnuoe131y3b8NZldD5S6Y/qIdHhcOBU/cDxsjlYq2E56QzWwd9rjziDVDwKrciFWNPHY2dvd4wo8JzrvK6ppMvpcd2uA2/RC7FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0D2F5300159FB;
	Fri, 21 Mar 2025 18:17:09 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D85C54F19A; Fri, 21 Mar 2025 18:17:08 +0100 (CET)
Date: Fri, 21 Mar 2025 18:17:08 +0100
From: Lukas Wunner <lukas@wunner.de>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>,
	linux-pm@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem Suspend Resume
Message-ID: <Z92fFAJCzQvW_1iN@wunner.de>
References: <0a76e074ef262ca857c61175dd3d0dc06b67ec42.camel@HansenPartnership.com>
 <Z9xG2l8lm7ha3Pf2@infradead.org>
 <acae7a99f8acb0ebf408bb6fc82ab53fb687559c.camel@HansenPartnership.com>
 <Z9z32X7k_eVLrYjR@infradead.org>
 <576418420308d2511a4c155cc57cf0b1420c273b.camel@HansenPartnership.com>
 <62bfd49bc06a58e435431610256e722651e1e5ca.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62bfd49bc06a58e435431610256e722651e1e5ca.camel@HansenPartnership.com>

On Fri, Mar 21, 2025 at 01:00:24PM -0400, James Bottomley wrote:
> There's a final wrinkle in that if I plumb efivarfs into all this, it
> needs to know whether it was a hibernate or suspend, but I can add that
> as an extra freeze_holder flag.

Perhaps system_entering_hibernation() does what you need?

Thanks,

Lukas

