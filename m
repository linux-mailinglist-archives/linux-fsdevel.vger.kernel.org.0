Return-Path: <linux-fsdevel+bounces-27788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76445964077
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 11:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A987B1C238CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 09:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B6C18CC1A;
	Thu, 29 Aug 2024 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ouPYeu28"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838CB18C90B
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924637; cv=none; b=APmGV5XhYz95nAlH8r4iUIdH8LRWiBu9ws0qGRR3WUyGJ2maSUXniNlgQ5T13tgMZ5WB4t6FjrTqnv9ygqC7cKuJoDJtlZZNctiNBeCjjjFmsrEaeEtxKChr7MRqKVWrsrI1k5Fy9j3n78HqAWUXeBj6zLB3ur1jM1B6yCEJXJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924637; c=relaxed/simple;
	bh=6WGtKULhO7NtT1xQq49oRvr+3cJhPPCbH0/ItdgppYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BT5TT/Ciu/i2UlLOCg/F3L7uMseeP58QIXFEwSj4KzW1MfGdhn2ahwcehkf/J+kfEnz/BhlEBX5eRCCGgqGTa91ob0rMQQZeh8jiZt9+0eVgcHhAty5hUQPGvtxxbZVDe8o5ieWIqH1bMDWzQ2MnzhFk0F2MX1z0U1SGBeWUNRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ouPYeu28; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a86b46c4831so43032266b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724924634; x=1725529434; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6WGtKULhO7NtT1xQq49oRvr+3cJhPPCbH0/ItdgppYc=;
        b=ouPYeu28QfmfP8rZfXqgKAOzq4gi1aF/Mxbiyd9Vm6hBQcWsuq8KotSXL+e6+Y6uKh
         kd98Rr/8kRSNZBkINQ6FiOs98oS2Y0PaFonpPBEBP4/97ICpjP4FmTXXRO7nHuH277G9
         kNfabgksSs1hZdmXh61HTh95WIw4z0V296QnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724924634; x=1725529434;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WGtKULhO7NtT1xQq49oRvr+3cJhPPCbH0/ItdgppYc=;
        b=RLX1FOFUq/qa/80iSOsPjguNzrOCwoQF64iSmAigYiX3bJ2MEBr6SDfp+4vHx5/vcv
         7aJZiDrGmLgSPSYPz7DXoSoFaMuTx65DKW2n0xmShylLLqDPtFZdiCx9epFZ3BS2foOd
         Jk80r71HRmcjuNtW6XLKfdkWKIe0k8WI8MSQ6zKo3CeT3Zcx+9bkxCEzf/Yo3LWKRL9Z
         if7dB2R0brnMjN7I0GHCt7H4DlCe5kmOy2VuofMpcRdHknt+7pCGYDh6V2vxUBau6yEL
         turqAL0LZ+lU3eu9Jogf/Ya+nw1UYKIzrlRH2EK2xp9/gnMtz9fOyT8RrPAWU0ByxWNx
         rLww==
X-Gm-Message-State: AOJu0YyPC1Kno8cqgaR7Ur05PPw1XNK8AAkvjN5cyUNamO8L5z1yxJnu
	q7ywU2gud8jWXOHjhXMiyGizD7jJxY/Gg/AmynpEr9PVl/SGm0X29qbbKGXtiBeNGsjf2MaM0Sh
	ZWQCH2aPJfNJcKyje5XmbmsEgCU6JRN+8AcdRog==
X-Google-Smtp-Source: AGHT+IHsNUkYXjfU1oM+c5YkSz3TMi9+2UKHgA3/7MACl7eKulH+vN+TQMlnBEik3EWNhJiL3d5fjhwJ5AyvhnwieYQ=
X-Received: by 2002:a17:906:794c:b0:a80:bf0f:2256 with SMTP id
 a640c23a62f3a-a897f7821d9mr162353766b.8.1724924633804; Thu, 29 Aug 2024
 02:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517161028.7046-1-aaptel@nvidia.com>
In-Reply-To: <20240517161028.7046-1-aaptel@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 11:43:42 +0200
Message-ID: <CAJfpegtBjy+ns4e73B3qB2_U82wwuq33LNcFuHtfMy9agncaHw@mail.gmail.com>
Subject: Re: [PATCH] fs/fuse: use correct name fuse_conn_list in docstring
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 May 2024 at 18:10, Aurelien Aptel <aaptel@nvidia.com> wrote:
>
> fuse_mount_list doesn't exist, use fuse_conn_list.
>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>

Applied, thanks.

Miklos

