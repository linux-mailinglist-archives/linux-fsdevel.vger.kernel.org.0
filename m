Return-Path: <linux-fsdevel+bounces-7075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB348218F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 10:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83E81F22340
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 09:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF1979E5;
	Tue,  2 Jan 2024 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Udm2tBP4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A10ED2E4;
	Tue,  2 Jan 2024 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704188118; x=1704792918; i=markus.elfring@web.de;
	bh=tSNyrdvOrmxmScfoESQeoGJjZVGUwhPYL8i1sd6cwWM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Udm2tBP4J/pdhzcrUlquYZ/Ml4NaW2Z5Hka8bruypnqytiTwG7Nf8eqcwNJXe8lZ
	 iz8dMSFTjAJpZEHCPH5Nd18iA2dYcFkq15GFaE7M2DhnXI9epg5/IfxH6hQCkAr/o
	 5f8BS6DQrr3yCjozlTMN7EyROVMS8KoJeU3Nmu+CrcQS2ErLfRggjGW0Yf/rFjBgp
	 bSbeN+UC/GgBQYTSdGvyDXYYvjUy0sxPN0hkOvwOt7woeBaZzwk06qPZREErcazLL
	 swGkqMY+Ev/Bb3Y6jxBq8pVzApGH57IDcfxbXTXq7IS47mkQkz3J/wZ9ZO/uzkTmu
	 OWqODwJ6knAT0NBCzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIc7N-1rPqVf0ZZl-00EZ1s; Tue, 02
 Jan 2024 10:35:18 +0100
Message-ID: <691350ea-39e9-4031-a066-27d7064cd9d9@web.de>
Date: Tue, 2 Jan 2024 10:35:17 +0100
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
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZY7V+ywWV/iKs4Hn@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WoH4l/kfnG/D1YD+yV/7PtW8vygvEXgrYZtTCzrEtR8rGb9nxd1
 d2KCgCErE3OUiwfidxwk5zEYEyBK3fQnMJclRQNSL2tLRTtVqBWurw9IKowTgr/wKU18Lgz
 Pyq6fdyUTgT9bnpQKXz+EtFKA1pGV1KS1Gbm91FBfLm4hyYpmn5IWu3PZt7uPZgfNin6AJF
 4KZy3HwzXsjySVAtkDofA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Cbq+ZiV+SZY=;Jt3xakHM8aRBkoWFImzl9NKcJMc
 Jt61HqtLCDFYLCp0v/8MdPdAs8HNbzVdui4BKaK/9i9/8NwiMp2ciQ/uDrdLcxs4QL5AjfjaV
 Sogs1IW0o69j9NWQPFZ5XkJfGL0oC5Pq2vWOmMFU34GT77pMbtKSKwKmrZCDOrC20ueIWJsvc
 +GS1UM/dYfPgMCLMu+f3G2pWvYRfT+0mxEMSl4elkSydgQ3MAbcHt0Sq5i1qFb94PrFgVsNC3
 jsd9iTcKEe02bfabtUrT2uQR+en9ZTamWsEJdCBZb3OtfruBvuFaL3C/sAQK2y3WkjPc+8gwB
 Mb2s0xrA0gDA0BAiDij6xeTCgGDUFLe1HxkouFj5xoMlYjqEctBDMtc8JyiZCSXOJWtPqZcqr
 4JlwO7FPw8n/lnrLZygREIQx/ODLs3mIN75vvgFX/aXXkHEc5d2/B5wPt4envf2PVuL4O1rU7
 P7E+EyrWBK4NXmXc6rVyVJq+0+SPRSIKqX4u4pK6+oMTtxT2sLawUlXJrYvHJwC9BAH/S1r3j
 b/l/DSSdMzoeQ9bfnsUeqm8ab4BZKIPcRLtQIasrG5lsl/LiS0wKH21Avgi5+RpSQSna48Pq/
 q2Rmn6anSCzcn0QohSbUXP1mmakNf8z0kTmhqPQfl4wyqoTa+u+SHZqooywxt8+IXRxCPXntL
 ZMurQ2W5DVhHha4v+0+d7HNcLd3T507P6MNE18vEeD75hJd25FCby1WwNlzhnPLxd5d9krc1I
 HDKHNKtvK+B6pTrsEw/pRwJ2ESrqFvL31Wlf2XZ8K7335Fe5775Hs3NVW2Rp8XAbmrkBmTF1w
 TmaZYDZL5hAqrJt7W/X6wJBHr7faUIZBhBE2IDYnyUs/6RS3+4CjGlRhN9DhlpvB9MeeTwfvS
 SHrnQrz3Hdo3EyW5yNYP/IBs6cIBNlM8ExDxkIZLaqkTwUZaBenMFAOr+l2c1S1AAGAj+t8HN
 YkO4Bg==

>>> So what?  kfree(NULL) is perfectly acceptable.
>>
>> I suggest to reconsider the usefulness of such a special function call.
>
> Can you be more explicit in your suggestion?

I hope that the change acceptance can grow for the presented transformatio=
n.
Are you looking for an improved patch description?

Regards,
Markus

