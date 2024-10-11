Return-Path: <linux-fsdevel+bounces-31658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32973999919
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 03:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CFA28580C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 01:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F1514A8B;
	Fri, 11 Oct 2024 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WDyTdPCg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BDDD268
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 01:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728609656; cv=none; b=KXVKxMlNCbHyWz23UcQTHdZcj2EKJsYFs2+xJ1fxB+Ub0Y1Wa608RjVmcq2maaHLHjmc+QFub2MaL8V6gEcW5L9fWmNnkD7b/3r7tDmXIKz24/pU1oym+Q1CYWbmYwD8DfjlkZCzEtsC8CgTSnXnwd5qc6toLgeOIUIuYU/EeUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728609656; c=relaxed/simple;
	bh=J86F7ed2RT/zbDTY0+kRdaTBCoGcZk0+nMD5IAWs8Sg=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=ClljWQe8N3ifgXBXylY3cPmyrTlmfYK26vXU67vpUrI1OS0OErlcMn57wAwJJDp0RRU/DFdC/NqDGeEKPQercAIm13N+due7j18kW2owL7aWJpBVLP7es/kq7JWvxT5nhoD/lG8MJhBDzRhg9m5sHNE9pct8nguz4MFZdfJ9zUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WDyTdPCg; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7afcf0625a9so146822885a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 18:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728609654; x=1729214454; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIiCQI9CBnA2xpryLIp9qGO7nsfK27rCMlDOpUtgb4s=;
        b=WDyTdPCgraeqYTt7M+8bPd38vqtzwxYszswMBFI0zkQIP7SWxDr5bnu84setloM3gu
         J9lv0qgujJvhfEApub6LH0bU/33cm3cB2ikeoWBZAlNeaVi7bfyVpILBx45RM87lUnnW
         Cqls/X89EhK2+7n5YaTfxzoXnn6SLsOEtRLtk6obQN3fLejPQLDXHC2AB/zqhO4g4cz8
         1YUZHuPO8ObAKSUJDgyHvXBIcU6k0+WcQdU6LL6SFk4eY5XzysjhSYSX1w1LVa2gb2OT
         soYIGQl4NEoInNFmhykq0BG2xnBC/aYBE1aBXkkvJVVPo8rkybJCiLemYAzoMP4j0Rxg
         AJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728609654; x=1729214454;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eIiCQI9CBnA2xpryLIp9qGO7nsfK27rCMlDOpUtgb4s=;
        b=YcZL62HgKAl8bhqiDe3EBLSCoDtTLDBWnSwxfLkuLrhA1BoJlWmVt+ZKXLAEP/5Wr8
         6UPoXX5Euco5m2nXX5yMBIB91wSryEJpyBcwCPeMrbrwydAITPDmPDon0NgInX0neTB6
         TDavyelmOOB4Kii2Gv5qj16LYCItUKCrOmu8JH5kZNZ1EPNqsfmO600vJmYtgubiWcB7
         V179Wzj6mBp3HqQ4haDNVsX7eSbhETuTXzFSyQrA6qvVpj6Wzrdw8R8N+sCb/jEvywZI
         HYLEGnJ3Sct6OoFUY4Y5yKrbHxE1tJMbXlhdN/iCnumpNdhOuO/VEYGgHHXNDVuwt2dC
         pAhA==
X-Forwarded-Encrypted: i=1; AJvYcCViSUlYjpQ1fx7CWglWmk/HhtNAkEl6E197o+GcwWrA5LH3DIX8IdroPDaDVhL+0flvOc//d7IM2+CaQ84Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxxS0KakVbADJTKbevxQJeHgBjCfkeTszuIwibM+PcDz3YK1UA+
	4KiDDfbkntHdAx9VJBWMrWt0Tq7BgCXHGMt/qtleHbIrFdF4abAdibpNLCJa6w==
X-Google-Smtp-Source: AGHT+IEbxunoS+zDqrd+m3js/aSOeihIlUwdEL4xLbaY1TX77dBsJbM5oDghN1hUr2RgEyIZ1k4zXQ==
X-Received: by 2002:a05:620a:28cc:b0:7a9:c8f3:999c with SMTP id af79cd13be357-7b11a364686mr199609785a.5.1728609653748;
        Thu, 10 Oct 2024 18:20:53 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11c0a8902sm2964985a.31.2024.10.10.18.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 18:20:53 -0700 (PDT)
Date: Thu, 10 Oct 2024 21:20:52 -0400
Message-ID: <bafd35c50bbcd62ee69e0d3c5f6b112d@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, audit@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>
Subject: Re: [PATCH RFC v1 4/7] integrity: Fix inode numbers in audit records
References: <20241010152649.849254-4-mic@digikod.net>
In-Reply-To: <20241010152649.849254-4-mic@digikod.net>

On Oct 10, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Use the new inode_get_ino() helper to log the user space's view of
> inode's numbers instead of the private kernel values.
> 
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Roberto Sassu <roberto.sassu@huawei.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: Eric Snowberg <eric.snowberg@oracle.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/integrity/integrity_audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Should we also need to update the inode value used in hmac_add_misc()?

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 7c06ffd633d2..68ae454e187f 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -155,7 +155,7 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
         * signatures
         */
        if (type != EVM_XATTR_PORTABLE_DIGSIG) {
-               hmac_misc.ino = inode->i_ino;
+               hmac_misc.ino = inode_get_ino(inode->i_ino);
                hmac_misc.generation = inode->i_generation;
        }
        /* The hmac uid and gid must be encoded in the initial user

--
paul-moore.com

