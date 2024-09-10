Return-Path: <linux-fsdevel+bounces-29055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4F2974395
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 21:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5527228D255
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 19:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918591A76D1;
	Tue, 10 Sep 2024 19:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YnVxhK2N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4998117C7CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 19:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725997082; cv=none; b=DiNQjUVP1P1ulfsbHzelQMy6O9T2z4C1iOyoadrrtkSQQ8xIJb9RNMQMtLBXNwLU/+HVhdzaiz+snQgFR3oiFey63BdT/wGTnc8BrKRqUuNV9NMZIQjkz+MeQgAYA+9fWT4X65sDyeQ82ZogOOUGnfCi6CplxtwZP7Qh2R13zwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725997082; c=relaxed/simple;
	bh=zz7VkGJwIOEzToa+PR/Cbp9y3j4yAwF9jm2YXuy5SG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUwjcKxegcSMzPiEQFYmYppRyX0IWyiy/RyqMBiDHCzCO/IwQ75enbWFHUZOm2pMEckQC2vZDdlKrjkOmOZ6RnD352ma1W1iv/pHipUlLBezho8JxPsPuSXOYpby4SKomMFB/89xiQrQy2P7EgCuK6gts4io7rf9hIuk6aWMT/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YnVxhK2N; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Sep 2024 15:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725997077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uwF6WNjv+64m7Y/xYevSxpjj6a6C720ZalVCVxXofIQ=;
	b=YnVxhK2NvUmB33++CPXRAbch8KVrXQqZPaP8iitDUDVApLGs+sjgyI1AU52bkVZgZ5Suf7
	K50hTHv4ZJUHPCJpGBiOqFXAeDAvDCtQf7xZelrXg/doiSLJYcmdkJE8OgNp0zQxE7WwA1
	qYcFvlgZXyjptwHpYs+UKkMVHBxKiyQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, Vlastimil Babka <vbabka@suse.cz>, 
	Dave Chinner <dchinner@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-bcachefs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-ID: <4fhhgnadehlfkjcmycwj27apokgrbqjz2cs44fhfzu7nfe2ask@s7vswmwqvev5>
References: <20240902095203.1559361-1-mhocko@kernel.org>
 <20240910122912.e7abfa39b0fd7683fbaf2325@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910122912.e7abfa39b0fd7683fbaf2325@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 10, 2024 at 12:29:12PM GMT, Andrew Morton wrote:
> Thanks, I have queued this for 6.12-rc1.
> 
> Kent, if this results in observable runtime issues with bcachefs,
> please report those and let's see what we can come up with to address
> them.

Andrew, have you ever had to hunt down tail latency bugs?

