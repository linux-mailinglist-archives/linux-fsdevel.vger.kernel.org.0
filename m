Return-Path: <linux-fsdevel+bounces-7081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B3D821A56
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 11:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BFA283100
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 10:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB682DDB8;
	Tue,  2 Jan 2024 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="AKGWWcpN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B9CDDA8;
	Tue,  2 Jan 2024 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704192459; x=1704797259; i=markus.elfring@web.de;
	bh=7lTu++jE80Y5lovMDkufPLLBPIN7e6g+jmCCUacF2ck=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=AKGWWcpNiDEpb0arZ5Nal3G8mmlaaX3bo9gtdFy6OW3hzdrQuMDEOKrxYKXIBmrd
	 TGXyO8WkWsyPTZyJs0d0+/o2/nTjvCY+fQjZ3YUeDE3uTpbv0yhwOZ85kl/oTHM86
	 UDhvX2nKRYT4reA8JWdS9u0xzQAF9pdYlhFs9HItK8M7KDIzTlmZ7HAkxwRu7J6l6
	 IRbyk/95VXrN85nBMkaPSLtOKrZIbpmzwcnkZUEsCahUVMdVhZpblbdsiRp/uYL4w
	 foHsjSBU5GidQBfbgyvg2mKJhmLM12br5zycW6lEtIE9k+3yeWlGkE5oZmDY+KLj4
	 VMoStzynGEgjp50w0Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Md6tr-1qkSPQ07MJ-00Zljr; Tue, 02
 Jan 2024 11:47:39 +0100
Message-ID: <9b27d89d-c410-4898-b801-00d2a00fb693@web.de>
Date: Tue, 2 Jan 2024 11:47:38 +0100
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
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZZPisBFGvF/qp2eB@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NQrjPEtu2sclqHgtnO1i2502o/Vpbe3+O2LyKYUhPOToDQSfBRU
 DI7rOJ28yLd4ISEiJ6VGRXezMOWtTYdlCfi3HKfG6pQurU9eHidjkB+YGEo/y7tuhxed0TK
 MAF3cmCrLZYeDdu8sMoqpeiHuINlr7Z1BtBN9gerO9LspTa045EJ4gsRJE973KOusC0izMn
 IDcGgK5pYDpGmLri1V2Ow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:058r1Zkd6zE=;lsl9C7ejOmkA9cjgumy9I5v+6DC
 RSt/fHu53q4wobmXYl1Vk0Xj/ahyq2AmpyUp6n1WYP1wly5YCN8AeAzXFT70txPNHfCZGns13
 LYnRyKzroh9oxMHMcrQ5DbDxq3ei7atfbpa4n20DpqpH+C5G4YyXRgT9dVp3X3rLHti7jsjNY
 hBTsiBn5W9C1EZfYXVwqUB4v50UlsTcb9i9sNfk2alFWJzlZhuHssI81YOHkburO//smyYeOX
 vEkUuqmOAMPnooFQGJkQyVe+4QXckuIArX1t9TaZJ/nUNdofBT1FlzKn7aMG2NW9DTmwqIbSV
 KDSZs/l9iCRl7CxrrL0PWM079oGp+s861fPWJr0pQSRghz5/52+3OR/M/DL2QwseGdYAsdkSj
 vEHt0ZcMe7UrVNghavaM1SznURVQOCFh6olp1JBzjeoPEvmgOuskjvV6OqILZUI9aNenNTqks
 6BEalOiQpLuK/8FnpruTmq4Q9ch2hjI7TYjLLGWpBMgRp71Hgqmo376AgJ7cxrcn1jRFwhRDN
 sBiy8vt18HsnYDF9OddtKQq7twPkVMwi/G5xVE3Ph0iLl4Xx/0sU13qbp0siwGqWsyL+3U+Ce
 LPrbMNt3Q2bt5K6oW/74uWTPwkBcNEiJM7ewOdBqNEOe3f2Q95iBjF2vpOYfRwswajPTjl8mH
 rovEqYQiasPlkUZ6jjjzCV5qkiB7MRgHPP8pWzTJMHc3a1P/SRR8AFZ9JhMtSUmWUukl1+U3w
 u9Cr1HpbZLU2F641+E4VYmbpxxnOxxJHAwcYw+uaaXVX/fwV790jjA6w2C04+H6ePwgckhZNq
 DA3sOkMbgVP0T4bTVgPVL37o+wHrkAIG+dKntNCbJBUNVghTWN4hnFihiGb6JFVjTmx1Rvr7J
 nfLavYLCGojkqZ4wr3ivvqBukyfdc3SDQsCbKA77gW6nGDZQ/wSOFjwL/haycAdppYYxYRp4Z
 Rt3kRg==

> Do you consider more clarity in your argumentation?

It is probably clear that the function call =E2=80=9Ckfree(NULL)=E2=80=9D =
does not perform
data processing which is really useful for the caller.
Such a call is kept in some cases because programmers did not like to inve=
st
development resources for its avoidance.

Regards,
Markus

