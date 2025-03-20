Return-Path: <linux-fsdevel+bounces-44614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACEBA6AAD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 17:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665DC98315C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 16:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE5E16D32A;
	Thu, 20 Mar 2025 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="IB8Nm7xv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WghGxeb0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C52A1E3DEF
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487105; cv=none; b=dGrBiI4k9rEKYPjcX9jXfLBl63TLu6IS5k6gO+KqepOu8qtYvAJtLQuCOi3ujV4OHnK7BupTVEpnsz81az50iiR8PlkAMUklproKclm+hRIwflccDRucFpZZQXYhO7gfMW2x24sRx6BlIyAM4o5KKq6cefC9qUcODOiEQ1s8NHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487105; c=relaxed/simple;
	bh=LarOUXWduylKHi2AKojlTeOAH5K5I2EaaHmUEPc9W1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORFtXeBBUspyVJG1NdmiZYBZ6VW7V4qP/5QcnsAX9+a0Zq7N4i39hy1UVeyDmm4PPtTExcjGdzYLmN8qySfUiGRXmPEVWrXdCVdd5OCuLmjUiq9KjoRtm/lpfw448/HnQ4zNUfJHYKg8CyWmrisf70SNJRh+kxqsNnpxiRiigZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=IB8Nm7xv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WghGxeb0; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 12A0011401D4;
	Thu, 20 Mar 2025 12:11:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 20 Mar 2025 12:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1742487102;
	 x=1742573502; bh=bBqV42+P/gI8DlS4mSCj8eITiLILWhA6ysjFZP5mBJo=; b=
	IB8Nm7xv1WAOOjWgpYkzqW+JX72Eq3EhXSgfoa+1nDZH27Qlu9TKvGPrPi8Nncse
	v+jRNFMxc4d5S1ng4Or3YBtGJZKelKKxgBd8Y0uGVZ/0GoA/MEVv3/5mRzvgmnPY
	tnTlkUARIlu7WKjCjbmG8feHn0v9bui/ctb5V9mbW7AL6hbA6/DLKKJfLUSPOhHZ
	ZHP/6eLZmWLA2IB6FIzXB2/lzgtYPUVIyVp8o62Mh6KbCDY6tooYeD2FVWVAU15a
	jqwYaHJpy6kFHa0JN81Zwqyh0H4AqcgVjjXI6HDRvhYGLUvDYyOFA60EH8J/UeIi
	r4RKeQ9htEKBKl1761CMlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742487102; x=
	1742573502; bh=bBqV42+P/gI8DlS4mSCj8eITiLILWhA6ysjFZP5mBJo=; b=W
	ghGxeb0PByhr9ScrDuEx6MIAbs6OP4XPuPdSxF/DSEy1RxWAmgpyP7cEf7EYWdat
	g2fn2kRhzeuRKMrh5xAIYzaHwcafgBrEwfR5XiFyaiqgEFRgFABrKrZKKyEPC2Oe
	OyLWb7D41R/m3LCAEYfSqLke5MnVpaSYzOOCdeH2SnZgWwCfIazLxjWg5HKurYKB
	LcEJcfs8ezzSD4/NDjRGKUIRbDyaXLexCbldIQ4eW6yLwYJ0SLRONuDlasQurNkc
	G+4tIepj5DSe5wjq/zO0uHzSEcd5V+qaRgSdhiJi+b5HVBygQg+CuzrNAT0HRtlf
	PzY2kW1GotdULRuioyzrQ==
X-ME-Sender: <xms:PT7cZzeP3LzMS0sOomjgkL9HV6rCv8d-DKjj56GoM9frOO76BlPfnQ>
    <xme:PT7cZ5OAPpPZTDo_N6hHzpEr-b1ZGJWfdZ0-aldeXfSGzMcKX80srTDkZYtZidsEW
    LM0HmohOm90b2La>
X-ME-Received: <xmr:PT7cZ8goBdJ_5UiaBxJCEvg1cwB2wSl1hh7JZV83sBel7LPZy0gda-nK8IeewEfFFr6HViZhiym4LjubIMUeC0mlaMAvh6jRhoiHI6IrflNAfnyIPa5y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvg
    hrnhgurdgtohhmqeenucggtffrrghtthgvrhhnpeefgeegfeffkeduudelfeehleelhefg
    ffehudejvdfgteevvddtfeeiheeflefgvdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohgrnhhnvg
    hlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopegsshgthhhusggvrhhtsegu
    ughnrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtph
    htthhopehluhhishesihhgrghlihgrrdgtohhmpdhrtghpthhtohepjhhlrgihthhonhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmshiivghrvgguihesrhgvughhrght
    rdgtohhm
X-ME-Proxy: <xmx:PT7cZ095GVwETbIGyaEMghTtNahP2M-UomUOPjdGanASMHs_XcX2oQ>
    <xmx:PT7cZ_tk7ayYXrcSQsO_t8gn7B2-ZLe5YfxvuYa45RDzqPXmA2qWxA>
    <xmx:PT7cZzEdGCyeKFLbjXsbUEUb1lRZd8YVYYCxlY0gl2SmN7TSCIFoYA>
    <xmx:PT7cZ2MFSEq3UewMQQrKupSLfMoiGZ0hBR3qNjtsaAighIZi8GhbqA>
    <xmx:Pj7cZ49V5TQhAP6CBivajMY8lWePJVizxng_QhCqyBgCrLRlqllq1mAP>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 12:11:40 -0400 (EDT)
Message-ID: <5e32597b-00ed-435b-b041-50668bf6d73b@bsbernd.com>
Date: Thu, 20 Mar 2025 17:11:39 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fuse: Clear FR_PENDING in request_wait_answer
To: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Luis Henriques <luis@igalia.com>,
 Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
 Miklos Szeredi <mszeredi@redhat.com>
References: <20250319-fr_pending-race-v1-0-1f832af2f51e@ddn.com>
 <20250319-fr_pending-race-v1-1-1f832af2f51e@ddn.com>
 <CAJnrk1aqS__AK0=hUkDYUPd6_BP8Wx_y2j1q-H06amA203t5Ag@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1aqS__AK0=hUkDYUPd6_BP8Wx_y2j1q-H06amA203t5Ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/19/25 22:15, Joanne Koong wrote:
> On Wed, Mar 19, 2025 at 5:37 AM Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> The request is removed from the list of pending requests,
>> directly after follows a __fuse_put_request() which is
>> likely going to destruct the request, but that is not
>> guaranteed, better if FR_PENDING gets cleared.
> 
> I think it is guaranteed that the request will be freed. there's only
> one call path for request_wait_answer():
> __fuse_simple_request()
>     fuse_get_req() -> request is allocated (req refcount is 1)
>     __fuse_request_send()
>         __fuse_get_request() -> req refcount is 2
>         fuse_send_one()
>         request_wait_answer()
>    fuse_put_request() -> req refcount is dropped
> 
> if we hit that "if (test_bit(FR_PENDING, &req->flags))" case and
> request_wait_answer() drops the ref, then the request will be freed
> (or else it's leaked). imo we don't need this patch.
> 

I thought I had seen a path that was holding the request, but now I see
that every __fuse_get_request() actually also moves the request to
another list. I'm going to add a comments into the next patch explaining
why FR_PENDING is not cleared.


Thanks,
Bernd

