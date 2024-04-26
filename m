Return-Path: <linux-fsdevel+bounces-17847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E61A18B2E62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 03:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC001F22020
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 01:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560FE6FB6;
	Fri, 26 Apr 2024 01:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHuk+JSJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC365227;
	Fri, 26 Apr 2024 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714095768; cv=none; b=k8zMRZQB72+nhkLXI+21E5OMSV22inYRIhXzxBh3B3aBbqqqAt1sFMoTK+8lnJ/uwB5J9nU+2dby1MBehFIl3DcEYb4yVbyV7aagLOZSRLwjpO1Qay8ah78oKv7x0aiXoqZ6kwMQWd6321oS5H8phYHPhz25oddIEluK98cmfjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714095768; c=relaxed/simple;
	bh=HVwkjenx9A1lf6NBB9XvYk1sKkeGhgxNJO17SZNMT0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MqoVpmkj/mcqKJkE+S9x2xpGhC6j7EByI8u/oQdyi1n++ecfARgYP2+uVV6GcXdyrRMe1tVQGhNB+qGTYrZ7jXemHYEjSr4s183Uts//a1Gfpxp9zrmn3z+rYS4lSEhnNZhKeqhT4GrPA2wxnhGWQmqZ38MM+ta/vADCzqcriBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHuk+JSJ; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c6f6c5bc37so865994b6e.1;
        Thu, 25 Apr 2024 18:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714095766; x=1714700566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVwkjenx9A1lf6NBB9XvYk1sKkeGhgxNJO17SZNMT0k=;
        b=cHuk+JSJy+Jvz3GGJvxCJr525sJ0Pc1ZlDt5gmRjPfcHn96hB46Q7k19v6igpNB3GH
         GLcCJRyFOJ5pqdLg0ccWg+9WUOw5lBIsGflopFEVvK1Gq/jGwEb0PyoUkEI3tqwLvdre
         eUR/xp2m/jdpD9vGkAgYbJkxPCRkE+0EGj1GUbnMIwW2hyQ4IPKJ+DRgzalpoxaXDlMK
         3xbVNHd8WN6RcKMwyeBy4KV6P6ZTU7LX8kiyRmpEu5PShKZB4dS+rMxphhTRhEP+iZGV
         +gczaSh/FymT4xhC8kEs9RR30j02T/U67STd4rNTMiRSbnCkmkZYYmXwdM6GiHUVsJsD
         PbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714095766; x=1714700566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVwkjenx9A1lf6NBB9XvYk1sKkeGhgxNJO17SZNMT0k=;
        b=Gmr2ey+V8LP4RYZg23AfsNK/6lv0zxLrmD/Tphqfkwd4kFJ6BTMhj/AoR0TcdGbD5V
         HBhD0Hi0FypMPPZtO43THlWTKhJLGVnkpqCchS1o4VOYlVGJxjvHXhiUj+GTRnj0i6E6
         1J0MaOcdnVR/1vvrhLESyg+YoWWfDWnEqH2TtZ2v5B8OoXXm8ZaNVAcV+OkMVUBKfL7B
         CgUEP2ZyDThqgbqzLOdxbV4LVns5SAWo5GJ5IOVmDVUpe5AruMbksTQTsbj6FEfzXZ3S
         Xol0P5FaqFF0todfWXO1SxZg2dotOtAzDHjvdjzeZEP/AiwLI4ufJFJ1uARaPDYXEdlq
         hx+w==
X-Forwarded-Encrypted: i=1; AJvYcCU4vi1JXKZOP5RGuNvqAxGMMOXBgF/BB4eiFhMrywuyvUDxpeFRAY9qfvj4maYAlDVmNaaoQ/j6Cn2eJXGaepqCLpb7INDf8VldO06huJO0zbF+QXBDtqqNdUv/8Hzg7bO8ep+oQFSnmkKz7A==
X-Gm-Message-State: AOJu0YwNdNlNbo2U9SBLTRqum7hMcKCnKJlGV6LkC2TXoOIzRtTdQpNr
	pmO1JwIUzbqCiACLQ0LyVmJouRV9vu3zgESIc0vdmcqSuLasfvPR
X-Google-Smtp-Source: AGHT+IFJ2YQlOAQva6WMbhQM5ztMAWWdfHO92djEjAbTw8X7PtnS0eyTm17L8xvnS61GMAoX5Ak7ew==
X-Received: by 2002:a05:6808:6343:b0:3c7:12d0:9bdb with SMTP id eb3-20020a056808634300b003c712d09bdbmr1518756oib.23.1714095766509;
        Thu, 25 Apr 2024 18:42:46 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id s17-20020a056a00195100b006e664031f10sm13768259pfk.51.2024.04.25.18.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 18:42:46 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: willy@infradead.org
Cc: brauner@kernel.org,
	jfs-discussion@lists.sourceforge.net,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzbot+241c815bda521982cb49@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] jfs: Fix array-index-out-of-bounds in diFree
Date: Fri, 26 Apr 2024 10:42:41 +0900
Message-Id: <20240426014241.51894-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZiqNMLWFIvf43Mr-@casper.infradead.org>
References: <ZiqNMLWFIvf43Mr-@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Matthew Wilcox wrote:
> In your earlier mail, you said the large value was found in db_agl2size.
> If the problem is in agstart then diRead() is the right place to check it.

Oh, I was so distracted last time that I wrote the explanation
incorrectly. I'm sorry.

To explain it accurately, if you pass a very large value to agstart
and set the value passed to db_agl2size to be small, it can be
manipulated so that a value greater than MAXAG is output when the
"agstart >> db_agl2size" operation is performed.
This results in an out-of-bounds vulnerability.

And the final patch before is the one that fixes diRead().

Thanks.

