Return-Path: <linux-fsdevel+bounces-11348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FAE852CEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 10:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22851F23563
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F1353366;
	Tue, 13 Feb 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K2X6gYDC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7431552F83;
	Tue, 13 Feb 2024 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817384; cv=none; b=on7nNiBxY3O42FvgrxYLDou/HFchmaLipQWC0bRSBbxMwzhO0mTs0Eob6fpl4V0JjqLaiXlLbKHLx8NFEUq51iJ+hwfq68LxFmdWYiALdkzd8a7uN5TEnlKKNiYnBrcQ6CxMY0c4LyCKSE8n8ly39MY+qL54YEmxRSXf+ZMXEdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817384; c=relaxed/simple;
	bh=QpTYMbV/On63JHEAg+7gEa8nlefPffxwNn6vcdnnLGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYB3XOUdXQGW65sqqhZPlyqy6j2RofTt9rlVLrRj3ElSzxsnigoMfpaM9vLNy1/xKAKWAqtFeKf46/YJqxcISSslISptDapkxVHq/s4+Knv9U7bucw6ob9ko7JmzK1Ipyt3vvK1JcVElQfUs/Ze8MqD0r42vBVFU73f7Q0n2who=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K2X6gYDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575ABC433C7;
	Tue, 13 Feb 2024 09:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707817384;
	bh=QpTYMbV/On63JHEAg+7gEa8nlefPffxwNn6vcdnnLGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2X6gYDCmsXjOXHrQHqlESxPVKAE1j3B5raB7tjWKI59nnQeHDkdp7+44+gAk1xHQ
	 vk8lkx//bMQWk1MDnE1SSUrOGe34c026khjTAU0nf+MHtQRpyEXn1phgf1MC/Q1vt7
	 pGhCsFwAQmvdhHTCl+1QYMY3kNGnj8q7YI6IIY84=
Date: Tue, 13 Feb 2024 10:43:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Karina Yankevich <k.yankevich@omp.ru>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>
Subject: Re: [PATCH 5.10/5.15 v2 0/1 RFC] mm/truncate: fix WARNING in
 ext4_set_page_dirty()
Message-ID: <2024021331-skyline-dicing-c695@gregkh>
References: <20240125130947.600632-1-r.smirnov@omp.ru>
 <ZbJrAvCIufx1K2PU@casper.infradead.org>
 <20240129091124.vbyohvklcfkrpbyp@quack3>
 <Zbe5NBKrugBpRpM-@casper.infradead.org>
 <20240129160939.jgrhzrh5l2paezvp@quack3>
 <d25ec449ffce4e568637a418edc4221c@omp.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d25ec449ffce4e568637a418edc4221c@omp.ru>

On Tue, Feb 13, 2024 at 07:07:18AM +0000, Roman Smirnov wrote:
> Is there something else to do to make the patch accepted?

What patch?  No context here...

Also, for obvious reasons, we don't apply "RFC" patches as you yourself
don't think they are good enough to be merged :(

thanks,

greg k-h

