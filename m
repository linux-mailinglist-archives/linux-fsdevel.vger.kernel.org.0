Return-Path: <linux-fsdevel+bounces-47932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD43AA7567
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 16:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B2D1BA865B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 14:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB18256C99;
	Fri,  2 May 2025 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipg8sWW+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A19A256C81
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746197696; cv=none; b=tkUzqZkwlWj1y7mWa6usM50NwdNycroJuKFlTZy4azlu0akaoK0jDGAuxdq7vjcYdFVdA5jguCXCM71KzRPKLyC+leBgzxdM51VqR3i1dvUFH8XbSvyR2V+Z9Y9bPFfPoruRMHh4lzl6MqndanKmueyYVzT4adzgZmK7nbGeS+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746197696; c=relaxed/simple;
	bh=RpJVwCDKSnByw8jtUR+cMwoe+OU/wu1hEclu+sJDocE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Wz2KUWtBfDisRELiLy591b/Ffupy5ks2zRD77kG/IZWOoGvv0gMF5VLmOiEru2DZqR0Ljn3M0qF2sx/ikJ55qXzr52WooqJXYsqlFkioKI2mEMTgPFv4LRh0WTxh4HN8nlChKJVpH3CBp0lzw9r3Ycw46kqPX5Zz9ss0V89kUuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipg8sWW+; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af589091049so1599579a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 May 2025 07:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746197694; x=1746802494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=APu7gvDG+GWIH3CqaZfGtDjeCKACn6athf5zXmMCeek=;
        b=ipg8sWW+RO3PsDQgPyWlbcohGJpxSLAypGyplxCAnf9Vila0qIIWauksYFGKOVp3h8
         Isc2tEIObakhn+4V4nbW3kH0YSQbp/NaIxqKUcEptDRci9skPzcfmTWt0GqcgicfBnc+
         rMlWlpkwzvsbipW1a8OjrAs1OhFBNdvi6O0FXZC4YPB6GihY6F7XEJCYXjCsq3rkz06n
         iooPZJH6fd5/txrB5EF7vR0wWkLieq6f+J12IFH6HCWp5H7xQIaZZ0OiGV/lSx26Am3a
         Aht4UZpEypFR5ZaukxitSLKKFURAVGxJgVu1MCrfE91tJcq7aPagSr8rPF0v39TiCqj+
         nUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746197694; x=1746802494;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :reply-to:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=APu7gvDG+GWIH3CqaZfGtDjeCKACn6athf5zXmMCeek=;
        b=l4htV7u+v2b8YMeYCvVqEmzynYqcqKk1v7jEYO7Zdo6Wa2Mgre7mLMEziUU2Ru37Lu
         x7apVjcz76AF/KcOKFH9PbPiTNOp4KY6Hy1HS37+HhQpF4l32CKr5gQ4AMbhgC0LuR5S
         UG/Nr+ItJQkEK7uUwSiYA2IH90tGhfEjPOa6H4WkGaX0M9fSku7cxiAH/VMA6nZqzpNC
         VrMakeZ1tJsT0TR7MmsLK17arAovPtb3LKlgJEW+8CQoSu6+B/VHYK6M8mIzL69K6/5e
         oe6fJ211MFiNX3H/V2fcrO7strHF13ZSv+rrg/Ha+Vb6vGFCnCO5/Fn/dPVBVkii0nSW
         invA==
X-Gm-Message-State: AOJu0YyTNKjCLTYJXrr2SKLLPN5JATHEdQVpx4yH6cD7reICa9+Aj7Yy
	RscodSpKwB7WNAhiBwfaomrulYTdrJtuBHFMkAXEgGkLgmCTsN55DDLVsPtqAh8=
X-Gm-Gg: ASbGncu9uv2FiORnk62B2NNHPs1QCC5Tw70wUruwJFmpI0uwUvBbvyD3RziiZJZIRCF
	ekBI1KoOSgxemw+ZcOjzLmtcHU1SRRplOMf2VGwGoRSw+ZGxWpl/oWHVjfIWH7KvIycBBEgytZB
	EwD44TYIoWaEiqlTWbuqIWHvXw5d5QpmcuZZhWS2DbM19sXCdxHZEh0wo+cKZUFvEDP4k8O+4JT
	f/JMVSNNVibZxjWPLe0+pvIIyqYZrrZzdyjnYSAFlSOAZITJbrwEK49nLVMtkUb0MKccFiBlI2E
	l5Ph9gddwuQK7JG82RoYEy9VUeh6aPeOHmcLPi+7s8EERb9XhqcEQOvhP4PaMlNoCYn6DvKOPmE
	Yfs7iyT+uQ80zOua1
X-Google-Smtp-Source: AGHT+IGxo9c13ps+OLbXDL80t7q4tXdQKgx5Z8iaB4QVaAToXzlRcys88xSVCbahLBH8/2L6G6DIVw==
X-Received: by 2002:a17:90b:280c:b0:2ff:4bac:6fa2 with SMTP id 98e67ed59e1d1-30a4e5c4d9emr5815641a91.16.1746197693830;
        Fri, 02 May 2025 07:54:53 -0700 (PDT)
Received: from 179-190-173-23.cable.cabotelecom.com.br ([179.190.173.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a3480f0aasm6423373a91.35.2025.05.02.07.54.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 07:54:53 -0700 (PDT)
Date: Fri, 02 May 2025 07:54:53 -0700 (PDT)
X-Google-Original-Date: 2 May 2025 09:54:50 -0500
Reply-To: sales1@theleadingone.net
From: Winston Taylor <sglvlinks@gmail.com>
To: linux-fsdevel@vger.kernel.org
Subject: wts
Message-ID: <20250502095449.A4D814737FAB33FD@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello ,

 These are available for sale. If you=E2=80=99re interested in purchasing=
=20
these, please email me

 960GB SSD SATA 600 pcs/18 USD

S/N MTFDDAK960TDS-1AW1ZABDB

Brand New C9200L-48T-4X-E  $1,200 EAC
Brand New ST8000NM017B  $70 EA

Brand New ST20000NM007D
QTY 86  $100 EACH
Brand New ST4000NM000A   $30 EA
Brand New WD80EFPX   $60 EA
 Brand New WD101PURZ    $70 EA

Intel Xeon Gold 5418Y Processors

QTY $70 each



CPU  4416+   200pcs/$500

CPU  5418Y    222pcs/$700

 

8TB 7.2K RPM SATA
6Gbps 512   2500pcs/$70


960GB SSD SATA   600pcs/$30
serial number MTFDDAK960TDS-1AW1ZABDB


SK Hynix 48GB 2RX8 PC5 56008 REO_1010-XT
PH HMCGY8MG8RB227N AA
QTY 239 $50 EACH


SAMSUNG 64GB 4DRX4 PC4-2666V-LD2-12-MAO
M386A8K40BM2-CTD60 S
QTY 320 $42 each


Ipad pro 129 2021 MI 5th Gen 256 WiFi + Cellular
quantity 24 $200 EACH

=20
Ipad pro 12.9 2022 m2 6th Gen 128 WiFi + Cellular
quantity - 44 $250 EAC

Brand New NVIDIA GeForce RTX 4090 Founders
Edition 24GB - QTY: 56 - $700 each

 Brand New ASUS TUF Gaming GeForce RTX 4090 OC
 24GB GDDR6X Graphics Card
 QTY87 $1000 each
=20
Refurbished MacBook Pro with Touch Bar 13 inches
MacBook Pro 2018 i5 8GB 256gb quantity $ 200 EACH
MacBook Pro 2019 i5 8GB 256gb Quantity $ 200
MacBook Pro 2020 i5 8gb 256gb Quantity $200
MacBook Pro 2022 i5 m2 8gb 256gb quantity $250 EACH

 

Refurbished Apple iPhone 14 Pro Max - 256 GB
quantity-10 $35O EACH

Refurbished Apple iPhone 13 Pro Max has
quantity-22 $300 EACH


Apple MacBook Pro 14-inch with M3 Pro chip, 512GB SSD (Space=20
Black)[2023
QTY50
USD 280


Apple MacBook Air 15" (2023) MQKR3LL/A M2 8GB 256GB
QTY25
USD 300 EACH


HP EliteBook 840 G7 i7-10610U 16GB RAM 512GB
SSD Windows 11 Pro TOUCH Screen
QTY 237 USD 100 each


 Best Regards,

300 Laird St, Wilkes-Barre, PA 18702, USA
Mobile: +1 570-890-5512
Email: sales1@theleadingone.net
www.theleadingone.net


