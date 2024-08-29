Return-Path: <linux-fsdevel+bounces-27851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E54F9647AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B93B3B254F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4B9197A99;
	Thu, 29 Aug 2024 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="fwTDCrs2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HbaZH7w8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4199325757
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940178; cv=none; b=NCHHqG6jvO1jojPvJa/3K7LpXwnm/mlTju846OAqAw/ZNsYN95zlx4Mq4kN/cu0ONYR0h1AxCn5uD5HUfJjaAJmrnoK1zvCksyo2OU2+vbXvELhsteGNbqDngxtWlC+RCU4bsmSRYLXEW7Z5DvzqOFnuSNN/Uc9mwqi/cEyL3zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940178; c=relaxed/simple;
	bh=TegvpcMGxnOs26773Qb3GglCCdi1Aeea2lvhDyc6mVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFt0ssxs8c++t1SJuvoTGy74D48nasy1XVRTib81kGroW8f7l3WvTw6ecMekETSoye6KOhp8PQuAZ7xr7h+Pqyu8JJJhC3YI+mWaWRA2eazErr6SR8j7xOq6XtIxvROWPTIN7pbPSu+vwO8YUGmWqcUK6/B+fpxf6zl78vvu9L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=fwTDCrs2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HbaZH7w8; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 436EC1148026;
	Thu, 29 Aug 2024 10:02:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 29 Aug 2024 10:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1724940175;
	 x=1725026575; bh=+xydFtP9JIisV9zl6SJlwPkpdUzwPyWEb4oYo0Ailpw=; b=
	fwTDCrs2dn5q7JU7I2EoWrvOcRxRrSAOUKMTtWiAdYy9FTZDdTcFuxk2ivkIgDIm
	iY4lVd9dsI03UYBeoTZ3WG5tHU9bPHcmlA5XIiNYXvILlcQttdnGCkadiLn+PYoz
	cP4yAi4KSXIbfOO8LwITEs3zZybh8m6y+d7ha+hW2ZHMZyL9/g+7TQCIlLUxQ+Mv
	PQbHMnLHI2hQA2VMlpmQOBEgCd8xYwI0fB0QFMy2uEpCjw45BSbg6OUf5kRAFI2M
	7zzG0DpSp/IwfQL92JSjusFkr5x2klCA4hFtG4mcu7VGjagfVwJkpNxqZNpaoxs1
	7z7PDhI0HbSdcjJU1fd+1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724940175; x=
	1725026575; bh=+xydFtP9JIisV9zl6SJlwPkpdUzwPyWEb4oYo0Ailpw=; b=H
	baZH7w8u5v/2ua6ZqRZnOQU37uVaUuJEj06bWhVqWH1SNzJlcVWj/h1mmlU/tzY9
	tofOz4//RSdNj+9+i/yWRm61oHtjSK2MfYpHYbKgegaUWIAOHEW8Bt/NpvzNMFUy
	YV7Jk5GhrSkSGuZSOGwXEESe/L1OuyKglUNAB0vW70lovUlYb7lFh5WZlkr3SGfW
	nfPClDTL8gRMaioboyix18c1UlEYplOQBc7IpCRl54ui9crYBu6PHi7iSHpJwYhY
	gxJrunEjl08Qo5IhSNX3YViinHTs71ckhC/j60gNbwwt2V0EcgVVrYn6zcVWtATN
	poi0yvmY4y2ogxjzgkjaA==
X-ME-Sender: <xms:jn_QZtSL3QEMVlUECQiLe5S49JiO8e6ezVg5g2VpGxTiWf__ytFRFw>
    <xme:jn_QZmwdW97faz6S4a9ZdzqnEnZuKHBpp9CuuSqesE5RLJ4dzi3OJZsxXDiHEGkwz
    -swUa6TatNVUyPD>
X-ME-Received: <xmr:jn_QZi3nKkiZW4UMimpyloqxXCILc7d37wHCMM9dXM_HT3K4iF7-m18ger4tgfFJXAOJvfvLk-JPfTc6_2cUSw51wEQ61W9bodAiXP_VzJpRsFIuQ4bu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfg
    tdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohep
    sghstghhuhgsvghrthesuggunhdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvg
    hvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhoshgvfhesthho
    gihitghprghnuggrrdgtohhmpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:jn_QZlBIVq6hQTN4orQKjlxt_7Y5ixFq9wW1_NEky2z-Jk_xPetjjA>
    <xmx:jn_QZmhuuAWm1gN8Qpik2BNg_a9UaCq2Cr6DGx4rXqvSD-0id0SQCw>
    <xmx:jn_QZpoOf5vioQ6zJ4ANl8sOKOtq2OnU49midgvfb-PfgvC9-8yx5g>
    <xmx:jn_QZhglzdC8L4Q2FnTOUtrP7KiZUotGrTo-T0cUTV3d2NTPRm9NFA>
    <xmx:j3_QZoZIXMTE7Yfd75IG5KXfJYxZzM5lF-FybqSoGNr_qRr_0ancO67M>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 10:02:53 -0400 (EDT)
Message-ID: <a38eee36-0ce8-4afe-bf2a-99a6fb990ee3@fastmail.fm>
Date: Thu, 29 Aug 2024 16:02:52 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fuse: Allow page aligned writes
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "joannelkoong@gmail.com" <joannelkoong@gmail.com>
References: <20240812161839.1961311-1-bschubert@ddn.com>
 <a71d9bc4-fa6f-4cfd-bd96-e1001c3061fe@fastmail.fm>
 <CAJfpegt1yY+mHWan6h_B20-i-pbmNSLEu7Fg_MsMo-cB_hFe_w@mail.gmail.com>
 <b3b64839-edab-4253-9300-7a12151815a5@ddn.com>
 <06c60268-9f35-432d-9fec-0a73fe96ddbb@ddn.com>
 <CAJfpeguuPQ-8RfwY1DQWgtz7poLrRtNrL4CrM8zYH5FLY40Orw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpeguuPQ-8RfwY1DQWgtz7poLrRtNrL4CrM8zYH5FLY40Orw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/29/24 15:45, Miklos Szeredi wrote:
> On Thu, 29 Aug 2024 at 15:07, Bernd Schubert <bschubert@ddn.com> wrote:
> 
>> Sorry forgot, additionally we (at DDN) will probably also need aligned
>> setxattr.
> 
> Hmm, that's trickier.
> 
> I'm thinking that with the uring interface it would be possible to
> e.g. give a separate buffer for the header and the payload.  But
> that's just handwaving, would need to flesh out the details.

New fuse-uring rfc should go out today, but I plan to do another change 
after that to get the buffer layout closer (or hopefully exactly) 
to the existing buffer layout to avoid differences.

Current uring has fuse_in_header/fuse_out_header separated from the 
request, but then there is still the per request header. 
We could change it, also for non-uring, but it would be a rather 
big change. At least for userspace. My personal preference would 
be something like

#define IN_OUT_HEADER_SZ 128
#define REQ_HEADER_SZ    256

struct fuse_header
{
     union {
        struct fuse_in_header in;
        struct fuse_out_header out;
        uint8_t in_out_header[IN_OUT_HEADER_SZ];
     };

     union {
        struct fuse_init_in  init_in;
        struct fuse_init_out init_out;
        struct cuse_init_in  cuse_in;
        struct cuse_init_out cuse_out; 
        ...
        uint8_t req_header[REQ_HEADER_SZ];
     }
}

And then actual data would follow after. Would solve 
changes in struct sizes, up to IN_OUT_HEADER_SZ and 
REQ_HEADER_SZ, but rather cumbersome.


Thanks,
Bernd


