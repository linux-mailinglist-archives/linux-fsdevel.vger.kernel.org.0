Return-Path: <linux-fsdevel+bounces-66204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517F6C1962E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 10:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33AF03B8D38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 09:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995A3328605;
	Wed, 29 Oct 2025 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="of3wlsDM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB18D32144F;
	Wed, 29 Oct 2025 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730528; cv=none; b=OQ0tTDGuvVnfmcaL1lU+Kva89XAuBg3nR4B8gvDlnyad7lvfMBElJm5+HqQXNJimWJELnXeMwSp6EbM5kk2Cl2MPuZNpe8AqxlpNaw6UzYzFnd7qvJK19gH3y6qUxBDjmIQDze/FDkEKMSi3L8fR4ZWypO7rlHiugsm/c0hdXKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730528; c=relaxed/simple;
	bh=DylIC7MaWzzlbf638yNKXtkBOWxFFemZl0IXhnljrdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYpd0/+kSEuhz4WsLcevIlJsg+/OgiUJVhQHK9bBzC4ZrxPkuKL4ACqXqdnhfrea1PTVM5o28BesFapTRQQmLOKlfWPex1QQZK3tx2wq2hlv0JKuga3bfbMMD+hceGrDqUmWw3tSpOPPHOyvMj1/ezxpSIm9hKLzQkGFzmQThSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=of3wlsDM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KrjYGkqN0kO9dM+tx1T5sNix3GHy3Os0ypxdsVL7Byo=; b=of3wlsDMFuNQTuAzRwgpcvs8DM
	RqW0UQo1Lhtz8jpSHdk784EGZPn9AVmdlqQN9gcMSUUkLJ234RG4E1Xc+qPzcdYetOQh+T3lp53tz
	iPfKDBNBiK6nwsfx/n7VXai4SDqe+8YYuWx60ryPz4Nw3FHowa40tDzbZ52tUb6YBcBAKrhzYtJb0
	Y/7BMtZi7822qBbgixNsF4kXDJ8Z0hbt0dbE6ClOWaE32J4HBUY1CnAZ2slge485GSlB+mSHv9BSS
	TABHa8ZkQOP1u7nQQuUVu5euS3W9kA3Enl82jHvTi9V2H4G0PdNUJ2q4i8060pmEZ6aOCkVqVEFte
	/YxPyb3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE2aT-00000000WAJ-38Ar;
	Wed, 29 Oct 2025 09:35:25 +0000
Date: Wed, 29 Oct 2025 02:35:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, neal@gompa.dev,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joannelkoong@gmail.com, bernd@bsbernd.com
Subject: Re: [PATCHSET v6] fstests: support ext4 fuse testing
Message-ID: <aQHf3UGaURFzC17U@infradead.org>
References: <20251029002755.GK6174@frogsfrogsfrogs>
 <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I find the series a bit hard to follow, because it mixes generic
with fs specific with test specific patches totally randomly.  Can
you get a bit of an order into it?  And maybe just send a series
with the conceptual core changes first outside the giant patch bombs?
Or if parts are useful outside the fuse ext4 context just send them
out in a self-contained series?  Bonus points for a bit of a highlevel
summary why these changes are needed in the cover letter.

