Return-Path: <linux-fsdevel+bounces-74615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPScBIohcGlRVwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 01:44:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A88894EA5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 01:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5859E58B795
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 11:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CCC42189A;
	Tue, 20 Jan 2026 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUcU5e00"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E973A9D9E;
	Tue, 20 Jan 2026 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908047; cv=none; b=XMSD0oGypnyJPys98mcyTDtg63yOHVL17VchCTUP97cGpVPS/Fi3Tbe7mC6TJRCI3lJiBjDcm02TBrjsUoLu58xUqr5s18Tbx5MEqmPAJyv0nTkejKkkMe/kqbd8Pmc9qvCPxpuVbBLWVuH1ihSzotbsT4MGBAPO0XYlGB5xZHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908047; c=relaxed/simple;
	bh=MCy+C7PhBFnx90O7nwNt2hL19D1Yf1zFlGj4XzO4PIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndSXF53TH3bqjjBxZNf0Za41VM5mAx5Unv0YDf/gtEnCNF4WfR6TGtQBkPRaGsTdZWE2J6ROO4YiGFnChLgjXxItMY4YR7VdWzIYq0nBwXXpF7C1/A9cL3jAN9Zt/geeYBiqIbs6NjhngQ097iQjuBuYCrm4bWVfMeoJHtOUGYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUcU5e00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC53CC16AAE;
	Tue, 20 Jan 2026 11:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768908046;
	bh=MCy+C7PhBFnx90O7nwNt2hL19D1Yf1zFlGj4XzO4PIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gUcU5e00PvOoMAR+XDNvXvwxuqCrsFk3h6IC2EkmddVR+mEQC8KYbZ1PMd9JtKVlL
	 xsw21tUWxCvDG1BnPp8CAu01YKkMvIHntcX+hueiV7OPl21FsnT0IEBJahJdBBZFue
	 6J6BW9W33XniODuuBvKgXo8BY+TIfOjKenyU83b0Zkx3J3rmcCLDMBzTmPLd8znl03
	 N2cqTYvp5IoRcapVU5kSx+AtZLjvNThMslkYa79J780ElxmsbCrdf+HXNiLTZ5H+SS
	 WROknbhYxTjNYLyoQmn0mQv1vJ1IzinTUSHu+DJDO8jORoSDHnQyvfCTzOSkRRGEQ5
	 LRRrEcrrAWFCA==
Date: Tue, 20 Jan 2026 12:20:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH v1 0/4] initramfs: get rid of custom hex2bin()
Message-ID: <20260120-umleiten-gehackt-abb27d77dd73@brauner>
References: <20260119204151.1447503-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119204151.1447503-1-andriy.shevchenko@linux.intel.com>
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-74615-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: A88894EA5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Here is the refactoring to show that. This is assumed to go via PRINTK
> tree.

No, initramfs is maintained by the VFS and we already carry other patches.

If you want the kstrtox changes to go another route then I will take the
first two changes in a stable branch that can be merged.

> 
> I have tested this on x86, but I believe the same result will be
> on big-endian CPUs (I deduced that from how strtox() works).

Did you rerun the kunit tests the original change was part of or did you
do some custom testing?

