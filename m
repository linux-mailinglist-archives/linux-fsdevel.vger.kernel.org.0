Return-Path: <linux-fsdevel+bounces-27948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98677964F2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 21:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFC71F2111B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917BD1B86F8;
	Thu, 29 Aug 2024 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUmRrsBu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A89E1BB6A3
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960335; cv=none; b=VuELGSzcoGUcoNQ57FY7o4MYxO3Dq55lBUr1ZlY1BNy0tEO39PDFM+ymS7ca4uonMbL4qX9Xd4QI0QSI6xS53f7Esm52hDFECPGFBElwiA9DcYNUrlFLOCcHtT3S5EP0DCGYBYR/+GfTGhRND0ZssCCFjHu8s7LCaVIU5El91sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960335; c=relaxed/simple;
	bh=yIhaAHU7m7mxycTRvdt9y2aj+EC5ilivEJEbzOgdfM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JLYB3mA0RUmQXhVv112kLHLWksPPxKTABptAW8EkNOdhW2diuanuY2HI6e/KPyjUfTrYGW6wV81segmhlUutkV0NiSv7GFtSuK4RTgZLHOTMK3/AKiLa3A3wGXi4M+Z9jm2ongo9GifIL0WN8ZIHeBEM1slos2UW/zraQ3eOSBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PUmRrsBu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724960332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yIhaAHU7m7mxycTRvdt9y2aj+EC5ilivEJEbzOgdfM4=;
	b=PUmRrsButOZu01eCC+qEvAvpaQGJGYn8Iwa52dFc5l8DfrLfXUeUjudYLyxoqyGqh6f2wd
	LOM4VvJTPSJEfnneg4BsD8QrjSEgBdKAUwimSkJbZljlaCPVNQiAKc7HVipWTECuzv7VEf
	H0A/RslxbSehN7AkzViodL19b2DkcR0=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-veKtX70iOh-A1GzvspmbmQ-1; Thu, 29 Aug 2024 15:38:51 -0400
X-MC-Unique: veKtX70iOh-A1GzvspmbmQ-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d4c745e31so12829915ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 12:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724960330; x=1725565130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIhaAHU7m7mxycTRvdt9y2aj+EC5ilivEJEbzOgdfM4=;
        b=Z2FVKcv9RLQTFstmiqRS/XTSaY6qtJdm9yrukbR9QHnyMQbmWuRzthbvcXKLOfG48Y
         Z5dEjtJPnrzBvE5qV10+sUuDF9AMChm8ouSUBVryi4EhrYQPPJpg+bb3qSp6WCpp3shT
         4rPOp4B+duw4UIWaJ+A0iFh2WdlQNFPUHttJj0ZglRKnVAGw6nr3T5Py23Bq1D6O/vr5
         FYm64f+htz696IXBcJXWftVCpGaEfDJgQVKCbM9PsmVR8aJTLhWttF4DGOeswSmgas4j
         3shEQXzk1mT+Vi5v8euZpemX/vNsjt02NPF6ndal6//5qHn8fKM6AMKqFVGVV1+ILB8E
         KVdg==
X-Gm-Message-State: AOJu0YwulNjDXdOjCtE6MzhP/zZtxsKdhqWD6AtpBo9zK+Hq024bvap7
	sRq1Lqoy7ciks1ACvPZsq67CT/5Uy/W6J7qmzTCI3yQ6mzVN123lNejEhJUlBO9bZDrqYbeBhd/
	Ew2GG6CyvCwGURZ56Dm8bY/t27F/fqTgzOdKQ4SFNNGEfhh6wcWFCnuqgshiiuacpZWphwPIabn
	/5Rq7+j95cJZA+TKT5kfYrEiYxZr9UasCuCY7jJWHB9JY0Cw==
X-Received: by 2002:a05:6e02:156b:b0:375:aaaf:e88f with SMTP id e9e14a558f8ab-39f3788559dmr45942365ab.27.1724960330407;
        Thu, 29 Aug 2024 12:38:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESimAgagRTywGqozee6yAIFC0XbbQr+O4omW4tzLNBp5Hn4cKJwFSRRjRSlPINqIDmiP3QGg==
X-Received: by 2002:a05:6e02:156b:b0:375:aaaf:e88f with SMTP id e9e14a558f8ab-39f3788559dmr45942135ab.27.1724960329968;
        Thu, 29 Aug 2024 12:38:49 -0700 (PDT)
Received: from fedora-rawhide.sandeen.net (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3b058880sm4388025ab.74.2024.08.29.12.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:38:49 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org
Subject: [PATCH 0/3] adfs, affs, befs: convert to new mount api
Date: Thu, 29 Aug 2024 15:39:58 -0400
Message-ID: <20240829194138.2073709-1-sandeen@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm going alphabetically for now ;)

These were all tested against images I created or obtained, using a
script to test random combinations of valid and invalid mount and
remount options, and comparing the results before and after the changes.

AFAICT, all parsing works as expected and behavior is unchanged.

Thanks,
-Eric


