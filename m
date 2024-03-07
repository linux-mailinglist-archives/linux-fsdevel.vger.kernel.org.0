Return-Path: <linux-fsdevel+bounces-13916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566D187575B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 20:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D781B1F21DC9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 19:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1E61369A4;
	Thu,  7 Mar 2024 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="pYvWWrqD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aDGBsK5k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A545F12DDB6
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840358; cv=none; b=XKGQwXMA9yChqGcCCHTOvSZ+n6FCMLyvHviDXkw2DmA6GVGdpa49mHbsCcPdN4jzZqph6nhc00NKxl7Ng5WzD9CKGTri3LIKXi/hWmuQmUrrv68tk/zv3nWP5Yl+8T+p7qUPhfxxEiLsGExeM6Pox51TCKyWmt0p1oYyLPXmj7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840358; c=relaxed/simple;
	bh=qAZwV+wARTAQ5reLzxsvXekBz54O+I3J+/DiH1f58FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WN6QyXtVmI7Nch7bu9fGU4OWnG7j3B0eEqOtHnMuZNvlr8ctbDVzpSYh/SYfElZ0350yr7b3ECkjE/YihKzhHHCY24yAVqLhPGM9ZcVm5Fe5D2VdwsjhxXRiB7AvwVukngK79VdnPrD+FR3IaeaRjPoEZH9Oo8V3+QBmS+biqB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=pYvWWrqD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aDGBsK5k; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id ACC821380169;
	Thu,  7 Mar 2024 14:39:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Mar 2024 14:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1709840354;
	 x=1709926754; bh=mvQzLquZASfLJpu7BuPhSnA/1eMFn7fAj2vUFqn/E94=; b=
	pYvWWrqD5GlzUb2vPRQO8L5vW42kHG1HOjcfW0Nfxt5LUZr8BxBVBZgc8mdUCauc
	/AEFLRb+qYEyUtuyWh8tLCcI+bj4rS+nZLkd9TZfxoYz/G7SmHwyV8JojP/AQmmR
	9YyMTWVhcTT36qTvDfUDG8M1KKdN06Popl7Z5WrTtlMPp2QG8gFGIpMUKzUqJAZ0
	Tcoul6YnzKiTk4L42CfnHM29kO79lTQkJ9HcqGK8l7NCTdZIJKAW7pfCb3SFBxgY
	NfDhPZc0phhfcV9AW4SYTbYNi5uE7n9gwND+y2yNwjJGW5dahduve5kDQ4yEKSL7
	d2q8WvvnN0QLznPOafou0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709840354; x=
	1709926754; bh=mvQzLquZASfLJpu7BuPhSnA/1eMFn7fAj2vUFqn/E94=; b=a
	DGBsK5kkzT5AN9obE/HytYXc/A9Ouxgb52e4NRaSH+sitKMpZZ4BfX90wl/F+pkV
	pFgEb4tGOABniD1weEXHTS1yk/ra4KyZT1DeZb8hDhgPmAhShNGKqyrM2PgsyB1I
	mpK4z6DVHXPs1MsNPx4JjIGH6k00wTx7Hlax4bJ/oDG48aaoI3WmkOFjkjo0uX9f
	Qkx4FrgXQ0klVqaHuKFjj73AGp4VeAya5tIoc7GS0S3FQO4MNTC5drT+kvjBBcTu
	1Ssr/64QUHrDMaTvAf3rY3fS23ntr0kwBHN0K6+H1Oml/wextaalWYdVDc3+fJri
	MMtdNJrGi1JwKm78TK6eA==
X-ME-Sender: <xms:4hfqZQHivgUhWuuxH4lYljWNyfKEIhBEnF8WMmusk6rMViY9oUaKDg>
    <xme:4hfqZZU8NXCIPkMt921F8jyi8JCeJjK4eyVMsbGhWXiSk_J2fcePNI_pKN8Bb2TF0
    JRmy3MvH1JW3mcP>
X-ME-Received: <xmr:4hfqZaIB1aGCXIk_fRImHXB6guO1PMXhscajxoPabdl0tFpc-0RhW960ezZtVpK54CXNA5h6Xpqm068jdov2Jl4CQNp5hmHnGg7D6GMiDTr5SZfu_YaS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:4hfqZSGqZIlPNbZsqPL9HxVVyZ_7yrNulrrME5cbUPiPiNXAEuvHEA>
    <xmx:4hfqZWXaZaGhQ8k6cO4pcuqw3bpoJLZVxT6fyJ3DDzJDrCeT3LVpLw>
    <xmx:4hfqZVNXl6Ybd5GL6ZbIH3bKkVe12NOAVuaVir6Nlp5sGxcLduxbZg>
    <xmx:4hfqZYLJHGf5EXicnglgJVlLuFDxiwEaJPa3NHZDQkkW2uo31TEh3w>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 14:39:13 -0500 (EST)
Message-ID: <64c77449-f351-4c08-9ca5-e17397b05711@fastmail.fm>
Date: Thu, 7 Mar 2024 20:39:11 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: update size attr before doing IO
Content-Language: en-US, de-DE, fr
To: Josef Bacik <josef@toxicpanda.com>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
 amir73il@gmail.com
References: <9d71a4fd1f1d8d4cfc28480f01e5fe3dc5a7e3f0.1709821568.git.sweettea-kernel@dorminy.me>
 <20240307160902.GA2433926@perftesting>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20240307160902.GA2433926@perftesting>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/24 17:09, Josef Bacik wrote:
> On Thu, Mar 07, 2024 at 10:08:13AM -0500, Sweet Tea Dorminy wrote:
>> All calls into generic vfs functions need to make sure that the inode
>> attributes used by those functions are up to date, by calling
>> fuse_update_attributes() as appropriate.
>>
>> generic_write_checks() accesses inode size in order to get the
>> appropriate file offset for files opened with O_APPEND. Currently, in
>> some cases, fuse_update_attributes() is not called before
>> generic_write_checks(), potentially resulting in corruption/overwrite of
>> previously appended data if i_size is out of date in the cached inode.
>>
>> Therefore,  make sure fuse_update_attributes() is always
>> called before generic_write_checks(), and add a note about why it's not
>> necessary for some llseek calls.
>>
>> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> 
> I had to ask questions and go look at the code, mostly because I'm not a FUSE
> developer.  fuse_update_attributes() doesn't actually do anything if the stats
> aren't invalidated, I was concerned we were suddenly adding a lot of overhead
> for every write call.

Unless the timeout is set to 0?

> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> 
> I have a question for the normal FUSE developers, how would one test this?
> There doesn't appear to be a mechanism for writing stub FUSE fs's to exercise a
> case like this in fstests.  Is there some other way you guys would test this or
> is this something we need to build out ourselves?  Thanks,

You mean for xfstests? I'm testing fuse all the time with it.



Thanks,
Bernd

