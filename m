Return-Path: <linux-fsdevel+bounces-36180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D25A19DEF4E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 09:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B317B21D04
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 08:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2360614A4DF;
	Sat, 30 Nov 2024 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="rjaMxG8P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XGvjCFsu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB23A2FC52;
	Sat, 30 Nov 2024 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732954946; cv=none; b=iJQtm06AXBuY2bJlCunAm+KSSS61gL2O5y/aAilAGIp0ShOGCql48ht0zA/Z6UVbwbwRmvsBvmVMTvUJUK6uizHtzE/hfSBO7UAdpKrVtHlQ0I1UHGS9cZPWkdBqNzJFoJLUt/FzInT0804llJmHtdW7u7Pu7YaVAnb+U/Q9760=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732954946; c=relaxed/simple;
	bh=GerELVZYzA7Aam9V6OAPj3Tm77A/MfaAPCutBks0ZoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSv/30j3oy5iYSF/v1MtvrQHy2GEiI4t8M8UjF1eXtZrKii4bmHp5HHuMyfINrR/H1m3d2JOBxPfwIpRCdq8r9lWTp1Cq0tFxinG+d38h1uFZwT96NZ2+M9UG0YPxMKt8NkV1Gl6UYadiWcjMMdyhCdgxeI+jLEAcuzNIbJGF0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=rjaMxG8P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XGvjCFsu; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DD41813801EF;
	Sat, 30 Nov 2024 03:22:21 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sat, 30 Nov 2024 03:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732954941;
	 x=1733041341; bh=4Ou19wY9Ipdh9TBIHoU4/AL0zN3LQZ/e+WUg7cq+Rfs=; b=
	rjaMxG8PKa+bd8/UznrD4K8ey43KhVl1+K1/zFUGlzwxAmbHW4pL/iSpTucxCGM/
	xmkSjGo8oBM/mWMeZaW4MZLNGwa87FsoLfuGeloYHz+b4i7AeZoKSbWjb1jq5UcP
	HMtNzIk6UnLAP0IVtbH+eDAnIBBH66ykAsFLjFJL2GSjWAclWfXkFiKCbRN3yKoj
	lroHj3CtiHcJSt0WPIVifOd7Z5BljK/SWT5BwwiAbFVuu/rgSw95bhnuIJ0+WmOw
	C/RMkjsUgz/27ga5VSZrQR6LL4+wyx83B/QitTSp6WG3iDy0TT6H7TDVmHVK/ZD+
	yTzLPTjKloz1Q/uK12ZxmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732954941; x=
	1733041341; bh=4Ou19wY9Ipdh9TBIHoU4/AL0zN3LQZ/e+WUg7cq+Rfs=; b=X
	GvjCFsuYbGpgTgmM/FVSdqVN7GuTrrJpqDioiK+auHdrq+nmTDClYs72UEV7DiTs
	7UUWauDXd+s81GhPJgTFEtqWPfb8oEnVjHza9gAQnW4kJI64mwV+QiE2hgNMgOKA
	IkKvHhA9oOS/inCI+QgGxqKJ7oHpOWVO1bXt8ZL5DapjIIshTkUgrFAGXuU1pac+
	mEWhnXecjd1zfxKeU/62z8fj6DZrhsaIjW/Gm2JkohVihfpy/ejfy2K+d7Ho4GQk
	qAvLp0Lld1k6iZcKIJDG7BokIW9RqFLWYhExFc5HqZrEY290MtgjuI0Zio2E/vFn
	MwU/h+U6o9AzuaPPbqUFA==
X-ME-Sender: <xms:PctKZ1vvDOAtCTTOPuZf8gpzMdpUtfcFPIJdekP3uerdlbRaSx6TZw>
    <xme:PctKZ-fHZ95LujsRJW5AhZ0wE4Vv2tOLFQY-rIGPHFKpqs9EHAvUshUgjHjngAmXl
    mOAF8Ph-qnujPpk>
X-ME-Received: <xmr:PctKZ4z_HYIjHAO59HsJmeOqXL80IlT8o9vyqhPrTQN-0RNPqsYRXZjkeqk8VbizNbOyKAZlApf2UV95u-6IhyUMOFNSxXnj-a2RskcCTGjJmAsZUc-Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheeggdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepueehjeekveegheei
    feehgfegudeiveehfeeuleeiiedtheejiefgvdduieegtedunecuffhomhgrihhnpehshi
    iikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsth
    hmrghilhdrfhhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnihhhrghrtghhrghithhhrghnhigrsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehjohgrnhhnvghl
    khhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhkhhgrnheslhhinh
    hugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehshiiisghothdokeejsgek
    vgeivgguvdehuggstgegudejheelfhejsehshiiikhgrlhhlvghrrdgrphhpshhpohhtmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:PctKZ8MCUZxvzt6mbC1t0DTTh0SiSeKkyZ7_XiyV0jdcKkDGUaCO6g>
    <xmx:PctKZ18jATlkyi0na3vsb4bpy4kSwwG3hKle0_tlu0e8hEO6UjCOhg>
    <xmx:PctKZ8UFvsnO9Fb9sC_EfNuEsNGWlflpG5-BITkaUTuR6q0woNlpLg>
    <xmx:PctKZ2cEUTlpvkBOZHpx95OHBWgRGYIZfeVthqnDYlO8cxC_P4Sw1g>
    <xmx:PctKZ-MZ_24flxSjgTOqTuMqh-TX_HokFAd7WENbLcNOrhc0FITtktiO>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Nov 2024 03:22:20 -0500 (EST)
Message-ID: <8806fcd7-8db3-4f9e-ae58-d9a2c7c55702@fastmail.fm>
Date: Sat, 30 Nov 2024 09:22:19 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: add a null-ptr check
To: Nihar Chaithanya <niharchaithanya@gmail.com>, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
References: <20241130065118.539620-1-niharchaithanya@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20241130065118.539620-1-niharchaithanya@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/30/24 07:51, Nihar Chaithanya wrote:
> The bug KASAN: null-ptr-deref is triggered due to *val being
> dereferenced when it is null in fuse_copy_do() when performing
> memcpy().
> Add a check in fuse_copy_one() to prevent this.
> 
> Reported-by: syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=87b8e6ed25dbc41759f7
> Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")
> Tested-by: syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
> Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
> ---
>  fs/fuse/dev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 563a0bfa0e95..9c93759ac14b 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1070,6 +1070,9 @@ static int fuse_copy_pages(struct fuse_copy_state *cs, unsigned nbytes,
>  /* Copy a single argument in the request to/from userspace buffer */
>  static int fuse_copy_one(struct fuse_copy_state *cs, void *val, unsigned size)
>  {
> +	if (!val)
> +		return -EINVAL;
> +
>  	while (size) {
>  		if (!cs->len) {
>  			int err = fuse_copy_fill(cs);

I'm going to read through Joannes patches in the evening. Without
further explanation I find it unusual to have size, but no value.


Thanks,
Bernd

