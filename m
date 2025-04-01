Return-Path: <linux-fsdevel+bounces-45417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFC8A775FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 10:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1563A9A5D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 08:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83D01E9904;
	Tue,  1 Apr 2025 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="aL4ctN68";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A7R2s4NM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66ED1E8329
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743495109; cv=none; b=RFdsc4WPtdQxhZh2G2l6evlzEPMuQxL9mPX80AQMxHXc+SwNrLUETaPuUQyHNtImgSvxFfjdDtYbGjFyiA8xqry0VpunIDrtC95JiC2e94udU7Fny62tGt+uvL+Zb6NGE57E218ykfU/D8hAUu1aohkEnbG//AonVOl8I+I1+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743495109; c=relaxed/simple;
	bh=fhoMrZwQOBY2tn24fbPrxM4hCH6eBNSp92X/4oJDAxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ivd1M14WMXyc+YYt06QleBQCYMCR4sWOKaLpFXsiNrl7EKvaeImxbS1gaJk0tPRXUzUVPKaGxgAmHudK6eoxZO9zFukUXNWG9ASjjy/hNysFK98K29KQI1MKBRaU9/xOTHlGYc9MFtfAvQm1t1BFTCc6OfhpZ5v500JR9lOecOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=aL4ctN68; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A7R2s4NM; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF9FD1140096;
	Tue,  1 Apr 2025 04:11:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 01 Apr 2025 04:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743495105;
	 x=1743581505; bh=5D/NNCG8NNQZ5k7ii9jWZOrev9RUQkhAEROVbN0t7hg=; b=
	aL4ctN68x23cXQ0bZmQuCNLRSucTfChU3gHGcxn4mANWKL6cej0F2KnbboEQQqtD
	pDS2Bd5Etg578GrjsaEMZ0/JO/5J/huPwQwuAJNew+L+Hyg3JTsiUDaFWbkdxNKj
	tYPnieh9bOv3TpDRGo+etiPlZcWlOevf9zHkGUVRzFVx2LChRop8a02VZ3sNwLQw
	uL8tD/xJyePrsnRk6aZFfwMRTNPgWcFlQbbNUixJ8VY5YvzpCXaea4ZJifR3Ns+q
	IJ6c2dhtKia6/4S+z7LveEJLA2paZh1oqzeU7bTRZt5o/y3Krtfud0KRjMx2u5cl
	JotbICf4M0oJf+hDAxK89w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743495105; x=
	1743581505; bh=5D/NNCG8NNQZ5k7ii9jWZOrev9RUQkhAEROVbN0t7hg=; b=A
	7R2s4NMa0UNoyujLffasOIP8wbuRe8ar0n5VhIoYvwHa/BnFVWbp7gYE8V0/tl7p
	rQzcw8Xkt5GqJuiWSNJItgo33YatE8BhWxCxs/Jd+6yn5WbR0L2dbTALPJ/C236+
	0aA020QRKuAobcDolUMhXulo8v5iBMzrroDeYgTdFCxCwk1mzqRVOr19J7IaHv9r
	qbq5YJk9/Jo6umgq+tx3a7Rb3ifiCfsD9MyVNkKo7BDLVezWj8QOopZbMDKwq8M2
	Q5RPr+kIcS+GmbBr/I/h2Rj/Tj9zesyL9SM5JuzNp3tt+nO/U3VuhLfzXswrL2Fc
	gS2ijO8fDoxAJi+6d60Bg==
X-ME-Sender: <xms:wJ_rZxOI_fA3NkBHld8CUpVkZJbXQ5NQoXAa92vme0efbDOrr8m50g>
    <xme:wJ_rZz8erpfkVRAzpIqmvzpICDyxkgw97z5TRQBASBalpQmMIiKJ9gGGKDHXpHVw3
    MPzP0yk4CoaZ2w2>
X-ME-Received: <xmr:wJ_rZwTTw3-lKMf9FVywhthUL2_QVgE87LfwZfs-CeiFL4c6-igcVYNKF8G7KS8vALYGDss70Nku4-Ns0a5HMIeWzFaobG4qMI7XEC2UAmk_GiooIzhN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedvvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepudelfedvudev
    udevleegleffffekudekgeevlefgkeeluedvheekheehheekhfefnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    vghrnhgvlhdqthgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:wJ_rZ9vciZrFsBWaOMdt0e1aKCVCmEsQ4ooF2Qejwa2G83vZbBczrw>
    <xmx:wJ_rZ5ePR2kDxalPa83doT5On63HIxusGsnv8R1gXSBYl_kqZW1xqA>
    <xmx:wJ_rZ51plPAkwgqv_q1Mn6VslqXZgpIe9WL5G8bxQlgkRfgN8cSdFQ>
    <xmx:wJ_rZ1-Xbbt8FavguAJ2OMTgeZgsdx8W-nniJnR7hYotC8M0HNLkyg>
    <xmx:wZ_rZw4T0XDLFi_7oh-KZFDnlFUWL5-jfDEKM0oPvNM-82uupcd64-_f>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 04:11:44 -0400 (EDT)
Message-ID: <c2ab84de-84b7-4948-8842-21dd8e8904b3@fastmail.fm>
Date: Tue, 1 Apr 2025 10:11:43 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fuse: add numa affinity for uring queues
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: kernel-team@meta.com
References: <20250331205709.1148069-1-joannelkoong@gmail.com>
 <CAJnrk1a4fzz=Z+yTtGXFUyWqkEhbfO1UjxcSk1t5sA7tr8Z-nw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1a4fzz=Z+yTtGXFUyWqkEhbfO1UjxcSk1t5sA7tr8Z-nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/1/25 01:42, Joanne Koong wrote:
> On Mon, Mar 31, 2025 at 1:57 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> There is a 1:1 mapping between cpus and queues. Allocate the queue on
>> the numa node associated with the cpu to help reduce memory access
>> latencies.
>>
>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>> ---
>>  fs/fuse/dev_uring.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>> index accdce2977c5..0762d6229ac6 100644
>> --- a/fs/fuse/dev_uring.c
>> +++ b/fs/fuse/dev_uring.c
>> @@ -256,7 +256,7 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
>>         struct fuse_ring_queue *queue;
>>         struct list_head *pq;
>>
>> -       queue = kzalloc(sizeof(*queue), GFP_KERNEL_ACCOUNT);
>> +       queue = kzalloc_node(sizeof(*queue), GFP_KERNEL_ACCOUNT, cpu_to_node(qid));
>>         if (!queue)
>>                 return NULL;
>>         pq = kcalloc(FUSE_PQ_HASH_SIZE, sizeof(struct list_head), GFP_KERNEL);
> 
> On the same note I guess we should also allocate pq on the
> corresponding numa node too.

So this is supposed to be called from a thread that already runs on this
numa node and then kmalloc will allocate anyway on the right node,
afaik. Do you have a use case where this is called from another node? If
you do, all allocations in this file should be changed.


Thanks,
Bernd

