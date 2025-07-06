Return-Path: <linux-fsdevel+bounces-54032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F23AFA76E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 21:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380A4168CAD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 19:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EE81CAA92;
	Sun,  6 Jul 2025 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mnRRbMDk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506054A3E
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Jul 2025 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751828814; cv=none; b=PUVNwpmT50lEV7WcJmp1mEFH6HBHUGTRNJTI05MtCKPQAm8zlDAM6arcOaXH9zlHi0E3od8CWkeuTZh5Hxpqjb24XQur8YA0HDOb3m99NzOt4jDuJ7xQ5xUwdf/0xocPTuwcnAz5RZyXPlmeMxtdEKQOfoiF7i0txtRjb2Pi8Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751828814; c=relaxed/simple;
	bh=+mMcpl4jQJdP/bQ3iJXWZHRTvtIgrtB7QBAEBQkuK0E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ATqfbbyhbGLpmPYJgiOq/hmguHdUdqVztle2UxXwxP+onqwHSGnQi9uWX7CZdUAqQdbhwqv2Mf6gCAievUZNU7FIO0+cuGijGumlJE44oapbu9ddh2MBbClJzutW2OqR2xkVlJ4IAurnrppYR4+Sk2wDCUDUVbxLZWWyk21FRUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mnRRbMDk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=1SwCYSR2SgXrdbkpDvz0OmnCGNhwWjR4X0SmFofmRBk=; b=mnRRbMDkPn7A7H6SUR1RLt2dwf
	zsjZnX5+ZkTmFbtBzmgrob05+gzIwh1iAIKgbp+iKjuxlNvwDbLwCxMfW6tRaqhdTPBIjaYRNACAs
	lGLCPnTJkr/IqGAqKlrF5NTggUbG4RVwC4NxDNFM1+MlEnboeRZ3czHTalp7qBvJGjIDldGOsWsri
	d2MzfmG03iiD0+IDvGtpy/EynlttIQilEQJpEz7Tb5ErjOONkxQ7TZU0m4EsKqIHz5kUrlQyO46+U
	rg2S/AAgrsw8/c2xWBbLC+CB+rpTbFN3IUiLrZiqqU7iC50PznxGORo3TB4pvMwbM5Vf8nBdkatvV
	KX/t+LHg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYUhN-0000000CVlH-0INI;
	Sun, 06 Jul 2025 19:06:49 +0000
Date: Sun, 6 Jul 2025 20:06:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] proc_sys_compare() fix
Message-ID: <20250706190649.GC1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af:

  Linux 6.16-rc4 (2025-06-29 13:09:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to b969f9614885c20f903e1d1f9445611daf161d6d:

  fix proc_sys_compare() handling of in-lookup dentries (2025-07-03 20:59:09 -0400)

----------------------------------------------------------------
fix for the breakage spotted by Neil in the interplay between /proc/sys
->d_compare() weirdness and parallel lookups

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (1):
      fix proc_sys_compare() handling of in-lookup dentries

 fs/proc/inode.c       |  2 +-
 fs/proc/proc_sysctl.c | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 8 deletions(-)

