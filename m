Return-Path: <linux-fsdevel+bounces-69880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 278C8C8992F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 12:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C720D356C99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 11:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1C6309EEA;
	Wed, 26 Nov 2025 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QQWSZS7z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FDA264602
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764157320; cv=none; b=K7oo/ruuDWcoi8PQxC+R0kt2sTD6g7YYGBIMCuhzJsDrBzI/vXG6jmorqrVIfdvpFUf4U8ngFDgiH935A3NyWByoDiIbw4pdkV1ur3Ra57Rw0FxRky3V1Jan6aycfmPDV8iGseWSHtFwVKv4x+6AkrqsDRP5b0N1FPcV7Jv4aIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764157320; c=relaxed/simple;
	bh=3TrPITR5fw5a0W1VeSPTH/hmYdtVdLq1/Im78yZGHyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erSlXcNXe+PChk9r29AurSQt5BiMCmRQg3mqy+l6vhP3S20q+e8VhkSuRa6ycumqOXGIHihSPGNp//+Kk94Ln6SUZF3A/wouvz8yusWfGcyuh/TRsviG1jguBhDSCOP+sKOSRyqWYIrVaDpDnRBO3kPAsIeFA6cJpIKUvT81rwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QQWSZS7z; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed7024c8c5so51671261cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 03:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1764157317; x=1764762117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3TrPITR5fw5a0W1VeSPTH/hmYdtVdLq1/Im78yZGHyU=;
        b=QQWSZS7z4pYN3ONJW8mjyd0fKcI9SrQYPFPpSJF0fqHaO0W8X0Dmo6YJgLtSa8nnhi
         h0Z2YId0cppMCrBrqHhjHnb7fZqjSXlljRn+/5E9DBrWqP+XTj3ffzPOfTsJQ1iUIC+p
         hpI/VwfzCiEE5Vm5ObjAf1CGb+MpCIYNWLgLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764157317; x=1764762117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TrPITR5fw5a0W1VeSPTH/hmYdtVdLq1/Im78yZGHyU=;
        b=rKuynki9AraEOdOH7bfwl+gEfgkenoEaV4ICYBcK4Tv5j7ZWy3j/xGFybTmLZGT4hK
         yrJDlbIwW4Na9AF9T9PmQtvGEq5hfz+DP5M1h+dQpIRzvNLsbCMZRvp7/aS65lbhoZSo
         K5dpjI3OblXVzY9XElH3AdrVXYxhn9YKWvw76sVDULTAX3ScEB6RIXSy6BUlggehw5KD
         XSyE7tN8/jnGfO8bXn4Eix5X0ZbmtMaGyqwXWd7sM5xrrF6T57LqdZXIr3qbWMqgSPuQ
         +KNf/ZnFJkRkn1NERcv3xqzIVbbXgTgWSVENLl5Xm/PUF9m5MA3r9nXL3jpy2j9ghmEw
         mTlg==
X-Forwarded-Encrypted: i=1; AJvYcCXCIl5NXXpOcT1PzpeKW6S8swnujqOr2Q4BNuZbsetIjsyev1AMApriKiss2sEPTnA7DKV7lm/F4LSV1Asf@vger.kernel.org
X-Gm-Message-State: AOJu0YwGEEnAQQBpmKYrB0CSayI6MtgP2tAICLV1PgIG5jsY2ncALb+W
	tBr0rdXIUDmzOrWGngfvBMx8B/8kM9huaJ/vXp6QjbouQqCGyFlpIRgqXb+NVfHTCqq2cZRa4iv
	PG1/K9xHVViJLNhi8x6m+aoeivJ7FVm9UNqYCpX+bkgYYf7G44NxDEtc=
X-Gm-Gg: ASbGnctMtp+RHT8qUSIeJwUOCcWy1IS8f+xa5JNYg1Gl7gLuoaUqIxsSHbE27xJUVNJ
	GgEuclDDKJ2eF2edWI2dvmST+0X3kjpe/4T/5oVamT3ugVNQGnvqO6IjEHNRU4BkvisE4wkF3cx
	U3pBSL3M+HDxX0oT6p7rJV72yGfd1TF672k9h3eLfqk+mFh2PUHWyku/4lulfK+uLR0tS+htGjT
	1PNKaMeiop96h3rUSdJOJGMeeCiWIf4/2X/ydow35JMSiCUM2uLJ50MEm19ddSaQdWCRA==
X-Google-Smtp-Source: AGHT+IGwiCfvsYjvRz601L3ODAD7Pe1dha+A6PPL0nEX34xBSTGWYz4spBcuGp2RgPp6PZ9kC+NSSFFHYJUM7ESANR4=
X-Received: by 2002:a05:622a:1a22:b0:4ee:d9a:8877 with SMTP id
 d75a77b69052e-4ee5894f754mr282593401cf.72.1764157317117; Wed, 26 Nov 2025
 03:41:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125181347.667883-1-joannelkoong@gmail.com>
In-Reply-To: <20251125181347.667883-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 26 Nov 2025 12:41:45 +0100
X-Gm-Features: AWmQ_bnAVgwLBvMbwg10zeckraBYA76EyDuBjr2HhKVgcpwPz3Sm-R7vS3aZ3Cc
Message-ID: <CAJfpeguy7ADLaxwCs1V2+Ojgg3xEDNhaU2JTMfHNTLPfYxxfKg@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix io-uring list corruption for terminated
 non-committed requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Nov 2025 at 19:15, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> When a request is terminated before it has been committed, the request
> is not removed from the queue's list. This leaves a dangling list entry
> that leads to list corruption and use-after-free issues.
>
> Remove the request from the queue's list for terminated non-committed
> requests.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")

Applied, thanks.

Miklos

