Return-Path: <linux-fsdevel+bounces-60756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE55B514C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 13:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E25D7BB4DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 11:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1B03191C4;
	Wed, 10 Sep 2025 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="c8A0cc9r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12687317708;
	Wed, 10 Sep 2025 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502322; cv=none; b=SxCRrXEzdHwdP0pUoDi83093IffHLNqnq3+4JhtyiYcxpqRKhz+ZY9qWxItKUB0IVcO73xII3bqo1DIPV5fFn7vh5Ec6lOt7v20r8U50j3b3vY9Oh//BIKKeLXOR2u0D1Aje2JkBOFXDp/X9vjhkdJlbTQcdh0Tf/DJtjRuqgZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502322; c=relaxed/simple;
	bh=sF3akI0GjuHGXIByxNa6BqNGYDjg8RePqZb7uOzcxAA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=tNUtKmqwvCqRkKtOR4bwtOkqFeDAzD3S90Px12Ck6RSf+IB8HJ8lMQRmyRzsgAUlBb8uM0Ts+BJDY4QfXpEagGFKXA1c8rpr80MSMXx9wRsOqs30TNBPfZUtE15aJWIZl/bHUNWFvCNWtnLmnJEWQq3GytmOryC8MwnS4iKwEQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=c8A0cc9r; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1757502016; bh=2GMMlW2Efuu8ar1d6ouNZ1NzI1QUxG9UiwKZzqUshXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c8A0cc9rgY24TxM6AFweq43h/+coHOseziu0TkZXGA4/fG3ICqKhWJSJssEQ+eUL4
	 Kkm15rek+8eoSpK2TuXbHhdAU9qwh03OWO7fwzNhCnKI7RSMHMJiqBoqvodoanUmS+
	 +pziQPrGpQfEA3ucCpzuTxLfngKkunrZ+7hFIyYk=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id DBEA0F; Wed, 10 Sep 2025 19:00:13 +0800
X-QQ-mid: xmsmtpt1757502013tpv1iwv41
Message-ID: <tencent_E396DE36C64AA675ED76D1675E3C3D378609@qq.com>
X-QQ-XMAILINFO: NxIimAsTiib4VcPSyhFR2t5kCKkK8kMpwWCp1suQsQYVxzvP+i6q9fbuCfSSBC
	 6jkY6eEzWBYrKFhHRl4ldhuND/inAPFNCxwUlkxVyi2ZLXC50ZlHAdeu5qXMPctrM7MPgdd/kAHL
	 AsQGZkruH0oF4KxN0h2okEcfdTp+62DsGf6rwmG0mmZoU+v/IKAZtZI8DBYGSAUGwhWRuQhlvTu7
	 Pb1F9xODegCAsE0AgCQ0OI+yi2NbL/gDd3G6N9hTonpYt0NYs7LWcQxg/UT00DXx2t7nNxzR3JjQ
	 4hxGaxcW0Oq1s9KSAbSGHhwkkF+OhoWRB/qXUyemAjL8oj4xjNxZhRGHvUz3OfQkY2DDgCPRF0wA
	 /IcZM3Xgz+wyy5f3R7hgG1XgcBy1mMsX/s2WeTiM5tFef9KX6gT2rGTIq7T6NaJNaPzKcjqsi9LG
	 jWJcZAjgzzOoFcg24DIhqx7e14+c3UQA6S5pyZsMaOjKPCGhVa4yj4tkXfe4f+buEvHpUtHadARy
	 E7MTxiOOyqwfFwDpjYEMG58Rg2jcX6xB+DDxk8ALl+SiVlrBibYRFo5nxahSJNZY4VEC7MxSiqv9
	 Kn9gulb+P3oXrJVw6q2S2AqaJpdWDdd5f6PVMZEt8E+4EqKvvKSbjUsu4EwujX24vQUXRw6BG8uV
	 /9SS6z1vojH4eQLf5RToH/o014WchiswRadT0hDqmkRs7c//68qRHnb9KhPBvQ85iuk4KVVwx8vg
	 KRS2AC7Hx+7Y7J421CTHF8cWq/bl88BNCHihY1W2VYiF/zcJrDePmynajeky8K/IYADL3QniyMxk
	 Bu6uz0aAIyps72XUSc573043KB9y0gLwH75Nvgyuh+MOVBfm4xJFvCghO3BYzBq6VEwgnHSdeNmR
	 IUXKjZP2DzqY62Bx/o/2qFJsfmspV/u6HrdSllxZHnCOeSyVbr4YUJszaI+uapjCYYf6qwvtqu8Z
	 W8bY4hhl5CRfoZOm+r7ISoGOaXSV2oavczwkgdILFl+bvrMOuneHOqp3o0ZOQqtQOSsWrsUTlA8R
	 s88v0F7GFlnNdauI2XDefxWdjy5o8FRj2twoDReJMykBywboMebRqlWqBc+3c7cmfSL0VOaw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: dakr@kernel.org
Cc: eadavis@qq.com,
	gregkh@linuxfoundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	syzbot+b6445765657b5855e869@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] USB: core: remove the move buf action
Date: Wed, 10 Sep 2025 19:00:11 +0800
X-OQ-MSGID: <20250910110010.1715779-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <DCP1E4UJ385D.JEXXJV4PPLJS@kernel.org>
References: <DCP1E4UJ385D.JEXXJV4PPLJS@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 10 Sep 2025 12:09:38 +0200, Danilo Krummrich wrote:
>> On Wed, Sep 10, 2025 at 03:58:47PM +0800, Edward Adam Davis wrote:
>>> The buffer size of sysfs is fixed at PAGE_SIZE, and the page offset
>>> of the buf parameter of sysfs_emit_at() must be 0, there is no need
>>> to manually manage the buf pointer offset.
>>>
>>> Fixes: 711d41ab4a0e ("usb: core: Use sysfs_emit_at() when showing dynamic IDs")
>>> Reported-by: syzbot+b6445765657b5855e869@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=b6445765657b5855e869
>>> Tested-by: syzbot+b6445765657b5855e869@syzkaller.appspotmail.com
>>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>>> ---
>>>  drivers/usb/core/driver.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> While this fix looks correct, your cc: list is very odd as this is a
>> linux-usb bug, not a driver core issue, right?
>
>I think Edward derived the Cc: list from the recipients of the syzbot report
>in [1].
You understand me.


