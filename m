Return-Path: <linux-fsdevel+bounces-36061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFAD9DB5BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 11:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ECB5281E4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A73191F8E;
	Thu, 28 Nov 2024 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="IJ/umrin";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="suozB60N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DE218C939;
	Thu, 28 Nov 2024 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732789787; cv=none; b=l+9Sy7iJbIrbiGOozabT9Oxp39dirUG+s9U9YmHsolZPR+SMfLKsJst1zEXd2OMWREO9+wabhgOqGKA3H8V9IAadBk9xbhSBRjjCNyVjguN6P5RTjPMGiXWoxKZY3QyRBc5TMTtgLk/1oakoGOnOrN6WtlLSwK01mEwCv3mXWK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732789787; c=relaxed/simple;
	bh=ecWqAwfCkhOxrNN7c5QkA6mIJ2XsvavIbuhJVMW3neg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+33392adIpc8ebgmKhz06+1Cvm5IHCRLSvsHZiLXo/JyKHxCVDNsFMW9LGxJqCRhMjwrb4bWyIYjSORHNDUdA7GCh4BpjeRncRlRCM62YvtOdivIQN4SxmOjV4d7zyBlZavMgUmalbvhezTS3MfMdzRRLV9uL7u+EyGaeX1euw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=IJ/umrin; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=suozB60N; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id EEA161140220;
	Thu, 28 Nov 2024 05:29:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 28 Nov 2024 05:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732789782;
	 x=1732876182; bh=bCignQmieF9mg1Lihwzd7puTQIZAlFfNfpgmIhK94y4=; b=
	IJ/umrinXzf8skf4LBJBDL420r191l9k6Z0AbRY4EBkEr2NO4jLRH8G0OvNKBWAE
	+7hD7+7OaOu/Gi6sZrt6nj99LS1E1ZPFMGee1hn4+NbvDTG1RQCqp0hzUUYMGG2r
	NcAJj57ajJ19IBqm7CRM0BYQpWe3N6ncWIxhcM6tUKv/H4GE2bwFWi6ZrBbZSUZu
	0EhwWIJJufOaplrzAAkZf8scjgeQ+Cej7upVu/a9melzRe40WDfWb9rARFbXdhgp
	3NK637oObqAhMggMcESwfIejMGOhZ8uI+ZYAljmtS49AQVPjrXM/WR5dRMHQ0gJU
	PhQIRNYDuQTr/UbMeLrw7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732789782; x=
	1732876182; bh=bCignQmieF9mg1Lihwzd7puTQIZAlFfNfpgmIhK94y4=; b=s
	uozB60NIudznA/KuuttmTQtmnEP/qo07XwXdvZTYTk8RTzJd26zr6ixa+GQzSrpx
	43OhVkoxLrvuhdTzfSJwt/7tzgckZBAIVfNoYdKZVsnFzhFherpbxL43RnadKTiH
	G5MdgQ26Kq1xkPamWEAnN/TQCcRsApI4Xn7Xwcrv0rGj4eFR29VXunJ/31yRD7+u
	teK2R1udKeeKaBnqxH+mePytVeqefoVJV/siXxfdXyigv5zRC8fBAW0lPmJdAdpt
	papV6zWvDHPqvU6nhLJz8oDE7PcerJ5nHKyDfcruq9T+rFEX02S9x3vlrx1coL2g
	GFi4Z5WOLyQjCsuPRonBQ==
X-ME-Sender: <xms:FkZIZ2UNB82iORUaQrBUVXSY2Lfh2XcHrngOHs4kPhVBPKwuWRe-yA>
    <xme:FkZIZymOG9mGqamMbyVb7N1wt2Df00hB08FPQ-otEVIFvUoDEbhbJ0JH4VcpWe_2G
    8YUJgledW-OEJuB>
X-ME-Received: <xmr:FkZIZ6a1oMXGkfDQd-qBB4iSVoHwmZX9JCUQzEHpGEHxJaJJttUW9pHnH5yWkO2HVsg7gbBYwswvwNWvjoRsNRXMrKbM4Kf6nPR5wwNnGc-q1m13QGLY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeen
    ucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrh
    htsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeffjeevfeefjefghfef
    hfeiueffffetledtgffhhfdttdefueevledvleetfeevtdenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmpdhnsggprh
    gtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsvghnohiihhgr
    thhskhihsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivg
    hrvgguihdrhhhupdhrtghpthhtohepthhfihhgrgestghhrhhomhhiuhhmrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:FkZIZ9XnizbNjywxQ_oWsulhW7VCmqhyLv5vBFMZNAGEDWntTGSCdw>
    <xmx:FkZIZwnYepb_d6FLntLhbAvINOgwD0pDEyuQN9yx0_IL6Z5tHxllRg>
    <xmx:FkZIZyeumOfRbBN8Gp8_J1kSkRZ41ycCRAXWPd3PdD2t8P-d97KrZA>
    <xmx:FkZIZyHCCpkQMOaJ2Iw-Ho1XbpDuq1OQHDYd6YuHxviRGQanZoGj_w>
    <xmx:FkZIZ_vgU2Vjd0bRTGTcxDc_YsMZxzOOxncbMMa5HfKYbluwkof5EfzA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 05:29:41 -0500 (EST)
Message-ID: <45da8248-d694-4220-a120-3d85a463c0cf@fastmail.fm>
Date: Thu, 28 Nov 2024 11:29:40 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fuse: fuse semantics wrt stalled requests
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: Tomasz Figa <tfiga@chromium.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241128035401.GA10431@google.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20241128035401.GA10431@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/28/24 04:54, Sergey Senozhatsky wrote:
> Hello Miklos,
> 
> A question: does fuse define any semantics for stalled requests handling?
> 
> We are currently looking at a number of hung_task watchdog crashes with
> tasks waiting forever in d_wait_lookup() for dentries to lose PAR_LOOKUP
> state, and we suspect that those dentries are from fuse mount point
> (we also sometimes see hung_tasks in fuse_lookup()->fuse_simple_request()).
> Supposedly (a theory) some tasks are in request_wait_answer() under
> PAR_LOOKUP, and the rest of tasks are waiting for them to finish and clear
> PAR_LOOKUP bit.
> 
> request_wait_answer() waits indefinitely, however, the interesting
> thing is that it uses wait_event_interruptible() (when we wait for
> !fc->no_interrupt request to be processed).  What is the idea behind
> interruptible wait?  Is this, may be, for stall requests handling?
> Does fuse expect user-space to watchdog or monitor its processes/threads
> that issue syscalls on fuse mount points and, e.g., SIGKILL stalled ones?
> 
> To make things even more complex, in our particular case fuse mount
> point mounts a remote google driver, so it become a network fs in
> some sense, which adds a whole new dimension of possibilities for
> stalled/failed requests.  How those are expected to be handled?  Should
> fuse still wait indefinitely or would it make sense to add a timeout
> to request_wait_answer() and FR_INTERRUPTED timeout-ed requests?
> 

Please see here

https://lore.kernel.org/all/20241114191332.669127-1-joannelkoong@gmail.com/



Thanks,
Bernd

