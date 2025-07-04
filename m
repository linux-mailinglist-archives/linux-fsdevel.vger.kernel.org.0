Return-Path: <linux-fsdevel+bounces-53876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE6FAF8580
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 04:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DE84E7B60
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 02:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88921DE3B5;
	Fri,  4 Jul 2025 02:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="T/IWDRbr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001CB70831;
	Fri,  4 Jul 2025 02:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751595589; cv=none; b=SDw9iNGVOe/sHfM3qDTUxzzVT5SRHsp0HcXmT5+9PHeCuRYxi20HBnbIqS3/etMvDfOh51xy0LfEQbIt+BLBilytH9B7rD2r/8jurC6h8lidn+B2o91YuFvKLy3D25Y5JUGZsayFAkzPypiS7e5/jcRPge9KCDkorPYtNHaDzaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751595589; c=relaxed/simple;
	bh=SnitO76j/PNai5HaO9BKt9HyiIzJgxN6vdzT36QJICw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvhQRvbRTmfb0g+Vdfh23Ec/H7DjrkfTYe90eeKyswT+SzewkKI/lyeCKmu+TS4uGY5tZe9Ea46WE4sHRrGPvmIEiPw1Li2dywKq2Z1mKyJed7Ui3mvVERBkENl8Ma1bt7z/zwk9ZOHSs4osNluvWA5hbX4EnvJIMujsSX9g+X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=T/IWDRbr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mq6iOR4iGSoS9yJVF0A2kBCn4Wq3Jldn68COS/xqcVE=; b=T/IWDRbrB97CYWYjp9msDt1JCP
	zsMiXYjXS0J+3b+EorhIeNmD1FzuUri5ocMDNWrGnFjyuxl3FP8jHGxrYKU2bd0PR2v+6Ni1YaLJs
	C6abLlTd3v7h/vTzDs1J5+acuG8sXtkUknoRNh0KlHiY/lGrDgYpGX+KCGeSLs/aaXvmlzEv02kf8
	1vzG1PvC7WBXH9G+GG37u7sZMWFGDsIHsN5hhuwJJLaWx+OYx06yt4Sb9AWOUejLuZ18pNg4iX39Q
	5lSkcLomx/MyLpc44ftZdwg0aoIhroJc6yz5e80DUqHbhlbhNWwXfQ7FD0EIx3YjK4NP2nDqd8f+t
	6emi14UA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXW1g-00000008LRa-1US9;
	Fri, 04 Jul 2025 02:19:44 +0000
Date: Fri, 4 Jul 2025 03:19:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>,
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3?] proc_sysctl: remove rcu_dereference() for accessing
 ->sysctl
Message-ID: <20250704021944.GO1880847@ZenIV>
References: <>
 <20250704010230.GA1868876@ZenIV>
 <175159319224.565058.14007562517229235836@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175159319224.565058.14007562517229235836@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jul 04, 2025 at 11:39:52AM +1000, NeilBrown wrote:
> On Fri, 04 Jul 2025, Al Viro wrote:
> > On Fri, Jul 04, 2025 at 12:43:13AM +0100, Al Viro wrote:
> > 
> > > I would rather *not* leave a dangling pointer there, and yes, it can
> > > end up being dangling.  kfree_rcu() from inside the ->evict_inode()
> > > may very well happen earlier than (also RCU-delayed) freeing of struct
> > > inode itself.
> > > 
> > > What we can do is WRITE_ONCE() to set it to NULL on the evict_inode
> > > side and READ_ONCE() in the proc_sys_compare().
> > > 
> > > The reason why the latter is memory-safe is that ->d_compare() for
> > > non-in-lookup dentries is called either under rcu_read_lock() (in which
> > > case observing non-NULL means that kfree_rcu() couldn't have gotten to
> > > freeing the sucker) *or* under ->d_lock, in which case the inode can't
> > > reach ->evict_inode() until we are done.
> > > 
> > > So this predicate is very much relevant.  Have that fucker called with
> > > neither rcu_read_lock() nor ->d_lock, and you might very well end up
> > > with dereferencing an already freed ctl_table_header.
> > 
> > IOW, I would prefer to do this:
> 
> Looks good - thanks,
> NeilBrown

See viro/vfs.git #fixes...

