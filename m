Return-Path: <linux-fsdevel+bounces-75920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJyuFjbte2kMJgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 00:28:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0192B5AC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 00:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3AA33013246
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 23:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4D237649E;
	Thu, 29 Jan 2026 23:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mVe3dmCT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F102A3451C6;
	Thu, 29 Jan 2026 23:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769729324; cv=none; b=ICmTLZ6wRz5RxQz6guotIwGOUECoiJF9sNpw5cV71k5a6hBQQT6uwYHB86tRsFjmc87qyQkN/OSMBe1c2LIEKmo6GYDldSbENr+zm0qURgS1W+en5BQFQ+auMnxrdHOlWqmy5iUop7btVz+ruCvCR/b9xnLwRau+aZ56/dktNA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769729324; c=relaxed/simple;
	bh=ojRwdMLSrrBWmMXuxJk6n5g2aDFomjtXt0utnZnuoOg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gQCr6YN+1FEfMZcSig1UpKjaJ9OR4Tr3Hgo1xUpVEfx4lnBBxsp1gbeCRmSRssB+DZCYxoqNSNp0MYmSHLMezJ7JA/Mgh8p0n6Jp4W5joX/KaNIC/IIiybE1YrqKwDkH00EZQl+mdyztYgRb5yhiH49NwIk16dcsS800yYtcvJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mVe3dmCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4D7C4CEF7;
	Thu, 29 Jan 2026 23:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769729323;
	bh=ojRwdMLSrrBWmMXuxJk6n5g2aDFomjtXt0utnZnuoOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mVe3dmCTBLR14n9/74xX4bc7BSBr2vwbK2vjDTENpIgH0e8hbbxfPAsiZwWDdyM3Z
	 JTKM9fuBfeh/1RvHJRoaZ50mLBwrJJIbXa8spURqcGBGZ3F2WB6iy9cjDTwJEXlf63
	 KicKYKY264Dwv7xBR5lbX1SjA+k6o5r9DlOcTCVU=
Date: Thu, 29 Jan 2026 15:28:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-mm@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, surenb@google.com,
 syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
Subject: Re: [PATCH mm-stable] procfs: avoid fetching build ID while holding
 VMA lock
Message-Id: <20260129152842.b8db6be6aa9e4fa93e69cc5b@linux-foundation.org>
In-Reply-To: <CAEf4BzZJSuc0AH1Hio-DVpgR9S-KZsMNqU7tb--c4=mPZJ5dcA@mail.gmail.com>
References: <20260128183232.2854138-1-andrii@kernel.org>
	<20260128105054.dc5a7e4ff5d201e52b1edf85@linux-foundation.org>
	<CAEf4BzZJSuc0AH1Hio-DVpgR9S-KZsMNqU7tb--c4=mPZJ5dcA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75920-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,4e70c8e0a2017b432f7a];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: F0192B5AC4
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 13:30:37 -0800 Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> > To provide for additional review and test time I'll queue the fix for
> > the upcoming merge window (Feb 18 upstream merge) with a cc:stable.
> 
> This seems to be exacerbated (as we haven't seen these syzbot reports
> before that) by more recent:
> 
> 777a8560fd29 ("lib/buildid: use __kernel_read() for sleepable context")
> 
> which is in mm-stable. So I'm not sure, probably would be best to have
> both of them together.

777a8560fd29 is actually in mainline.  I'll move this fix into mm.git's
mm-hotfixes queue so it should be present in 6.19.


