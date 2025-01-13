Return-Path: <linux-fsdevel+bounces-39065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDC7A0BDE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 17:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5239118891E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 16:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADFA13C8F3;
	Mon, 13 Jan 2025 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wzUl+D7e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7D824023A;
	Mon, 13 Jan 2025 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786763; cv=none; b=GVUwt2zvkCkjjyJg2kvF2lYPPFSAdu9NXQaq3f9kb6I+pyViOipStCg3JXbIKqXrRsxta/WwZOn7NODmu1DKKV0ZUyNR3u8NzCznxjqYGwFd0dwx6S+sJgel1jx6ODfv4NoXQD7+XnIU/08RTto0DFzZzI9AukPmFWdNIQYhYh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786763; c=relaxed/simple;
	bh=3Oe4ZfUTyaxllR7LHbuYrP3MnMnwYGp7FVC5w6DIgiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u90FnJ8pWvvkMHlSHPxAxfDK6YC4llJhoGD9p4az2lxu1MdxWsBoGMzWwKXuwn0RDaELsao9J3vcTFM+Fhnj4l0OETPz8koIw9X/Y16PJrPzbqre4MEWkS+0pYC0vyVfSRieYu3Y4VhHQhNcbChQYUz9RmUp78CWxfr10qLMihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wzUl+D7e; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=3GWgRQxag0TRYv/8+ieBkjd1Rb3+drajvd4ZFBIv7eI=; b=wzUl+D7erEiYQXyK9jEddb+VDO
	ASBSmtktkz0TPt7jAQgB1WQxjUWkXBnDO8boid4QVViMyxv8wdxXvghxTwGpphm2LFd8S8Wi/rH+R
	8l7VnVvo4rH6+rM//KEIRduabCIIigGVVcaLnhcLbBMl3l+ldkENePPAQQPQX2FZBfkXb7RXhcMS7
	XufU9TFCh4VdiYoeMDzPy6mCUYAGolYoxmdNqwKq3l7Zkgd838yXdi5xKHit6G7WCOORUk3zrrOP8
	N9udl2K04FYD5jaec9EXr/HWtboK1kuUt0MbezDam9O0xyNytFlGzAHl2UZwPKpXhB0UjHWItbO3a
	1IYgdsPA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXNZN-00000000yZp-0jwg;
	Mon, 13 Jan 2025 16:45:41 +0000
Date: Mon, 13 Jan 2025 16:45:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 27/30] fs: Add iput() cleanup helper
Message-ID: <20250113164541.GY1977892@ZenIV>
References: <20250108154338.1129069-1-mic@digikod.net>
 <20250108154338.1129069-28-mic@digikod.net>
 <20250113.juseengu1Po2@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250113.juseengu1Po2@digikod.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jan 13, 2025 at 12:15:05PM +0100, Mickaël Salaün wrote:
> Al, Christian, this standalone patch could be useful to others.  Feel
> free to pick it in your tree.

Bad idea - we'll end up having to treat uses of that as a serious red flag;
it's too easy to end up with lifetime extended too far.

