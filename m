Return-Path: <linux-fsdevel+bounces-27435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F012B961849
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 21:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362A91C22E35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 19:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C221D3640;
	Tue, 27 Aug 2024 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="sKZShOio"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07A21D318E;
	Tue, 27 Aug 2024 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724788740; cv=none; b=hXWsp3QybEU9PLltyrLDbBC+NoW6WeyrY44rpGN3oi5B/T8IzCZlDvbv53IzQcHCm5FCH9Nzcgznr69qWQGREJZwGxXvYPyn7QPnp/BMaqMVCj+25ATwDxndZBwxDSzMy+fyu6iyI6xm0PYZDCN6nCQ3C4KhLARceY868xRNQfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724788740; c=relaxed/simple;
	bh=79Wy4990U5+ACAgLZJtukWndwWdUtDEuehTjLakTktA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYPTbkxHjuaNJBrbblH3QqOp19u8Ub7mCxA9D3lc3d5wyq8iWhNvhv1EHkfI2kGyzMzgYw5eeg/7dhuoZppmf8SzmYlc2K0ioyZZ2XZHX20wrBcNFwll0GvR79vHXIgou6TYzrKMTPUovDvN2zDO36McMC+3XZ9EdpJ20gBYXzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=sKZShOio; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 5511514C1E1;
	Tue, 27 Aug 2024 21:58:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1724788736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gnImlVYxTHmpkmEFgvN6q4f1eiqqHxJTkuzCyeQ6ZA4=;
	b=sKZShOioJBhejkG1/gZziebNy9sGtzAqp9mG0hCodcqXWnln8zAhyG+7/vGa8BKIPB/+Sz
	X7mVhsJmxFg9XFaeU3j9hIHGfNNCHn4UGZhSHmKMtIy00DNzkfQOsOI54Wev7s70XEDdg6
	vd8cF0iyb4TTIVHXWwwJLA4Pxmm98Oi5FJBSe2GLx2277bJN7b4syiKlgXUI3CMdtSV7GN
	YrOJ0o6Nn4Aa3d3pj/8wEsKnMYRYV7kyzbtlZL5kaPAro5knSONFN4docvwUkfhIepupT+
	PnKYilgevshsMeOivp1dO2qnFF8wK0VjDn9J29VibVCYUtZaj23JHbTMPxF9bg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 591bc950;
	Tue, 27 Aug 2024 19:58:48 +0000 (UTC)
Date: Wed, 28 Aug 2024 04:58:33 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Ilya Dryomov <idryomov@gmail.com>, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
	ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.10 083/273] 9p: Fix DIO read through netfs
Message-ID: <Zs4v6aV4-VpIqdfy@codewreck.org>
References: <20240827143833.371588371@linuxfoundation.org>
 <20240827143836.571273512@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827143836.571273512@linuxfoundation.org>

Greg Kroah-Hartman wrote on Tue, Aug 27, 2024 at 04:36:47PM +0200:
> From: Dominique Martinet <asmadeus@codewreck.org>
> 
> [ Upstream commit e3786b29c54cdae3490b07180a54e2461f42144c ]

As much as I'd like to have this in, it breaks cifs so please hold this
patch until at least these two patches also get backported (I didn't
actually test the fix so not sure which is needed, *probably*
either/both):
950b03d0f66 ("netfs: Fix missing iterator reset on retry of short read")
https://lore.kernel.org/r/20240823200819.532106-8-dhowells@redhat.com ("netfs, cifs: Fix handling of short DIO read")

For some reason the former got in master but the later wasn't despite
having been sent together, I might have missed some mails and only the
first might actually be required.. David, Steve please let us know if
just the first is enough.

Either way the 9p patch can wait a couple more weeks; stuck debian CI
(9p) is bad but cifs corruptions are worse.

Thanks,
-- 
Dominique

