Return-Path: <linux-fsdevel+bounces-52573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC21DAE45EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E173443CEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B167E253951;
	Mon, 23 Jun 2025 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eYYlWNj4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47344C7F;
	Mon, 23 Jun 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686969; cv=none; b=iUszwU7JvkG8s+ZYkKFFjOyD9gsiFBnarcJKM++wz26GulsZDtZiOh6X6C+LSooNGvzz9TcQBq3vLfZ1ZDrHgk31evuJmNqb1d3k0TfceBkBIXQXggd+w1WyT7q47aMDw/iN4e7A1UoObiPAHDPey0NYqcx5WvVeoe9A1E0/HcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686969; c=relaxed/simple;
	bh=kswF/vinj7GnK79fLBwJ+CaAgQTqEMy43A7XebCvfVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otXNkOb1djbPPq2xOj3EUadU5DivXkwL8ffzXgDtdOjpgSXhvTqMEDPWp5I2zYC5DX4/OC2oytPelUmvD/pUgwym5V/Dauiu5QgdAA4a6PpYlimpjjPTt8DIhRlgLcHDexP+py2PTXxjo7r+8HbkjjIOkqawjsSDYDkZoQsNzQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eYYlWNj4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kswF/vinj7GnK79fLBwJ+CaAgQTqEMy43A7XebCvfVI=; b=eYYlWNj4u2trPCTGmRhR2on2AW
	68FU9GAW8YSVHmdB4HkmVr8XS9BAiB9INjIOyCuzsTJlWKONyZqR+VyEvjxH5NrV8Mn9xVTQ3yT5x
	lMXHlK/fwfiPX61Ze6iLQktcVtsBYE7SMssEoSVMmp//e7HUhL8lYlGnwH16+N6dDKRWmUwUvLeE7
	9DANkzlUyRXdaqoQyOQBWzW2O/hZkvpiYuvQzwrXojF9k92GJ/WMdA1s3a/7NPCykU5kSUzq5xVt9
	raHyRhi43WL0SX0c2vk5y4EbECtduQK21CsxGrhE98rN55rE/2Ze1VcobznSk/9h3MFE+OMLZ8TAT
	3nK7VfNA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTheU-0000000CH0p-2StS;
	Mon, 23 Jun 2025 13:56:02 +0000
Date: Mon, 23 Jun 2025 14:56:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-fsdevel@vger.kernel.org, riteshh@linux.ibm.com
Subject: Re: [linux-next-20250620] Fails to boot to IBM Power Server
Message-ID: <20250623135602.GA1880847@ZenIV>
References: <aafeb4a9-31ea-43ad-b807-fd082cc0c9ad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aafeb4a9-31ea-43ad-b807-fd082cc0c9ad@linux.ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 23, 2025 at 07:20:03PM +0530, Venkat Rao Bagalkote wrote:

[NULL pointer dereference somewhere in collect_paths()]

Could you put objdump -d of the function in question somewhere?
Or just fs/namespace.o from your build...

