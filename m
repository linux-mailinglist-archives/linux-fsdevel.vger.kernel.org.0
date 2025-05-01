Return-Path: <linux-fsdevel+bounces-47872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06897AA649E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 22:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D0046707D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 20:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A4C2505D2;
	Thu,  1 May 2025 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nFpPoQ6m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735802512DE
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 May 2025 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746130513; cv=none; b=R2odlXmsFYjrHEdw3UB2hAUcI3XFJfde7DnhG6UH0IUgV6vku4k/Bu9SeCa98gxuefmytaxD54SElNKvEVr/V+GnHE/OS2OOPuKLzkCFzcji03s/IHKFBB99FXS8c0O9Fu2Wmn9AgDLrokksYP856eDEV+/NkGMwjO9hMJXfJRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746130513; c=relaxed/simple;
	bh=UoF4YKI7y5zpKfFPMpqeZFS+Qets0p8XsbDGKC/WkeU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o13e7gQI/SkF4f/lr9ziN3N3y2caBCK/hPRGBRNBHFnDzC++dfHdKEHQ1+NtmIUqRE3rjHjH5owoXKz9UP5F9TnSpu82eqWSMGtmj1FyB7RUcuPifV3PrtbnIUxD9TRK1lrwYx/NpFqz9nMgYI7lSGra4AfRgbjpKuD+jGOHPig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nFpPoQ6m; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=RcQxyVATp5voQyhOO432j1k1jqJJ0y3yc3oaohS6NEc=; b=nFpPoQ6mipntCGSKX9jCsOb0Ve
	qrABybx3U+a49Rt5mCuoEd/qdV7T797xqh2VEfGGJC/Fo8DmfY690KWfH3WkMbL0yOeeYRw2OHdy1
	Zc+AZQNowdEIxe8nDuyVzeS3yIe3XtYKuTgvXjf7ANcpCqJZ2OO0BK2m7OW4pj5W1w5CKgAHf1K5R
	7OCO193j5zvUhawvqu66VA8/4Kgg30+0bn8OPYngsKeK5x+LkBJpHAQsxxAEbilI2Eu2e1Dikym9p
	/E75mcbR50FdzWcUjhdUVJ67Pu2lx3OmB+/Ul2GinSoqkQeZi/WKmt2hre8Xgd8Z0szUfIOa2haVh
	Biv7pjLQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAaJG-0000000DLkY-2dOj;
	Thu, 01 May 2025 20:15:06 +0000
Date: Thu, 1 May 2025 21:15:06 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [RFC] MNT_LOCKED vs. finish_automount()
Message-ID: <20250501201506.GS2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Back in 2011, when ->d_automount() had been introduced,
we went with "stepping on NFS referral, etc., has the submount
inherit the flags of parent one" (with the obvious exceptions
for internal-only flags).  Back then MNT_LOCKED didn't exist.

	Two years later, when MNT_LOCKED had been added, an explicit
"don't set MNT_LOCKED on expirable mounts when propagating across
the userns boundary; their underlying mountpoints can be exposed
whenever the original expires anyway".  Same went for root of
subtree attached by explicit mount --[r]bind - the mountpoint
had been exposed before the call, after all and for roots of
any propagation copies created by such (same reason).  Normal mount
(created by do_new_mount()) could never get MNT_LOCKED to start with.

	However, mounts created by finish_automount() bloody well
could - if the parent mount had MNT_LOCKED on it, submounts would
inherited it.  Even if they had been expirable.  Moreover, all their
propagation copies would have MNT_LOCKED stripped out.

	IMO this inconsistency is a bug; MNT_LOCKED should not
be inherited in finish_automount().

	Eric, is there something subtle I'm missing here?

