Return-Path: <linux-fsdevel+bounces-75276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJlzExZpc2mivQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:27:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B0475C0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20DD2307860D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EBC310777;
	Fri, 23 Jan 2026 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7rW7gYY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43352D1911;
	Fri, 23 Jan 2026 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170970; cv=none; b=PcxdaYL319dM/sffUHGxpd0iCgENxLOtvPxGx5bVoIFiRGDX6jdHFTHpR2OYny/WBCMCeOsEoX0WN/yaO0W+balJAZmL/zA4a3jP0VilMsQxNJXhuSXiqFpzghMmqFuZEiwfZTZ2AdrDlihzVUj74nmPnMsju0zbimWw+P6/ImA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170970; c=relaxed/simple;
	bh=uQv2UvOAW2yZXAPujoNG3CAqw/tToV0d7UQLVrFWGc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVgABbyo6Za5BWXskksDj8SfFjcRuNS0d5V2KO4cfoWCDC2/AXhYa8/IgXqEmCQFVEBdAvThlEFwFFJzdrTADQ5s6mEpM7IDM837e3fp+A+MEElIY6R/ZJInYJjSr2gGdWgtjxW0jDfqHtvxxotAIgxUbID2OsNEogOpiOEyNgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7rW7gYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05953C4CEF1;
	Fri, 23 Jan 2026 12:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769170969;
	bh=uQv2UvOAW2yZXAPujoNG3CAqw/tToV0d7UQLVrFWGc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l7rW7gYYUL918QxZFgz7mcX/SWMtbaiGVpmAb6lt8DIBRGM8zRlM77zJCBxp5C61L
	 F7WMTlsLT/VaMBAOsLpUP/GZmOzkydjjpLkWIcL0c6b8udYKxoQjk9rHjuyw3ERtKV
	 xITxFern+4Rp+JlNjG4FMPrVGT0xQDIrv2VfPGQ0N5k9ZJjGRrJUVlJA2oWKnfBqxa
	 QgqBRbiFKZCLSFuliFp3R/EU4H1KZBoxeUp/Upe2x3OqKhwzeAB9sNccWl3iwrgh14
	 vu6iqs7o1dr7UzKtG7kdSgGJhueHab+fJGgUBMmx6HGj7CZEFfU0uPi4I9X9K0wuGl
	 0pFcD2hDMl+Sw==
Date: Fri, 23 Jan 2026 13:22:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH v1 0/4] initramfs: get rid of custom hex2bin()
Message-ID: <20260123-locher-neider-24c1c9cc64f2@brauner>
References: <20260119204151.1447503-1-andriy.shevchenko@linux.intel.com>
 <20260120-umleiten-gehackt-abb27d77dd73@brauner>
 <aW95Pk3f0GGtyNrY@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aW95Pk3f0GGtyNrY@smile.fi.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75276-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A3B0475C0D
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 02:46:54PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 20, 2026 at 12:20:41PM +0100, Christian Brauner wrote:
> > > Here is the refactoring to show that. This is assumed to go via PRINTK
> > > tree.
> > 
> > No, initramfs is maintained by the VFS and we already carry other patches.
> 
> If this applies cleanly, take them through it, I will be glad, thanks!
> 
> > If you want the kstrtox changes to go another route then I will take the
> > first two changes in a stable branch that can be merged.
> 
> I am fine with this route as long as the custom approach is gone.
> 
> > > I have tested this on x86, but I believe the same result will be
> > > on big-endian CPUs (I deduced that from how strtox() works).
> > 
> > Did you rerun the kunit tests the original change was part of or did you
> > do some custom testing?
> 
> I'm not sure I understand the point. There were no test cases added for
> simple_strntoul() AFAICS. Did I miss anything?
> 
> (If I didn't that is the second point on why the patches didn't get enough
>  time for review and not every stakeholder seen them, usually we require
>  the test cases for new APIs.)

Sorry, I meant the kunit tests that do test the initramfs unpacking.

