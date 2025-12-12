Return-Path: <linux-fsdevel+bounces-71212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BD2CB9A5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 20:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 414CA300AFC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 19:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A489030BB95;
	Fri, 12 Dec 2025 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="c5m+1blG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6FF2356D9
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765568278; cv=none; b=Y/BycKH+D9JJFz6ixtdNkGUu8ulSAZ4LgoxCYpKvmtASbPHKKvb0n9HeoClaJsW2PNbCr39bJUw5rrMj6BTsqPJozJX/HMWew1zHpKJWb2i6DR+D4PznU9VDnG5w0oQRwwMjrZBSYmBoUKOE18XTChdzomKuCigT/vITUUwd/Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765568278; c=relaxed/simple;
	bh=VwPoKas3ILAATq/SFSU9txmC5xK1gqUaBfTmIdhRerY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iGeYa/vZibFIL9b5Fjyd5RrzXqiKM5Ux/tYpHPs8F1pSgYm06oEUsXfnbm0QY//lIXTPa99c/F1I2REZsD5RqK3IXMgdyUfFL0NPxjXYujycxsg+DY4A+Gsums90g1jMKwIoWlTEjmnmci+8jpUj0S29SohKWPnIcX5WovHAvM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=c5m+1blG; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34a8ceb9ae3so1675879a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 11:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765568276; x=1766173076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StTVbGf1mPsXgZZ3d28QJjsQQzKmymRGuXpSNQalBC0=;
        b=c5m+1blG6ge3DTAI7nAHPhHVgc+BMSIozQa31FSf7ThS3uIGzs6iGbu5PHP5lZK4mk
         /W08Ke2mOJQH4C40BdtfgEliG2aCkSUIchXVjP4aGDgkbo0NGKKk4v/sT/pqKhRGdy5o
         LuZC4srxaPdLlCTyoaenvnA84F1454vR+yjfwWRRy3YKL10qgQesEYH9Rnv6iqwsVcxc
         I5OR++zJ5pQK/GATzEEFb7QZSCaV9k210EYF57fpDIjshNzaQd1INI+hKc5YULhSkk8s
         xRrNg//TV/wQ54QZ3F2hmQGV1pIb1fLNpoxJaPgjkMFuahd/64ye/4BaIkJPat3bdR6V
         Onbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765568276; x=1766173076;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=StTVbGf1mPsXgZZ3d28QJjsQQzKmymRGuXpSNQalBC0=;
        b=hpL3ms1gnwD9mDswTWE7YEx68lOWHoS4G5bzritYytFHDm6eK/XXMhB9VzqkdjGm8s
         DZpMOUMAJxKWAUX/C2UeD1A6WqThTLKGf2ao4KW69BVXIqmOnPT2GCBm2c8RLlQr/++y
         G9xUR6pcLGt26BWIY6lxzXCE3yJg2jsAVT2KI+0pxoN96mC5kBrBNSRQxlOKjyUtNhSz
         xYDj3b1oDWh/WdVrfuipoHqV6qnv1biEl2RZ9ewMmI3R3IaHOT21KmQsXH2OB0dB1USt
         7p5JHMR9jbwl7ayb/T+HXsbJSWB/jpMUEmj2e8UpQi9fFPi1iT5/eROqtwSli+UqjD5D
         7tKA==
X-Forwarded-Encrypted: i=1; AJvYcCW1RvDqx1hTqzoFlwt1Sxngs+DEI4d6rStqcj/z8P4yNd6SS0F/S4wOnbQWlTfjIjIYYXkxSa/9ED+NZTIR@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhsm4fXtw/lPoWIQkasrYWxtrIHBpBcFzbgKkbvzHo0w9LBC5J
	k3OoPX6LxxZUT6WaDHKYs1lZkm66BlGnQYlb/aPihtDTWe5t6srBaJrItsL/FFdF80s=
X-Gm-Gg: AY/fxX41S7F3qAbeIelBrRJc10JYLfdCNaYCHKVfCiKftdumVsThFaAGYrK9FL6rpsT
	28N80RejFVpAoMLy9Z+AgjvroSWUuAVDtSCFVb1HD4daBMWnHzE5HjJZYHyTUY2x26MMBeRlB8k
	bArAYXhMLwOIluAJLFDqvkuT8NEJNQByTwZ2JNeaLKsATl5WQziI2GpH4BcVhH/2IuiDwGe6T7v
	vqv+pQarknfPyxA+0oGVMMzdlBX0SFlb9B8ikJgyHQreq1cEbygyoLNZ3wkYfUE/tN1jhGtnDXF
	nykukNLwCoyem7K3wj3h3lc3ryqadYZHc8o1d+s2JgtOvEhnbhfW3o6NHSHd66ItGMvMlGLZRNY
	e/LVMHG3W3HLUCDLWnIujkMRO/Dt+hkEepvEgmzP/ON6lniWZR/9enwlkLyg1QzkE7Lf3OG/R2f
	AZjVhUWYsEBAbGF80Q6LSGAxyUzeEntc1CPo5CjJKJ12N5g97BMyEIRm3t
X-Google-Smtp-Source: AGHT+IGRg2Nd8ny+lEY1UTB7dhC5oApF/NmRzRo0kswvAor/xhBJns1Qxh+lICHO2/Y0nRHD/a4u7Q==
X-Received: by 2002:a05:7022:e1c:b0:11e:354:32cb with SMTP id a92af1059eb24-11f34c39abemr3023356c88.49.1765568275584;
        Fri, 12 Dec 2025 11:37:55 -0800 (PST)
Received: from [127.0.0.1] (221x255x142x61.ap221.ftth.ucom.ne.jp. [221.255.142.61])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2b4867sm20294552c88.6.2025.12.12.11.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 11:37:54 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
 Pavel Begunkov <asml.silence@gmail.com>
Cc: Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
References: <cover.1763725387.git.asml.silence@gmail.com>
Subject: Re: (subset) [RFC v2 00/11] Add dmabuf read/write via io_uring
Message-Id: <176556827123.851918.9976241171726294701.b4-ty@kernel.dk>
Date: Fri, 12 Dec 2025 12:37:51 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 23 Nov 2025 22:51:20 +0000, Pavel Begunkov wrote:
> Picking up the work on supporting dmabuf in the read/write path. There
> are two main changes. First, it doesn't pass a dma addresss directly by
> rather wraps it into an opaque structure, which is extended and
> understood by the target driver.
> 
> The second big change is support for dynamic attachments, which added a
> good part of complexity (see Patch 5). I kept the main machinery in nvme
> at first, but move_notify can ask to kill the dma mapping asynchronously,
> and any new IO would need to wait during submission, thus it was moved
> to blk-mq. That also introduced an extra callback layer b/w driver and
> blk-mq.
> 
> [...]

Applied, thanks!

[03/11] block: move around bio flagging helpers
        commit: d9f514d3e6ee48c34d70d637479b4c9384832d4f

Best regards,
-- 
Jens Axboe




