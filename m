Return-Path: <linux-fsdevel+bounces-65864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A88C127D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 02:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11C05E4D05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 01:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE6A21507F;
	Tue, 28 Oct 2025 01:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bYrDOiVt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A701758B;
	Tue, 28 Oct 2025 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761613356; cv=none; b=kFrYkSKGz2HT598K2rzJuLM9hNno70lO5dQkDpTQz2d3pnNOvghZGpoalppqYKnVaqJbtxc++kpwqoN78H4936cGIK0odn34yBFQTHlUwOd/T6/oCrHEVMD2GuDFl2S4eNoh0tM3NGBi0Lgkpr6qNpxyCGGbuJioAujbFIuHK94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761613356; c=relaxed/simple;
	bh=+rrlVZSuOxU/mzFNB78NdIvNQMdIXjvCZ4f3YDQ4Vy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9E+tu6qFf1zO1UB42vpqxyPUFi+W30W3Gpe4p+6sRL0EwpKpehMUZ2HB2PnSJPrRYYLwykrEzJy+MBIwt1NVmG4bNpl+9ebN/yi56IZsA4xiDq9Xt1vyvjB8SimYunuiaBDU9qavBVLKCMtOPAy64EeNyuceR5WRJd0IO4Oa7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bYrDOiVt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9wyoIZYTrVDDO7g+99sSfbwUrHDKLElCNrsKfYNRevE=; b=bYrDOiVtr9EnBCfWeyaRKsN0Rf
	zO8thzgRBHKXhYx/oORvEyK4vY6Lh/KF4IU6ZB+15g7s1PWyfACnJ8ZUB6uKhzi/ywkiIYACjMEUA
	fOg/T6QctXpDZBgXPrUjGIXpN74nbg7sXP6WMlKmHnvhs7IHmvDQ4fSsxsB2yNVu5WDBqRWQs/4mu
	VqLVY7LfZpSLOBTqqDWt3Dj48aR9TI4boH4iE7d+iH4XNY+K7frisMFDEpM2MGAIVw+TcCyv2B6mW
	kN/vCpaOPX8rpp+QhOzxzUmHJjhY2L3aZJAJ7ZO/UnNOyL+2oM21W4iRjm1spaIvxuG664KGPM+x2
	2gK54TvA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDY3h-00000001wen-1zTr;
	Tue, 28 Oct 2025 00:59:33 +0000
Date: Tue, 28 Oct 2025 00:59:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
	a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, paul@paul-moore.com,
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com, selinux@vger.kernel.org,
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Subject: Re: [PATCH v2 00/50] tree-in-dcache stuff
Message-ID: <20251028005933.GK2441659@ZenIV>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 28, 2025 at 12:45:19AM +0000, Al Viro wrote:

> Compared to v[1/50] 

*blink*

That should've been "Compared to v1:"...

