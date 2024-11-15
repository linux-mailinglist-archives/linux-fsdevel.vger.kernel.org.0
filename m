Return-Path: <linux-fsdevel+bounces-34866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A58D69CD601
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 04:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A821F223DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 03:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831BC136341;
	Fri, 15 Nov 2024 03:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4OlSYwT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B841EB2A
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 03:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731642887; cv=none; b=LM/b6qYByqjav6sXXrezxgJdz8ywNMBM5poXJdXigEzQ2YzpjtHD7Ps53wToPxqFt/tI1SdJPbtnmb5teAWAmuek94mxpunJTaqd3GdDVqKw8XpHc0ba7XSjJBYVPxcAfc6oVTlKhJEtPYQAyq20/Prm2emsPYyGO1ejSiQJbsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731642887; c=relaxed/simple;
	bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=ixFjUm7DaHgY2Y1LFw+5Sc4qmg9dgbTyL1Pfyanr/RnStFYzGgFq1ENgMki4oLDAGkoloPZ2L6JMP1LiCJoaDPk6YCSilcrjeMsI8pmanRD0Yw1oK04Ha2+FK/1zfoK946ULhkHzM7pm0c2FckfXdKTRvJ20PUkD3/zRghA20rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4OlSYwT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so12236155e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 19:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731642884; x=1732247684; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=h4OlSYwTkov2QgEj3pN214eTcl4+DwSayz6s0M7CgkDZ29uISMgBz3HSq98gzbzicM
         rTxyO5h8VeucFVW7zKT8C1EdpUHWBkbsuQSZUo9u9l+vlhwdZwmAbVqpFnJUuqVMM+51
         rbDqgW0p1RXYrcm8gX9MkkwbthCrGYt4s4BIt0OElHk+ofYrO31cfTKdubxz3KtA7RY8
         J996dkT8Ha/UuXpOTvZyr+nbFyPm5vs9xi7qn7by+70MCwQqqcIo+ZEUUP3a5OMku0KE
         KrcdkY5kE7KaHqORpqmBmoe59ojixHDM2G2lw/X3Kxc5fXofR2vMeTexHg8N9o1Yv1Hr
         K+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731642884; x=1732247684;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=QMYWaHgSQ1wTghcWrB5Okwe7QZMOO7yiyeJAfqHVV5IcW9deQ1VrtYXdAoeMSQ+JeW
         1RsIMZDQ5hVouYLuAMJPEMDnvC2ZF4tearEz6E1R2ZaOTYV2oIELp6D2OqHOZdv0Q4Z4
         i4Kg5a+t3/RD7Dc03jDFr2uhgjtyyCY9H1k1AUYkdi2Z33b64gnsN0x381b9Da2gWb30
         rMYps0oWWSBKwvmvHUN/LOPQYHLTW8aHn254iJm1foAJ43u++ZnKGmEjilkSJamD9Sct
         fq6pSyb/sypdYgB8yYXJkGJvYrXP/J4oIbQJcOLyFKn+eXBLr9Pe8EU2yVVqHPK5WisS
         3FPA==
X-Gm-Message-State: AOJu0YxCNMp6rT96ad/2IrbexwqAppjqxU6y7pXVhJ8z0IOAxF0NSxD4
	Uraqs/hqGYAyZQq3rhT7QpTRPI7XC/boH/pyX+CV7cmtLV1IQ0W53xfCag==
X-Google-Smtp-Source: AGHT+IHS0W33CaNlMkNguKngRaJLquGIx2T2W3I3O9tSLvWNtzKg40L2rXGGCpPlREm0an+Hg8h8NQ==
X-Received: by 2002:a05:600c:510b:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-432df72cf45mr7908565e9.8.1731642884172;
        Thu, 14 Nov 2024 19:54:44 -0800 (PST)
Received: from [87.120.84.56] ([87.120.84.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab807d4sm39778875e9.21.2024.11.14.19.54.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2024 19:54:43 -0800 (PST)
From: William Cheung <likhirahaman6437@gmail.com>
X-Google-Original-From: William Cheung <info@gmail.com>
Message-ID: <de7fd6b6699abb0ddc1d95ddd95b44e63ac74fdc1bde5822ad0577f9d9541878@mx.google.com>
Reply-To: willchg@hotmail.com
To: linux-fsdevel@vger.kernel.org
Subject: Lucrative Proposal
Date: Thu, 14 Nov 2024 19:54:41 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

I have a lucratuve proposal for you, reply for more info.

