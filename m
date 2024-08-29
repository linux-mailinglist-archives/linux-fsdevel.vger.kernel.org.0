Return-Path: <linux-fsdevel+bounces-27781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6625963EC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 10:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81DB5282A59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 08:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6919218C002;
	Thu, 29 Aug 2024 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSL85Yxx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F451F61C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920692; cv=none; b=I4xZNz4dfsn+dC32oMM2aT9WX5Q3T/ldtjx0USJMiBex5li2ceq6Lhsa+x8JcDY1XKbiZP9NSmWVzhK/AVhF5K+5JBCTp3hunzf7PbG7vfv65j/y9qoUFdNZ/j1fOFRK4VuyaiLQqF9xP0cnasomyGdWq6rOanh/QmqtS0R6jE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920692; c=relaxed/simple;
	bh=RsnYS7nA3Lirail3brEDk1VZXPrbAAt3M+Xr5WMgDAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J68IXHjeMnY1YMDW0zVY9zY5vhfV/RAFqV/ouS8Mou/P94vdiYVGfcAlaAPOBVsujShos6GESLDmfdIEhzesA7dlOQ89LqwRfXUrxEE9zt3KYnLvd3sHAyI4Ki4Rc/QDO6HggSQciB3Hx0etjU0ygBIpSyhs3o72qxM3KijlJcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSL85Yxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AE6C4CEC1;
	Thu, 29 Aug 2024 08:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724920692;
	bh=RsnYS7nA3Lirail3brEDk1VZXPrbAAt3M+Xr5WMgDAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VSL85YxxLPQj70ZOSeuRlILahR+FPl4fVy2ddkM1i/TVtSNqMG+LW5xCUeGdZ4kd1
	 x5dZKpodSzEN7jgG7c8xdywDUU+/qoAXg+V+SSkUzVRVtFzPOo6dyYF0vZchbuS0jZ
	 090oEL7XhW7mvBnHYEHduugwEb6wXBKoISe6XYfITntIacgIEhpDhMFYmG801IiWSu
	 Eh4kHti8cDdmJVmtDoPQoEaa4ycMrfpzmck3s9g3ubEjI2G3Ui5JqJsnCladcv/RbK
	 hbkgfva0t57H4l85ddG4qdyy32Y344Z6eIaavDg/GfXHgc5DK7gfus805sy2MhS3W9
	 NgwEeaE2WzmyA==
Date: Thu, 29 Aug 2024 10:38:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm: remove unused root_cache argument
Message-ID: <20240829-cremig-keimt-a84819d2e292@brauner>
References: <20240828-work-kmem_cache-rcu-v3-0-5460bc1f09f6@kernel.org>
 <20240828-work-kmem_cache-rcu-v3-1-5460bc1f09f6@kernel.org>
 <2590ea60-12f1-4b7a-a5b5-bfb7c3906e30@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2590ea60-12f1-4b7a-a5b5-bfb7c3906e30@suse.cz>

On Wed, Aug 28, 2024 at 05:05:11PM GMT, Vlastimil Babka wrote:
> Ad subject: "... of create_cache()" ?

Done. See vfs.file. on vfs/vfs.git.

