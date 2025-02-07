Return-Path: <linux-fsdevel+bounces-41250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03652A2CC9D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 20:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1B9188A126
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 19:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2238918FDC2;
	Fri,  7 Feb 2025 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RnY+s4B1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8023C8CE;
	Fri,  7 Feb 2025 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956741; cv=none; b=t27B0uf6wYKCdIS4vELMgiB3CP1NNF0bhY/lgs3y/cPiPrj+1Y6gTAemZStgUpxo9MuwXjXT3JQybqmFFK+1a2GIWWsjglBTLpSGX8bLqOoGfmmTJ5FTwhFj3ZpuvTLEHmTz4Y0neeC9g2Y5ZklDbY6yUt+2/kEUg8CvthOrjQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956741; c=relaxed/simple;
	bh=BrTkFhO/nttI6rCVCRYbW1TGOD5aCdJGhsr3ZlbJoFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bq7XUMNxC4HlRRJ/6czl4kzAYEETFD+qs9oe9xDFY/KkfGyfIC4qUfqwChEiYD30KM6p/7RF3sLyUr0Fi3tgH9Y+Mje17/u4wNRCMqzQdZWKmEZwdLAt7+Ko0yL2Go5Pm7OibK/EG8PrYOjo/rxtfzyBa3gOi51fMAUzoOSuyH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RnY+s4B1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Sc1U51bEkTgu/7QT5kQPuPjsprGzw9QUDCsj4fLzTNs=; b=RnY+s4B1Ft1yc1wHDXhZp52OnZ
	WZsKhu/pH+LrcaVeIfhqLHWNh6NdPxOKltf9xWOT7wV80cyAq+OdZrPXs5coX+FAGy5MsZu54mwPe
	ElCrDT4gM+7YtWoV07nGZ4175NXuDwtBHRrgiC3E3m+p29p9XkJ+Qh+VisH/zMNnOZeX3UeXArVtM
	F5RFUlO0CD4Mn+RRwJQjZgegFsAWuAT2iJ/izviysOOiNjAmHjPeDe3yaI4srq8/xKOA01YIym6wT
	aleDXyzCg0DgGyK1mhqxd40nx7GgZLfHpTAn+pgFfTxhSqdKXEZK/bC7XrCj6Q8Dsa8uqYww9Z5/l
	R+69v0Xw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgU5H-00000006VMW-39Dv;
	Fri, 07 Feb 2025 19:32:15 +0000
Date: Fri, 7 Feb 2025 19:32:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/19] VFS: use global wait-queue table for
 d_alloc_parallel()
Message-ID: <20250207193215.GD1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-3-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-3-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

1) what's wrong with using middle bits of dentry as index?  What the hell
is that thing about pid for?

2) part in d_add_ci() might be worth a comment re d_lookup_done() coming
for the original dentry, no matter what.

3) the dance with conditional __wake_up() is worth a helper, IMO.

