Return-Path: <linux-fsdevel+bounces-42767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6253A486DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 18:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B4B3B6A48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 17:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92711E51E2;
	Thu, 27 Feb 2025 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8PGlZM5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F3F1DEFEB
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678075; cv=none; b=VR3A91slCStmDchUouJC+weHmlOXVvEJOfXZy5+BjnzVfF5TH9buov096yItY9YohKj7MXgFC2rNqlOvU8WGuQh0+mhdugo4p5PMCILcBWeYqUqawItXjxbv4zaQ/i5vavgcZAk2Sp59/cq1Qj16jKELl7yFgAalgX8UbBZENeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678075; c=relaxed/simple;
	bh=s7SonA2YO2XhZc9w0mFYOxb9EBpOwWss2EBzczoWq/s=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=DTTOqGi3IvxeGJAz2mkAltlfwyG+VRTwKjOcm1XRzo4YdO0WyfXndpH7cwWF78esR91t96ot4ddLHDuA48oaN8WuMvU4KcBt+XcU1CjWmWJZF5fdFoRU7NfYRQqsXD2D2wRzp9Ckpy5oSbeSCRRKJu+AzAI+ghP963Z2MGsagPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8PGlZM5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740678072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K24ZhcBl7J2Nj7CJyDkYNszGGSE6wlTQg2UzYKmmPCc=;
	b=Z8PGlZM5nTCXqct5fXriEedn8Oo1vrzj94azNrGYZ+ktXSuhZF2TlNia+GYCMpo2/Tf/ne
	hp46W7D/mwHgqlSzUGICemiZ1HzLH41PFfjBK+8zHZspf11xv7PLLO3UMnRkrCXohaEneo
	tvijTOC32wJP9l66kOIRsws7DG2wngo=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-bt3oLlZVPH6lKixHZjZQ9A-1; Thu, 27 Feb 2025 12:41:11 -0500
X-MC-Unique: bt3oLlZVPH6lKixHZjZQ9A-1
X-Mimecast-MFC-AGG-ID: bt3oLlZVPH6lKixHZjZQ9A_1740678070
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2ef1a37beso12282715ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 09:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740678070; x=1741282870;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K24ZhcBl7J2Nj7CJyDkYNszGGSE6wlTQg2UzYKmmPCc=;
        b=aJub1QqJTkSs6kWrZnam8oIjt0NYjY+vZfx2rVt87sjeA+hwpJOjRhkuWRN75DJulB
         3UxiBIJuTd4nSNJLhM0ejoBUlWBAGT+vm4N4/nbHVWiqu6VqN2mQYZqaRImpXS/UqJyW
         2RUCokMTwPPMTV1n51aAq0LU9dFyoYIS9mYVFLUSTP2+GLaK7sclOn4DXDDrO0XExPWV
         UIfY5nqmH/Vk9AGZF2CsWeh4Py4zd/27Vs1/gBLjEFjwX9yW7jSB3A6N+NCMvyKUZda+
         EOSn19fdLYmNlGeoFToU+JT3sWZEBB3+X+LX2DbU6HoxxYxT8bmuHQCpmnNqHY4rYAzH
         ZtMg==
X-Gm-Message-State: AOJu0YxmoVgsstXWyCRshmMCF3oTLAKvsj8oS6b97HQnXalwyoVxpbsi
	7RbzJDYX3MH+Zmlxq53f9S79GLMnt3si7xgZQ4k4BYDnCmwNBsixBxLT3r5FuMZ+o1Xm6LS6KPs
	34kRNdVsMLRkgIYb4WDmKEqhn7mWRb/LW4Nsi2kEHi521wBxsBg8lO341YKR/CZoDg4sd2EQZ4z
	hd03mZRBaUL/ff3vs1oF3e31xbi4bzbEqbJjSeuy+6lsJeuoSZ
X-Gm-Gg: ASbGncv/899KMvYpYD9c5pEjzgjuazOrTe9s+Jyd5RHuEDYb4WiEzbdgS27Hecxu2T4
	b8/+YJQO2m4SjA+WM5KWdobO05K/D7WKLtDNBQHlIid0/ZhZ+RubfU+I1GRa36VJucSft7ycSLm
	T1eX7isKGuQoFBHAuDLhh30XweFgZVGfY3A7jJz5+RMzjL3lt/f/s6y+bKzo4ymIsRY2n8DU46Z
	WPoo/ntNNpbyrR/ek0CBOcKde+peM8OFGTbjgG4d560ZXbFWfVrOCRImAm5jNVZl4tmGZoKljcE
	9c7EcC4XYtMoybaPFXWQ9BhoKD9k+fi/nyKY0wf/qquI4XZ106g4qg==
X-Received: by 2002:a05:6e02:184a:b0:3d3:dfc2:912c with SMTP id e9e14a558f8ab-3d3e6f39cf8mr2097135ab.17.1740678070205;
        Thu, 27 Feb 2025 09:41:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYqI7J+/GbZXZfRzB0crK7AA+4QfJMu7k+rCRmh8plFsc5qJGo4oi+17NeFoVJqG9YVodEzQ==
X-Received: by 2002:a05:6e02:184a:b0:3d3:dfc2:912c with SMTP id e9e14a558f8ab-3d3e6f39cf8mr2096825ab.17.1740678069744;
        Thu, 27 Feb 2025 09:41:09 -0800 (PST)
Received: from [10.0.1.24] (nwtn-09-2828.dsl.iowatelecom.net. [67.224.43.12])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061c084c4sm454429173.17.2025.02.27.09.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 09:41:09 -0800 (PST)
Message-ID: <206682a8-0604-49e5-8224-fdbe0c12b460@redhat.com>
Date: Thu, 27 Feb 2025 11:41:08 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: David Howells <dhowells@redhat.com>, Lukas Schauer <lukas@schauer.dev>,
 Ian Kent <raven@themaw.net>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] watch_queue: fix pipe accounting mismatch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Currently, watch_queue_set_size() modifies the pipe buffers charged to
user->pipe_bufs without updating the pipe->nr_accounted on the pipe
itself, due to the if (!pipe_has_watch_queue()) test in
pipe_resize_ring(). This means that when the pipe is ultimately freed,
we decrement user->pipe_bufs by something other than what than we had
charged to it, potentially leading to an underflow. This in turn can
cause subsequent too_many_pipe_buffers_soft() tests to fail with -EPERM.

To remedy this, explicitly account for the pipe usage in
watch_queue_set_size() to match the number set via account_pipe_buffers()

(It's unclear why watch_queue_set_size() does not update nr_accounted;
it may be due to intentional overprovisioning in watch_queue_set_size()?)

Fixes: e95aada4cb93d ("pipe: wakeup wr_wait after setting max_usage")
Signed-off-by: Eric Sandeen <sandeen@redhat.com
---

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 5267adeaa403..41e4e8070923 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -269,6 +269,15 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 	if (ret < 0)
 		goto error;
 
+	/*
+	 * pipe_resize_ring() does not update nr_accounted for watch_queue
+	 * pipes, because the above vastly overprovisions. Set nr_accounted on
+	 * and max_usage this pipe to the number that was actually charged to
+	 * the user above via account_pipe_buffers.
+	 */
+	pipe->max_usage = nr_pages;
+	pipe->nr_accounted = nr_pages;
+
 	ret = -ENOMEM;
 	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL);
 	if (!pages)


