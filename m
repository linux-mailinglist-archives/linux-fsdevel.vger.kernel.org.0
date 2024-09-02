Return-Path: <linux-fsdevel+bounces-28257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED71E968971
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 16:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989561F22733
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 14:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A378210195;
	Mon,  2 Sep 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="PX6JQw+N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D9D19E992;
	Mon,  2 Sep 2024 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286061; cv=none; b=TMzMBPhDub67m5ExAFA2I3lOCuoNOjy9XhW6Kat/o87DLAfFxRZyYP9MOFK/H1yRwnevw+8QXF3trYa0S3OYtO66DbQh4gXPfTBt5o6EvYBuCxm2rZVbXwAZe0Y+2pq4tgksazV+BksYecuZ6NxbsZ9xasbqg/O2fmiapX3X/vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286061; c=relaxed/simple;
	bh=+/UPlFMaAq5gLKfLwgisGqB+Y16NZKUz6wSMIpBVEnI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RrOWL7vn4TcJ6vAJ1QjrKDhDC8SwDKh40qnh22cHcxOpByDRp60Z5Smz4J+l2OcTP3CrmMxSXBWIralprZoT0NdaREzfL/n6p8zIUhzCaOCy5UTLOHRplI9OHnB9nByPQO2oR4vK32ddR8SUiCoIHqVYDoNvDknR4REypTWuNiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=PX6JQw+N; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DF6FA418A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1725286055; bh=QWc1Y13ydYZB7h7+cUcpghnJ2c0RtmcenUjX78aFysM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PX6JQw+NC0k3lK4CM+m6IAaXsrQb33IN0FRC6zoplOWRFcXR/uraR6FHkZokKoaql
	 chcVWy5Dvet0nkcqGXdVRdWdQpVMz88ygoJZJvOIkmv7kU5W5YzU5c+5Hixl8JM+EK
	 QswM3xSZksU5aCvjysMyOALQiChqWui0zDTBuVZJxy/QM/5jT/AHnBDC/x9rI/nIPb
	 04CmZcX9kuNstEK4rL2IsQonk4rM/qKXWPFiB8m9A+PJcvMOBat/UZw7GA9U/RhodN
	 PTfZ+au+v1126wrzmke7Ssl/4JTLHoYypq6O63YpDKT6Tk/v+0N+mfCNqGF+uK9a3k
	 Q2T3PBFHAlYgQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id DF6FA418A0;
	Mon,  2 Sep 2024 14:07:34 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Kent Overstreet <kent.overstreet@linux.dev>, Michal Hocko <mhocko@suse.com>
Cc: Dave Chinner <david@fromorbit.com>, Andrew Morton
 <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Yafang Shao
 <laoar.shao@gmail.com>, jack@suse.cz, Christian Brauner
 <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
In-Reply-To: <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
References: <20240827061543.1235703-1-mhocko@kernel.org>
 <Zs6jFb953AR2Raec@dread.disaster.area>
 <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
 <ZtBzstXltxowPOhR@dread.disaster.area>
 <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
 <ZtUFaq3vD+zo0gfC@dread.disaster.area>
 <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>
 <ZtV6OwlFRu4ZEuSG@tiehlicka>
 <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>
 <ZtWH3SkiIEed4NDc@tiehlicka>
 <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
Date: Mon, 02 Sep 2024 08:07:33 -0600
Message-ID: <8734mitahm.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kent Overstreet <kent.overstreet@linux.dev> writes:

> You're arguing against basic precepts of kernel programming.
>
> Get your head examined. And get the fuck out of here with this shit.

Kent, this is not the way to deal with your peers in this community, no
matter how strongly you disagree with them.  Might I suggest calming
down a bit, followed by an apology?

Thanks,

jon

