Return-Path: <linux-fsdevel+bounces-50263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99904AC9D68
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Jun 2025 02:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8DCC3BD07C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Jun 2025 00:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC4B2DCBF9;
	Sun,  1 Jun 2025 00:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Exm/mE4p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBF2184E;
	Sun,  1 Jun 2025 00:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748737584; cv=none; b=exF+f9RhDZGNqKAQec3vnWpYYvIRtIOqwCoDlcvE1Sj34mEP+0IdBl3+hSVhXZMcdwA6SvcmDXyDhXQNdp5v6qXfQ8n2E9hQn8BTI0989jRe2SoIszYpNAirMiH1DEQLFo5923MMeod0U2TIeXgp4+YKnZJNa/SIWw99GCgPnns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748737584; c=relaxed/simple;
	bh=wnjlPLdQigk8QgUrIHw5yk6jJrpMJY8IJU4pMMPHFAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i26LlqxtT0Tah+IlIFtIWUrN2l59c4D+DTf399S0S+NfsswwVXKYeVLXFqjRNgFwOdgwffCOvNtkofkVDlj4k4X+/kp96IEMnOgFlKPvaeTyO7gu6ZGv43dU53nmrPc4hIo+D/pMBOTD1upbCFYy4TiwV5Xx9RMZrOD85FO4WSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Exm/mE4p; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5rMEOV3KLFf+UgtAPaHUd4YMhA+OdnA8tVR26hQhvHY=; b=Exm/mE4p4ROy2CB3jVoyT30S5s
	CZwAD3td2DHQhuXhoNsMlrGr6/4Fu+gZ5ZMxz3isum/jvx6wHBpY/HqfHzfV8O8mVca0YnPZdt0Ii
	TJUAhCQVf3ONs1apHQXVDwdA6Ki+CaSqyYrYQBREpHRyNGbOWuLG3w0EmHYmCd45IDdeLz7JWpHAB
	FLns5ip5T1x8h6GjA/YCEPKY0ADhUW2iKpDn/DXGLgnfRH6o/41Dh6L6PMlJ4l2kNcdWNaeQnWMlm
	4PTfCEflJTI5RzsbFZWtiB1H08ys0qYjSRqA+4DSIuhNZmLy2gJ9Qm1HjVY9ggkhrfUOA9LJA16NN
	Ds2tp2tg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLWWa-0000000HB4K-15Hx;
	Sun, 01 Jun 2025 00:26:04 +0000
Date: Sun, 1 Jun 2025 01:26:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: syzbot <syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com>
Cc: asmadeus@codewreck.org, chao@kernel.org, dhowells@redhat.com,
	hch@lst.de, hdanton@sina.com, jaegeuk@kernel.org,
	jlayton@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com,
	v9fs@lists.linux.dev
Subject: Re: [syzbot] [netfs?] kernel BUG in folio_unlock (3)
Message-ID: <aDueHCMDLPs2UtY2@casper.infradead.org>
References: <67b75198.050a0220.14d86d.02e2.GAE@google.com>
 <683b8ea2.a00a0220.d8eae.0020.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <683b8ea2.a00a0220.d8eae.0020.GAE@google.com>

On Sat, May 31, 2025 at 04:20:02PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 80f31d2a7e5f4efa7150c951268236c670bcb068
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Thu May 8 05:14:32 2025 +0000

That's not possible; this commit is after the original report.

That said, there _is_ a double folio_unlock() in this patch, which
I'm about to send a fix for.  It's just not fixing the original report.

