Return-Path: <linux-fsdevel+bounces-13732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7308733AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 11:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3103F1F21C9E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E025F85F;
	Wed,  6 Mar 2024 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GUyHMI8e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4F85F560
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719783; cv=none; b=oZ8L8R6cE7GehHgae/SSS0qCCoQxkvJTRnNpj6oKsHPbj3o4p1GqhG6gYh0eFDxogAIktk2AhwrUmhMP81JIHkyI3iV/yLbvWFZ1FlnFHPOMerB9B1xJMaUTSJChSDx2Vj4jfVMwK1gmMcTInPXtqZASLvbOvarlLiYlI/1d1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719783; c=relaxed/simple;
	bh=0PccJErTXHfkHNF0XMu4d/4cmRjalvJVodpw/sl2B/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5IEe1+rCvNjKmssL3Blzx5HnfFFJyBJKE6ZB6NHeW+jLqSxB6xM7y6VWbEj+sgYL9sxYtFhdnDQhuwyVNNjSZUzgSUMZiDkA1Nx5AZkclDVIR2yOYBk+W/OQzDjE0YMdKdK2gG2F+g48nWN0fagga4/BffeVl4Pr2x+7aULYzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=GUyHMI8e; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3122b70439so222789566b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 02:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709719779; x=1710324579; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0PccJErTXHfkHNF0XMu4d/4cmRjalvJVodpw/sl2B/Q=;
        b=GUyHMI8eu0HwnZaN3mZxnaw6WtgSJWq+jom0ECcQiRrN/jVWCIzmdLFwgIUgg+uyIj
         8AUgRZEQx2vhrcpBE2+ayQUxFOxwIMscdy2bjnvWWKhmJZve0gBxcfmFjVfqv8RL/zPg
         0u6MadqV89KSptM44YFbwPW8c13oHr8Cfxd6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709719779; x=1710324579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0PccJErTXHfkHNF0XMu4d/4cmRjalvJVodpw/sl2B/Q=;
        b=hoV3mdlmXpSW/JGBBE4lXlhMNOCD6JYrBSSOxSSqjiKnEpKc+3PyrbeBLfZmBJRMv/
         Tkn78qww9Fzz6L+kVd60NxpRzGcrQtSxP0bA/pFAKdeJX/aNw/rSqWgAkZgPswUTGIdf
         +KgXcXBWipZq2rJ29XNWjUBaGwMC41KegIOywweqdlWGiy2DkWXiQVcI3AqUNx3aiE89
         yD3EMzYHp6sPmfFOHRY6veEuuLx5BrQQLwbi1R3ylFR31gIVuhAwvXqSxiXIWI3vpyqp
         ndsbZo32AIvxfEwCmOJ/qXeNFlm9TqpMpG+uXDwKDxH4BZK+z4VVLTWlnHPuBg69PsGv
         h0NQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4N7hByRca6sis+rFtGc8WNkDBGzP3yBpqekmJfiFin4Xzqk6bU/1tUHyb6P+J8+dTbUiUcDEEnoMDmNQORWcZ54icRCKMtqV0bEJ6wg==
X-Gm-Message-State: AOJu0YyIc2oGvrav69rKx3uOZfsFVKxzFeo6Uu16aRh8IX3xug9MviTa
	bqnKvvOBBVGCU/lKpJR76b5aATXbSuy+3shQ9hcBAy0w0lKo6eLuDXQI7EMjxYj44DRuwYjsZ+h
	Vm4jHv5dlC+34Bz0tZOekEhAl2VDXPME1R5b9j5pWljLfEzHI
X-Google-Smtp-Source: AGHT+IFRWLJmYTfiQQ9IQCza1Cgaiv+dmFKZL7V25wJdmMcJXunLADhAUYgk89XezMRItWsiRwu58/w+/rajyS0vIW0=
X-Received: by 2002:a17:906:364d:b0:a43:811b:71de with SMTP id
 r13-20020a170906364d00b00a43811b71demr9390748ejb.38.1709719779577; Wed, 06
 Mar 2024 02:09:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231007153956.344794-1-shikemeng@huaweicloud.com>
In-Reply-To: <20231007153956.344794-1-shikemeng@huaweicloud.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 6 Mar 2024 11:09:28 +0100
Message-ID: <CAJfpegtjB1RufZBRTJ0wh_xdtbOdGkyuxVV9kNV98WxbUiqQFw@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: remove unneeded lock which protecting update of congestion_threshold
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Oct 2023 at 09:40, Kemeng Shi <shikemeng@huaweicloud.com> wrote:
>
> Commit 670d21c6e17f6 ("fuse: remove reliance on bdi congestion") change how
> congestion_threshold is used and lock in
> fuse_conn_congestion_threshold_write is not needed anymore.
> 1. Access to supe_block is removed along with removing of bdi congestion.
> Then down_read(&fc->killsb) which protecting access to super_block is no
> needed.
> 2. Compare num_background and congestion_threshold without holding
> bg_lock. Then there is no need to hold bg_lock to update
> congestion_threshold.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Applied, thanks.

Miklos

