Return-Path: <linux-fsdevel+bounces-69671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 47020C80CED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 14:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C3FE4342AEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 13:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D34C3074BD;
	Mon, 24 Nov 2025 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Os99fXi/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC5727FD78
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763991537; cv=none; b=qbr3NIUL19SNDPhx8/0CWprTI3j8NjIiqsBoHHYGfuhcBEsvrvMBLVZrNB5fiwjo41TsngycKcqbBZ1gssBZaREVWYuXjVm4KRueuZFv11XlntVM7u2OJkJCN+Pm2DHZHPN61xR9Y8NzPh53DxKYOgOXoc4UFbfj4afi3ZpG+/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763991537; c=relaxed/simple;
	bh=hFssPJTM7dfkeo3nvA01t4OSU6WT4LDzj+frYOuLW9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjE9sFrCmLLSWMSCZOZpsXI/NDavcNKiR6aezRuuc0dT0gIW3WuCLjDPtLyfBUjbdS00mD6LQRfJF3GrZq+0UNIprmI3Y4/Rrr6Co+YIhajN9BkzCUYzn26t1O3nT944kLNj3Kd99pzV95bEZGTxzMIAD3DsQ6x9y4NsI+Zk07o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Os99fXi/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso197143a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 05:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763991534; x=1764596334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fGnf1zvNYnk55vDoYwHQmt5WFO2pnbA0Jle9HXGkL5k=;
        b=Os99fXi/P5CtZqR0D3ax0akt+Gp2AWkUY8AfW1xNYM3Z26PGCN2nf6zaAjKy/Ikd8d
         Qntn5kv6SU1FT40UgPr8zjJzkyV8h8MLTGyNwIRLmhOq4ww4rVliyKsDTmLpP2YTgbJ9
         OgxGJptnmlRfQ7plwEN0TMg4/kDuvtseCKxW311HD+6vHq6yFn8OkOPag8Uy4U88YNXb
         TMZzomQujHkv6vZi1yL80iDMicSrsGT3c0GAlAH2iCLY0mEpkCARFupuwPF1jx2qyQj7
         SPrUm8JCnGMgkeTABaMj+nI1buehfnfBxXcCAyP6BxzmauWDRi7bB0H53rHOpLBbPEUN
         K6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763991534; x=1764596334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGnf1zvNYnk55vDoYwHQmt5WFO2pnbA0Jle9HXGkL5k=;
        b=Ts1uyVE7b6QbzzmfC7dB+/D80WHEzDcty+Th6ccNXrO/u05azzbMsEDNGjETRx4lmY
         kqKDUuD4As0tg/P/A2qbU2tnw4waQk69hSy3TtLLujKD/B6xHEJk71ZRYOjbZrW7oanx
         syBhzrqCkvWlO3cNaYvliFttQZvheCOfieNH5+f8wuJCOqP4rVCcCbaVDea+jBsSqVJU
         zWd1PtH+V3T1BQyUzvSpQye60+CcoGTgUX8TS5ngfU/td5+wVuQ5VsFQdPxbvT+YpZIY
         8JYLWJ5eFKJqEpOE87VBrhgU/oNoPzeC5MY/G8dUjm6Ka32lcZnjPpZvGaAEWSmekBK/
         rXiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ8kfgq9wTgJzVrWMpXxwPbSDXY/fCJxUky2FyvTv3jeHoKYQhKY5eluceGG3hKrdslRS5iaPtlTrtt9vu@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxl63d5C5W9X05HhsTN+ED3slJ7oLbPXxHI//N7AzTjdJ7JR62
	t4QKxvn95PgT2KyYw4Ioybg9FyH/5WCDg9bACzyAututYGg7ubGP9LTbspEp2yIGq3s76QFf8XK
	cT8KipJV+IS/dXRAUCqDw+78IpFMI1g==
X-Gm-Gg: ASbGncvzdU6pahfTod078sb/sDQTv2Qk360afD+TWzvrFDvKcMBrXzLzsri76TNtSMT
	usvBGeKujIGITtx2J9h2zwW4C/NBTfao2AHm8X/PbRBDa8wt5gIbeaE9YgaRZQpCIGm+0MaeyZn
	WoHsOndwkBPOa6oPp9B9Z8qh94hgaXEM6bqO4CQSK1L44Z0tD5EhRAk2EQJlhojbKkkMUp91Gs1
	O5VHzcyEHCxh4GZIn/sqVzllH/tWEt0AVvmPW/GkYC/pYmRT9dV7IBSRPU77NbZJ9vM6yf2FTGl
	Wgqoi7Vd59pgdJ357CWUNx2Rh6n2/rMyqUSMgbi2noLaYt5HBBMoSUDkg06lFvdEqPI=
X-Google-Smtp-Source: AGHT+IEIrrPvcFC3+rTLrgAPrW5zl0/cNdfSGGH+WdJU8CBkNncTEWdpxNp4QGdNjnbB8MXP5BRq+4un+OL6bxIbhcQ=
X-Received: by 2002:aa7:d814:0:b0:640:93ea:8ff3 with SMTP id
 4fb4d7f45d1cf-6453969fc53mr9852940a12.13.1763991533736; Mon, 24 Nov 2025
 05:38:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763725387.git.asml.silence@gmail.com> <51cddd97b31d80ec8842a88b9f3c9881419e8a7b.1763725387.git.asml.silence@gmail.com>
In-Reply-To: <51cddd97b31d80ec8842a88b9f3c9881419e8a7b.1763725387.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 24 Nov 2025 19:08:16 +0530
X-Gm-Features: AWmQ_bnDcYvcgkdgCo-kXgELlQbBhcvXrCXwL82qa0EngBmCaaIoNiIBz4Az0nk
Message-ID: <CACzX3As+CR4K+Vxm2izYYTGNo1DezNcVwjehOmFjxTqaqLrDGw@mail.gmail.com>
Subject: Re: [RFC v2 05/11] block: add infra to handle dmabuf tokens
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"

> +void blk_mq_dma_map_move_notify(struct blk_mq_dma_token *token)
> +{
> +       blk_mq_dma_map_remove(token);
> +}
this needs to be exported as it is referenced from the nvme-pci driver,
otherwise we get a build error

