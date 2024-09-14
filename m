Return-Path: <linux-fsdevel+bounces-29375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5534978F9F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 11:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B31D1F238DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 09:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB17E1CDFD7;
	Sat, 14 Sep 2024 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="T2U6Z0RY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IBmuxhTD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9E71CDFBF
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Sep 2024 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726307585; cv=none; b=Au85E26Qclx2UWxvrOQaqDBxNNMX/OazCqkTza3jgSA7itxzP6aaFTFjfVcXvmidP0ff5R343TiBiq+wnMJtIW5r58AzxjTTSa7vllBw+xxBg3bHJPZbyw5MWpnSag0lKvW6RcjKe5BnGf57iuOyFArVlQ2/h66vOyxPnRpzj3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726307585; c=relaxed/simple;
	bh=B1p7JxHnbtK3vSAV4Z19GS6HEQd+Fyvdt3WUa3nPKOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1N9E9hVfxIyumm5ASSTHcsSAXlJ70y6bvQlbt08bb3rsUatTM2rbQ6/Xr3MqUi7qYL9l+EoIVdjS/SgXiKBa9WxA6q866L7GOs9fDH6wNyynR+NdxHa43vYS/h9ltqJYJOxuJPDKknbeCY/dYnoczA8j2r/0VI6o11e/z+Q9CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=T2U6Z0RY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IBmuxhTD; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C1225114022C;
	Sat, 14 Sep 2024 05:53:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sat, 14 Sep 2024 05:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726307582;
	 x=1726393982; bh=on+BaWfrA9lg3c6d2NnU0aQwJZbvaK+/pqZ7Rc6Mer0=; b=
	T2U6Z0RYmo4dcMegi8bzK7/R2ai7HLv9X+zyWfeYdBl45j+4y6VX7Tzjqc43VePX
	YjgvAV8PTvDNI/Crrigw60ajQt/MbmC9FdEdSTmLYLob7mo1TJfauZ407hRlXY/W
	CP9rrGJjqOz5AKmiqlufaXTzQkltxuh66czG8thNwb0e6RYy3ZLAJmJXlM0Cm2CI
	CVB6UqDkgcMAGwi9xuTeX5Wcs+aZOO6AtX6afDruZ+Q9u6xEvE3w4LCEhqLeQKE4
	E+5uWBOXeoaG4o3/kEGuoqD+lIpQpozz48Z6gF0voGMWeOZsfrISlsEmOzpfCHLT
	BJah8ngWBriLrq0WnxlYJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726307582; x=
	1726393982; bh=on+BaWfrA9lg3c6d2NnU0aQwJZbvaK+/pqZ7Rc6Mer0=; b=I
	BmuxhTDu5HoxfBs/93dVk1hF7ZSjFPh2oX9oM0j8i0O2bJIrHhRys10xkjE7RLBP
	ikdVCzHewetN2IwaCjyaUAalrcYz/+rrJwbO0LbNa51ZuG5OhGgipw3/FaQMnJCf
	jQcKlnysEEsMO8QRwmIecTuKC6Pwj+6vA9x9GNyI1aqpegPLa64FD0CBy/0Vd2OX
	C6INqn44vug0soF1ij7DdKC6+r7ntUb90nXeW/e8EPFEumEDl7xq+4mXA+X+zWZ2
	30Iyl9gj+cXTk5UYI8KZ6xq/KSOT+4xtwqdYLag7eQ2wBmgZRLs2hsZ5yk28r4B8
	Ivxf5BS948J51nUeost1A==
X-ME-Sender: <xms:_VzlZgV37u7r6rZ5yL9bWKXFuv84KZ94xg67X3a0Hwo3uLcW3qbV2A>
    <xme:_VzlZklHCVHlZTw6SzNCevwsdrqsmblv_UAclSYld_MHvAeG94cdykHKpjJOZawMp
    2uE8WBUnCgYD_4_>
X-ME-Received: <xmr:_VzlZkZIq9PL-3vYbZ4OmrFBJ5_jmTmQIKY86qTnkT5lJWWyvAn_rQvZ4ZQLY_08M8BxGzFw-L4dN6zbVGlrmNQkP677_zniErJNKnliC_uL3J75PkaM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudektddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfg
    tdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopeihrghnghihuhhnhedtsehhuhgrfigvihdrtghomhdprhgtphht
    thhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepsghstghhuhgsvg
    hrthesuggunhdrtghomhdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhigihirghokhgvnhhgsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:_VzlZvUVSJy3IElg50Eb2TYbGTPXp9L8IGV2ndAJhGjlpIvbh6SybQ>
    <xmx:_VzlZqk7iz5kGEY4pMahMEmI1JOSha4dtWtN9jHt1gaZFY8OLLY3rg>
    <xmx:_VzlZkfZlMcJ9uVr2GfLHwJ-cuuWAb7CHQH8PTmm7u_VEei_27rpjg>
    <xmx:_VzlZsHepwemn5iSzWfTcLjzSzY6IxaeqfBKDpIh0figyUuDUn8XHg>
    <xmx:_lzlZoanKwHPBPQRwQ3xW809dUEcN0PsOfVpguYzzsidwNJFOZoyIi2o>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Sep 2024 05:53:00 -0400 (EDT)
Message-ID: <df0497f8-ddb4-4149-a578-309ac2f60548@fastmail.fm>
Date: Sat, 14 Sep 2024 11:52:59 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: use exclusive lock when FUSE_I_CACHE_IO_MODE is set
To: yangyun <yangyun50@huawei.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>, Amir Goldstein <amir73il@gmail.com>,
 linux-fsdevel@vger.kernel.org, lixiaokeng@huawei.com
References: <20240914085131.3871317-1-yangyun50@huawei.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20240914085131.3871317-1-yangyun50@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/14/24 10:51, yangyun wrote:
> This may be a typo. The comment has said shared locks are
> not allowed when this bit is set. If using shared lock, the
> wait in `fuse_file_cached_io_open` may be forever.
> 
> Fixes: 205c1d802683 ("fuse: allow parallel dio writes with FUSE_DIRECT_IO_ALLOW_MMAP")
> CC: stable@vger.kernel.org
> Signed-off-by: yangyun <yangyun50@huawei.com>
> ---
>  fs/fuse/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index ca553d7a7c9e..e5f6affb0baa 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1345,7 +1345,7 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct iov_iter *from
>  
>  	/* shared locks are not allowed with parallel page cache IO */
>  	if (test_bit(FUSE_I_CACHE_IO_MODE, &fi->state))
> -		return false;
> +		return true;
>  
>  	/* Parallel dio beyond EOF is not supported, at least for now. */
>  	if (fuse_io_past_eof(iocb, from))

Oh, another of these, maybe I should have named this function
'fuse_dio_deny_wr_shared_lock'. The good part is that it will be later
on caught in fuse_dio_lock/fuse_inode_uncached_io_start and then switch
to an exclusive lock. I.e. testing did not reveal it.

Reviewed-by: Bernd Schubert <bschubert@ddn.com>

