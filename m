Return-Path: <linux-fsdevel+bounces-7130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA8F821FAC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 17:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C0B1F22F4A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 16:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B6214F9D;
	Tue,  2 Jan 2024 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cxt/tmu0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF95914F8A;
	Tue,  2 Jan 2024 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704214232; x=1704819032; i=markus.elfring@web.de;
	bh=YzuA4S6nhHOojFNtxACZ01ivp0AQ+vZQh6tXXT3uSYg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=cxt/tmu0gTkOeM16FCwRmi7vy74xROcj1smMkUn7BfUYHfasx3s23jnp0w9/YRxj
	 vttktd3Eeb2W1tTJjcRBanEnGBNjz3VTPtpMq/ur7cFF4OUCuWO87Y+UpAPvRI0zH
	 z10qgCXBpzHnPXGit13+kHf3ZCGDhqC9f0rInjtQ0Op9JOI7QPK1OnhNANZJATRjg
	 mZ8rZ/EyJHT4m7j/7db1nA45YJGHeMgsEJkTxLQMyM0rk8CojFMTGScN3zIV5podX
	 u5IxtTmOymadbnPwHaPEubNqWy3FitxHqA/bSzmIChB6Ywicj024T1mEaYvXQRQvU
	 mQFz07bJJoL+Pm2swA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIyeU-1rf7AY2eug-00KrZK; Tue, 02
 Jan 2024 17:50:32 +0100
Message-ID: <a08b7922-c28d-4667-b7f3-a4064ff7d6b3@web.de>
Date: Tue, 2 Jan 2024 17:50:31 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [2/2] virtiofs: Improve error handling in virtio_fs_get_tree()
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>, virtualization@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Stefan Hajnoczi
 <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <c5c14b02-660a-46e1-9eb3-1a16d7c84922@web.de>
 <5745d81c-3c06-4871-9785-12a469870934@web.de>
 <ZY6Iir/idOZBiREy@casper.infradead.org>
 <54b353b6-949d-45a1-896d-bb5acb2ed4ed@web.de>
 <ZY7V+ywWV/iKs4Hn@casper.infradead.org>
 <691350ea-39e9-4031-a066-27d7064cd9d9@web.de>
 <ZZPisBFGvF/qp2eB@casper.infradead.org>
 <9b27d89d-c410-4898-b801-00d2a00fb693@web.de>
 <ZZQ5vKRcq9kkQxSD@casper.infradead.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZZQ5vKRcq9kkQxSD@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fgny9c5f2W3jpLqzVc7i9FuUiueq2RLS53d72LSSK3RKZc3zftm
 SsP1AV7t8VO8xthakUAB6NvI3QaBLyBbnq4mrGqVN/LvkJogBg0W80X8H/yrMhFi1YsU4xv
 C2vSlapjMi+j6VketDeCrzsqKvWK1UecJmULvqMgwHTKNURCdcFTpHJVBoWNsEavBDM4uu7
 DM9zSY0XWfHQMyfaA8ALA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:INHlZ34bTrY=;zJ6eL3Bj8LtupwNNsZ/tNpt+E2E
 rhyAK3+huAVszX+0JbpGi64wipqZXXquvT4FmqAX7pGXUkHtAEoOHZIokacWsiAyrws3VQQeg
 DIXuuLYzp0aIuiVIkLmUmqRsavOE26MAy5tZdoMkNJMu7znwwSxof//lHLJHqspM7G04K+1CB
 lgysUAozHm8yIUawO6/9T0gSrzzF3TXmYjwKDkCpGct18rREpOAfzaO6oY5QVX++Bd9W4CHC+
 NbE6zpqSx/pi/ylp/zDkcYgF07rRsGZHbP2E9yASNv43STyAIK3V2W/A7tStBaWWfle82L5XR
 bNWST7bzpauZtH3bauwe0HWUvoMQvjV0qbllMqX8INYz5x4NR87GRSm+VnS6UwEeWSm0v3fRJ
 +iBHgX0EX3lWuJoBp/eu6Tf5ua9nLns/mUzPDtxetGhdLz9LdfLdYX3bv4W7/1IuLOOWuZ/Ap
 py6IlmAMef9Pd1cL9RM1twOr90kLwBsxQbKM/1TqV9AlEh5BGM1tEZHLTouOTfEmA7JdU7tSH
 RWJj9NRY82jXBs2s2ZomWUoqPdjLvmww41zM80qegF4RQrmASVMjj3DFJJJ6JTcTZ4MXDgJK7
 y7GPQ0WHvENX0DUd7xdEHlrViDvcbHjaoEnbiedprJ0iYRZB2RmynuzyeNSTJGtcP0xakIsFD
 Nhyv/faX+I0RWr8Aiz2KX3susJR7RPm4y8nN4i40T4KSJITTgmtrYsTvpuEl9lzcaQdD7Rdfk
 +BjKi+dBPasvlXNEp4iIxEAWpnqdPu/AJp5iJ3UJaC+GEpPZQ1rUNgu/BGtqaQddSiCMLuOXr
 r0CEC5MpHK2gxv/aBAyEJWHVaQMwQGYDXQaR3zVstjx2w1G+f2VFo7fR7HG+hpV6INVeI4flw
 0rkTsIFFgwiL75v4U80TKk11B71DGoSjAR1Cg0V2UtZTsoLK8hSh4YWuF83pWInQeZHeSUoIB
 eLOjiw==

>> It is probably clear that the function call =E2=80=9Ckfree(NULL)=E2=80=
=9D does not perform
>> data processing which is really useful for the caller.
>> Such a call is kept in some cases because programmers did not like to i=
nvest
>> development resources for its avoidance.
>
> on the contrary, it is extremely useful for callers to not have to perfo=
rm
> the NULL check themselves.

Some function calls indicate a resource allocation failure by a null point=
er.
Such pointer checks are generally performed for error detection
so that appropriate exception handling can be chosen.


>                             It also mirrors userspace where free(NULL)
> is valid according to ISO/ANSI C, so eases the transition for programmer=
s
> who are coming from userspace.  It costs nothing in the implementation
> as it is part of the check for the ZERO_PTR.

How many development efforts do you dare to spend on more complete
and efficient error/exception handling?

Regards,
Markus

