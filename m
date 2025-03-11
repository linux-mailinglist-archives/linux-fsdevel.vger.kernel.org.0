Return-Path: <linux-fsdevel+bounces-43685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C82EA5B96C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 07:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E210C188F5D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 06:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0556217719;
	Tue, 11 Mar 2025 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JLHn6t4A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366B21EB1A2;
	Tue, 11 Mar 2025 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741676073; cv=none; b=I6cIjWpuayA1n+w7Hty8iHFENhITJ6VBBlB3l5bWtyk9Tr7foy8+KdrgkMRR1rzEJa72a3vCyUmdPu6LoOPHzEl1eorlhcwNbZvjkOKguXt17PO0B6L1Adn5zxNEIaBfZiTw3QHawqyjW7blgbSLGJRppfQH8KCTxlF6gcPDcws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741676073; c=relaxed/simple;
	bh=Bs+npam0uzqxPNvNikNRrJy0sjSofjBeY8WJW4eGkEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hifueXVphwB8XIygS0moCIL1R2+jKsKd24uiiI6gOatTGkoal33/o5oJr5mUWrGk3leH0vnasJqIgWmstd8FoKBjx5qeovXVxnVN5m5zDUHwpgtvtLbgWaS8fOnGImxarTc0y6TA+fzUrr47gGDKEjIwkJO4iPPj9wTSRrWLzZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JLHn6t4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45936C4CEE9;
	Tue, 11 Mar 2025 06:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741676072;
	bh=Bs+npam0uzqxPNvNikNRrJy0sjSofjBeY8WJW4eGkEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JLHn6t4AqIO1gjTJCjdCtVbzbH2/X3hL1nDAp2BDrsO/5p0MOQKuRylc0Gb99E8Py
	 V0qSv3xXiTy8FNTNQ6QNwENCIb03eMLEnqAjNnBvjN9PXMIEUZn+zNuZKohX3oo8zl
	 kf5MDiYvVifsXVwfSrAVPYtGcB2WsZcicLtcjGM0=
Date: Tue, 11 Mar 2025 07:53:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dave Chinner <david@fromorbit.com>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, cve@kernel.org,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: CVE-2025-21830: landlock: Handle weird files
Message-ID: <2025031131-cactus-turbofan-6ad3@gregkh>
References: <2025030611-CVE-2025-21830-da64@gregkh>
 <20250310.ooshu9Cha2oo@digikod.net>
 <2025031034-savanna-debit-eb8e@gregkh>
 <Z8948cR5aka4Cc5g@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8948cR5aka4Cc5g@dread.disaster.area>

On Tue, Mar 11, 2025 at 10:42:41AM +1100, Dave Chinner wrote:
> Greg, you have the ability to issue a CVE that will require
> downstream distros to fix userspace-based vulnerabilities if they
> want various certifications. You have the power to force downstream
> distros to -change their security model policies- for the wider
> good.
> 
> We could knock out this whole class of vulnerability in one CVE:
> issue a CVE considering the auto-mounting of untrusted filesystem
> images as a *critical system vulnerability*. This can only be solved
> by changing the distro policies and implementations that allow this
> dangerous behaviour to persist.

I wish we could do that, but remember, we can not tell people how to use
Linux.  We have no "control" over that at all.  All we can do is point
out "here is a potential vulnerability, it might be applicable to you,
or you might not, depending on your use case, it's up to you to figure
it out".  And we do that by issuing CVEs.

Heck, if we could dictate use, I would issue a "stop using panic on warn
you fools!" CVE right now which would instantly get rid of a huge
percentage of all kernel CVEs out there.  Smart users of Linux do
disable that, and so they are not vulnerable to those at all.

Remember, we issue on average, 11-13 CVEs a day, here's our most recent
numbers:

	=== CVEs Published in Last 6 Months ===
	   October 2024:  427 CVEs
	  November 2024:  280 CVEs
	  December 2024:  358 CVEs
	   January 2025:  234 CVEs
	  February 2025:  929 CVEs
	     March 2025:   56 CVEs

	=== Overall Averages ===
	Average CVEs per month: 415.99
	Average CVEs per week: 95.64
	Average CVEs per day: 13.66

So don't get all worried about individual CVEs, unless you all think
they are not valid at all, which we are glad to revoke.

> At worst, this makes the reason you give for filesystem corruption
> issues being considered CVE worthy go away completely.

Filesystem corruption or data loss is not considered a vulnerability by
cve.org, so we do not track them at this point in time.  However other
group's requirements might require this in the future, so this might
change (i.e. the CRA law in Europe.)

thanks,

greg k-h

