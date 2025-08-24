Return-Path: <linux-fsdevel+bounces-58891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89068B32E99
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 11:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49784453A7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 09:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960FB2561C9;
	Sun, 24 Aug 2025 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=excello.cz header.i=@excello.cz header.b="iUFShxkw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out2.virusfree.cz (out2.virusfree.cz [89.187.156.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E467620322
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Aug 2025 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.187.156.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756026474; cv=none; b=irYXmyonqonsguMKqoMQvkzK+Q0fNEKlShKEyKFdjx36ZpZMj1EIDiYRn1ba6mdvQBemuAEAKO/arYI9N3mBOL8c8B+ljrrWfDaBg99kMXx2t2C2zmpWWJdCbGd028j3ADGVn3dp+KJw3JfJHum9msn8l2Ezbxlahj4lZBVAu8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756026474; c=relaxed/simple;
	bh=Mq+/hYWq0cVG+amD6qkQ0L109sYYur24JCBfR8TL8t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpMd5VvcbItIYcbOD87qIk9/OaJzskfmegF3ljGMesNNyBpLIJkthKu3QA4XUXhvi/4nsL1hhi67oQzQWlZW74G0UCTMrdYydDpMnq3jX2pZDyyXU1dwFthTXrar8njv6WtFWu569jHOqBnIZsjJTUcAxEGm81nil8HGQE0+3Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=excello.cz; spf=pass smtp.mailfrom=excello.cz; dkim=pass (2048-bit key) header.d=excello.cz header.i=@excello.cz header.b=iUFShxkw; arc=none smtp.client-ip=89.187.156.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=excello.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=excello.cz
Received: (qmail 4870 invoked from network); 24 Aug 2025 11:01:05 +0200
Received: from vm1.excello.cz by vm1.excello.cz
 (VF-Scanner: Clear:RC:0(2001:67c:1591::6):SC:0(-0.410381/5.0):CC:0:;
 processed in 0.2 s); 24 Aug 2025 09:01:05 +0000
X-VF-Scanner-Mail-From: pv@excello.cz
X-VF-Scanner-Rcpt-To: linux-fsdevel@vger.kernel.org
X-VF-Scanner-ID: 20250824090105.522754.4861.vm1.excello.cz.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=excello.cz; h=
	date:message-id:from:to:subject:reply-to; q=dns/txt; s=default2;
	 t=1756026065; bh=FTo/8VYVYhnYGdhHVBkoNGOEq4VXoYQoUU679M2OnzU=; b=
	iUFShxkwGE5M91seUaCupubbd0REupQrlEdDr+5UElVX9zPwONCVb+RHzIWz4lGc
	nPkLtQu+w+dQMLi9J/KW9lEDbqzxdcYvN0D+aS1ojtZvwT8V706P7lL/fBN5gmKV
	Fnejk2tLq3is2q4n98ib6p0h4XUfP1Ye2cXa/eZ+ihyMGSHEBWsJejScSOGnU9Pl
	YEIQ1IKrxoGJ+F8QKaDKcPmS5/N0Su1m/AXwQg3h6Qa2k/ftO4PjyJ9fiWhdimmH
	1jDCccnzv+DVc2OMx98HUlSurk4FtmYVtsHSwZEnlxZjmXNASWEOSxH+k+R3J82O
	z7Yj48HpEb3h5Dfc4JNNWw==
Received: from posta.excello.cz (2001:67c:1591::6)
  by out2.virusfree.cz with ESMTPS (TLSv1.3, TLS_AES_256_GCM_SHA384); 24 Aug 2025 11:01:05 +0200
Received: from arkam (nat-86g.starnet.cz [109.164.54.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by posta.excello.cz (Postfix) with ESMTPSA id 4FA8F9D7482;
	Sun, 24 Aug 2025 11:00:57 +0200 (CEST)
Date: Sun, 24 Aug 2025 11:00:55 +0200
From: Petr =?utf-8?B?VmFuxJtr?= <pv@excello.cz>
To: wangzijie <wangzijie1@honor.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, viro@zeniv.linux.org.uk,
	adobriyan@gmail.com, rick.p.edgecombe@intel.com, ast@kernel.org,
	k.shutemov@gmail.com, jirislaby@kernel.org,
	linux-fsdevel@vger.kernel.org, polynomial-c@gmx.de,
	gregkh@linuxfoundation.org, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v3] proc: fix missing pde_set_flags() for net proc files
Message-ID: <20258249055-aKrUxz36A3Yw6qDd-pv@excello.cz>
References: <20250821105806.1453833-1-wangzijie1@honor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821105806.1453833-1-wangzijie1@honor.com>

On Thu, Aug 21, 2025 at 06:58:06PM +0800, wangzijie wrote:
> To avoid potential UAF issues during module removal races, we use pde_set_flags()
> to save proc_ops flags in PDE itself before proc_register(), and then use
> pde_has_proc_*() helpers instead of directly dereferencing pde->proc_ops->*.
> 
> However, the pde_set_flags() call was missing when creating net related proc files.
> This omission caused incorrect behavior which FMODE_LSEEK was being cleared
> inappropriately in proc_reg_open() for net proc files. Lars reported it in this link[1].
> 
> Fix this by ensuring pde_set_flags() is called when register proc entry, and add
> NULL check for proc_ops in pde_set_flags().
> 
> [1]: https://lore.kernel.org/all/20250815195616.64497967@chagall.paradoxon.rec/
> 
> Fixes: ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al")
> Cc: stable@vger.kernel.org
> Reported-by: Lars Wendler <polynomial-c@gmx.de>
> Signed-off-by: wangzijie <wangzijie1@honor.com>

Tested-by: Petr Vaněk <pv@excello.cz>

We have noticed lseek issue with /proc/self/net/sockstat file recently
and this patch fixes it for us.

Thanks,
Petr

