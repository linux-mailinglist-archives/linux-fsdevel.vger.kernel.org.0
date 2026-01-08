Return-Path: <linux-fsdevel+bounces-72922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1777FD05A85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 19:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31D21312C515
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 18:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B135730F52A;
	Thu,  8 Jan 2026 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJfNMYdL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E3B30FC00
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896337; cv=none; b=Lb9pCqywXL3+Z4AsqCOG8MaeMMP4UluQz6KYE1MURwsc2jiIJxs5zTbvW8swbftdEEj4StCXB4oy136RN3tBiCHzOJJRBoOqmyfI0UpWIvImZ3bLanf6JeKSQbMVXU6DSEzJDnaecBv1Eu7mVgzuuZXrQg9/Tay9DmDeV6vIY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896337; c=relaxed/simple;
	bh=Fn/JoGzjgMnLNspl3ck18e3p9KeNwhc/CT4wpLvvEIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjW3yzRiaPVaxYqjkLzt/Jcf3QCnTbZH1gotrAxCNildGAHnu/qvNA5qap8gGJbT3GRn6KQNMcmZ+588k5WGJl8c5R7WhFRUPFmvuiBQOyY7dDaagKX6gL/kbmGdT+Flxex8gOTh7kTl70IY8unYRF921cBfLJoEa1cguU17d4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJfNMYdL; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-93f5761e09aso1975424241.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 10:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767896335; x=1768501135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fn/JoGzjgMnLNspl3ck18e3p9KeNwhc/CT4wpLvvEIw=;
        b=UJfNMYdLd7CGhfVtjf1YZKGwtsOA6VJM7o0BT5tJIxRs6a8Iq6OO+fo1J4eWXj+8F+
         BVzQj0KyOeH9b3veFy27ddmS9r/VL/S9MlD+TgZYZx//kzC0kUAZ44OdgT4+vNH6WuGw
         GjWvT3NRd153lgF7kQCSWuec9feiOQaikbrvBgfY1cjuAUb4ZVAG4nReqMOeP8geE0AI
         9+Xuon7lnqUd2tJOmEmG+4tt1nv9CQEioyplZAXF5OkjOsIuQMPxzjXhKYkqPDLTSnag
         95b9o0Sc01ZmSu5nuk6rgdsZ3LbqHZsjncK5ibn1TvRh2sM6kUZGuu5KIau9ukCcNk/1
         TYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767896335; x=1768501135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fn/JoGzjgMnLNspl3ck18e3p9KeNwhc/CT4wpLvvEIw=;
        b=g+W2XyQeEDz9h10uZvHin3Wd8UVur4ObUdKQl8MuKs5PchZjdSBbsy3B004E+VIGfL
         LD3tRv0VaE9E1RUIdr6GEuA9+ccXg9+AiKImBDFGwUh/tgyK6nYDanfQxrfW97VOw/hP
         AK+pOecCKISqTqEg7NWDMeyyKvodFi6IOPLaGzX0+gcj2htl8aWJWZgqEfs2KUqKBTWQ
         vCAvwIqC86KT52rIKc2IeYtbmPNpOmK6pHydpjQp8VsNBm02m9XlPi1xrheZFUoHE7Yg
         /ZSvhHD9buZESJmkfwIFOINQlsPm/YQ5FhXt/TdTpECi1+ZaAbgwqfUPPQFzMImnMTDq
         XdRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIkrCZkEjGXAUmtCIprU0ruH3Qy9AlMkV+2vGmfBmG4WQxc/alRRpV+GfINrSGXRONPB60xFwpaUdNRNfS@vger.kernel.org
X-Gm-Message-State: AOJu0YzBZO0KcqkCY8VKU9UHMY28YCr7LxvmxK7kTmIVKR0Nd4Bw5jk/
	nM+CjWgJjQ8T16VncGe86lv5nnJ21Wn8zypGYHxO558qsj/Mxtoel4LwnT41PxW5j9yAwdU4YI8
	nwV+vNjD+b5VIRGkDFD+zaaMQ+ex4wQA=
X-Gm-Gg: AY/fxX4R6gjen+nyDwckVsofoOgl63MVaIqyyAOvEp3hRF+HQYlX8HqvZE91w6TRxnE
	MnFIwybx2Y+PX5AW7AHqz9NyAITYWnS7rD3peWmIHsI36Ijm1dSEXYdbC1hIi0INUW3/fWgAneX
	Tx//vfnmGTImeowyF6r9aLLn043GSmPCdOBCV6rvyAmnpZ/Rk9wbEmGtnljOQMP5oThvif10R5/
	XKXZ/pQOSOw0yY0RBxPq4HOTNClmzESNQp5zDqVqaVODr2jahUx18vRbmdD+nnSk9+bvc92UzT0
	OHBc4Mem36ob+kVaSpwaYPTNxXML
X-Google-Smtp-Source: AGHT+IFZDy2QW6KnuIxIEyHkKpqj6MMEJSR/7O9XSRt3iqhghTeDZkCmQR+L8EcADh1b6vUy07gKP1CBUhZxixK3ryE=
X-Received: by 2002:a05:6102:4412:b0:5db:f352:afbe with SMTP id
 ada2fe7eead31-5ecb5cbb3e6mr3294188137.6.1767896333290; Thu, 08 Jan 2026
 10:18:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com> <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
 <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com> <CAPqjcqo=A45mK01h+o3avOUaSSSX6g_y3FfvCFLRoO7YEwUddw@mail.gmail.com>
 <58a89dc4-1bc9-4b38-a8cc-d0097ee74b29@oracle.com> <CAPqjcqq+DFc4TwAPDZodZ61b5pRrt4i+moy3K1dkzGhH9r-2Rw@mail.gmail.com>
 <704e5d2a-1b37-43c5-8ad6-bda47a4e7fc6@oracle.com> <CAPqjcqqhFWz0eNGJRW-_PoJhdM7f-yxr=pWN2_AfGSP=-VpyMg@mail.gmail.com>
 <02c255b8-2ddb-43bd-9bfd-4946ef065463@oracle.com>
In-Reply-To: <02c255b8-2ddb-43bd-9bfd-4946ef065463@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Thu, 8 Jan 2026 21:18:41 +0300
X-Gm-Features: AZwV_Qi1KXJg98wuNlhob-PhKfYxveiRiQnCM2LlNsbeCGFpRxNmbpDflphYfZU
Message-ID: <CAPqjcqoqR8UdC5K-RCjKvQEoA6jnRBVZc53ieR1fjJKz9-V9=w@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Soo, let's remove the 2^N restriction for raw block devices?

