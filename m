Return-Path: <linux-fsdevel+bounces-54182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0584AFBCFE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 23:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3EDB1704AC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 21:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A048026FA4B;
	Mon,  7 Jul 2025 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rRKLJxfJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438BD192580;
	Mon,  7 Jul 2025 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921996; cv=none; b=LP4SLJvHqXQDT1OLsppiYCUolt/PlxaPxIFi57oXHCiGLKHpEF4YEzuygHq/Hgd0swZS5JyVY2C96VCilCIiqQCqcb8fkLaPYfMJl7RHF4KX3LXAqd1wsKRRl8eWl9+TBQgGXurhn6CprgZrNPIlIqJjfUFH0Iadcyj8WgtIiJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921996; c=relaxed/simple;
	bh=+y7EztdV6WpqRU9cifADpRNzPWKc1leXEQnVxp6c7mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9O+eSKzyl7cAKl1W1ta1SQYxXorIoq1727fWzBwjJKJQlnQ1tP07nenLV2cvlPpaAhBrRjOBAMd5tTD2vK8Wr/LvOx1zDoOY+ly7dJrDuq7nxNUTRjU/n9v1RQ3vh+WHcbLMsII+dGKwASPA3AX2bE0gbbBXEhC/lT/uae2BmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rRKLJxfJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=Z8/myWqj0qI/9Ufgc2xvyx0Q85nxC+PgJ1iynCR7Yew=; b=rRKLJxfJMHMB5RbPOmMYnJjqAq
	ZnPaUUdgjIqHmnqiOTthVYC0WT0nErQdCANOsXRyqcIloLoVDFDNU+vFrmtmMXJK6u3p64PAkOMcO
	1oPCCzysGIYKz6MMRiOQ0nXutNh13q142fvvLXrSbWF/8U25UK7X7oFgNl5msPJ4+Tu8pfVp1j8TC
	jkGhJMSPoNTkcSM1KKS90SxLR7e90Odhya3kTjlgBFnF73Qxfw4oRcrvKR9RkmVDfdrwfT5JvAStY
	8M/QeV9bJ/aCKdfAg8WKBpk/nqocrufzqUI8ssh6RXIciFjnFU/RPGqyD9BLeDTEMe13LcngCND+z
	IfmNzYOw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYswK-00000003nYD-2TUZ;
	Mon, 07 Jul 2025 20:59:52 +0000
Date: Mon, 7 Jul 2025 21:59:52 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
Message-ID: <20250707205952.GL1880847@ZenIV>
References: <20250707172956.GF1880847@ZenIV>
 <CAKPOu+87UytVk_7S4L-y9We710j4Gh8HcacffwG99xUA5eGh7A@mail.gmail.com>
 <20250707180026.GG1880847@ZenIV>
 <CAKPOu+-QzSzUw4q18FsZFR74OJp90rs9X08gDxWnsphfwfwxoQ@mail.gmail.com>
 <20250707193115.GH1880847@ZenIV>
 <CAKPOu+_q7--Yfoko2F2B1WD=rnq94AduevZD1MeFW+ib94-Pxg@mail.gmail.com>
 <20250707203104.GJ1880847@ZenIV>
 <CAKPOu+8kLwwG4aKiArX2pKq-jroTgq0MSWW2AC1SjO-G9O_Aog@mail.gmail.com>
 <20250707204918.GK1880847@ZenIV>
 <CAKPOu+9qpqSSr300ZDduXRbj6dwQo8Cp2bskdS=gfehcVx-=ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+9qpqSSr300ZDduXRbj6dwQo8Cp2bskdS=gfehcVx-=ug@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 07, 2025 at 10:52:38PM +0200, Max Kellermann wrote:
> On Mon, Jul 7, 2025 at 10:49 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > Yes, but where does that ceph_evict_inode() come from?  What's in its call chain?
> > Is it several shrink_dcache_parent() fighting each other on the same tree, or...?
> 
> I described that already in my first email, but here you have a full
> kernel call stack (in this example, the shrinker is invoked from a
> user process due to memcg pressure):

Umm...  Note that further in that loop we'll be actively stealing the stuff from that
shrink list that hasn't gotten to __dentry_kill().  Does your busy loop go into
if (data.victim) after the second d_walk()?  IOW, does it manage to pull anything out
of that shrink list?

