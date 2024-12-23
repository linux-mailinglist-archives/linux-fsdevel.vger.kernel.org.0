Return-Path: <linux-fsdevel+bounces-38020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DBE9FAB09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 08:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CAA27A1CBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 07:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E59B18C03B;
	Mon, 23 Dec 2024 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ozbJE22D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B2C18052;
	Mon, 23 Dec 2024 07:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734938820; cv=none; b=AMlOLSeDmNe/WH8js3mD/yaVbF0baDs1kXA0hn5IpDgKBYeMXpwFKTeauxuviumGpwo46/xD4Tl70ay1pn3GWwBbzJUUMZny/3i5aJsAtFkXMqbUCM3ZslRA7R/wi8HuouVlb+7SDktif783t5q8YrlBmIxweW4ofTscN4T2MYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734938820; c=relaxed/simple;
	bh=xO9DN8kG0vPM3hET1A3eaxsIU/5WuAWDNmU9A1ZvZSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzT40/OtXi5lr631v9EOxTXa9XFLW8H7st6znyn3ngD0De6qoXpqxXp7Eq/OH/RZfJepEeNzenWYQgoRP7+z5ZuLc+F1qyD3/Y2qKVUpbbDVI23N+W5SYc2upWLPW0s/IGL3PreMiDDjYQr2pAbPuvGippTpZM78VhlyA43dtdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ozbJE22D; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vHT6TgirjIu+wDyge7kent2nRx1RNu7A5awLiLh8a+E=; b=ozbJE22DZHceDgEbJCKOGsS1pW
	ftsMu3lFf3Uhncq6dV4gV4794y/6pWk8mp/YJi5npUT17UvAyNUz8uRgf12zz/JraitauUU9sRTQ8
	NUqywzDPM1IOxvXhW1X/YWbxTJPzyyac78VsYsuiVpcafsuxiP7g7V3luH6qdidKE8QL9HxJL6Q/Q
	tJQWtMzVJjIUf/1rxBTA6ij9mVKffrCgWpAKWlwzZppuhRlXwdteY4DXH8bs7faW9VHtqLZKUsZGe
	d0pgF9XO7tooEkGjV+aRhii3WlRESd7nxQy6t28JVUf88eXh+Aal203fgHMC7V6yGpCn6jhKidf1Y
	kwxyD0AA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tPcq7-0000000BEKG-1uKD;
	Mon, 23 Dec 2024 07:26:55 +0000
Date: Mon, 23 Dec 2024 07:26:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] VFS: take a shared lock for create/remove
 directory operations.
Message-ID: <20241223072655.GM1977892@ZenIV>
References: <>
 <20241223051941.GK1977892@ZenIV>
 <173493787613.11072.4293875424077013617@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173493787613.11072.4293875424077013617@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 23, 2024 at 06:11:16PM +1100, NeilBrown wrote:
> ... Yes, thanks.
> 
> So I need __d_unalias() to effectively do a "try_lock" of
> DCACHE_PAR_UPDATE and hold the lock across __d_move().
> I think that would address the concerned you raised.
> 
> Did you see anything else that might be problematic?

That might work with ->d_parent, but it won't help with ->d_name
in same-parent case of __d_unalias()...

