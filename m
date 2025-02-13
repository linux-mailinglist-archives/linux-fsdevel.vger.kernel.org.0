Return-Path: <linux-fsdevel+bounces-41673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D65A34CBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 19:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3DD16BE50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 18:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10856241664;
	Thu, 13 Feb 2025 18:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kLRdeKr0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1000811CAF;
	Thu, 13 Feb 2025 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469717; cv=none; b=GwGzvhPxxFZG3gItuKWBPMi6CEMzf5qfI6LLlmz9Wq5AdRPalobxKiIIC5CK4CsI2uw/nHh9+TzdwFS9jkUOGqXEdm0ERF9PJ+98hIz8ctByy0+uI280+uXVyof1FfsweLSbu/PN53TrjxP+7FlwYXKB07aqVgXUeUgjdmIB3Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469717; c=relaxed/simple;
	bh=iyhqa4FySUjQ5g0GozFIhZ9M1QVxH9ovbvFV+x1tQmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWz4+bfDvvStC+GXLEqc0Z5xdWi7qBlABFtu0wcRkBv9AD5mg3uW0HcWbCo2WZaO8hXaxWBeqTY19sm7sS2amADi/lkRk5A19qvFvJtnMdA/SRZ+CEvnM5dZEEF2yWjOZofuIciEWzxatRLiMlxbdN18/8BV8Iv6bdUtbNhwqcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kLRdeKr0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N/YGsSevGDKmsz4LAefFC+UEHA9OmLmk4wbOJrxTVu8=; b=kLRdeKr0dKZDhXr64HOZS652ZS
	2waUMiIGGakszULoeykRUGX1NpC8m6N8tg5U0gvYm131ahaYGnHDv21o9kA/7mfCmovSepwGAOab6
	OCNFt1XG9rIiYuPeB6eTpdKg6kQUu8dlpIpTIgrM+o3zH+nKcLTqOIAkJ/8dao8RlVprldUV8Q31/
	zcuyGJa18scY52Y9Hb6oF1I+CCAp9AA7yI0VxFgmSqLEbX6OpQcRWYmv7nh1uSV3ZBbXvSjnXScUH
	Za39SwzC3209qdTpPFFOrahPRtmdvf94XrhIGxTQx633u1P0xA4MCAr1FzENW9Dqu8cNc5USrf1DX
	hyWx1Eyw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tidX5-0000000CwYA-1VgB;
	Thu, 13 Feb 2025 18:01:51 +0000
Date: Thu, 13 Feb 2025 18:01:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/19] nfs: switch to _async for all directory ops.
Message-ID: <20250213180151.GW1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-20-neilb@suse.de>
 <20250213035116.GT1977892@ZenIV>
 <20250213040931.GU1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213040931.GU1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 13, 2025 at 04:09:31AM +0000, Al Viro wrote:
> > > +	} while (PTR_ERR_OR_ZERO(sdentry) == -EEXIST); /* need negative lookup */
> > 
> > What's wrong with sdentry == ERR_PTR(-EEXIST)?
> 
> BTW, do you need to mess with NFS_DATA_BLOCKED with that thing in place?

That'd be NFS_FSDATA_BLOCKED, of course, and apparently it's still needed for
the "not busy, not sillyrenaming" cases in rename and unlink...

Nevermind, just looking into getting rid of d_drop/d_rehash on the AFS side
of things.

