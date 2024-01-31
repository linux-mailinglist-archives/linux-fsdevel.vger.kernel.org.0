Return-Path: <linux-fsdevel+bounces-9617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258F4843601
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 06:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 888CDB22047
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 05:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F9F3DBAE;
	Wed, 31 Jan 2024 05:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bQ8aYwFG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068F13DB86;
	Wed, 31 Jan 2024 05:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706678422; cv=none; b=Eq2Eu5TpBM8j9vHAiW+yELJPAbE+WmQ5d0WjAleue0opVoccfcLgzGAYgxyCB6Pb6qJIMcOUbQxn9uwWxK/4gu/rpcxwbf+Ll/F7MqllMQ4glM6ngWmiboM3AXA2ZT8ifIXpzqdf+iLZzBmXugvqJlgQJ+YbF5ca3Viwdm/L3K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706678422; c=relaxed/simple;
	bh=rH/YhRgQEliRP/kdhBfb5XZwK8P+CVb8yaJUlhaUNUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puAfhF9H49FanG9DPXbizp6gKM2t1Nd+ni417jyK9fNDDidNO5MJesBJ9tkry3FaAwvGGHS/J8V105sdkbsI/jhGm3JbvRl/hFMMQfrCH3fEUddzU0Fz0VaC70yhGiKmPPiQNNYy2604Td9QMHl2rdQQiG/as1i5kpU4H/oS1Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bQ8aYwFG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MZk7kYXBZssL0JGkbcMdXjvUSTYEFvCr/aUZgH4AYMI=; b=bQ8aYwFGqhZN+Yxz2BYExWJC45
	yHWo1Wyd29XpL4zO7YQQhI1fdKiFjg131M0otuwYIbKOMiyWBNnbiMFN2Gi18/0yBw6WW1f2P3ati
	rvQ6rwzShIzcnxw8uiAnKm4X3g1apRq1i4pJ3qsGX3WcXtSmP4yZ5CP5+9r3WAdT1ZM5E10IzSK3p
	x2zMZPZI9HAomYTtYXBZxYsledYJ8HQfjeUisjluj0XlshP+e+pYz6Om4E8iudc/05PkdHTe2gyFV
	oczBw8rzFOcDOxEIQ4hStvfJDO64DlH81UmFr6jde/r4fnkVGGLMzB+GLeUbrS+O0Wj2GG8E7yASd
	K5WBg1Xw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV318-0000000BpAm-0YLX;
	Wed, 31 Jan 2024 05:20:10 +0000
Date: Wed, 31 Jan 2024 05:20:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Dave Chinner <david@fromorbit.com>,
	syzbot <syzbot+cdee56dbcdf0096ef605@syzkaller.appspotmail.com>,
	adilger.kernel@dilger.ca, chandan.babu@oracle.com, jack@suse.com,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: current->journal_info got nested! (was Re: [syzbot] [xfs?]
 [ext4?] general protection fault in jbd2__journal_start)
Message-ID: <ZbnYitvLz7sWi727@casper.infradead.org>
References: <000000000000e98460060fd59831@google.com>
 <000000000000d6e06d06102ae80b@google.com>
 <ZbmILkfdGks57J4a@dread.disaster.area>
 <20240131045822.GA2356784@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131045822.GA2356784@mit.edu>

On Tue, Jan 30, 2024 at 11:58:22PM -0500, Theodore Ts'o wrote:
> Hmm, could XFS pre-fault target memory buffer for the bulkstat output
> before starting its transaction?  Alternatively, ext4 could do a save
> of current->journal_info before starting to process the page fault,
> and restore it when it is done.  Both of these seem a bit hacky, and
> the question is indeed, are there other avenues that might cause the
> transaction context nesting, such that a more general solution is
> called for?

I'd suggest that saving off current->journal_info is risky because
it might cover a real problem where you've taken a pagefault inside
a transaction (eg ext4 faulting while in the middle of a transaction on
the same filesystem that contains the faulting file).

Seems to me that we shouldn't be writing to userspace while in the
middle of a transaction.  We could even assert that in copy_to_user()?

