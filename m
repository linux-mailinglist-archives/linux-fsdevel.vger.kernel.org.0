Return-Path: <linux-fsdevel+bounces-22891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C85891E615
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 18:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E0C2820CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 16:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7310816DEB1;
	Mon,  1 Jul 2024 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NFsLX3JJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758EB43144
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719853170; cv=none; b=gVPAdu+3gJBGtxlDxiGufzcRuWk+haGSVgVNlg2Hbx9JsO9TxZyiXbz2IjmE9V//sG8Ub2uiCkUPY8Exi0wWjmXqphYAeMHieaCcwdml5ow7nCeiOb4EVoysr37e6ZT/V9TIdA7TnXLE/bHoSlqBTYAXW2GhVD3WZ0Sp8w8u4o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719853170; c=relaxed/simple;
	bh=NxGDV2UXiI6SgpNk3mwgzCzv4qUKPPKAxrQz2AJfZcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Apvu0JhdbFPIe6WYLglgT4vKKbF0gTenm4u+oGwEtS4fR6q0SXTuEqNHvS/kmwIDwL4z99JMf+PyEf01+Dhh/NHHhIGCYcqeT18r2s20lV8CcdhRK1e/H+lpS4Av1oat/MdxT2VGXAdSgZiy2onP9A7Pz9Jerjc3HxfERaE7kNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NFsLX3JJ; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WCXMN6V7BzlnNDt;
	Mon,  1 Jul 2024 16:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1719853166; x=1722445167; bh=xcSwD1+ucfk+WitMGjIfeTVP
	mRK+EdOA9xJZ+Q12B+0=; b=NFsLX3JJu5zgtziPSqcA58uYXCjyM1v3Cy+at/yF
	R8ixDrtAKidvygr1m78rPFaX3zeVte4JAnHittMoqPFxwTbsgX04yVbtPcluhbUG
	12qrIPo5PILcLhYJQG2V5djuhGYew8GbfF+EdfDxaSzntfb8/LszneVdabBFZMY+
	CJyR8sfL4Hovcsw/NV603Y/Ck+2ULV4L5HTa78BKgf/5OJ80mkSsdS9VPOjtoOb5
	1J64sFyh2oI6xYMIQh+GVYJ4m7HsxnKs+dRPLm9UKZuAyLJsPGzUwDEHK1WbsGq0
	a60z7mpyHJPHgxTYzhk+nKFhec6LOmvDr1GM+9eqE2T8iw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id NGtHNXf-Sp6I; Mon,  1 Jul 2024 16:59:26 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WCXMK3yK0zlmb8s;
	Mon,  1 Jul 2024 16:59:25 +0000 (UTC)
Message-ID: <e1a19990-d2d2-4870-bf49-6c2ca26e76d0@acm.org>
Date: Mon, 1 Jul 2024 09:59:24 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fixes: ec16b147a55bfa14e858 ("fs: Fix rw_hint
 validation")
To: Hui Qi <hui81.qi@samsung.com>, jlayton@kernel.org,
 chuck.lever@oracle.com, alex.aring@gmail.com
Cc: linux-fsdevel@vger.kernel.org, joshi.k@samsung.com, j.xia@samsung.com
References: <CGME20240701025614epcas2p16db7bb7616cf8be284034ae7fb35275d@epcas2p1.samsung.com>
 <20240701032110.3601345-1-hui81.qi@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240701032110.3601345-1-hui81.qi@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/30/24 8:21 PM, Hui Qi wrote:
> The high 32 bits is filled with arbitrary value.

Which application does this? This is a user space bug. Additionally, the
patch title looks weird. Please improve the patch title.

> If hint is set WRITE_LIFE_SHORT (2) by fcntl, the value is
> 0xf6d1374000000002,
This is a user space bug. The fcntl() man page clearly mentions that
F_SET_RW_HINT accepts a 64-bit value. See also
https://www.man7.org/linux/man-pages/man2/fcntl.2.html.

> which causes rw_hint_valid always returns false. i_write_hint of inode and
> bi_write_hint of bio are both enum rw_hint. The value would be truncated
> only if the element value exceeds 2^32.
> 
> Signed-off-by: Hui Qi <hui81.qi@samsung.com>

If you want this patch to be merged you will have to add Fixes: and Cc:
stable tags.

Bart.


