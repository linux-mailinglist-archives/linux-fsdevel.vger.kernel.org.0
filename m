Return-Path: <linux-fsdevel+bounces-12642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEB586221B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 02:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B041C23D9B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 01:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0612AD53F;
	Sat, 24 Feb 2024 01:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGLCya6z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61881C147
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 01:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708739926; cv=none; b=FCI4a2Dlk3Iu0kyGpS/fF8RHtq9Y6bq5IG466kyUgHnnkS4tP6o+Oj4T/gq8mNVbZaaeXIEKawe9/tMrd0bCtexZfycsBXo3Yy1gNjGwzcnXUGJFDI4onXukjMfeO3hIQsrKWwEmdZ9tw8Zhhv673S3R0GQkXDFZSp/7UkF1WpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708739926; c=relaxed/simple;
	bh=1fPE5WJFWsnWk7OnjGmWrooKq02SldpVjanTTVAIqvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r62TErDeD8zDouIvnQyUcaZSJSIfUD3xyxEM57xHpfZ444/cnt6BJXTtCFUCMiXJ8oba01FwIN63OAacMVwm+0gMSOV83qjhoRtYcDqQz/E1fIeqSMaxucxid98C5tT7LPffJRExjo6SCJhev1Vr4tyVT23U/UK8XYARBHyX6qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGLCya6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCB6C433F1;
	Sat, 24 Feb 2024 01:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708739925;
	bh=1fPE5WJFWsnWk7OnjGmWrooKq02SldpVjanTTVAIqvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AGLCya6zDsSg5m9Q4yYws75yj4vhnkWKKDQy7LJIbq3KzlVybZ84aLWdG2ew809UC
	 ss0Fs5gc0LpuLuPmbIq/cGEQhDKkkeehH/hZ5UeSQX5e/mwAZw6Zc+x+mprP4pAX0z
	 rrSsUZW0yvv58AsFwfUbol55/ISBIVLRJof3Wjw9ZgqBu1RMxoVYiEDRm1CkDWlJS7
	 ripC8f7j2pokjNXq0S4sYtuZUjIRW0GQthDOyVX7597SghacG0Lys+9ODuM8Nw6q3V
	 HUWijc48H9RhOISBtQaadW8Ey9ifY/WqyCDY0dAL4a6gWLMVFopLIGtIhjar2tmN8N
	 poBst4C5tGFEQ==
Date: Fri, 23 Feb 2024 17:58:45 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Bill O'Donnell <bodonnel@redhat.com>, Eric Sandeen <sandeen@redhat.com>,
	linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Alexander Viro <aviro@redhat.com>,
	Bill O'Donnell <billodo@redhat.com>, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH RFC] vfs: always log mount API fs context messages to
 dmesg
Message-ID: <20240224015845.GO6226@frogsfrogsfrogs>
References: <9934ed50-5760-4326-a921-cee0239355b0@redhat.com>
 <ZddvIL4cmUaLvTcK@redhat.com>
 <20240222160844.GJ6184@frogsfrogsfrogs>
 <20240223-semmel-szenarien-cbf7b7599ac0@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-semmel-szenarien-cbf7b7599ac0@brauner>

On Fri, Feb 23, 2024 at 04:56:34PM +0100, Christian Brauner wrote:
> > Can we /please/ document and write (more) fstests for these things?
> 
> So fstests I've written quite extensively for at least mount_setattr(2)
> and they're part of fstests/src/vfs/ and some other tests for other new
> api calls.
> 
> A long time ago I got tired of writing groff (or whatever it's called),
> and it's tedious semantics and the involved upstreaming process. So a
> while ago I just started converting my manpages into markdown and
> started updating them and if people were interested in upstreaming this
> as groff then they're welcome. So:
> 
> https://github.com/brauner/man-pages-md
> 
> This also includes David's manpages which I had for a while locally but
> didn't convert. So I did that now.

Egad that's so much less fugly.  Do you think we can convince Alejandro
to take some of that without so much demands of splitting things and
whatnot?

(Thanks for keeping those from bitrotting btw)

--D

