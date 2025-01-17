Return-Path: <linux-fsdevel+bounces-39472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B14A14BD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 10:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 422A07A3EC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 09:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AB31F7914;
	Fri, 17 Jan 2025 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Y1tpCXbF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FFF1F790B
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737104866; cv=none; b=XGIsQHE5LcyfO9T65dnzlppd7JTfg0LC7NkdZtbc+C+vI49oBMgJDOxPwiGIgEgkhCeOM0QyMzGvvp7hGcUizWR34XI9N/FkFXuq3je3/Gxk2kRpXZ0HwvSKi05vLUuNvuFg4S0dg/CxmxFmp4OIN2tFJaenzRS/MdpzFeutymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737104866; c=relaxed/simple;
	bh=UFZLFZVOSPFTwx7bGx9gIu1IzEKeA8HNkjx+6oyAzLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R43OkCF9ZP0gY2iiZewdQ/t0w2Ow8Qml8ILPbrRMrRcBB8rZcnTffjidKAQziFHIw1BacTszPoSq3IUsJRuaOtr4YpPXMpcBKg4jGOghyBSIOkqGud01UblGsvCnBqxIJh6dza/sZcdKrUmtAwgKN/Zt9pSFY2b1Hv+GYh1LDo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Y1tpCXbF; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46788c32a69so23437721cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 01:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1737104863; x=1737709663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n2D0doGdFPmRbwuIzISntkHAs9R4c9ifeS/tzPGrUjA=;
        b=Y1tpCXbFr3tMpaeZw4ua7HxvfhOLkjznmWmv9NgMkQj4e5Yw+6Dj+LZg3xCvvyflWL
         yBzrHFNsV07MrkRp//NOndsRdSHO5MqWoJzQ0zC/2f0CcS9y/H6BlNRyIg7o7Ccon6LR
         +Ip4KVD8fMi19obD8Soj1LZJptO03GHteqOjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737104863; x=1737709663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2D0doGdFPmRbwuIzISntkHAs9R4c9ifeS/tzPGrUjA=;
        b=NWBROFjgReUZsTXMSKHbdMiDRPUxZZlnQeK00ib1wm9ZLRMnzCGot1ldijkXN633kt
         of3SW24dm5VJR2S7FcJrzn4t3B1vy1pXiDdhWbutCLbYXlsgT98CJ4LIxXHfjN8uA/+n
         35Wv0OpyrVh8eRWq+qAlUqN1akndQvr+Q0ubJc6mekT/8xpuCB8pZ7Oyu2xw+7lqj906
         cxvbyhB72bqTf28Z2XAyKCO+IZEG2j9XoMybTjdxDXDAf1rdnmEpUW3lXld4zrqCvUm2
         SR1U3PTwrgSx2S8fiDrlX0CMxqUw8eErs0cH7rlNszVnAn5Di2pcuELigkBBwepZ4GaE
         kIBg==
X-Forwarded-Encrypted: i=1; AJvYcCW3z1yZPDn7+VoEFthjgJYlS1JLVr/QeqE7p5BK9Z9HSwBW2PJhBqv0Ekw/zfPONJarprkqa/UmVmKw/vcC@vger.kernel.org
X-Gm-Message-State: AOJu0YxmzfcSKtd2/uvf/qJC+djjF66z5ufkmRpxI9/8X3pfU5IvSBv5
	Vnwdac0Kcievb9WVNMrn6UXT0Ju0WHKKe4coVZmjRJAQd6zYvoW3W0KMOEqb2p0wXBAkF2ePOJF
	JTJtfwiWWy7GKyhSKMrGmJNPgJJSdZne/sdZVbo9h8R3Vvbt5ZEY=
X-Gm-Gg: ASbGncsO2i2FKUr2cZ45B4zGMYGnD3mFmrVPzzkMcnuSRDcL6UbhDixAgJ8D8DXPrVi
	/XmYMGsjbL+FYeCYA1g2/FaEzQSoiGf3jmLxp
X-Google-Smtp-Source: AGHT+IGCDFXeS8ZzLEXccqU7GkD35tBBU4jVnwPVdQeOUlK2kDh1P+jQkHKBdM9rdPN3md+V9k3szdCmf8EjZ/p4ims=
X-Received: by 2002:a05:622a:303:b0:466:954e:a89f with SMTP id
 d75a77b69052e-46e12a60c6fmr30515191cf.14.1737104863020; Fri, 17 Jan 2025
 01:07:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107-fuse-uring-for-6-10-rfc4-v9-0-9c786f9a7a9d@ddn.com>
In-Reply-To: <20250107-fuse-uring-for-6-10-rfc4-v9-0-9c786f9a7a9d@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 17 Jan 2025 10:07:32 +0100
X-Gm-Features: AbW1kvaGPCBOasgyxU3CSVJGl8V-5w868NJSd-B2xqXvfntoT4JB3vfn4s7uhQs
Message-ID: <CAJfpegvUamsi+UzQJm-iUUuHZFRBxDZpR0fiBGuv9QEkkFEnYQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/17] fuse: fuse-over-io-uring
To: Bernd Schubert <bschubert@ddn.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Amir Goldstein <amir73il@gmail.com>, Ming Lei <tom.leiming@gmail.com>, David Wei <dw@davidwei.uk>, 
	bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jan 2025 at 01:25, Bernd Schubert <bschubert@ddn.com> wrote:
>
> This adds support for io-uring communication between kernel and
> userspace daemon using opcode the IORING_OP_URING_CMD. The basic
> approach was taken from ublk.

I think this is in a good shape.   Let's pull v10 into
fuse.git#for-next and maybe we can have go at v6.14.

Any objections?

Thanks,
Miklos

