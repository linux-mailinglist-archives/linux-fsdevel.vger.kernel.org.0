Return-Path: <linux-fsdevel+bounces-40534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 284C7A2487C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 12:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E093D7A2444
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 11:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F97A1581E1;
	Sat,  1 Feb 2025 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMDG/lVE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D2F19A;
	Sat,  1 Feb 2025 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738408373; cv=none; b=QSkq6vPREoSLI+/xvcZGxFOUX0FgOLy9Qm8pKALZqJB+SMS+scI312nkBUxOxD1KzY9VHSvReABjT4szg65vcLi45VldW2fAkCSYKvXLte+J8wHLwvOk5hakFk2/P3O4NB5LHA2DYcNOBJ0I5K4JW+I4yPWMkJfAYjcx0KYIo8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738408373; c=relaxed/simple;
	bh=/A+9ioR6oxXv0tTTLfZfZoer4mvDdiifgkLG/Ak9mUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fk27BouPH7dsjpcNvNYTu0HBumDhTdgNoX8EM9Pt+61G4JVIXC1NjIA9ouYima7yLqMDMzFenAygFiryLEdTWHfIJ/QkC3bG7/9WQ7fKoef/U6LLnwc6V5cokvJZeOCKtm54PUt2mluTvwCneMXwsyWZoVkYn9uIQWsVY9e/1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMDG/lVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB8DC4CED3;
	Sat,  1 Feb 2025 11:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738408371;
	bh=/A+9ioR6oxXv0tTTLfZfZoer4mvDdiifgkLG/Ak9mUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AMDG/lVEmnwNryWo4aqYuWEZYwTxgC6T+PE+WFAW+RjhqDSjvpRPLfiSpmKXtxkTY
	 qUnq1Pb6LjSecV6MAuvrOWPqau7c4g9jFCsosl0F4Y6lr63pYKfjnZjKUKhALJkHFQ
	 87fKODpk9a+4hhv61K5yKc8kXISMQXlVt7E4RLGR284RVdHoWCgxsP5nD5/CviKima
	 ezyfFS7V4F9Mci9YS+hNKx1b20cx+MnXJXkMxxnGWWCvdsJAsUmdEKX7axn5C82+IZ
	 RbFTxepM7VGJiRLnRvOqUTxZM7njEsxtzOWijhnfw9rP4gt4h3kwhIekf9khDzSrV+
	 EUyjZVOVfdYaQ==
Date: Sat, 1 Feb 2025 12:12:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Christian Brauner <christian@brauner.io>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Sang <oliver.sang@intel.com>, John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v7 0/6] introduce PIDFD_SELF* sentinels
Message-ID: <20250201-cremig-desorientiert-aac3b09da8e2@brauner>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
 <20250130143754.1b8bb87bfb15175dd434529b@linux-foundation.org>
 <b396487f-b906-410d-9ff4-6956d99e2771@lucifer.local>
 <CAKbZUD3w4_4MjrME-0mgRL01eFggb7et2BLa6012tzQX78KK9w@mail.gmail.com>
 <20250130153236.198664b9a19ccfcdb24f888b@linux-foundation.org>
 <7519b85a-cd04-4ae9-a8c8-3d16fb20582e@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7519b85a-cd04-4ae9-a8c8-3d16fb20582e@lucifer.local>

> Intent is for Christian to take this in his tree (if he so wishes) to be
> clear!

If you send me an updated blurb I can fold it.

