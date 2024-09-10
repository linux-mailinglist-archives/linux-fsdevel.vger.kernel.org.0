Return-Path: <linux-fsdevel+bounces-29054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B44697437C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 21:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0365CB248AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 19:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EE31A7072;
	Tue, 10 Sep 2024 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2OIFb3CY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3745197A6B;
	Tue, 10 Sep 2024 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725996553; cv=none; b=NEdyURIaqKhLaJlyh6fGgPwErrsjzQ3665uo2q/KfNfOjIjQZXanbBBFvhEB+mFsvYWFNAmHc3CEQX29+EK/96U9cZcRUW7BWi7J/68DK2PeR0DQTCkGu5HjIRkxGb3TNyjCQVa14YsLjoOSKIm5Y7f2VNcThkp33j0guh/xYOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725996553; c=relaxed/simple;
	bh=eVJOBrGIgKMsQ9dRJJ17aRlya2kVlQB7lhg8bZJyxrA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=syBR6FkYiB4lhhTHwSspI3oNNFFwYHxfPKHZal5UN22SFHf2b7NieYXlryDZbIt0i/UbO1BISRuAJrxZ6i8FA11oJHZ2gbdST0kGVic38krngHMx+9/RrfLKjB1B5mlOh/6K7hVJcAtM2D9gIyYssMGz7qwBjKMXUlNOdB8Stjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2OIFb3CY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CA3C4CEC3;
	Tue, 10 Sep 2024 19:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725996553;
	bh=eVJOBrGIgKMsQ9dRJJ17aRlya2kVlQB7lhg8bZJyxrA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2OIFb3CY+9jlZVXS1NcMNPiJCPu5Kh1+AilRZqnQGcZ69nKHdj8KJLRM8hHngKZRJ
	 pScE3yPfr0BBraPSsoGwnWHDr3biGc8lAswjgNDxWvA+0cDFQCQc7wSpFs9z06zoBN
	 v6FzUbHEqSqWqH8RuGw6dQo2vvkh36Wm50RGEmvs=
Date: Tue, 10 Sep 2024 12:29:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>, Kent
 Overstreet <kent.overstreet@linux.dev>, jack@suse.cz, Vlastimil Babka
 <vbabka@suse.cz>, Dave Chinner <dchinner@redhat.com>, Christian Brauner
 <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-Id: <20240910122912.e7abfa39b0fd7683fbaf2325@linux-foundation.org>
In-Reply-To: <20240902095203.1559361-1-mhocko@kernel.org>
References: <20240902095203.1559361-1-mhocko@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Thanks, I have queued this for 6.12-rc1.

Kent, if this results in observable runtime issues with bcachefs,
please report those and let's see what we can come up with to address
them.


