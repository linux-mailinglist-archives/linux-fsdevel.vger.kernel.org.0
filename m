Return-Path: <linux-fsdevel+bounces-19688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D58128C89EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 18:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A031C21798
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 16:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D8312FB3C;
	Fri, 17 May 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="EAbYwBLS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E51DDF8;
	Fri, 17 May 2024 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715962830; cv=none; b=PCPzR4JvHZNUA4Fui696Ey9q5JcKheQC5FFnAcqECFNa5VACQgaCNfv2yzGRS5aS2OKJuxFK01xSj2Y93kCEjymYFndmnfIkPH6+yOLUtQkVKdNUsVgQ+hOV6dKr+secs8X04+DR3/GruVc2l+PpRo+FAxVmXPm70GlHdSl9qpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715962830; c=relaxed/simple;
	bh=MhCqEObRQqnJSR8w68mFYmxXWm1UO8FSzDLr2vj0eLc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GJokXUluehgjrS7mcpqa1WDUPm9IIa8KgPnJTy5medOm9KEEy9bNUkiIQ3b31jKZ7FC0CCKBrAtI72R84fY1hO2jkg7aXSM8DvfpeipaxatlUXa4BJr+XS1FmNnedn9qqP5J1VZ9bhtJA26l/pSiSbHt90RKBRqJnLuLmFanb2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EAbYwBLS; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715962787; x=1716567587; i=markus.elfring@web.de;
	bh=MhCqEObRQqnJSR8w68mFYmxXWm1UO8FSzDLr2vj0eLc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EAbYwBLSfbaP7DUcjywthjOZ92Z/m36nPCmGIKQAc0JYoap6mHV8CBWNqrmPu5DC
	 FSkEtomqyovcoyzEvZgpAEdaQt+PYjcVQW9AmBXm271ODYR/Lc340/bSKz2M2q0lU
	 KEkVBc4zmZwk8O+FGXA+jPoMz+BAgfNb1djJFImVUMgAa76k/wMxbjqFeDpB5kKOd
	 msh95+aHkOE7mkPUc52b0H6HXhBYQI6hXRdB6iuW6qR1vViBanX7aBpE+aCrb7cle
	 9k5IUcorUHcF94cPooaWm+/RHRAi9txj0DpZMh3x2jQ24q1jd0bFu5xfuHL5QxrWo
	 /Oyelh2Gd98WUhEqeQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mvbn2-1sNt0130zO-00sfle; Fri, 17
 May 2024 18:19:47 +0200
Message-ID: <3dbe3c6f-e700-42d8-b2b7-574a3fd1da85@web.de>
Date: Fri, 17 May 2024 18:19:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>,
 Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
 Yu Kuai <yukuai3@huawei.com>, Zhang Yi <yi.zhang@huaweicloud.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>
References: <20240517124005.347221-2-yi.zhang@huaweicloud.com>
Subject: Re: [PATCH v5 01/10] ext4: factor out a common helper to query extent
 map
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240517124005.347221-2-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dlvnttXyEIHdwQMV4dHCwXlZtMglBNz+cRMJQ456ZO/CNNYl2oF
 JVULUzrvhC9rwRvHuywnHesK3jkgQgO6xF1FAStHzMURC6XmvCKdRgG+0agTPk+H+ILWw/r
 Oed/KRVPdfx+7kZlydrvDZEs1oVEp1XVt0zB9/nGP/7g/YSla4WflkAT7zOjnQeMu5Q+Pwr
 /BSrI804tjZ17uSh1KXTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b0Ifs6EglUs=;qCx0L091tWWSokjyvY9KnHZSVDb
 tIRIQesyVLuF9y0J7GZ2CMp0cDDrmQXjsVDq20ukGgxlvcmr5rqC7upj8cScR/RFmUzRXjUZG
 rnIvaEaww1MbcCXR7n89sRPox2le36W6+e0WFqwHdjQ5kwTxIUWxbKMl9ncR3wxlL4qo0N48E
 G08D+uZZGFTJERJPlHoqupfg5yZlnRhMJZrSFErdWkho/bH9xeqjsWDWKqDrYF7sp1fG00Ex2
 0OLHce6ltAWjD8Y9/xo9ok9OnjmRxZlyTWt7nqyEeHzll/h7xgXH07Ng6tgSkAqYQJLzXmkk1
 OVf4+7LIABFzWteFAtzyQLYilDLWR2zgC8F/Ln4MikYEhhoWDD79Y/mQHJ56lKGPDSUnbHAMw
 gSBs2OVP7R2zDlw78cQ0fyjvcNSBv8GTSU6m4K+XNPIyg+s0pW0PNc64mScEx2WvxmvikcHob
 7EaGEw0OMtIy8d3BaRJ2XGFrFuYZ8F7rPBxoxMxbcSkGiIqbKrX14gbRrmVmIxMUKF0LBhoa/
 VbZNjz5rlwYGK3bqlgiSLy1rWf25cLNyr3+VgppgbwM+my+P34GcEajQIN7UofpSqyT1uDXO1
 J4NUD37s8dqsLpg0gPm2P+6IE3L9XY5bnydbUaqbvaezeRNW20W5TmMNHZimYyCx8Szz3ee7s
 KCQalqzLce1iT2BAmDa7a+U51RoetM/2dYe2JdDMkppHNfewxJXGulxvVHB6G4TVHZexFbQxE
 HVofm+I/8EF74t4Ghd7rvlc45r+MHzZA+9ancN7OvRQg6T1W6Qngqjl5+a8icS7EJuN26Srun
 r+y+05wNZWLoN9M2aNJLLDn6ycz5NHGBcCuHzdm6LDzBI=

=E2=80=A6
> ext4_da_map_blocks(), it query and return the extent map status on the
> inode's extent path, no logic changes.

Please improve this change description another bit.

Regards,
Markus

