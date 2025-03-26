Return-Path: <linux-fsdevel+bounces-45092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BD1A71A44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 16:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604DE3BDBD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 15:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4944B1F4160;
	Wed, 26 Mar 2025 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GR58arud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C721F3BBB
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002713; cv=none; b=NN0FQ7VAAldWjoxts6hTV6hZTKx9yZSNttQy6EkzifCcqfdI/h3Gn1OnCqj90y5cdaNnlh1IIDQFHuuBHC7f9HsTNsYrAfcDJnGz2FMV1FylDKo8IhHQgJu3GTW8j9vjSw8CE8+1sTtF1ju7TiT3vz3XQC8XFQLxzCWeDH145TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002713; c=relaxed/simple;
	bh=s1Uk5HIUXk5OK0Fg7lnf7yl1KotdzvonbIq32pTTYLw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aMxyCuZ7rP9XbEmBXHS9ugOo9Xyte8lYAN5VOa4QXitORsgWzhmG/ogNYb0/kviOq9071jmZw+vgG0ciyqe2uM/fScHJAyeEtUnHPKdUOu/abLmQayOGYkP4y3BKxNaMcWavwtJPTHQz+ddOOQ5yXnIfvaq8sCHmx5cSBj8Qr5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GR58arud; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=zfbeb7WqetTmo2iA8BBW4rqSB1gcNrJ7G6vBwpbpG5c=; b=GR58aruduxRgg0W3Y+frVYbelO
	tD3GrWf6Dhm0ISK2827Zn76gqoaJhStzZjc3sM6BSI6oX/2DHBZZQQAvUHi5s7E/NPsK3KU/hlrr2
	vlVQi+3h/j5lyeIULUDcnTxYz7zDFH3SHljld7gaI6xFtXlZTS9tOWtf9QKe859u8QIjvXGJvSTVf
	CNRVyExAQuU2gKZg3OQC32Y7JnIhdTEeDNYZc8hWSnywhgRMUvW0bC2xT/TqsF26FYkIeWQtAiqpD
	AIdXlk+GX2vsqCSndfHmf995h0iipOrsAEHOnxOTmon93vw96kkkGRKYWO4+VDWDLYmUDfAKCPoQ5
	LmzHLT0g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txSct-00000000BAe-1zp4;
	Wed, 26 Mar 2025 15:25:07 +0000
Date: Wed, 26 Mar 2025 15:25:07 +0000
From: Matthew Wilcox <willy@infradead.org>
To: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [LSF/MM/BPF Topic] Filesystem reclaim & memory allocation BOF
Message-ID: <Z-QcUwDHHfAXl9mK@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


We've got three reports now (two are syzkaller kiddie stuff, but one's a
real workload) of a warning in the page allocator from filesystems
doing reclaim.  Essentially they're using GFP_NOFAIL from reclaim
context.  This got me thinking about bs>PS and I realised that if we fix
this, then we're going to end up trying to do high order GFP_NOFAIL allocations
in the memory reclaim path, and that is really no bueno.

https://lore.kernel.org/linux-mm/20250326105914.3803197-1-matt@readmodwrite.com/

I'll prepare a better explainer of the problem in advance of this.  It
looks like we have a slot at 17:30 today?

Required attendees: Ted, Luis, Chris, Josef, other people who've wrestled
with this before.

