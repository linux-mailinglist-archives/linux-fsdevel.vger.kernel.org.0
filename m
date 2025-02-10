Return-Path: <linux-fsdevel+bounces-41419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4149FA2F47C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 18:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6EC163BAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 17:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5098F255E49;
	Mon, 10 Feb 2025 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AVUHrXPI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2C624FBFB;
	Mon, 10 Feb 2025 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206822; cv=none; b=onssGobh8UAbSha15c3rNTxf+8Ahs7rFFnPV11eo5avmHUxqLAXq9QVsaBklzO5Ikg6LaGlxkr6HFWX0InA06egm+L4ar7G+P4lY2g8hGWqnDY/zclNI+X3MdgJUQatt7efIxy1ts2fcB/P/f8AMDdZwbWOQRiMXSNtS1kb7pyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206822; c=relaxed/simple;
	bh=rO0JRWBaYP8RPL9Khbv4P0/RCh3JELHU5FgN/G1z4Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zx+mtmL+bVVe5YTaVaZWVpDkrYX8FfRfArvDX6hut/tZSy29G5aZYw/psjcIzr/jC+K6JKkhamDyVD7Pl3JLTNBR+wslKZraTgdWeTBF7dWoEhdx/PauyBl65Rd3eFnxTCI8NahcrpIbGfZipvIqtAdzMkPcfIHDy4fShZE//2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AVUHrXPI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rO0JRWBaYP8RPL9Khbv4P0/RCh3JELHU5FgN/G1z4Ok=; b=AVUHrXPIUB1PM4gwbWgTcDQsV/
	Yd9eVqQbskGtBdI5sSpP9iDV0cvNwVETw/P5AZ6icYqsiMBRXtYp3cU+jDvCNglUJTE9PYHb3IA0O
	PZAPrZvY1waDH4eEjxoI4v1ILyywpqEUCj3tw7XoNW1mkl/O0JK9woFMHuUJim0b98EbBuEEFq/Sb
	ZYorX5A6ptUrBJ7NALsqXHMgZACXTV9jD8wcrgmudNzOT79hI8TVffHrMInjOIWHIXlr2ZdYt6Ppp
	o8o4kqknj5nfb4nyIdYkCDcwo9Ew4x8PJaraMz3K7zypYtziWbdLkq8QPen8UzkpFBmoTX6OOvb2k
	vEBqtdgw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thX8q-00000009dX9-1QaO;
	Mon, 10 Feb 2025 17:00:16 +0000
Date: Mon, 10 Feb 2025 17:00:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: David Reaver <me@davidreaver.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, cocci@inria.fr,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] debugfs: Replace dentry with an opaque handle in
 debugfs API
Message-ID: <20250210170016.GD1977892@ZenIV>
References: <20250210052039.144513-1-me@davidreaver.com>
 <2025021048-thieving-failing-7831@gregkh>
 <86ldud3hqe.fsf@davidreaver.com>
 <20250210115313.69299472@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210115313.69299472@gandalf.local.home>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Feb 10, 2025 at 11:53:13AM -0500, Steven Rostedt wrote:

> No it will not be fine. You should not be using dentry at all. I thought
> this was going to convert debugfs over to kernfs. The debugfs_node should
> be using kernfs and completely eliminate the use of dentry.

I disagree, actually - kernfs is an awful model for anything, sysfs included...

