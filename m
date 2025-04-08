Return-Path: <linux-fsdevel+bounces-45988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7F8A80DB5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 16:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D46F4A390F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 14:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBF31DE2AD;
	Tue,  8 Apr 2025 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="Arb62mbC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aYdFIflE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8C11AB52D;
	Tue,  8 Apr 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744121998; cv=none; b=UdPdBslmeqMxEG2E/IYP4fH4pLgZdqkv2iYDcTfZtosbNi0ZsNywDxw6E7oqcSur08Qfcn71N5AW6dJxjUkU71JF33cC87sI/mTSDnKvWOYzrtSKtTs6h4AhQ8yyQVWGcRpYCiM9zSZPa8sg0KEwh1DL81668yY0k7YskPB6Un0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744121998; c=relaxed/simple;
	bh=vroccB3hc8QzTkaFSHAFq7lrOUzJlHXBEtovGQKNZvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQ/Kq3JD5ktDutrbx/1pI2qZS18EOBKOM5If3xlga1HxQU/5FsPWa0XPmAznRqEBRfxGnRTTeL68A/e8LgjmEDI5E+KeVobeUVSxkcEffn+kRzQY4Y6dYb1vm9Tn3WTiyh2bc9sjSM2m4r7raxQb5FlCKqfemZJfklyld8vPapQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=Arb62mbC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aYdFIflE; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2FDFD1380195;
	Tue,  8 Apr 2025 10:19:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 08 Apr 2025 10:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744121995;
	 x=1744208395; bh=+b3ara2Q4q4NRQ8QLp9VAkPjxaW2oDNH02MnnVA+1J4=; b=
	Arb62mbCN7yk6PXSyxSd2tYJQ6ZHVLyurUQCu2mhJYth+eYNEC7ozGRt1DCqvDar
	UGiYgLesw+vEa8PzJCf9n8EEA+hOkqaB6UpK1KdNCSR2mKWg0MBlGysosptDbJ1w
	WlG8r061J3pG6mzTo+cAwguEyUwGoEUvcOKwwGvNJzDXnbWwtw/EODEsiW7ijahL
	AKOE7//RucSxKXRbbzbO6VVoorzOs+5eX2iXtePzo5wG2TPw0Jgyghrm6di/FeLu
	P5R2D93GViY9+8ZWCg805Glp/+AXYHujXMA4u/7qzNa8ZVEbtfQjpvBmjdHy/WDQ
	7otjK2HI8epnFGE3OYMwXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744121995; x=
	1744208395; bh=+b3ara2Q4q4NRQ8QLp9VAkPjxaW2oDNH02MnnVA+1J4=; b=a
	YdFIflEf0cK6J2o0jo1ZqQWGhCSWxdgewT6TcdQDloi2dKHLVQhck+FU6BgCYEe7
	njBZebN6MNbPt5r9qfnyuiP6ewC2J4hKeoF8gK1XIXrsXgsDuAbQaR2doONbi5MZ
	Gc+2NinAisPcfhqim2qUTC7lleUv4kPw1ehV4a1f3xJYE17tON8Nep4DUSIQasLK
	DRRROBya1MJvBwnvtkBR1Cc7MOhEsD5bw0SLrJrWuCDcrQ4wFHiUrpUZ+Wlq34b2
	sB7KPeZ+c2lHUrl/P1djNNLRVFRr+WyW8xuacRSPFOcXR1vLFXE+4Y/6x1xIrqet
	epQtl5V9jl+UHm6TN425Q==
X-ME-Sender: <xms:iTD1Z_Bf64ty3rC326EqAGfmLhhbbz5uJ_Ny9MKjp-r6d20P9s1LQQ>
    <xme:iTD1Z1iVn-SRmxfvRLAXYTut45rmGIMl1j8JeJg84oqyoXJ3XKYZkamos4PnrPUIi
    9Ef6B5cW9pMY6JI>
X-ME-Received: <xmr:iTD1Z6n-n6xAJ8pXOcGcPUBCuBMvzPcisqzr-ORquOf8l0oNHZKv5-eTkZKZbGcvesBWzdxYK9a_UIUPHxX6LRn65F2E3h5klHQTHBOFNx0pjRfFYu0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeffeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledt
    udfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthht
    ohepjhgrtghosehulhhsrdgtohdriigrpdhrtghpthhtoheplhhinhhugidqfhhsuggvvh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhoph
    hhvgdrjhgrihhllhgvthesfigrnhgrughoohdrfhhrpdhrtghpthhtohepjhhorghnnhgv
    lhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhguuhhnlhgrphesihhnfh
    hrrgguvggrugdrohhrghdprhgtphhtthhopehtrhgrphgvgihithesshhprgifnhdrlhhi
    nhhkpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:iTD1ZxywmtVD2Yw28OjqZ-XQ_lcbZqeSD4BBtlKFYB_a9vp5ATwXKA>
    <xmx:iTD1Z0ToKctKC9p8g6Cl5mHk_CtKmWO92tbEIyl_jwV0Yxysh1Srbg>
    <xmx:iTD1Z0aZG7-b2bxhK0aM2pl4boXRyxRTcFzlTACEf-MQofW6zz7LSg>
    <xmx:iTD1Z1S4mp1cj5_ot_RZwVi5MHi2dCnNOqyymZBBEVV_Wn1AomD47A>
    <xmx:izD1Z6aaMCKQflOtEHEHWlXxELXxF-apVqCmTWOJ_WODNzSIr0U1D-rT>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 10:19:52 -0400 (EDT)
Message-ID: <d42dec00-513c-49d4-b4f3-d7a6ae387a6b@fastmail.fm>
Date: Tue, 8 Apr 2025 16:19:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fuse: Adjust readdir() buffer to requesting buffer
 size.
To: Miklos Szeredi <miklos@szeredi.hu>, Jaco Kroon <jaco@uls.co.za>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 christophe.jaillet@wanadoo.fr, joannelkoong@gmail.com,
 rdunlap@infradead.org, trapexit@spawn.link, david.laight.linux@gmail.com
References: <20250314221701.12509-1-jaco@uls.co.za>
 <20250401142831.25699-1-jaco@uls.co.za>
 <20250401142831.25699-3-jaco@uls.co.za>
 <CAJfpegtOGWz_r=7dbQiCh2wqjKh59BqzqJ0ruhtYtsYBB+GG2Q@mail.gmail.com>
 <19df312f-06a2-4e71-960a-32bc952b0ed2@uls.co.za>
 <CAJfpegseKMRLpu3-yS6PeU2aTmh_qKyAvJUWud_SLz1aCHY_tw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegseKMRLpu3-yS6PeU2aTmh_qKyAvJUWud_SLz1aCHY_tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/1/25 17:33, Miklos Szeredi wrote:
> On Tue, 1 Apr 2025 at 17:04, Jaco Kroon <jaco@uls.co.za> wrote:
> 
>> Because fuse_simple_request via fuse_args_pages (ap) via fuse_io_args
>> (ia) expects folios and changing that is more than what I'm capable off,
>> and has larger overall impact.
> 
> Attaching a minimally tested patch.

Just tested this and looks good to me. Could we change to

-	size_t bufsize = 131072;
+	size_t bufsize = fc->max_pages << PAGE_SHIFT;

?

I'm testing with that in my branch, going to run xfstests over night.


Reviewed-by: Bernd Schubert <bschubert@ddn.com>


Thanks,
Bernd

