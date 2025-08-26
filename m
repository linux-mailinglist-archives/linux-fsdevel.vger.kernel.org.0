Return-Path: <linux-fsdevel+bounces-59289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF834B36EF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C26463E6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB68730ACEE;
	Tue, 26 Aug 2025 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="t7aqt5gF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AD4368089
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223149; cv=none; b=f4BbESNoiIacn4s54h0AZ5sZHvg4H/lpJI9vs8x6RRhAP1ZF/b243SrYFbpQYNz80kC6wJ5no2YeJSS8eGLNkHgTtQdR9yVfhFdAj4S6Yh1EEASOxYIOce/UW/IDvfLWh9+2okorlIm2B3x8F0Cw+DUTJLMcEZcvuFltJjCTHs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223149; c=relaxed/simple;
	bh=9E/TpdeEZIs8ZjDNx/aYHRiG/BSBf5AfxiqZPnPiKEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnfTv4IuFSm1kpRCfJXd37PdssRa/9ja4m30IKu4gkqIwsLzNJIamgAUHIN6NE2aVieS6UtYM8CI4hbnNbjcf5SqtVy8imBf9clPo8Xcs0i/4E6uHzwp5QypPjloYCOSdaThm/Zm8sEmVcYLHYfsaSow44dWBANtKDRyYIDshQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=t7aqt5gF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fNHLj8VL1AESwBguG2OTCnB4ZS2D0PSSirYLStA5aHg=; b=t7aqt5gF9RpaI91jEL7iKQQsXh
	eUrMGXwc3sKh3xzK8QwKYy1N2dJP5A9EGDZIpAMJqe0FNOMU1YdoMJN39NDcBqo9QTYm2rhBCRs4K
	E1WeAxzi0bKthVPg1268jx6NVmWLih+2vmHDKX3awmHWICNHiZaAanzpe8WdQKnNkyUxSeQJvy2jl
	YG5kSUVme7GfCGyf3CJXqgEiY7hi5a+oW2xoRv/0Abtw0tduzXs7RVc+6q/YPzAayua+b3JFWOCZS
	gM0mTtX/jyvZzQmJYvTlZmGEN0X+gxod5RZa0eP/k0EmbUKCB1Yd0dprXEagWpgSIKdcHHKMMJ4xY
	BrLq+73g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqvrk-00000001PLg-0Pwk;
	Tue, 26 Aug 2025 15:45:44 +0000
Date: Tue, 26 Aug 2025 16:45:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Askar Safin <safinaskar@zohomail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 02/52] introduced guards for mount_lock
Message-ID: <20250826154544.GS39973@ZenIV>
References: <20250825202141.GA220312@ZenIV>
 <20250826151745.2766008-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826151745.2766008-1-safinaskar@zohomail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 26, 2025 at 06:17:45PM +0300, Askar Safin wrote:
> Al Viro <viro@zeniv.linux.org.uk>:
> > When the last reference to
> > mount past the umount_tree() (i.e. already with NULL ->mnt_ns) goes away, anything
> > subtree stuck to it will be detached from it and have its root unhashed and dropped.
> > In other words, such tree (e.g. result of umount -l) decays from root to leaves -
> > once all references to root are gone, it's cut off and all pieces are left
> > to decay.  That is done with mount_writer (has to be - there are mount hash changes
> > and for those mount_writer is a hard requirement) and only after the final reference
> > to root has been dropped.
> 
> I'm unable to understand this.
> 
> As well as I understand your text, when you unmount some directory /a using "umount -l /a", then /a and
> all its children will stay as long as there are references to /a . This contradicts to reality.
> 
> Consider this:
> 
> # mount -t tmpfs tmpfs /a
> # mkdir /a/b
> # mount -t tmpfs tmpfs /a/b
> # mkdir /a/b/c
> # cd /a
> # umount -l /a
> 
> According to your text, both /a and /a/b will stay, because we have reference to /a (via our cwd).
> 
> But in reality /a/b disappears immidiately (i. e. "ls b" shows nothing, as opposed to "c").
> 
> This happens even if I test with your patches applied.
> 
> So, your explanation seems to be wrong.

Take a look at disconnect_mount().  For example, if mount is locked (== propagated across the userns
boundary), it will remain stuck to its parent.

