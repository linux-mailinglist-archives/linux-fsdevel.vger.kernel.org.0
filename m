Return-Path: <linux-fsdevel+bounces-16910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449AD8A4B10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 11:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002772845F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 09:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5D23FB2F;
	Mon, 15 Apr 2024 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DcDtSfBy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCD33D387
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171805; cv=none; b=D4s0BBsqctOBGOl1WFzjl0vMckej4yGX1CFi/lWNu2HgevDYdAu4IsD28vOLkKFzfsrxhlwCrhsRz6vDUKxjR+kSQE//2tEwQRBPtyxvZ6SbNs0Kx25j6JlIEg6gUjKbkaj0TdpcrW2Uk8PSlveYB0f6PgVu/DuS8MnG5ZpKDmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171805; c=relaxed/simple;
	bh=UDZVZVX1g5OMTsjjQX+LVyzw/0HNCSkUc1rv+qnyaWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=is4z9lhoLvkpm2z3070+tTUfd+ebd6UoKPvs3tMj7eaquR9m4U24AUyH0zwRiIGvAeum4Wjxh7d2N+W/PPXydPY7nkh60RuBwJBrCnkZKHEru7Y4v1XyOMpOJpRCfYH5eTp0nv11L4kaYxQaw2sU/bE5UJrHCk1N+/BqlksIKz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=DcDtSfBy; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a51969e780eso381909866b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 02:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713171802; x=1713776602; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uiVrcy4V4FP2qGsVjSkGZEzHTf7mhE6QcNdUktSHBF4=;
        b=DcDtSfByN4oHigYyzTQvOpg8XspiK0n6vQ08OdVh6w5ZITeYWLSxRPe+es3S8UjKEX
         d91sbUCkISoXURiBSWIQpN5msbwrmqzp9mD2fOtkBGMnpNcr780KcnSYEPurS+Mt3+Lx
         oIQNhrbm46tliPNQpTELQp8WxjExWKuf9IUNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713171802; x=1713776602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uiVrcy4V4FP2qGsVjSkGZEzHTf7mhE6QcNdUktSHBF4=;
        b=tJI7YkNNEs6evEHNJFgjTuqhBUTXP9u/17Q370xFSasCj5Y77+jJBhsLPhPEEkH5Sl
         93x+0MONxZJ6yd9FEyR9bffD4VPrYG24ipAdHyjUplhljybifdJA0SRNlDDJpagI28Zp
         9ND/5oUYFFAxYk8F+yiZ3NYgcoRCZN5yzPvmJh+ubaApvOS3z+LzWXDNyOJpEoFiqLej
         8l+6val3hb454tc0sBw32ctrWHcJnNtU+ZhHd9yn2OczZPciuLydjR7s5fvVwWsXJZ+e
         Sl1iDqUMDIGzfaAGjgXzLfMM+NJU9pR/dzcJwtiwntpCMfco2neRHcm9flUzgAEiT2Gc
         UaIg==
X-Gm-Message-State: AOJu0Yz90BDCLfv3GTwpgGPh+a4fswJYrWYTeNQbFWQrsb8ktsHcZAtV
	rxjZKaX1dkf3HDVaoXvIxnpqE9bChDrQvWWgk35F4zmfgwEHcrwsUQIX8OGvjATj3lASpMOcNYU
	LP7JJDMElnPmdMHfo09aHXwqYBPQlo0nVuyYggg==
X-Google-Smtp-Source: AGHT+IHZnYyw9utewHHngmLFU+axvZ0XsTuNGqFJGs6VqXeiZSFD1wEg4rl8R7VHVMANvVZv2j+OOB2ZJ9824J0/6JE=
X-Received: by 2002:a17:906:f9d4:b0:a52:3645:22b6 with SMTP id
 lj20-20020a170906f9d400b00a52364522b6mr5424742ejb.1.1713171802253; Mon, 15
 Apr 2024 02:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315080253.2066-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20240315080253.2066-1-yang.lee@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 15 Apr 2024 11:03:10 +0200
Message-ID: <CAJfpegs_orEOsHs92kok7eUbsSWhSyCudrg3ffEQ-mkXOvghiw@mail.gmail.com>
Subject: Re: [PATCH -next] fs: Add kernel-doc comments to cuse_process_init_reply()
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 09:02, Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> This commit adds kernel-doc style comments with complete parameter
> descriptions for the function  cuse_process_init_reply.

Applied, thanks.

Miklos

