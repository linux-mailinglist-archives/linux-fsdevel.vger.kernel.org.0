Return-Path: <linux-fsdevel+bounces-21705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB57A9089FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 12:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52AC82892F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 10:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA554194AE9;
	Fri, 14 Jun 2024 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="Yc+Vs9KW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="glDpqo6d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965A146582;
	Fri, 14 Jun 2024 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361091; cv=none; b=RLGelpMVp/AAZkziFHhFbbOmUlU8OgaMHPdl1KkrNVP429mQXd+o9UltuuHXCmZTho8bHNLXz31bdnewmdaZoeBcveStvKzk5l9SuZeBd0WapCqIw+EBY3Dqdk7fz6eJmh6fDL70UKWmwcNNJBNgxZ3OcpRroLL7pbzaPeMV+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361091; c=relaxed/simple;
	bh=KRkhcV5DWmSQPYcL4vTLlTxYOcRr7pajVYtM2tuwSWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRyp0p6be0XtPSJgzhUMGGGraI3ZfoZNUuaQbiujjYKlfISZuR4wXN78i95ueU5LgwR52itW55wEaxtNObLtD6WZKYKXpHwp2RzjDuuNFuVWq8NxDmC/6G7zJXF9dKrTTfJOqAfqXe9PwiXm+G97FcyB6iqmohg+DVJX1KVy1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=Yc+Vs9KW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=glDpqo6d; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D9AD611401B0;
	Fri, 14 Jun 2024 06:31:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 14 Jun 2024 06:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1718361087;
	 x=1718447487; bh=hC8QiFcNpjGGIN3IDZeBtjO2AURbPkpfzWhgxWF33uw=; b=
	Yc+Vs9KWrfKi5e5zTBXLZmDr31xRRKkHDjTggxv5nSh8SRc4ImvCLUeP7HzsrDic
	rQIxqN8NLyBur3fBJnnQFCR9CwtDCKBAyza/KIK4+8Xbsu+nFc/J4oBJbB0zC1Yu
	LeR3RRVyhNkZti5YultIGnv3UNJedIml+0fF4YdofCjxP5x9gYA5ZBNfMFyNnT/h
	AM8RBpmQk5MBqUoku6VCCzSIbLQN4zQUgPNH8LT/Z5wtm3SZo9EARowoMTRT4UHa
	VbErK0VHAySO/Fj9d1TWQGsnEHOCzo3VrHWxRTOnXKd2CSG2gj39/+0Tqr0/kZA6
	+yj3y/sgv16ld2U0k+9Fvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718361087; x=
	1718447487; bh=hC8QiFcNpjGGIN3IDZeBtjO2AURbPkpfzWhgxWF33uw=; b=g
	lDpqo6dQ8cLRziqb2NPzU+i63E0AtKVVmU+0hp/EgmqAE6fnC9WuCjRKOsP7K3u3
	ZBl96VwvCFsHnhwGIbViBw4FPy+e9E+DAuwbxoVeEtduE6MzuKj3v8Zqei6Q3zlX
	BQLK+OkcA+SL0Gt1UIZk/KEqYay/NKdd/DAyaBjuGIa1csXmCG7KNNc1XUfBWfcs
	t1fyEbfWIShHJmd14qw3r1dwsYrAQByV3PEyyrBPYL2H5Rf7ffTCOkkSGYQWVItB
	oW0bnLCKs5JXWEQBvYOjcxJVXWOZTnXUQP8N7xrENZlwhOePFblxfTqtlU33vtgb
	YhyB+ZWjUQfiOXDPyHEtw==
X-ME-Sender: <xms:_xtsZnHgRi4T4z6FWLt2kH0wLzZjxdJNZB0c-TG4XKSRaTr_lxMPCw>
    <xme:_xtsZkUy9Y95kITwa2Xl7WObP-LWFb7nrAyru_K7WLnjLI1j4n9QBMEbgnZerz8Kb
    aWd6OZcRoiQiHmz>
X-ME-Received: <xmr:_xtsZpK9jLsjPWcscbZAiyjml4el-5KtruX4E8UB7x8ibvy2lgB4m88v7sIzBZsqgCAHwIASbJDtBgLNpU86sF3wR0dYToD4SYrC1l-Xi_fAIbzmX5hv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduledgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnheptddugefgjeefkedtgefhheegvddtfeejheeh
    ueeufffhfeelfeeuheetfedutdeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    rdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:_xtsZlFPufBRzlo5I1Re46zJkUOg__NNmFUCismD-1eAy2FBSHdxBw>
    <xmx:_xtsZtVPGZV4RcKHFz4yP74FiGmMxJPXNw9f6_QlTyzmHNsXHsztsw>
    <xmx:_xtsZgP4wgil2vaEKdOwpJ_h9_Q0a-iOnkGuZCT_Xnm4QC85ziwYYA>
    <xmx:_xtsZs3cN5UzVwfDA8cZNlNrgrmamdg5OORh-Q1wt_Zz7WG7RtOnxQ>
    <xmx:_xtsZjxY6X9HQ7sI2MkHTE0otxwGOQy_1g0iWmSjWND8n52z93dS9kvg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 06:31:26 -0400 (EDT)
Message-ID: <bb09caf0-bb8d-4948-97db-9ac503377646@fastmail.fm>
Date: Fri, 14 Jun 2024 12:31:25 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] fuse: do not generate interrupt requests for fatal signals
To: Miklos Szeredi <miklos@szeredi.hu>, Haifeng Xu <haifeng.xu@shopee.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240613040147.329220-1-haifeng.xu@shopee.com>
 <CAJfpegsGOsnqmKT=6_UN=GYPNpVBU2kOjQraTcmD8h4wDr91Ew@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegsGOsnqmKT=6_UN=GYPNpVBU2kOjQraTcmD8h4wDr91Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/13/24 09:55, Miklos Szeredi wrote:
> On Thu, 13 Jun 2024 at 06:02, Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>
>> When the child reaper of a pid namespace exits, it invokes
>> zap_pid_ns_processes() to send SIGKILL to all processes in the
>> namespace and wait them exit. But one of the child processes get
>> stuck and its call trace like this:
>>
>> [<0>] request_wait_answer+0x132/0x210 [fuse]
>> [<0>] fuse_simple_request+0x1a8/0x2e0 [fuse]
>> [<0>] fuse_flush+0x193/0x1d0 [fuse]
>> [<0>] filp_close+0x34/0x70
>> [<0>] close_fd+0x38/0x50
>> [<0>] __x64_sys_close+0x12/0x40
>> [<0>] do_syscall_64+0x59/0xc0
>> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Which process is this?
> 
> In my experience such lockups are caused by badly written fuse servers.


Btw, if libfuse should be used, it now supports disabling interrupts

https://github.com/libfuse/libfuse/commit/cef8c8b249023fb8129ae791e0998cbca771f96a



Cheers,
Bernd

