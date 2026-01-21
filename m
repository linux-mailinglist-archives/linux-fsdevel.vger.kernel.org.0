Return-Path: <linux-fsdevel+bounces-74936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK58BOlgcWkHGgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:27:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DA05F7D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14A9A9A94FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 23:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C052338905;
	Wed, 21 Jan 2026 23:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="AsLQPSzt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6532C286D5E;
	Wed, 21 Jan 2026 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037848; cv=none; b=H+Ncoi7c1KDMndJv1BIh3HW6FbOm2XLu0cbJ/2y2SfH+3g4jk7ritFrIAPLcH/DbVz7IXZ0NKaJa+5tbEBCzRQTeak9qZyCO/Qy74Q65FWnAdtK6rKTulINgbIPUTdczj4dCQTdkrii+Cn8Jdgg+ziOJ8Pn1qsUxaN9Q8v969HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037848; c=relaxed/simple;
	bh=noGctKV7hSfPIMZvhoPpW/JkK2WKKQTYnjhm1mnxB8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNbuUDhF077pHmJaXfUKTx0EOD/+Jt5ZzSrprzC7btALnItbMIUWZhmNOjjgarvkvc73Y+4nyjlCkw3iad7ii6CausoO8qz2LwjJxlUUacnQ4s93JnOtEljTXZtSUDWusuWyF/rrZ0P764526Nr3nXkkB0K2pSrlc/CtqRqXkoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=AsLQPSzt; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 5C41C14C2DE;
	Thu, 22 Jan 2026 00:24:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1769037844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YS2JAcOeVL+Usx5qZkbSLHdNWHXAog+0vtbjbzuN4RE=;
	b=AsLQPSztZbAq0I+/0/l9thdklbtt12gl3xwbmWA9sMj2+qThFqlmtlS2XsqgPKuzv9pXtn
	XxFVP7t3/S60s/me8DVMqBOanlMlhBNmdbsNwsyiiZ4uW7QXzu4yEN6TobXq0KWZw9T4rK
	kUrGIjrd8FNlt2mbU1MemieBXuwJKMpNGFsSWmd/jWpgPQBvJp9Ay2cI0y/wtODzDlGrqi
	JIbz5vcPA3U6CAxTBgN2WahIMXlIKNSA1+n22RFKdsfiRwOB8FL+WHwHl66ncORsDd17en
	v4lE5fET4HzhFteUNRcZlqzAFhv1nVBsJwzchrlq/Iuez5yVZf6wWpOCFwA8sQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1012ecd5;
	Wed, 21 Jan 2026 23:24:00 +0000 (UTC)
Date: Thu, 22 Jan 2026 08:23:45 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Remi Pommarel <repk@triplefau.lt>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH v2 0/3] 9p: Performance improvements for build workloads
Message-ID: <aXFgAcDjjqJc6qhQ@codewreck.org>
References: <cover.1769013622.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1769013622.git.repk@triplefau.lt>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[codewreck.org:s=2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[codewreck.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[codewreck.org,none];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74936-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmadeus@codewreck.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 92DA05F7D2
X-Rspamd-Action: no action

Remi Pommarel wrote on Wed, Jan 21, 2026 at 08:56:07PM +0100:
> This patchset introduces several performance optimizations for the 9p
> filesystem when used with cache=loose option (exclusive or read only
> mounts). These improvements particularly target workloads with frequent
> lookups of non-existent paths and repeated symlink resolutions.
> 
> The very state of the art benchmark consisting of cloning a fresh
> hostap repository and building hostapd and wpa_supplicant for hwsim
> tests (cd tests/hwsim; time ./build.sh) in a VM running on a 9pfs rootfs
> (with trans=virtio,cache=loose options) has been used to test those
> optimizations impact.
> 
> For reference, the build takes 0m56.492s on my laptop natively while it
> completes in 2m18.702sec on the VM. This represents a significant
> performance penalty considering running the same build on a VM using a
> virtiofs rootfs (with "--cache always" virtiofsd option) takes around
> 1m32.141s. This patchset aims to bring the 9pfs build time close to
> that of virtiofs, rather than the native host time, as a realistic
> expectation.
> 
> This first two patches in this series focus on keeping negative dentries
> in the cache, ensuring that subsequent lookups for paths known to not
> exist do not require redundant 9P RPC calls. This optimization reduces
> the time needed for the compiler to search for header files across known
> locations. These two patches introduce a new mount option, ndentrytmo,
> which specifies the number of ms to keep the dentry in the cache. Using
> ndentrytmo=-1 (keeping the negative dentry indifinetly) shrunk build
> time to 1m46.198s.
> 
> The third patch extends page cache usage to symlinks by allowing
> p9_client_readlink() results to be cached. Resolving symlink is
> apparently something done quite frequently during the build process and
> avoiding the cost of a 9P RPC call round trip for already known symlinks
> helps reduce the build time to 1m26.602s, outperforming the virtiofs
> setup.
> 
> Here is summary of the different hostapd/wpa_supplicant build times:
> 
>   - Baseline (no patch): 2m18.702s
>   - negative dentry caching (patches 1-2): 1m46.198s (23% improvement)
>   - Above + symlink caching (patches 1-3): 1m26.302s (an additional 18%
>     improvement, 37% in total)
> 
> With this ~37% performance gain, 9pfs with cache=loose can compete with
> virtiofs for (at least) this specific scenario. Although this benchmark
> is not the most typical, I do think that these caching optimizations
> could benefit a wide range of other workflows as well.

Thank you!

We've had a couple of regressions lately so I'll take a week or two to
run some proper tests first, but overall looks good to me, I just wanted
to acknowledge the patches early.
(as such it likely won't make 6.20 but should hopefully go into the next
one)
-- 
Dominique

