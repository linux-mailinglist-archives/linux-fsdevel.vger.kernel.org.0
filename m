Return-Path: <linux-fsdevel+bounces-69024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4CFC6BB0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 22:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 7DFF42AF78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 21:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B43330BB89;
	Tue, 18 Nov 2025 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyk58eXZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE2230DD14
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763500313; cv=none; b=WRk5sKFyJq1rcmgR1rlC0+VMjySi0cOP0raWqbprr/cUm/yRd+tMpZDzdFLE6SVHl++UudaYrbYV1BiTulqXi+tyijbXSVTEjqZcY2yTwEb9FMVu66aUySitn8o94T4UUZ2LJz6QoSmDJBzAc5nY91TSqFNkH7NxZJtBS0akXXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763500313; c=relaxed/simple;
	bh=Xbfw7U30XfZhlKbaU/FECMI9JAon/qDoTnP1lUNWiic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=APWuRdLAprUURg8nRvHIPVkaEeuxi+I+yoq8A9WHYGNQ80hEUZ1/+P4/umzpFJrMBdHfIYGgMfc4+fnx9liTUTQRuVqjr3mau9CP1pEE9Fev4uXuQoa+n8sxYfkYkz0gOh41sB+pCVJSNBajcKXe/zP6kpw4gejPie8fAAA03C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyk58eXZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-299d40b0845so49574725ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 13:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763500311; x=1764105111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MPV1rxLxb3G50AbzVKwdeAMq/abb1mYv9b9BclCLBi0=;
        b=hyk58eXZV6kTwaRjDzpkqMhRGyl5CHE8QGt0gaAvLpZQpDJMN8OD7h7hINrSJZTLNU
         5zZnJVCtpkfLNxPfrzUW0/+kUfIPLaOql+3QFTYXI9g1AgcB13vlKaPg1D6MKQ+ZbmEK
         UVYtWfYyou2yRHh+ExecK6RrCCE3iZKU3JJkwQwlIlRK51i8fPx5f25ZAG/h5psYwf9p
         wxGZof23OrMApOyPkY0DFlywVgPCCJVokojn3Xd05P5K9DnnVQjB7eIo1zC4SuVLHAb3
         NtReznKHsF+0t2FbpCN+iCJNnyBou7D9lMHDWhr1gpAny14MTRzzaVIPBjfRybzUo15h
         ffzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763500311; x=1764105111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPV1rxLxb3G50AbzVKwdeAMq/abb1mYv9b9BclCLBi0=;
        b=RZgcwzk4QFO4CCPJ5eQb6bTIhTB49nYrYqfBzbD6tw6LtYpS9BkFUjsjUNCgr+UHer
         AiprigsxefPhDM4bJfGg0YVwP0LnP3hzv/48yKGMCfQdt6p/I8kXdvD2P7xgSdkptkPg
         jy9tWYTfdi6QzDmrng8IxKzM4Yu4/3cgMD+0W+MzKyICihZbdMI2oZn7iXsQtPeP8BmM
         bf2/aLk+SsMJRZ719WI8+Q9grGKIyCgi06oec3C923zqpFOpibsXv+o6/AxXVOiEMAFS
         Je5iySC/giyJSdhsobBPEq7jUYjAyYsbm1MY8TE7/10VMm9Yao6fC5BcpHhPbY0v1lpk
         cocQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/6/KAcLwe1nQfusEFiNcT+/i4KJikjlHFnY7GSKmMKxgbfRpBem4IKGv+tQIW7/Ila3ue13o1i61+kLNE@vger.kernel.org
X-Gm-Message-State: AOJu0YyNEEAAkGYd6Lj2cIxs+TlAduRG3xNwDmx26RSdng47U73vBtEB
	1f7aei1It1An7z45Rne/NNx6txsaJ7J0geUhOPonGk5EJz96ElHJ8u1s
X-Gm-Gg: ASbGncveaHjDYEBIv8XQAsRZWQikcUzJDxJmM8Sx3Pl35vOVfcQpe9FM7wjyHOu+XA/
	f1q8a7T+m8ru6FZ1PB8p9llVXPIhk4KPyFVWbL6gHeeJcK52q95E0md2GX6ZoTP2oPGcThQAL7n
	z808TbLtJfis5R1nuHnxVt6z9pvMNo9cAVg8BGL2YdrHEVgo4iVzyG03lAbYqapVAphIetTa16I
	b2WD+WLoiZ3YbK1C/L1kJuLDvDW36G7MF8CTjBJJL3lXi2WKzKGCfe4/9TC6QLwMHTqfaanZPam
	ql10fCPnu4ZavSZZV5UDgSN4aQ7ukJt0iysbX0XkCFugSn1xAwCPmUZERm8piOL/dvEgAAKeVJv
	8eWlIqsNDKUOUegWjdtAnhHCg51mH07Fb1XeFUKRra/7HmrvIFmvPC4dMBL3yNo8BXCarLeN0nK
	eEPWbxM5AvNQSw7DUZkMUzNsVRTWDf
X-Google-Smtp-Source: AGHT+IHYLjlzjtLcR/0WbKCM/Dct4XtsEsb6/4vzBv/aUvSaCX9dlMe2TMrhhJqWKpEr83gnyNK69Q==
X-Received: by 2002:a17:902:c405:b0:295:596f:8507 with SMTP id d9443c01a7336-2986a5fbf9fmr237763895ad.0.1763500310933;
        Tue, 18 Nov 2025 13:11:50 -0800 (PST)
Received: from localhost ([2a03:2880:ff:58::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2986e5ef32asm147745405ad.39.2025.11.18.13.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 13:11:50 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	linux-fsdevel@vger.kernel.org,
	willy@infradead.org
Subject: [PATCH v2 0/1] iomap: fix iomap_read_end() for already uptodate folios
Date: Tue, 18 Nov 2025 13:11:10 -0800
Message-ID: <20251118211111.1027272-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a fix for commit f8eaf79406fe in the 'vfs-6.19.iomap' branch. It
would be great if this could get folded up into that original commit, if it's
not too late to do so.

Thanks,
Joanne

v1: https://lore.kernel.org/linux-fsdevel/20251118004421.3500340-1-joannelkoong@gmail.com/
v1 -> v2:
* Improve readability and formatting (pointed out by Christoph)
* Add Matthew's "Tested-by" and Christoph's "Reviewed-by"

Joanne Koong (1):
  iomap: fix iomap_read_end() for already uptodate folios

 fs/iomap/buffered-io.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

-- 
2.47.3


