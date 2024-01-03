Return-Path: <linux-fsdevel+bounces-7253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 722648235CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 20:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1561C20A74
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 19:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9881D537;
	Wed,  3 Jan 2024 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="wnu79S7k";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="B4k+m/q8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44A1CFBB;
	Wed,  3 Jan 2024 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 329E1C028; Wed,  3 Jan 2024 20:46:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704311162; bh=DYpAMKUEr4ZUo/A2V1G5Stqgcj7W2gBmNsNpjPAItNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wnu79S7kdE+HWljFIVMAS7Vk67BpQzcH/o34qldo/6irXMtO+faoEAyINGHxImOXX
	 9GP17leT7P1W463WpEJZkyiolgk52RwUBvSDdgQYZSlPA93YktS1I4MZNigEYvKvBC
	 Xk0YC9QAjdB9I5r1MXBi2OE/AsG90K1YZh/emHkgct2U+wc2yremZ4RwFLOcwAMujr
	 9sigwMmkv11kEXwB4THRJaP3J0I1fvAwnwFDvawq+X2g060DS0uESZGmYMxXT0JtuE
	 V3hB2WyD18x19osmXaW0egTf7IMBbX/p0vKGtZImTCyeKKt18MSd4XpeBgjHEcsMVL
	 NAdWTSCvrXIHw==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 13998C01A;
	Wed,  3 Jan 2024 20:45:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704311161; bh=DYpAMKUEr4ZUo/A2V1G5Stqgcj7W2gBmNsNpjPAItNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B4k+m/q8vwyz1cmJjWarRzlV3PUa/4GYuScLc3MH9IP8RXLMxQgNKo26pq046ww1w
	 IXiwt0dLInSvuNJJhA69DW/3p05amxvZHcQYMeEGw4S0aXDDnM+hfwt6n23bW8rE0j
	 321wZwAkYtQ2G2n2+mY3DL2D4JIsNe02StYEJsq7JutX4onPpj3vRyZbc1iQzVvJau
	 BhSK0FEsTlhA3v6B2bG4rvREluC3TF7JpZvOXy8473obAqXXGRVKv9zNB9Ekw5yCRB
	 P1E0WP0KYgz5HWK4aIG7D+g2rhNpqeTEVLUtzx/r4CDXibmlMLGrVTN1XCxXzGJmdX
	 SKwuMgP0lMVHw==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 7038adea;
	Wed, 3 Jan 2024 19:45:51 +0000 (UTC)
Date: Thu, 4 Jan 2024 04:45:36 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH 3/5] 9p: Do a couple of cleanups
Message-ID: <ZZW5YEy0xiGp1JRT@codewreck.org>
References: <20240103145935.384404-1-dhowells@redhat.com>
 <20240103145935.384404-4-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240103145935.384404-4-dhowells@redhat.com>

David Howells wrote on Wed, Jan 03, 2024 at 02:59:27PM +0000:
> Do a couple of cleanups to 9p:
> 
>  (1) Remove a couple of unused variables.
> 
>  (2) Turn a BUG_ON() into a warning, consolidate with another warning and
>      make the warning message include the inode number rather than
>      whatever's in i_private (which will get hashed anyway).
> 
> Suggested-by: Dominique Martinet <asmadeus@codewreck.org>

Thanks,

Acked-by: Dominique Martinet <asmadeus@codewreck.org>

-- 
Dominique Martinet | Asmadeus

