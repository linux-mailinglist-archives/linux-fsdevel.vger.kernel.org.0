Return-Path: <linux-fsdevel+bounces-37338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBB69F119D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 16:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAEAC28251D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C951F0E5E;
	Fri, 13 Dec 2024 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HA1gc6ir"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476811EBA02
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105380; cv=none; b=OFXLkQaEpDcSOMEObM9XnwQEmtGpb+0H7w60DZSc3zPJt2sTjKEKOzTU6FmB+1tpypbynPp/0EXybhlXkVZtajWpf4ABUhtT3DXQTv/4URLMLQQzLHscFLHaUjxguB1DIi852ppL2t+iaFvgl5L8PUEbRX7McLeeVPmRFktWR5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105380; c=relaxed/simple;
	bh=zE0xjm5rhzd2cUhrSxtogiQia/migrwaLvBNVMhxtxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0kAsGm8N5wE4MeLDpZrujtQdcr+hf3sUgJU9jJhvVbpZ6H3P4vd9LcsqX+bb4CNoCAaNJuMf7SLsNEuewxzLlS6avwc7cbt2Pjd6XM0JRzrb5lxnMNFPpcYE3GXAHWqV4PQIWvGitidHr0H4gnTPVZGAZpk2d7USvXTVcnu/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HA1gc6ir; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a8ed4c8647so12588525ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 07:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734105378; x=1734710178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ol/7y93UZDywrWGNYi5AP2kj1AIRWUpJ2p+2aggyqzo=;
        b=HA1gc6irLN/yCOG18U3Q+66W/+z4/bTyZiSmJMqj1/w+cvYgQM7rHONzuluiRSQkBb
         cweE2VTc/HK/3DIwpjt1c2Nf+Gxv7SVYHiJHDaKlL6Ue4358GqyJqk4lFnNX4KOo53ku
         VmFbHFJypEDtZ/AoDel7A6O8JplP2uox9ONHtdpGANY26YTB9qjBVeCUpnTIPrYq0ADq
         LGEw+WA50yc2FslUOcedqLOjA5g2WjxE2ecuUhJGb5e4XK+bOgfINf86n4UFnP7qlARk
         Nc+mPBS0Zq36JNexBhw4nymkuB+o+0BvszRwuF2bqFwfAyaUj0YG3/g+Q75RwMt318lO
         3Sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105378; x=1734710178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ol/7y93UZDywrWGNYi5AP2kj1AIRWUpJ2p+2aggyqzo=;
        b=kFCqg8e2Am25pxA+O427jHBqf0rTIMpQztKs04DKqZpQc9chDRmkVf3XdbgGb868LR
         gNjcQaNr0/en2SDb/A0cr8Xh/jayCJRNMBULn5sromZ0nN3nTQ+2qQRnO7QuSf5YIXsy
         bYGcsWOLsMyq3Ee3lQHwCQW6nTZYQoeLOTShgfaVI2DvOW+d/lnYWP/4zIICnQIsZMNz
         41DFzX+Fe/kyNbCzLpSEbO247RfHU6hSTrd8uGkEp22dCfigsXEHKWJKr+sIkf1VS0ZH
         aUDJ4xguOYi3MeGEpOsAE0Fm2wX+8+aY7LjBXvXlrQuYY0IRplT7KLREUgCJJDZdADLX
         HA8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdhe5dWElebikbfTPCVGcdjDzV+5h4cfNZrCYsZCwQmW/dgiCcDazUxGhwLciUuyXn3f5ryFWG/QZ7X5m3@vger.kernel.org
X-Gm-Message-State: AOJu0YxiHqJ0hlQN/4W1L0e9X/l17uv1+IFeiQzt9Zq6Qx9aMy497wIt
	ihXNvj9JmuuMVJOxhScuCWIJ/t2c2VLAp3H+V4KSRvSOERacOlWPQAhR9iUJWpE=
X-Gm-Gg: ASbGncvj9vFQSU9opJxUl/nDgz19UbktZrrI/9uBTvY+2D/VXuBOST5rylvcI6mxM89
	tiUBdaXOqn9tQL6IkIsEdAzbsnrrk9YOkT5/e6Fe+8/CzhsqHdwgXM/S0etg83crGL1s6BaAKyN
	sGCXXnCz+vttEypcSaYdHn/2seGyTSqL829S/LyxYis0UhkqH2MIcf3bsMq3RooIzVyWAtsRyrY
	xf3hBudTtK3UzjzkweoR9gcSX1GFr9NgkHP0+C1bc0kLsDaw9rusxnrJh0X
X-Google-Smtp-Source: AGHT+IFA+GuHLn3+MK1ZeRZZP3C9VMVBGmb7rBcbA1fV4I0OGtHKvL+W7OoGXWUKvvS+Tr+1pcK1JQ==
X-Received: by 2002:a05:6e02:2169:b0:3a7:7d26:4ce4 with SMTP id e9e14a558f8ab-3afee2d0367mr35186015ab.9.1734105378594;
        Fri, 13 Dec 2024 07:56:18 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9ca03ae11sm35258405ab.41.2024.12.13.07.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:56:17 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/11] mm: call filemap_fdatawrite_range_kick() after IOCB_DONTCACHE issue
Date: Fri, 13 Dec 2024 08:55:25 -0700
Message-ID: <20241213155557.105419-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155557.105419-1-axboe@kernel.dk>
References: <20241213155557.105419-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a buffered write submitted with IOCB_DONTCACHE has been successfully
submitted, call filemap_fdatawrite_range_kick() to kick off the IO.
File systems call generic_write_sync() for any successful buffered write
submission, hence add the logic here rather than needing to modify the
file system.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 653b5efa3d3f..58a618853574 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2912,6 +2912,11 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
 				(iocb->ki_flags & IOCB_SYNC) ? 0 : 1);
 		if (ret)
 			return ret;
+	} else if (iocb->ki_flags & IOCB_DONTCACHE) {
+		struct address_space *mapping = iocb->ki_filp->f_mapping;
+
+		filemap_fdatawrite_range_kick(mapping, iocb->ki_pos,
+					      iocb->ki_pos + count);
 	}
 
 	return count;
-- 
2.45.2


