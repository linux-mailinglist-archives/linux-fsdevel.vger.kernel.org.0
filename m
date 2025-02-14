Return-Path: <linux-fsdevel+bounces-41722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2DCA361EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 16:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB293AE9BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 15:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32D4266EF6;
	Fri, 14 Feb 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkpMo5st"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF0B2753E5
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547544; cv=none; b=RTe6KPN1oJsWtWZ1LX8Ufd6CZhK9P6drYEAzxfv/E+CBuIR4BrmsqHPIjY7iago8eTPQmUcZBLNw93mSYYDtzWj+OHQzIo1tk6fyEhKA4Rp3BcCl6kRGRBKOXFDnYPF8xvtGZ7BMfmZQc23X5BPHHiJpWGABSPlxYHAV4pfp9EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547544; c=relaxed/simple;
	bh=7/Eoiw5XDMD6n0LGABIySlP8E83WqwNwAcTABea0H+U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VwlwmJq3nQh8MQZJr6JvHD6VE9QW1kNesRggLXyslvMZllb0le+kGThA3lln4gEgncDsDtiYP/HHZOEo5Twzb8GaOr/F96nSw2cDopZ+JE0nM2LDGYG24awywpfv9m44+le6I2BLhhbRsGPH+i2cBHYlk9GwVqAKedRPJdnz/I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkpMo5st; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739547541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvEbhVgzpHtKWmlvq8dAX0vs1oHGg2RodgwJE0IwGHA=;
	b=PkpMo5stZNygMPARNdNwKanTDZUBxUA5SeWaQBE/M+4lSaMmNCOblBd7mE9IfbJUyVrhUN
	yyB6saso53HTIIpv5hi6vmnFHvID7pf46xatMxwJ4d9dyXqoU+tQDHks1cOP2RX11WE2o+
	KuTrpyls2lx1q14+gwSlibHAHRb/E64=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-fwZgsww9OReLfzrHKkDp1w-1; Fri, 14 Feb 2025 10:39:00 -0500
X-MC-Unique: fwZgsww9OReLfzrHKkDp1w-1
X-Mimecast-MFC-AGG-ID: fwZgsww9OReLfzrHKkDp1w_1739547539
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d1a365d10fso3012065ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 07:39:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547539; x=1740152339;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvEbhVgzpHtKWmlvq8dAX0vs1oHGg2RodgwJE0IwGHA=;
        b=dN8luAunZ7gLzcSxf9t/ZVx2DeB3oGd2m++Qe11J6BwhdRVWgi+aeYosL+EORKJJ7t
         ldFTmgSuv55cMdeeHwfF39ezRZicjStQH/By2kZQm97dh11AxQeEPzLfkHp7QL9iOyXo
         zA2rBZ6ssATgCrvudWiInFF/FID8VYjtshFtW/EWZpN8WGYlk1DvRPPb4ZZpwtadAdgs
         xCrgdyXXkeojbQiLYlvIUN6dWwHgS9HVfmBLxmsXJ3u5J6vA2TtD3Y3EZ2gfxgeOoK6J
         vnQ1d2ayCak4GiVSNu3RJXAJrdAXz3Qp/owX+vpH5oap7LuTSEKIHpzrafhazV/m0OKv
         VQxQ==
X-Gm-Message-State: AOJu0Ywl4PnmUNXR2g4UHaAL/Z0i69Af3+GuZ7zHAtVnjnCsa1x0ibMB
	C4gFuUxvgSbUpcstTq1BXhtS6X5s3t89j1i3snhARiCiiyYDY8MRoMZAN3TaPPTfUlWU72whiME
	BG0Yzn0oni2AqpbDZxvHAk8PAYhHAp/q4s9qtz57Bc+FiQBZEZW6Gx2hExuF1LiC4xuaUJDGLET
	HTYbmayOvQsJBkjcOSjdYgWInkVt93fdOcf715dapm1Ds1BOnw
X-Gm-Gg: ASbGncuHqCg3pmkfil8PNiZ+HGQF59PFptWIWhk2mMLKJQFQ+//wwxfuvPiqh8hVTDA
	iM1HBRT+EMEzQRg5L+6QXSblzyzWyJfTOom+L/5xVoWKu7kL2RpQ2l2cUECt2R9PAghNRvp2uSk
	wqCadsvllfZhbhsPdM8RY32bxmIbfGv6yEN9Y1o++k9q7Nh2UhcP0kpp4yOK5x2IgDjGtHgL6m8
	YHQ0yU4LETrckyWHgcCtcXrY5fp8KsYkuoS6/VghyjDHIE/gagokOTNsRZqogeGMGin6YMsloc6
	QEnE2+5IUYEy0pKUA24/NtP7+4608KZgDtP5DJj2vPGp
X-Received: by 2002:a92:c7d3:0:b0:3d1:54ce:a8f9 with SMTP id e9e14a558f8ab-3d18cd2214dmr53673955ab.10.1739547539500;
        Fri, 14 Feb 2025 07:38:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH8FtBYzhMfqD968caAGEnEHC1jkzBzIqnqZtsxC6uOuQ0eruGv2RK44Tyz9Pq6tAX5unMqw==
X-Received: by 2002:a92:c7d3:0:b0:3d1:54ce:a8f9 with SMTP id e9e14a558f8ab-3d18cd2214dmr53673825ab.10.1739547539060;
        Fri, 14 Feb 2025 07:38:59 -0800 (PST)
Received: from [10.0.0.22] (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed281492easm853539173.20.2025.02.14.07.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 07:38:58 -0800 (PST)
Message-ID: <a8d8f11a-0fea-4b74-893b-905d6ef841e6@redhat.com>
Date: Fri, 14 Feb 2025 09:38:58 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [RFC PATCH 2/2] watch_queue: Fix pipe accounting
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: David Howells <dhowells@redhat.com>, Lukas Schauer <lukas@schauer.dev>
References: <b34d5d5f-f936-4781-82d3-6a69fdec9b61@redhat.com>
Content-Language: en-US
In-Reply-To: <b34d5d5f-f936-4781-82d3-6a69fdec9b61@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Currently, watch_queue_set_size() modifies the pipe buffers charged to
user->pipe_bufs without updating the pipe->nr_accounted on the pipe
itself, due to the if (!pipe_has_watch_queue()) test in
pipe_resize_ring(). This means that when the pipe is ultimately freed,
we decrement user->pipe_bufs by something other than what than we had
charged to it, potentially leading to an underflow. This in turn can
cause subsequent too_many_pipe_buffers_soft() tests to fail with -EPERM.

Fixes: e95aada4cb93d ("pipe: wakeup wr_wait after setting max_usage")
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/fs/pipe.c b/fs/pipe.c
index 94b59045ab44..072e2e003165 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1317,10 +1317,8 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 	pipe->tail = tail;
 	pipe->head = head;
 
-	if (!pipe_has_watch_queue(pipe)) {
-		pipe->max_usage = nr_slots;
-		pipe->nr_accounted = nr_slots;
-	}
+	pipe->max_usage = nr_slots;
+	pipe->nr_accounted = nr_slots;
 
 	spin_unlock_irq(&pipe->rd_wait.lock);
 


