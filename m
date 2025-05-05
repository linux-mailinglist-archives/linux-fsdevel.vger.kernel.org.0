Return-Path: <linux-fsdevel+bounces-48107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E85F8AA9761
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 17:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275983A3C95
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9A225C6E7;
	Mon,  5 May 2025 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="KDUjLDiK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tKBi0Lu+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8A61C1AB4
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458600; cv=none; b=MPTpfOQ6mVQrRxoO+Dk5Qke5H1U9mwtNBVuivJF8RGBWKVIKHbnH+N3zdBPgc4g6H+qVMxuvUcnLtRgoX387oszwsy6XZ4Li8tZ9gfjSdjZNxedFWKceTnwC+A1aVfKe4rgZpFWJifC9AAOJfz7gE1+lUCy96LijJ/+12Qu/a7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458600; c=relaxed/simple;
	bh=Ynh215exOPZ7uJ1qLuydUOFUM7c+naFTZMrp8b9ByZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZS2bghzbgoE38d4EiVnayWC62OmOm1jWdqcGHkIfYn8Jd9gsqQoScJDHe41vICyOdXq2hHM8WnHPOhs6dXVu+4S7huGqsWGLSLZizhFfVqlP6LOZb1ILwZ7X12+0IdDDexf0bGdkmKe/Kl82yd9H+ahGRRdWFSeWjwytkmRAt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=KDUjLDiK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tKBi0Lu+; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id A778E1380FDE;
	Mon,  5 May 2025 11:23:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 05 May 2025 11:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746458595;
	 x=1746544995; bh=HRs2bj44KF4qAxCfZPUdLse+OtkSYRE6d+Xv0udqMhw=; b=
	KDUjLDiKQ/FQ3i32fnbwLvCT2Sdkd+byRSU2QT+liLIo+CWcrKilhfLd0WYzzQQl
	tiNR0ujsdK3n++vx2IkXa0kAHJd84BTmW8aHGkrbkp9AcLOCDXkn/53C9todfr31
	cAL7ca5W5EhOe/xiulppG0TDc68atNv6T9Zk2i5bkunWxmn0WiEsMdfWH1sP3THc
	ngfbwZFTA444I3ZQYcVX1nQf62+JhRppByIK0rbzXu83Ancm1VA5OE3hJxbcOeQi
	QdPLWDHfBq07m0tXyd1vnPq/qXKJf5GfU70D0jqBa5RLn2/N+yXN6Nmesi4q3yxx
	+yHASWbmE2Pz6qGIEzVuDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746458595; x=
	1746544995; bh=HRs2bj44KF4qAxCfZPUdLse+OtkSYRE6d+Xv0udqMhw=; b=t
	KBi0Lu+fcEfDeMjzFpsk9/TrWrLPH+YLPuCe+6hqfDaCdjwT6oY5KDZME03xNLf1
	wO/ZC8HYiOOyNUc37BDgF2a59pzBI1r+UM5tS0D9nM1XV2a9/PQtJ3ToUtE+rBOR
	VbA+0ib3GOQKlQl8JE/dlR0IQiYsAmhN6yRGUx+MN1O8xmqGYDyCS6WpnR23z+JN
	tnw2vFP+Yz49k7+rF1eMtolYty6exi1SlD9wFjAJ2DSLdEIqfZhUbNQOhnVZsrmR
	o0nxM0qxuRzJynbDlVhOx2F8FQQG24zawFe9JRTY06UvteFwCvHS9oZ62YAbFLO9
	3kAzrTT1UgkPauisNyyIg==
X-ME-Sender: <xms:4tcYaBdgdggX8S2Xo7ZnLw6dKh5S9pW6WeLBYFiB8q5D21mx2-gxPQ>
    <xme:4tcYaPOv5cPf6yY-g140KRpsy0b6Jh_OSyJSCpa9MSM0lhUwZPCVlTTRVEF8rNKoj
    eMoh0gH4yeXIOgW>
X-ME-Received: <xmr:4tcYaKiURKqT0HriQjlGz8J7Voo_2t5Y4uwdvvrub60hNw2zR9TS9360n7-0FsjRq_LR7DJGY4nAVWrRmkG8qJb003vRerMuI1hkqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledt
    udfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhikh
    hlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepjhgvfhhflhgvgihusehlihhnuhigrdgrlhhisggr
    sggrrdgtohhmpdhrtghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrdgtohhmpd
    hrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehk
    vghrnhgvlhdqthgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:4tcYaK-nhRybjl8VptQVsyTsFMnd04ZLjNHqqD_n_FFrPCC1k5fUEQ>
    <xmx:4tcYaNtjJ81xfjzJnoOfAaHoa3HBvJPWmtPCuq34B7eI3mfffBQBmg>
    <xmx:4tcYaJHiRjZEGipRxDxKfu_W8TYL-_nNXlod4RWoWyik3YaDFYh5Sg>
    <xmx:4tcYaENPBtqbGJqBitk285gxxoCfCh6-ItYXDEyEdjOeE03j1XP8bA>
    <xmx:49cYaCu0MztZ0AzYS-2VWzINtgbvC7HUKRGrq4mmAiD9HDFU40Y45LM1>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 11:23:12 -0400 (EDT)
Message-ID: <e66ed6f1-eee4-4a3e-9807-0fdb575fcd4a@fastmail.fm>
Date: Mon, 5 May 2025 17:23:12 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/11] fuse: support large folios for readahead
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, jlayton@kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, willy@infradead.org,
 kernel-team@meta.com
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
 <20250426000828.3216220-10-joannelkoong@gmail.com>
 <007d07bf-4f0b-4f4c-af59-5be85c43fca3@fastmail.fm>
 <20250505144024.GK1035866@frogsfrogsfrogs>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250505144024.GK1035866@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/25 16:40, Darrick J. Wong wrote:
> On Sun, May 04, 2025 at 09:13:44PM +0200, Bernd Schubert wrote:
>>
>>
>> On 4/26/25 02:08, Joanne Koong wrote:
>>> Add support for folios larger than one page size for readahead.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>  fs/fuse/file.c | 36 +++++++++++++++++++++++++++---------
>>>  1 file changed, 27 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>> index 1d38486fae50..9a31f2a516b9 100644
>>> --- a/fs/fuse/file.c
>>> +++ b/fs/fuse/file.c
>>> @@ -876,14 +876,13 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
>>>  	fuse_io_free(ia);
>>>  }
>>>  
>>> -static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
>>> +static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
>>> +				unsigned int count)
>>>  {
>>>  	struct fuse_file *ff = file->private_data;
>>>  	struct fuse_mount *fm = ff->fm;
>>>  	struct fuse_args_pages *ap = &ia->ap;
>>>  	loff_t pos = folio_pos(ap->folios[0]);
>>> -	/* Currently, all folios in FUSE are one page */
>>> -	size_t count = ap->num_folios << PAGE_SHIFT;
>>>  	ssize_t res;
>>>  	int err;
>>>  
>>> @@ -918,6 +917,7 @@ static void fuse_readahead(struct readahead_control *rac)
>>>  	struct inode *inode = rac->mapping->host;
>>>  	struct fuse_conn *fc = get_fuse_conn(inode);
>>>  	unsigned int max_pages, nr_pages;
>>> +	struct folio *folio = NULL;
>>>  
>>>  	if (fuse_is_bad(inode))
>>>  		return;
>>> @@ -939,8 +939,8 @@ static void fuse_readahead(struct readahead_control *rac)
>>>  	while (nr_pages) {
>>>  		struct fuse_io_args *ia;
>>>  		struct fuse_args_pages *ap;
>>> -		struct folio *folio;
>>>  		unsigned cur_pages = min(max_pages, nr_pages);
>>> +		unsigned int pages = 0;
>>>  
>>>  		if (fc->num_background >= fc->congestion_threshold &&
>>>  		    rac->ra->async_size >= readahead_count(rac))
>>> @@ -952,10 +952,12 @@ static void fuse_readahead(struct readahead_control *rac)
>>>  
>>>  		ia = fuse_io_alloc(NULL, cur_pages);
>>>  		if (!ia)
>>> -			return;
>>> +			break;
>>>  		ap = &ia->ap;
>>>  
>>> -		while (ap->num_folios < cur_pages) {
>>> +		while (pages < cur_pages) {
>>> +			unsigned int folio_pages;
>>> +
>>>  			/*
>>>  			 * This returns a folio with a ref held on it.
>>>  			 * The ref needs to be held until the request is
>>> @@ -963,13 +965,29 @@ static void fuse_readahead(struct readahead_control *rac)
>>>  			 * fuse_try_move_page()) drops the ref after it's
>>>  			 * replaced in the page cache.
>>>  			 */
>>> -			folio = __readahead_folio(rac);
>>> +			if (!folio)
>>> +				folio =  __readahead_folio(rac);
>>> +
>>> +			folio_pages = folio_nr_pages(folio);
>>> +			if (folio_pages > cur_pages - pages)
>>> +				break;
>>> +
>>
>> Hmm, so let's assume this would be a 2MB folio, but fc->max_pages is
>> limited to 1MB - we not do read-ahead anymore?
> 
> It's hard for me to say without seeing the actual enablement patches,
> but filesystems are supposed to call mapping_set_folio_order_range to
> constrain the sizes of the folios that the pagecache requests.

I think large folios do not get enabled ye in this series. Could we have
a comment here that folio size is supposed to be restricted to
fc->max_pages? And wouldn't that be a case for unlikely()?


Thanks,
Bernd

