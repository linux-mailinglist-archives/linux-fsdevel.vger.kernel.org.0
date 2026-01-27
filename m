Return-Path: <linux-fsdevel+bounces-75658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKlHEdM/eWmAwAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 23:44:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3529B315
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 23:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7604A300845E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 22:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7D12E8B98;
	Tue, 27 Jan 2026 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="RQ71i25t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EHK13jj0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED212E11A6;
	Tue, 27 Jan 2026 22:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769553865; cv=none; b=J9c+ZoXkdn77Q6iLLGQe69D55rkjZVB4B4R/oVWQ+hdkJhNhCzZu7JRErEMiz8JKNSfjBQw0yThtiIOvRfgZsdRB56gRGK5luaB+kkYpZhDk3lpXhUirK/14NFUTakxZZiET374OfO7vBXwiEexn0v+NhXjtciueK7hqBiIu7s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769553865; c=relaxed/simple;
	bh=uKfrKsEvu0RZTLIvVNqWI3LmcP14/n9T3QIUjROtNZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6ZcPW/9jrDk0O2Zpg9ZTafEGAVnylF0OEcqPaH3CQmW09ByylMc5poYpxtmFODi1XgOilt2ui+k23AiFh6yaw0foUGEWPJhdM+/alM7OyhFDeXVgDVKZn/meHfahHckeUNHvbpFGDTwZ/uXEnAyg8FLBELxQJrMkroaWx2OLaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=RQ71i25t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EHK13jj0; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id D7134EC00F2;
	Tue, 27 Jan 2026 17:44:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 27 Jan 2026 17:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769553862;
	 x=1769640262; bh=dCH+e+Sb3AYsoUHbD0ywtC42NFzwIIXmkMm4NkTbzpo=; b=
	RQ71i25toiNsEBIVe1xDWuyqfrjcFp/Y/+ybj0BjlvrBevL3jMF/i07WbgDKJNlr
	X0B3wkNFUvhtY/jzgEG6cjWuEveL293FohM7oj/oXkjzjYyVnkeB1sVaw91LqvIk
	gi6Jeiv8zU5M5Df5WJUjsu6guFAN7O6VdYJcV6KTEOemawaWKSNfvHPxkN5Mg1lE
	3sioVk8+QKu+6mXYcY59E+oAenY73A8drgX+20g8BbGT8x6E/AvLk6ieNNZi97TC
	Ld7tM3PGQ/5irDpoKGDAQ01qAeCAVp7QJkMZW6H6MnNu98PrzfjM1sYtiFlMbTL4
	oHoUKEmLhvsVCDc/8hxbZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769553862; x=
	1769640262; bh=dCH+e+Sb3AYsoUHbD0ywtC42NFzwIIXmkMm4NkTbzpo=; b=E
	HK13jj08KoNbTzy+GUJIUgp8LBBPSnt5oV3SsZ6s5YX5C6SNPCKRWGFHslbFCe2N
	S9k+FN/HNrCE51Roh3XUU8uDIw3aRZP5Li19TVCJ6DjWbINKKOWcVI4EAC+oiU3h
	Vo8Hu4mYmY/Odx82KDzoZDShOiXinumnkRDE0zfps2sLwvT4jtRFPWVI2FklOFcW
	OrFYchHExFvg2h59BANmIzV3MTe4HzoDwr52/WZXFpifVeohvFLwpQ3JLf9LSD3V
	Q3kQaQoM8Wht7bgnZkIk+XdrBWLLgWrn7wN/P1B9P72h1P7oBlhva2HBZH5GZ5+n
	8cTqi4xGm6LwpbEjqdiIQ==
X-ME-Sender: <xms:xT95aanBi4LTrfUpFckDnaQInneaU0i4jCVcQuxkUjnviOkNzHYSVA>
    <xme:xT95aU5MwGsZ3hHM8tpe9WE1zoAXT3jO8swM7R7GRWnxee0o2y9HtnetikCUEbehM
    vT4wgSw_RAt5wLOv85Kf7YPaClHrtEi7Flkyy73O6sMs_piqppp>
X-ME-Received: <xmr:xT95aTRpdP0oywWzIzgOdmwKzvuMt6gJxAK4zJgP0_mForMOKc5EyqvXGWWjTbupvH8kozmcRqv9BSIjJfKJ4mUY0TmskBk_wNUUrO0X6CcLZBz4UQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedujedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheef
    lefgvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehm
    ihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheptghsrghnuggvrhesphhurh
    gvshhtohhrrghgvgdrtghomhdprhgtphhtthhopehkrhhishhmrghnsehsuhhsvgdruggv
    pdhrtghpthhtohepihhoqdhurhhinhhgsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghsmhhlrdhsihhlvghntggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    gihirghosghinhhgrdhlihesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehsrghfih
    hnrghskhgrrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:xj95aaz6B25VWAtS24Utz8a8ra7Uqo2DFK-sc1xyzwoq5bXK_G96BQ>
    <xmx:xj95aTqs7NaCOeFcSd-6OdPnOU7L3YWXhE4cisJ1W25sGap3h6zKlg>
    <xmx:xj95aV2Ba_np9YAf5sbYWNLfpmqoG_-O95mK2b1LAMgSZaM3jiqgdQ>
    <xmx:xj95abxkNjpu0cSAa2kh6cK9v6g9JPs7Z8uN8nVn4FyeolFEwtkNZQ>
    <xmx:xj95ac_859Xu-olhUat9iRWI9s2LMwuWmoNVEtIwOlo9qLsv_NFgRF6X>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 17:44:20 -0500 (EST)
Message-ID: <d6eb86a9-c5b0-4660-8cf2-9c853b43b494@bsbernd.com>
Date: Tue, 27 Jan 2026 23:44:18 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/25] fuse/io-uring: add kernel-managed buffer rings
 and zero-copy
To: Joanne Koong <joannelkoong@gmail.com>, axboe@kernel.dk, miklos@szeredi.hu
Cc: csander@purestorage.com, krisman@suse.de, io-uring@vger.kernel.org,
 asml.silence@gmail.com, xiaobing.li@samsung.com, safinaskar@gmail.com,
 linux-fsdevel@vger.kernel.org
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
 <CAJnrk1Z-9rsP86Fc=57P9gy=vFjfjT8nuAgE2_snL3_vfbbBmg@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1Z-9rsP86Fc=57P9gy=vFjfjT8nuAgE2_snL3_vfbbBmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[purestorage.com,suse.de,vger.kernel.org,gmail.com,samsung.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.dk,szeredi.hu];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75658-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D3529B315
X-Rspamd-Action: no action



On 1/27/26 21:12, Joanne Koong wrote:
> On Fri, Jan 16, 2026 at 3:31 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> This series adds buffer ring and zero-copy capabilities to fuse over io-uring.
>> This requires adding a new kernel-managed buf (kmbuf) ring type to io-uring
>> where the buffers are provided and managed by the kernel instead of by
>> userspace.
>>
>> On the io-uring side, the kmbuf interface is basically identical to pbufs.
>> They differ mostly in how the memory region is set up and whether it is
>> userspace or kernel that recycles back the buffer. Internally, the
>> IOBL_KERNEL_MANAGED flag is used to mark the buffer ring as kernel-managed.
>>
>> The zero-copy work builds on top of the infrastructure added for
>> kernel-managed buffer rings (the bulk of which is in patch 19: "fuse: add
>> io-uring kernel-managed buffer ring") and that informs some of the design
>> choices for how fuse uses the kernel-managed buffer ring without zero-copy.
> 
> Could anyone on the fuse side review the fuse changes in patches 19 and 24?

I will really do this week, getting persistently other "urgent" work :/


Sorry for late reviews,
Bernd

