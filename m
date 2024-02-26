Return-Path: <linux-fsdevel+bounces-12784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA06C86723B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0171F2D040
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 10:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D906548CC6;
	Mon, 26 Feb 2024 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCHy+XLL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4629148787
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944691; cv=none; b=CjLBi9sQQ7SyZPq9L85zP1VJkxmxfBi22WEAw5U+3QV7FtuTzCHYZNyJpdmDsDiuA2F/KFhKiCC+ZK2fE48fUNRyptLsPVMDjrztYDb2j0O9xs7cu6mK+3A3leyhV6bizyEdR4itl4LoDmAwzJlXJJv7ftUIJRqJropEyCBX8V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944691; c=relaxed/simple;
	bh=JjitD2yfeUHed8oT05nnbBoxgfpobxj9GGJmDnVFs+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcWPrPlqKJ5Bav4WMO81k4hEj1FILfwpaCJNr8zKrLVxu76uigZq6MLAantu+Av891eAjdw150viPbH9pnRHq1jvYCHZ5thA/tT0DK/gnaxIR+Lc2JSOE6aA7FEaHNuAW8beXtf497zPvli66SQbLTXHtRppMpCmwSOeySkWpWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCHy+XLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B715FC433F1;
	Mon, 26 Feb 2024 10:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708944690;
	bh=JjitD2yfeUHed8oT05nnbBoxgfpobxj9GGJmDnVFs+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cCHy+XLLlwoN8n+pQY8nzI6tGr1T3YR+LuV5y/p1CDtldn1KZEeo5kC8wzXpmHMsS
	 IDy6E6Sp4JnqvRt8cb4HYxAANHyIoWjsTE5uyht/bV1qBhmjJviyAL1gvPH6nBgDfB
	 RF9Bp3owHwld1JIFguZHMkx4/00zAWYS1T4sSCqCFXQagZwnBNRY0DSFoPsWnv0zgT
	 zX/nQA9GjqsilibBvYAuHGUEz7QWVMQHHHmRiL/GnxvT35AdqYgd4BwBlWWs4W4vyi
	 Q/atRfwUh/OMaXYD2Lvkx2XM32VxhRVZOvMbN3Xbx1lrxc9qQSgjW88B4Umu7nuScl
	 Ti1PwDuYJg1Tw==
Date: Mon, 26 Feb 2024 11:51:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Bill O'Donnell <bodonnel@redhat.com>, 
	Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Alexander Viro <aviro@redhat.com>, 
	Bill O'Donnell <billodo@redhat.com>, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH RFC] vfs: always log mount API fs context messages to
 dmesg
Message-ID: <20240226-zulegen-fallpauschalen-f27a9319aa10@brauner>
References: <9934ed50-5760-4326-a921-cee0239355b0@redhat.com>
 <ZddvIL4cmUaLvTcK@redhat.com>
 <20240222160844.GJ6184@frogsfrogsfrogs>
 <20240223-semmel-szenarien-cbf7b7599ac0@brauner>
 <20240224015845.GO6226@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240224015845.GO6226@frogsfrogsfrogs>

On Fri, Feb 23, 2024 at 05:58:45PM -0800, Darrick J. Wong wrote:
> On Fri, Feb 23, 2024 at 04:56:34PM +0100, Christian Brauner wrote:
> > > Can we /please/ document and write (more) fstests for these things?
> > 
> > So fstests I've written quite extensively for at least mount_setattr(2)
> > and they're part of fstests/src/vfs/ and some other tests for other new
> > api calls.
> > 
> > A long time ago I got tired of writing groff (or whatever it's called),
> > and it's tedious semantics and the involved upstreaming process. So a
> > while ago I just started converting my manpages into markdown and
> > started updating them and if people were interested in upstreaming this
> > as groff then they're welcome. So:
> > 
> > https://github.com/brauner/man-pages-md
> > 
> > This also includes David's manpages which I had for a while locally but
> > didn't convert. So I did that now.
> 
> Egad that's so much less fugly.  Do you think we can convince Alejandro
> to take some of that without so much demands of splitting things and
> whatnot?

Maybe. I'll make a note to return to this at some point. Hm, I need to
update move_mount() again. I just realized.

