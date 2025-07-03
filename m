Return-Path: <linux-fsdevel+bounces-53861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F57AF846D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 01:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CEA47B8A55
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 23:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D272DCF74;
	Thu,  3 Jul 2025 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ow7yBgqi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF992DCF4F;
	Thu,  3 Jul 2025 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751586198; cv=none; b=OCvP2s8JR1iyUs2dYe4XuExO2K6tx2grpoj9a14YpG24xGEBulHLtWzsJ73bdJQPuXqdyH4tt40B2LBfLKYE0A8pvBYrtAipiBW9vn9dpGeF+JdnP1V9lLMgVwfXcT6QhqXbDk7PIBMwnv2iZZdXvkuEjM9Yl1D4I4caVgHKFUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751586198; c=relaxed/simple;
	bh=8L10Etk4mvmjcV6qVKhYd0smsEleEiS1H1uSp2LT2AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUHOAxrsMAJBv8o6h3/oemOLKNKAxl+e2Qwk3D+Hy5+MD9AdwBgoEQPppDEoQtX7fHbxqnW8BEEfAV9VjAUofWxVgIDgvfT2/8qxnyEam56XWnVM90ymjXQH4P75IiFSuW73irRaQorv3zT8sszXCVyDzHMgp6mQYS5Uo84i/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ow7yBgqi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zgNKWm8FllbZWdvMW9H8gUuH1SRQJuldiBv47Z04nmA=; b=Ow7yBgqiVyd9HUd0LzExpmY/88
	aaCTC6WnYdKds/H6sF0z62Sqg0JuncmAYxocL+gJB8T3+kEjmAQ/W/QkUCcC8g7jz1cmJdPvAAg+f
	TTfMGVqccK0LeoGJ05FgF30qAvQar1AI+LOKMS9sd4EYYyXPQOB+dBtPak82WpYZirPbz9/gEx0xF
	KgFztAB35Wsps8NdztJfq2XKJy7fDdKdMW1LjBzNQHNvpiOOQpBxOnVt4BMkjvmDkAyE4Y8NrpzOx
	SSyfgLpr+AcHOf4cO+M+IIVDmOR2tUNonEt6f28STl61iVncaP+9jg+GYlfDkjqk0mR61xBKxsFlg
	naNiRJOg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXTaD-00000007KR5-1YBE;
	Thu, 03 Jul 2025 23:43:13 +0000
Date: Fri, 4 Jul 2025 00:43:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>,
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3?] proc_sysctl: remove rcu_dereference() for accessing
 ->sysctl
Message-ID: <20250703234313.GM1880847@ZenIV>
References: <175002843966.608730.14640390628578526912@noble.neil.brown.name>
 <20250615235714.GG1880847@ZenIV>
 <175004219130.608730.907040844486871388@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175004219130.608730.907040844486871388@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 16, 2025 at 12:49:51PM +1000, NeilBrown wrote:

> The reality is that ->sysctl does not need rcu protection.  There is no
> concurrent update except that it can be set to NULL which is pointless.

I would rather *not* leave a dangling pointer there, and yes, it can
end up being dangling.  kfree_rcu() from inside the ->evict_inode()
may very well happen earlier than (also RCU-delayed) freeing of struct
inode itself.

What we can do is WRITE_ONCE() to set it to NULL on the evict_inode
side and READ_ONCE() in the proc_sys_compare().

The reason why the latter is memory-safe is that ->d_compare() for
non-in-lookup dentries is called either under rcu_read_lock() (in which
case observing non-NULL means that kfree_rcu() couldn't have gotten to
freeing the sucker) *or* under ->d_lock, in which case the inode can't
reach ->evict_inode() until we are done.

So this predicate is very much relevant.  Have that fucker called with
neither rcu_read_lock() nor ->d_lock, and you might very well end up
with dereferencing an already freed ctl_table_header.

