Return-Path: <linux-fsdevel+bounces-38017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2579FAA00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 06:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F59166372
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 05:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4252016EBE8;
	Mon, 23 Dec 2024 05:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="d9VnBWnV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC3B18BB8E;
	Mon, 23 Dec 2024 05:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734931367; cv=none; b=hqWI5fpyWUWxBg49+v0RUnXCBwiyafuazV6hJpdbhwGynaY4pv4UzWtG+N6Pbh83d8fgXjFDr5GYVhqf2BEcCr8373/kcIU0mm1dKC9MLyE5/6lCkcqrs1f2A1hi4LZ4Z03Z5dT1J+6KvR3qQABsJEW0HvyfCzqf4aVZ6l9nKgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734931367; c=relaxed/simple;
	bh=4pPS6YtgXBHX4uTzDRhOtQosPluHpsW256nb91eWP9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWVWEJaNtcMX1h2tm/MUkhVF5TmWceFeEZuqAEglwTUE6hJ/aNBM+o2nedRG7y8YsIekP6AuAX0Ej70RyeJDmN6mz3SQohTSFc4MDJGpun5Ayk4gDR5fliAzohsM99sj1cmOp3pdLp57dHXhFPXX0c0FmILW880y5q+In+Jkafs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=d9VnBWnV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N65vpPHaHdNWl8oLbny3RBW/+aFECD7pa4OxA5r0yGc=; b=d9VnBWnVH57Nfhebw8yPs2Olje
	C/Y80cmDVyz0qfRqGSQDngpapX7Bm3uV+Gdnx1zbpr5oxRgxKj6sOEi38zZmIImHn2VQ6H0GoXje5
	xqAKS1iWjFmpj5WbTMaeB38o7a1jWuaET4H635f1+1OGUYuoCHT5Vt/CDuQuHKsfwsuOlS6LdnkMO
	v3agqyGwXSAjLE4kLmoxMJd7rMFtailHV0I/+npR/bh1SogTghIOneLzg2srlyeRZ91VKL5ZXHsFc
	SDb5vMtj/M+2MH8WVj03qbZ8z4qEbUzUBfc5ZYd8cajDjlsZGk3EAemv+Dyb0bZ9J6ApwcE2mcZ5U
	mrVfG9lA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tPatv-0000000BCez-3c5P;
	Mon, 23 Dec 2024 05:22:43 +0000
Date: Mon, 23 Dec 2024 05:22:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11 RFC] Allow concurrent changes in a directory
Message-ID: <20241223052243.GL1977892@ZenIV>
References: <20241220030830.272429-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220030830.272429-1-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 20, 2024 at 01:54:18PM +1100, NeilBrown wrote:

> Not all calling code has been converted.  Some callers outside of
> fs/namei.c still take an exclusive lock with i_rw_sem.  Some might never
> be changed.
> 
> As yet this has only been lightly tested as I haven't add foo_shared
> operations to any filesystem yet.

It's still fundamentally broken.  You assume that shared lock on
parent is enough to prevent the parent/name changes of children.
That assumption is simply not true.

