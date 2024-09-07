Return-Path: <linux-fsdevel+bounces-28904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D20589703CC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 21:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2381C21043
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 19:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AD115E5C8;
	Sat,  7 Sep 2024 19:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JLhl3FMk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64FD17FE;
	Sat,  7 Sep 2024 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725735757; cv=none; b=kLnAeclWjcPKDrmx1X82cZouwVBT+s0bcjIQyqTSTPR8602ZaNzwYvJOv3/I1xWOEsi4ez4vFHgAAm/mdJIO52aXHs6QwpM7CekI7OnNXSr27C+iTNu0MJzc728bn4SarX51gZGj+xk2e5HIEvsfcpn4R8lXlEiF/hELTYotV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725735757; c=relaxed/simple;
	bh=8TG9Q9C9WUF4Z26jooEX1NVB5l7ZrAOabJP7qxyldoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BW5rcw/E+yq7sX/xaNCZMFbugXRoWXcnDur9iuT/Xg8JyEZxhvxspGPg2S16cO/i1kO4MlAMAIBjtadUcwqY4lIETJ1pLycUvsOeck/TEN1z/K6MW0RAd0RLCspA4IfJcKa+/weZqnXVKFjvI044hay//BwRIXQqZuJfs8QlCo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JLhl3FMk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8TG9Q9C9WUF4Z26jooEX1NVB5l7ZrAOabJP7qxyldoo=; b=JLhl3FMkkgP784HPXWLiR9g12+
	ppPw2boOxchkJQeOV/2zEHzFvG8lpyzvtyOGmiRNZBLL+qvyxNfq54C2E0/UVaEycEFmWFqdgEBvC
	ZFPSgzOCualYZ/W8fosy9ZA7RLflLOfOdIiFgZU+DquTRUnvTroE4rQgoRbdwg+p88dyhe4SjJVI4
	dE4V6UFljxv6x9Wtz4Rsj2w3dHNlqPAY6wM5JeePWW4wz8VYKe3/VaXb9NHHx9O4jnEGO4Biod36K
	QielkLEBMWNtqD6VOz84F6+31cAI66WWQc9wCJwDAJYotmdDi4JsG4lSv8LjoSa0UbDLu6Uf/B5ie
	QKr3eNBA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sn0hc-00000009vQe-0REG;
	Sat, 07 Sep 2024 19:02:32 +0000
Date: Sat, 7 Sep 2024 20:02:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+41b43444de86db4c5ed1@syzkaller.appspotmail.com
Subject: Re: [PATCH] VFS: check i_nlink count before trying to unlink
Message-ID: <20240907190232.GI1049718@ZenIV>
References: <20240907172111.127817-1-ghanshyam1898@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907172111.127817-1-ghanshyam1898@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Sep 07, 2024 at 10:51:10PM +0530, Ghanshyam Agrawal wrote:
> Reported-by: syzbot+41b43444de86db4c5ed1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=41b43444de86db4c5ed1
> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>

As far as I can tell, you have jfs_unlink() find and remove a directory
entry without any problems, then find that the damn thing had corrupted
inode link count (presumably due to creatively fucked up image).

IF that's the case, NAK.

vfs_unlink() is *NOT* the place to try and cope with that kind of crap.
What's more, having unlink(2) quietly succeed and do nothing to directory
is simply wrong.

