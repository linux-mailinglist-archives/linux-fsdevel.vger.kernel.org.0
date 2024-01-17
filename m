Return-Path: <linux-fsdevel+bounces-8201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A57830E3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 21:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF16A285C83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 20:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46012554E;
	Wed, 17 Jan 2024 20:51:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE14B250F2;
	Wed, 17 Jan 2024 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705524705; cv=none; b=FLHdsm4NSuiZVYPwLHDpAwIh95gcbHefK0lnbytrJ1GFYGeSwZZMUgIElbN8ZZfyidOSPad6pNxDwwJt82D7ViwtSTdE7TEFcWMsYGIKD6QFGd1nKj2DLfe7EqTRcoIzjD5Zjz9GBEWyks1dV2xmQDRC84yMwVLOXLlgJX04w3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705524705; c=relaxed/simple;
	bh=4JnBt5A2h6l14DAoNYQRG+5RfhgnLIK8Ki9AnPYuK4I=;
	h=Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:MIME-Version:Content-Type; b=gDWooUZ1X33fowhVtioOCnF563QTdLi2z8dNSeQZIPmtXvzuiDiZ7y3N4yVm6EoN3carXTw/j9F5OPieMuh31bFIbmfETysxeBcwMtQWToMdWK648luW3z1yZDtUVM7O1ZjdUqbRWqfti6lca+RDbFYZBODRym7t+JqQaHIs6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=pass smtp.mailfrom=thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 3AF89153C25; Wed, 17 Jan 2024 15:51:37 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
 lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
In-Reply-To: <ZafpsO3XakIekWXx@casper.infradead.org>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
 <20240116114519.jcktectmk2thgagw@quack3>
 <20240117-tupfen-unqualifiziert-173af9bc68c8@brauner>
 <20240117143528.idmyeadhf4yzs5ck@quack3>
 <ZafpsO3XakIekWXx@casper.infradead.org>
Date: Wed, 17 Jan 2024 15:51:37 -0500
Message-ID: <87il3rvg2u.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthew Wilcox <willy@infradead.org> writes:

> We have numerous ways to intercept file reads and make them either
> block or fail.  The obvious one to me is security_file_permission()
> called from rw_verify_area().  Can we do everything we need with an LSM?

I like the idea.  That runs when someone opens a file right?  What about
if they already had the file open or mapped before the volume was
locked?  If not, is that OK?  Are we just trying to deny open requests
of files while the volume is locked?

Is that in addition to, or instead of throwing out the key and
suspending IO at the block layer?  If it is in addition, then that would
mean that trying to open a file would fail cleanly, but accessing a page
that is already mapped could hang the task.  In an unkillable state.
For a long time.  Even the OOM killer can't kill a task blocked like
that can it?  Or did that get fixed at some point?


