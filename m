Return-Path: <linux-fsdevel+bounces-56957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE7FB1D125
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 05:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B486818A8627
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 03:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAE81E285A;
	Thu,  7 Aug 2025 03:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ss16KIfq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E393C1D5ABF;
	Thu,  7 Aug 2025 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754536103; cv=none; b=WXmYqfeiNg7Ns32WvKyHwNKNDVYitxO/92vYzDXPKMYdHBgGIkd0VCZKHb6vvJEdYfH7f+qohzlOD7KFZmjl17dEO2ileqTuWe7VvCOn3zQfseVq4dg0LkPN9y3jgJoFiQUGE/YJhMLq5Oo1BRKGbVcJ4rCL//S4ognQhTDzz0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754536103; c=relaxed/simple;
	bh=WY2EhGfiUl1uE0qy34wSO3JErruJR865/J+qREdKGmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U71OMeOZJlu5nA/h8v2hDGYKTKPnljI9l7BTcDzJl3gtof01UoDd5nQVI9tnxi7QnkOZti5EtDX6F4HmBsS674xDW8lmUV6Pv75SBk3Ac2Mc4XSwm64CkB+mOwMX+QFQMeZKZB6NJHnj3t1YwxTw4pNMCb8aIeLSUisTmUDHysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ss16KIfq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WY2EhGfiUl1uE0qy34wSO3JErruJR865/J+qREdKGmk=; b=Ss16KIfqBX1jUo0C5UJegCeOJt
	xveApjcQWUE9xwvjhf3PyJVlcG7R9r2I0iCHn+wwDNrV+Cqedn26vxiIYK8Sfge6tZckj7wnSwSbV
	e3hab71djSuq88isAjLjIdReOW06/RHGdSvfO//RyPpzUKf9h3ud87KJpXbopb0jYooBT/7uEIajx
	QLKDyI5Xb9I6ugB6WUb4H1KyFMLmb144fQLZcIDq5b08lcKyMv9vEHIZ8D+OGGp7Y2KpdGuabopxz
	TKZu/fTPh8pseDEzCjTbwrqj4BJlXRQa8fnDtAoudMn+Gsg/Su9O46uCO6GS0JTbXs1FYBgJaGTVc
	Q3KZsBNg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujqzJ-00000000JSt-2hut;
	Thu, 07 Aug 2025 03:08:17 +0000
Date: Thu, 7 Aug 2025 04:08:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fscontext: do not consume log entries when
 returning -EMSGSIZE
Message-ID: <20250807030817.GH222315@ZenIV>
References: <20250807-fscontext-log-cleanups-v3-0-8d91d6242dc3@cyphar.com>
 <20250807-fscontext-log-cleanups-v3-1-8d91d6242dc3@cyphar.com>
 <20250806190751.GG222315@ZenIV>
 <2025-08-07.1754534735-core-snowplow-plaid-exiles-anemic-gulls-v9Da77@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025-08-07.1754534735-core-snowplow-plaid-exiles-anemic-gulls-v9Da77@cyphar.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Aug 07, 2025 at 12:46:17PM +1000, Aleksa Sarai wrote:

> It felt odd to use "return ret;" at the start and switch to "return n;"
> at the end, but feel free to change it when applying.

s/ret/err/ would take care of that, as well as clarifying the intent -
not that "mutex_lock_interruptible() returns 0 or error" hadn't been
the basic common knowledge...

Anyway, that's really nitpicking at this point.

