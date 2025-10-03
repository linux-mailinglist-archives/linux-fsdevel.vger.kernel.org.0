Return-Path: <linux-fsdevel+bounces-63347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E364CBB6603
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 11:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8F484EC469
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 09:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D463F2DE700;
	Fri,  3 Oct 2025 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tl0AS49R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8560A13A258
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483852; cv=none; b=usvkVSSVWQDDWqov1/40hwTdediGPAzxdV/jpQtra4MJ/+aphnXL8jS5JbrhSTWVwi+UkdacJWAMYIgZ7gm42WbjR80YbT8DVxbcj04DSuciLBn2m1nhQQBG1N5L36bl1QHkb1voPfA6BXu1pX6GtorEpJKcP6GaNGYmGviIgg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483852; c=relaxed/simple;
	bh=DAoVlV27WWlmXjiBC9nMRy5Zf/pHsEoBLiOFORFTr2s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D3iUj5oqhdZN/uoc+DgJxA7kXa27AZShuy8ewtbcwf8zanxRBSHQVpRduOX6EvoHmDjtGI079en+33dISaL2EpJu03x1w/8ANzHqHDFqCGd5vqMDwtbxbJ0HLL2M6ATNtSfig7Kc+WWymMe+s98irFrn0zuKqJK1iA6Jbs16p5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tl0AS49R; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so1334224f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 02:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759483847; x=1760088647; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBt9sQ3D35nPjr/0RJe6RkWlXbYt10tG/bFkTZQxvEs=;
        b=Tl0AS49RuMil2112GCILDBTccy4PdAEkp0aIIlAcukl+8DcBeFEUOl2Pw3cb+7nyGg
         6iLtxAdBgOUhYe5ts8T4N7HKdU4wC7s1BP1snIPJULJ0oSEXlc2lK0VEgkx+fyxi+zLt
         6hauQZsAs2RMTT7zhaYyZvuA1O7mqzexAMgrjkcOtfV0qUJE8o6d5F3Su39VpD7s8P76
         qgU+Sl2aOL0q5OAFkixN/9BEwBbuygjcN6fZAEyy5Kr2uPu68NMch7dQhZtLE/w+EljE
         gpDE9v9cRBeZpHaBedBGLd/no5sxkYPLj2uactpgay74bvo83WA6gWXJIT3P7ZC0+xnU
         jxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759483847; x=1760088647;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBt9sQ3D35nPjr/0RJe6RkWlXbYt10tG/bFkTZQxvEs=;
        b=D4fflRvOh0F/FpdJ1scfZJ4zjG0R8geyhpKTkamGrBf7SyCSWnH6wGqWnhCW1mbYIo
         JoQfHdG7E2iX0myVJq1t3DtE9o5nIPFiYjwLhLhF9s0OVWGa7O8KfHnYX1ch+zLsl381
         f1XTp9SNyvBp2ENU4lNMwFXMdIbjLO2z8IYw+1IiMFnl7icsKX5ZUJtvqRCAESIegO15
         yTiaJPt9kM3UKJKzFxzBxnR7xEuAcYHK/g+qeyjzVf+kEinV7CoK+OH4MMEc8rIJw+YG
         z/Lk3EXto6dv4GU74KYO07IwppAM7w8hTlZchG6XlwYdUcazqSuIrPshDI/rVJXRJwJi
         gGDA==
X-Forwarded-Encrypted: i=1; AJvYcCV+mciEis5FxAqn9FN+owQU1I1ZsFiVUbXFaem1oZ0Kag2FGfvgO21JloVetOfCCYIz2s4sh9/QkuXWXpHT@vger.kernel.org
X-Gm-Message-State: AOJu0YwNr2nbfo63uTpZPoTn/LoIUqzt1FIKpv7exm6W+1Jyk8HKknT0
	dHVYYHV864i+iQ/hdnyGgXhaMzjff0UyZkaNcXhx+QgQ4TD23OwMaRsxQ2xBJdgzyU6a8szJdX/
	7n8/x
X-Gm-Gg: ASbGncsZ3b+8qRSg7RRebEhEGVbUn+IuAVaenwHud+YX3Q/s0SypIIIbckMKX0ioe4K
	vMyT23Y/A6NnwppXT3y1IVphpPjUdwgNBpxoauMiHLmb2/Rad+3fr3oumNSUdar5lduIbc6stuU
	jOfDkohQ1QPO8iBfOlOs1pymk4su4oK32NA3HyQeyOnSRLVwm2kNH+0jaeWVvxgP/vdHg5taIwd
	Q6vEvIq+pKA3bGmm+Y5EasEzge+7gtyDDwmbmXUelR/RKu3QyvaPvdLtRbQPjQSRoV1H1NbON0N
	kRGx5fbrOqejSuUDgQZiFzKg8wYVIvICWSxxdgMFjPbM+rWQD2VJJAG2aQOQ+EDWppbExpoyDz4
	uM+fSbNb7Dm5S++hRvCM9jG6QlM8c7ObBS00BxGlRbQn1mmPzgrf19Wz+
X-Google-Smtp-Source: AGHT+IEiUMPA8MqxUGgCJF3dzR9jrj4sZakAlaFbxrDTR/05ZU6XCC1uwI5Zc+1AT4pSlne8f2foMg==
X-Received: by 2002:a05:6000:2012:b0:3ed:f690:a390 with SMTP id ffacd0b85a97d-4256719e3c4mr1507845f8f.40.1759483846850;
        Fri, 03 Oct 2025 02:30:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8a6b77sm7143523f8f.6.2025.10.03.02.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:30:46 -0700 (PDT)
Date: Fri, 3 Oct 2025 12:30:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] hfs: fix potential use after free in
 hfs_correct_next_unused_CNID()
Message-ID: <aN-Xw8KnbSnuIcLk@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code calls hfs_bnode_put(node) which drops the refcount and then
dreferences "node" on the next line.  It's only safe to use "node"
when we're holding a reference so flip these two lines around.

Fixes: a06ec283e125 ("hfs: add logic of correcting a next unused CNID")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/hfs/catalog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index caebabb6642f..b80ba40e3877 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -322,9 +322,9 @@ int hfs_correct_next_unused_CNID(struct super_block *sb, u32 cnid)
 			}
 		}
 
+		node_id = node->prev;
 		hfs_bnode_put(node);
 
-		node_id = node->prev;
 	} while (node_id >= leaf_head);
 
 	return -ENOENT;
-- 
2.51.0


