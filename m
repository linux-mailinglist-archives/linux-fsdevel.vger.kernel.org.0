Return-Path: <linux-fsdevel+bounces-28967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE43E9725FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 01:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15F88B22215
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 23:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C7118E76E;
	Mon,  9 Sep 2024 23:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBNbOW26"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD91B18E36E
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 23:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725926280; cv=none; b=RmDFj/Nj5hqciwv38NHN5NN6eGjmTtlr4a0yauX6LNSK/uz8htyW8rMmayZFgTvWbFXnKem4QQS3GN0NzTNJJZLz5QQlFFrTBzilOof8aKN8nHXOdwnCyIM1+nt+WjGza6QxV1iNXzZuI1DWJhPT2mxowrBhKw1wEl52Nl3iZys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725926280; c=relaxed/simple;
	bh=lQhn2uPJQmP5XiJdjuiIobzcSaZmDikyUT/yUvUX32w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=BMA7ufh+AgCiExBu4OUj1J5++6BN/IodTG2f+e/wNUW7cCBjjxMgRlrMADKpie2rxmREM2QdmcXTWdNUiq0zPTPZiUx0Oy1jDV9wolqCzs3qw83GhSXaNpqLMGq0+aM7KYh3NtH/HBTsHhtfh4xEpexdhR3oN801mN0QyrLXm2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBNbOW26; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-49becc93d6aso616752137.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2024 16:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725926277; x=1726531077; darn=vger.kernel.org;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lQhn2uPJQmP5XiJdjuiIobzcSaZmDikyUT/yUvUX32w=;
        b=LBNbOW26+CjeYTXRW/HRu4Y4yregNmtUqsNkMbhbYf7C/3o/cKNqEkzrQXMKsegNFH
         XIXWqDLTh7XfDKFiyyHGyAwFHyjVAm7NVpcLcsuwI79GSKq0xZ4KE+6h1eNwTjP97BbC
         Y5rBkR4RZ5TFWxDqlzr2Py4gyqUzOr1CC6t4y0uPDfNXF/rarISNSBKCA0AgQ0gJIIcL
         1yUFL/rw9XervPUTxzf6qexZBzQOwfKem6Ih8ht2u33m9V+6LyxUzSs+druxYMTU54B1
         z0gOruBy4w0RqZSy2W+vWxuIo+xPgLtylcaAoE0T5njbvXkFEhoSLv2bZN7hnk4X3emt
         3sOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725926277; x=1726531077;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQhn2uPJQmP5XiJdjuiIobzcSaZmDikyUT/yUvUX32w=;
        b=cd6Qbo/NAm+RdTksXlluo/0+G07S834RDcoBMT9eyebXCjrOBfYIStiR4vs5v7Eh1K
         b1yqs1wKQSaZxiuaGHElUNexCi9kuErK82BMLCWQl4srjGcl/GsC45pv1InEsXnM7sU1
         yfOXC0fZDn7vio+ASmrprh0RP+LmEf0Byup+H1ZhSwuYYgpTa4SGJfEqtZnVPyqdhdB7
         6PcuueDDgYHZ1SnCyttOCo4fzfSaQ65gA7tuZPEcP4RoKDgPMCLmN9K0+1eZb8VZcwe5
         LBeKtd1b6U5Y0LfnxXh30hKmejtGMMEhfAO5yttF6+3gU5StF4H2qAp0uS2VYiZO/Scb
         BOJw==
X-Forwarded-Encrypted: i=1; AJvYcCVrb+u8W3PJoKXE3fqUmjrp/ih6h2aPMdMnS8iqIwpUo+8BqYFFwICt683u6gil2cNnGaRkwnUAXkFWdW7E@vger.kernel.org
X-Gm-Message-State: AOJu0YwFxYzbo1BTof4/FuPWp0IN05zVmSYohc9RNynuVZxQ/OzmpYZM
	035222B78cBbodzIgsU16gsqIluLls2HcOPYMXApSCQMrXgRVft3DPfl0bUb+4OVZopHyXu4bF+
	Wk0nkSX+FOBCe0mgbY0MfINy8ZYs=
X-Received: by 2002:a05:6102:2ac6:b0:492:9ca1:d35e with SMTP id
 ada2fe7eead31-49bde0f8b06mt9009667137.5.1725926277510; Mon, 09 Sep 2024
 16:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908192307.20733-3-dennis.lamerice@gmail.com>
 <346199.1725873065@warthog.procyon.org.uk> <CAGZfcdkGw55MKTYxuOkCgu8kJU86jkERfLRJAP+J8Z6=0z1F+g@mail.gmail.com>
In-Reply-To: <CAGZfcdkGw55MKTYxuOkCgu8kJU86jkERfLRJAP+J8Z6=0z1F+g@mail.gmail.com>
From: Dennis Lam <dennis.lamerice@gmail.com>
Date: Mon, 9 Sep 2024 19:57:46 -0400
Message-ID: <CAGZfcdkCcjX0-xyR9UbhnnnnwZuRcKfah+FG+KkSNztj1EHKMw@mail.gmail.com>
Subject: Re: [PATCH] docs:filesystems: fix spelling and grammar mistakes on
 netfs library page
Cc: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For those reading the mailing list, sorry for the top post. I'll be
more mindful in the future.

Dennis

