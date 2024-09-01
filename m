Return-Path: <linux-fsdevel+bounces-28148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C4D96764F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 13:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEF41B214A7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 11:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DE416EB76;
	Sun,  1 Sep 2024 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="gI8MytcQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PHwAYBWj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5321C36
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Sep 2024 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725191817; cv=none; b=U3g0PQJgI7xqNa6wChMBMgpuMZl71bN9b4cUBrflZAa0mHSWWD1Iy7s5YVLGAKklKll8+uaps4GtBp+6pqzm9za0oPMltxfFTDkq+fO66Bo7VlHkCX60T3kvNlyq6NG4NDHYD0Tv+i1ShnUBseXU5tJ1visUkEPrcrKo1W3PYRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725191817; c=relaxed/simple;
	bh=QQt2WjOYRFh8gZnsjXn23CjQrX0MPNIlR+zVSL6NzAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DClO9JaAUnM5xreK8M/i3fD2B0PevxA6j6xyftoF4ogg0zsWXZfFQXpas1pxFrhLj8MkIobSyrqW9n2N+uFYqCOzkLR23XsHQwRRZzMSk3tLk07ECVIbTMkaT9NThdzs29rQVxT5ghsq/ZymKTkPlkIPJWOrjx1Ezq4RZgUjpP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=gI8MytcQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PHwAYBWj; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8CA991380329;
	Sun,  1 Sep 2024 07:56:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 01 Sep 2024 07:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725191814;
	 x=1725278214; bh=/n79tFT80YWexs+8RdZJi4AvyFkh48JAmuCiU6gZbLk=; b=
	gI8MytcQL7za13NljjG+14D3o1hoSlKqcGPbYOuikiOGHkIHxotQfmsFdVfLkPMz
	TdS2O/kNPBx/nXOtWEz0NBzRf0R3SQFFT5mI4sbNqXAfzzlFDnYpLRHn0ztfO/Eb
	4G2L+gYCVf9U03N/e2uBnnO0AwZF+BTs+UlYL3q/JZsTS2Ng0GfeDE3QrlcbTRhz
	9DKWT2HClLBl9aZ+fvomtAU8jD/130FUWZBfkyvF7Jb48szAEH21WzrfqNadLfz0
	1sFwFokWUmumWAJGW0Et5Sd6zY7KJsjDj2HINuvb0qSz9H31DxxDiA6prJDnOPF4
	5rIBJfhN99hXFWV8PhRZ4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725191814; x=
	1725278214; bh=/n79tFT80YWexs+8RdZJi4AvyFkh48JAmuCiU6gZbLk=; b=P
	HwAYBWjo/m05TuNjiAoDjnEC8fSJ/CrgcXyh3ZoL33S/EP+LovsEl6gEFnkQ2AVE
	ik4TPtvSgLmZbRb73CfoAo+WtvKzfNZZtKovRAilQd3uWRe1W6C3JpOfYTM33/qJ
	3LZOBPvV3flRiUkBuGz74rukURXExZ9Tuv/rzSvhHjENGTW91ANIZ8gu8LH8YK/9
	M9KMp4iM5/XgV0fUbl9SmnQh94ycnbf7phvBWS4fcXOs5XpJZGjQdHjLPmfxOHMP
	Ll7J+vY+/7qAGogbulswDPVj33ipPmw7vGex6iZ+Fy1CESEm0+951BdtzM2N+D8v
	PPi5ZrLsT0kEu3GEwhfbg==
X-ME-Sender: <xms:hlbUZskLztSm6Pp_bwsiOoG8Mup1mDtv8gcD55v6iuzcx09tSBu2BQ>
    <xme:hlbUZr22ky3Y5kq5Q2JOCiFfqJEmJxUrWnqnAh2N2dDlK02AzaNFGmpfGxIzeEaTt
    3igcZymidyFBdVu>
X-ME-Received: <xmr:hlbUZqr0rnErsBtgcwEY-3XAhT5RZekgDIXc0UfOwK8El2MQdPDyh3eRY517Jg8Lx8smyUzVUzJJojmf0-puDFYRpMRCuiapZqb19_GSKW125-yFeTIe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeghedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfg
    tdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphht
    thhopegsshgthhhusggvrhhtseguughnrdgtohhmpdhrtghpthhtohepmhhikhhlohhsse
    hsiigvrhgvughirdhhuhdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:hlbUZolU6tTVacMNezXYmIGPx67NyBofnWvkk8UExihvQZb2UB_jAQ>
    <xmx:hlbUZq3YSCjPL72nW-6ZWtVx4GAFpd8_UKvYUGJaTqskxhTYFf6aVg>
    <xmx:hlbUZvtLEuAuIYY9X_o1n_1owbgvhzMwvj6IOnBFkXmb1fMwcbpD8A>
    <xmx:hlbUZmVtDwCTKBVylVL4crwxw2DTnVrSz_d0HJ0-pNsPEhOdEZJe3g>
    <xmx:hlbUZm_vGJUns-ldrNKKcU22XcH1RipSpJFa3loFex07xyLWNy2QVVuu>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Sep 2024 07:56:53 -0400 (EDT)
Message-ID: <67253e1c-9395-4503-b7f8-5380d8949339@fastmail.fm>
Date: Sun, 1 Sep 2024 13:56:52 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 11/19] fuse: Add support to copy from/to the ring
 buffer
To: Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 linux-fsdevel@vger.kernel.org
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-11-d149476b1d65@ddn.com>
 <20240530195920.GC2210558@perftesting>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20240530195920.GC2210558@perftesting>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/30/24 21:59, Josef Bacik wrote:
> On Wed, May 29, 2024 at 08:00:46PM +0200, Bernd Schubert wrote:
>> This adds support to existing fuse copy code to copy
>> from/to the ring buffer. The ring buffer is here mmaped
>> shared between kernel and userspace.
>>
>> This also fuse_ prefixes the copy_out_args function
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  fs/fuse/dev.c        | 60 ++++++++++++++++++++++++++++++----------------------
>>  fs/fuse/fuse_dev_i.h | 38 +++++++++++++++++++++++++++++++++
>>  2 files changed, 73 insertions(+), 25 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 05a87731b5c3..a7d26440de39 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -637,21 +637,7 @@ static int unlock_request(struct fuse_req *req)
>>  	return err;
>>  }
>>  
>> -struct fuse_copy_state {
>> -	int write;
>> -	struct fuse_req *req;
>> -	struct iov_iter *iter;
>> -	struct pipe_buffer *pipebufs;
>> -	struct pipe_buffer *currbuf;
>> -	struct pipe_inode_info *pipe;
>> -	unsigned long nr_segs;
>> -	struct page *pg;
>> -	unsigned len;
>> -	unsigned offset;
>> -	unsigned move_pages:1;
>> -};
>> -
>> -static void fuse_copy_init(struct fuse_copy_state *cs, int write,
>> +void fuse_copy_init(struct fuse_copy_state *cs, int write,
>>  			   struct iov_iter *iter)
>>  {
>>  	memset(cs, 0, sizeof(*cs));
>> @@ -662,6 +648,7 @@ static void fuse_copy_init(struct fuse_copy_state *cs, int write,
>>  /* Unmap and put previous page of userspace buffer */
>>  static void fuse_copy_finish(struct fuse_copy_state *cs)
>>  {
>> +
> 
> Extraneous newline.
> 
>>  	if (cs->currbuf) {
>>  		struct pipe_buffer *buf = cs->currbuf;
>>  
>> @@ -726,6 +713,10 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
>>  			cs->pipebufs++;
>>  			cs->nr_segs++;
>>  		}
>> +	} else if (cs->is_uring) {
>> +		if (cs->ring.offset > cs->ring.buf_sz)
>> +			return -ERANGE;
>> +		cs->len = cs->ring.buf_sz - cs->ring.offset;
>>  	} else {
>>  		size_t off;
>>  		err = iov_iter_get_pages2(cs->iter, &page, PAGE_SIZE, 1, &off);
>> @@ -744,21 +735,35 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
>>  static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *size)
>>  {
>>  	unsigned ncpy = min(*size, cs->len);
>> +
>>  	if (val) {
>> -		void *pgaddr = kmap_local_page(cs->pg);
>> -		void *buf = pgaddr + cs->offset;
>> +
>> +		void *pgaddr = NULL;
>> +		void *buf;
>> +
>> +		if (cs->is_uring) {
>> +			buf = cs->ring.buf + cs->ring.offset;
>> +			cs->ring.offset += ncpy;
>> +
>> +		} else {
>> +			pgaddr = kmap_local_page(cs->pg);
>> +			buf = pgaddr + cs->offset;
>> +		}
>>  
>>  		if (cs->write)
>>  			memcpy(buf, *val, ncpy);
>>  		else
>>  			memcpy(*val, buf, ncpy);
>>  
>> -		kunmap_local(pgaddr);
>> +		if (pgaddr)
>> +			kunmap_local(pgaddr);
>> +
>>  		*val += ncpy;
>>  	}
>>  	*size -= ncpy;
>>  	cs->len -= ncpy;
>>  	cs->offset += ncpy;
>> +
> 
> Extraneous newline.
> 
> Once those nits are fixed you can add
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks again for your reviews! I won't add this for now, as there are
too many changes after removing mmap.


Thanks,
Bernd

