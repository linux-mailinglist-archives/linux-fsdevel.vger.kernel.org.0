Return-Path: <linux-fsdevel+bounces-57957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 274A9B27012
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 22:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC5BA20705
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 20:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605742550D8;
	Thu, 14 Aug 2025 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwHUfZ34"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF5084E07;
	Thu, 14 Aug 2025 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202532; cv=none; b=sMD7/G9Cy3Np87SO67C1czB5FZDVGuYZCrUEXI/+iD1GWtVXsSqUe1rRboI2seqB7zGheAF9mTUzAeyHtjsWdRlLu5c/3dalWPYFiZvoU6mWTogz4MlAsXBii7mjOhmAI2AW5beJtjrvEeiE98jeCOelCWTFQ0qZ2n0UNHjcdOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202532; c=relaxed/simple;
	bh=n2y6rS/x9IlvE+n2myLhZ0aWVJ9Z7jAwjl1NrwAxtVQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=aqIXMDDVCCrJ2LvYrJKY9hWRzg3FevohMgSIV1vl98j7EvVPn8E8ZHq6BMyyOX9ry3txZZwUT+iF1wHs5Glm277e+KYI5G5ucVRbNJ2d1zUR3MPo/4hYOt60jVA8vjVcQ8R8h65cYUbXVnySgrumJszqDQxO7wES5E8uE/BUstM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwHUfZ34; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55ce5277b8eso1420637e87.2;
        Thu, 14 Aug 2025 13:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755202529; x=1755807329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpfjA5K7h+Ri7MLKJjSWhR0szYf0X0LofqrNr8WC65I=;
        b=WwHUfZ34vQzNUbuvYDmh4i///XH8yMkn0w+fyN08Y3ZWlR1As2sVJLOFZkz7Rmwz6c
         zk8MVYnEls2rdYgNvfD1iUDPcvil4HwnNKerHHvp0YqWhkHIzrCLFK3GBDzjTEZXwTw7
         cjnE1x8bH3xE4sfGowUntAC3E9jDoXwh87ABPUZUO7UamWqXGUC5Qpbja6OXc8vHWLvS
         HJLGT3y6Wp0FjOPEw3SG3xbe91ezVX9b8F0gSaNxl+xiRXlRJ5hipxZyxMTRT1imPL91
         hK6T8A0rUwaWcMSJdcOdaS52E3joUaLureMffWmz7XzozckbwNnRc2CwAfuAeboEbCXw
         ESSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202529; x=1755807329;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zpfjA5K7h+Ri7MLKJjSWhR0szYf0X0LofqrNr8WC65I=;
        b=bcn2dO3sRW86Dq2P/s5yU/xw9QxsyMYyzICJlgv0585bvm2TtO25YBngiCPyBX64wR
         38SehPQu6a3R9MyknfoIOF+X/cKSC9XkmTMUEBcxVWGVZ2GfTljXLDpQhnwpOJeZcJEh
         YKY/E7PZRb29PMVnZUP+3IZVGU2ZiuLXDcI820ZaC6uxK/2+3/2T6JAsfxKUNWlwBCid
         QuystFALeP9j5MqfjDl+kF2uO/ZuPmatVockMfGgZDrgJjIQtv6EsMTJ4xmJHt8VlZee
         PIT9J9Inh7oS/6eRIjOqzD3SetZHVWGkCQlhMWOw9TpKAod5xM/2BVuRw+GiAdZ4WR3c
         U8gg==
X-Forwarded-Encrypted: i=1; AJvYcCWv5qmsaA03cbxp7nEWgaBfBgzl3yOSlLf0qH3hDb1yU+bzSyPZKTE6nwLlgMEpkm7qrtbU8RwYmQ150J3f@vger.kernel.org
X-Gm-Message-State: AOJu0YxMMSvlWzECPwwxnmc6fnRRmriVgSy+gdNwhVL+XgHUhah4192O
	gbwY65uM9fsAtOOvDnvRcja7CnTwL99CI73b6L09Xkx53/YThlb2pniJI0uVuA==
X-Gm-Gg: ASbGncv2QtQEZLUXsWyd73IuIFFbwJafTDIUGSLN0dxlZ9W220NrJ/g0jCkDz3gd1RD
	1ObXUnXPvA4EmP3R6cEoIEMGTLuWbrh6sBAgXL2PxXKagc0TbHrYH/S8Fp3Mw2ONJHBlYiolxTM
	+Pfn8hi9nfwm5CdOWS9HLV3wQFmMvq3XikxurFBMtJK0tsxhdERY5EgvCQ5fuOdfL8sPpa9KPdS
	8yVGW4D6GAvtLqrLvqkTERjPYwZ1vsVbajFsxXyl29Iw+EcSmiKYaZIg8hUEKc8v4qLErAvmU5u
	gmr04IBj466UnpZBQSVTwA6KFtu1WLSJMrxrJot6MIuG77eBmBQDiUmgxGoKLMsa6dmf+UIS/x5
	qM0DjXuEFDu04q97wZV1Pker0+/qE9Ichjx5NeJ8wOFJLM4ZlW+QUkBijldcvmcRbDpGFaKM=
X-Google-Smtp-Source: AGHT+IHEbt1/DEb7hy0YR/PtOqlpnVbNFwmZy85JZOjaxWrztrZ9sHwVUrGkIuBGz05srgw7M91r3g==
X-Received: by 2002:a05:6512:1410:b0:554:e7f2:d76b with SMTP id 2adb3069b0e04-55ce50667c8mr1258757e87.56.1755202528823;
        Thu, 14 Aug 2025 13:15:28 -0700 (PDT)
Received: from [192.168.1.176] (h-155-4-128-119.NA.cust.bahnhof.se. [155.4.128.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55ced0aa992sm59778e87.156.2025.08.14.13.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 13:15:28 -0700 (PDT)
Message-ID: <4074e944-91ae-43a9-beab-12dcc27ad9aa@gmail.com>
Date: Thu, 14 Aug 2025 22:15:27 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alfred Agrell <blubban@gmail.com>
Subject: [PATCH] Documentation: fix linux/linus typo
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: trivial@kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Signed-off-by: Alfred Agrell <blubban@gmail.com>
---
  Documentation/filesystems/proc.rst | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2971551b7..218dbb67b 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -459,7 +459,7 @@ ioctl()-based API that gives ability to flexibly and efficiently query and
  filter individual VMAs. This interface is binary and is meant for more
  efficient and easy programmatic use. `struct procmap_query`, defined in
  linux/fs.h UAPI header, serves as an input/output argument to the
-`PROCMAP_QUERY` ioctl() command. See comments in linus/fs.h UAPI header for
+`PROCMAP_QUERY` ioctl() command. See comments in linux/fs.h UAPI header for
  details on query semantics, supported flags, data returned, and general API
  usage information.
  
-- 
2.47.2


