Return-Path: <linux-fsdevel+bounces-7018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708FD81FE80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 10:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12BE1C22DB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 09:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40F810A26;
	Fri, 29 Dec 2023 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="w/0Mlf1E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8D110A00;
	Fri, 29 Dec 2023 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703841009; x=1704445809; i=markus.elfring@web.de;
	bh=kwp02RABdJCyZ3yl2RoylrMKne6oKDRA7rQaRstQKcg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=w/0Mlf1EnYN0Ur/89VJwh68FifaYEyxE28/oywR0ACikQKiPGrV1BWoEH/X9HPS1
	 LaspxeVbe1bPLRS4DMYi7uMRuzUc4A+GqZpnzAxTYS+9+Q6G6+NlSw4XYqsP5Y6OU
	 kOwpyVxZCd3zjrzUd4yyu0gf2kHUc59AJXDIuZx5mAWe1gk8rEREY3b07MTn8xa5b
	 i33jOxc/FZIQ4ThGMf48a3xmaJz6/1e4YGpsitX0jQFfBQi/poRpA4/dK1N7ZNO05
	 CfM95utptyKXMkDDMpgzdd5gJFQs1yDcwligZTE+US9XRkTsW/fZjc7LWC/oCCdbW
	 lkWukxTIcwOMi+f2wA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N30ZL-1r7GrE367x-012vCR; Fri, 29
 Dec 2023 10:10:09 +0100
Message-ID: <54b353b6-949d-45a1-896d-bb5acb2ed4ed@web.de>
Date: Fri, 29 Dec 2023 10:10:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtiofs: Improve error handling in
 virtio_fs_get_tree()
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>, virtualization@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <c5c14b02-660a-46e1-9eb3-1a16d7c84922@web.de>
 <5745d81c-3c06-4871-9785-12a469870934@web.de>
 <ZY6Iir/idOZBiREy@casper.infradead.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZY6Iir/idOZBiREy@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t8qsjc2WYogtClPaVEvIXtsNeBDm8MJDsW4YwyyK3rWmuIV3a4J
 QlQx/LBSww/zT37OmCIC+b+h8eAVMaxvyCeDWDe1qh/JuvcJmdUXVXLRZSsXYgTylyS0tex
 WUUn/LBa8ZwmfWwBQXUfadtxSklkmuz6ADt8brttOFiBPPT2QfwBts0LCPPzTpdXhgGQVrb
 Yc+eibgoW9zVV2le4L4VA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1dWv8dhDypk=;y5MKr3i2uBTJEttlXgbnMgeGRrY
 3Or+GGM6OkF/cGX0FbckdLwIJqkA+sPtuSFEv90y5II1CEPFHlsykumPWYthXiPvi6fCidWmx
 zuk2lLqIRUmm5nDYPh36lRkmwz1D50xQvzkyx/gHMNFnKjS/DUkHNXw1TG67PBSsc6xFK8r2z
 AHuswbhFhwdVWfk1Abq1GenYxugBb0HBguYpBNNWEiutYf6HNhieK2efueVqonuJBnBHTr3KO
 9R7+A28uv8IWBLECEmQb/fPN2D3Kwycwx4+lm6PBPl5EtqbSTwawM26T5wYKiE4ABMPk6hykT
 PDvv/Q83HLYoXQeZ5r3dBNo8Rgbya37z3nmO9X9+RGDWAltocxMnLG87pKI7LtYJdy0QHxNxm
 yrdxUDK9CNQHyorZzCzOz42857LRbJz2mcX//ffO5TIKkOkraXRUNi2N5oHLKMKhudMXjEWQo
 YVytx2w63SUXoC6YXlWxI6SkgCO2pOkFkag5Z9BKR0zpmH3iTidyF7ZLHlWldxrTH6O1AM8vX
 /jQGx6CN6X1OcTrJA5Y/za03MfacYrSy8cn2QX0FwgkzTfhAlnkdRErrdCD4wfq4XLItE0hwX
 PKF4XVyLcVgzBb2RcJSdr7VCU2WrIef3Xej36/CALQGGlPqCOgthpPIqh4ZMOCS4zOp8MvM0w
 ysPJkzHyTdfWk/q0ngJlZeVGpc6Rmh4R7ofkpCwFuQO14nrQIraKC5Wm5FnaneltZTMh9rPHD
 mlGnQYcnQwtZz4UF/mYUQL5ywnU37jbSK1CtPPigiUtYGTAckNQ3znAVeQQHR3fTxyb2M9m5r
 nUWLPOlRgtyIt67JIGSDvj6GT6J4ShsRy6aptNNbhyaDTjPAjGSb10tvsqsqMIp8q2nTKPOq/
 goN+6E3Kd09NSHMF5IydgjJUhv5zGC9JiL/Vt4Te2HJZE+fFMjfLUsxWOiGrKamgNvSVgoUQc
 /rUGAQ==

>> The kfree() function was called in two cases by
>> the virtio_fs_get_tree() function during error handling
>> even if the passed variable contained a null pointer.
>
> So what?  kfree(NULL) is perfectly acceptable.

I suggest to reconsider the usefulness of such a special function call.


> Are you trying to optimise an error path?

I would appreciate if further improvements can be achieved.
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es

Regards,
Markus

