Return-Path: <linux-fsdevel+bounces-31155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 336A49928C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 12:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF901F24DD0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 10:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDE31C1742;
	Mon,  7 Oct 2024 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BusjZvhn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288161B07D4
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728295522; cv=none; b=IOIojta8ZWky0SN1zJrGtgvhfqEtVNiIZu7UDnuYWsuowxugGIGLSlrCil5J910rMljLTFmpAu0mUsINpgyF9bLGT4V35wQJwqwDAjtyouorS262qdhyv9QwDdqmZxkNqYkPy1vq9QA7UD4WhLO8daVgN6UFwQas4oU/bBW3HMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728295522; c=relaxed/simple;
	bh=60X5nUyAE9DrS52akUXLSBpRxabsnePVmWNJSqfHVqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4Jq38pOX86rW8H5Vc5rVyp9wH23R9RvddiRGkIohqSFQgASWwsbutLew3A34mQQ1ZPEetQLvOTbqPAFy7SSC4XAocJiGu8iGQkn4lElsZvlCmjHdqFjBWwM05zIF+o0s5rCAip+Ff45ZPXYu289mplpIyUSnr88r/fnjVJj9WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BusjZvhn; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5398e7dda5fso4108833e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 03:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728295518; x=1728900318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=60X5nUyAE9DrS52akUXLSBpRxabsnePVmWNJSqfHVqM=;
        b=BusjZvhnpQ+pE6LCNNDzU8CKH67hwvr3bhWzgM3pc3NZW9sxcvyHp2mejs4G/6urkr
         jPbbJsRcpvOFX7OZGbh4OlWuqmHObw1K9G70klCADV/Aiatn49VBwBirqb4BcwwLPDfH
         8FWVjXibpnIa/fsZUnFrHh7fgtvgvUmcWC/Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728295518; x=1728900318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60X5nUyAE9DrS52akUXLSBpRxabsnePVmWNJSqfHVqM=;
        b=XZB9RHWFCNbtqF8OLIlPtwrkJbBA0yUGhw6+GUIyEFbi/gRX+te9DqpXqkFnQjQMOJ
         O/j2/VLgNOnhZ12RyuuBSwnf0W9HtVx3CeTb+SE8sy2QCv8kqk0505O/7DMrpqXpT5As
         mdZIQGk1hRmakvKjXovWneV5BfMCFXC7ChgxUfZP8IksCOeGer2N6shRq9+GrWrnzHKD
         +u65jOcUzKvFBzXa1Ipa9ZYxYyviKX2mE7qZNjaBAudRR5BE90Fr9dPt+aknkBbGewzA
         +TMrwwZ2Bd2L/UVJ+OwpCCMRIPQMNEcPm+fCc//JJCOeoYvtrNo3tGGYdB7fy4V0HeBL
         R8ug==
X-Forwarded-Encrypted: i=1; AJvYcCXDhdlNUd8wURJ8ipdKuBRzGl6mHBiwZMLPbA0bcGj0FwAhxIdJm/ZIgy/Q2xBmsM/tcfBUsN/Y29e4+Rwr@vger.kernel.org
X-Gm-Message-State: AOJu0YwwV3Km6Zy9s1oCNla6kQvDkfuSQhArG8pr0KsTJAhLFyl+lg5d
	vjhtRfzN6o7YPLgIms6d2BcMpmE4rvfUTQFQf8bor6FpTPUkk4+O4RhZ7bApcFtjwKrC0KcrBA3
	vl+9tysh+ISP1k1pgHwdOzX5G063FKOdQ1tncnQ==
X-Google-Smtp-Source: AGHT+IEMCR/7S6+NB65Ewgm85Y27kXieWu5X6dcSByOH//2ik5TJFm6oU52jizX6aN9ixkQGjMbaeNJrse8KTg0/+zE=
X-Received: by 2002:a05:6512:b9c:b0:530:aeea:27e1 with SMTP id
 2adb3069b0e04-539ab9e6cfcmr5778643e87.50.1728295518265; Mon, 07 Oct 2024
 03:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004182200.3670903-1-sashal@kernel.org> <20241004182200.3670903-45-sashal@kernel.org>
In-Reply-To: <20241004182200.3670903-45-sashal@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 7 Oct 2024 12:05:06 +0200
Message-ID: <CAJfpegumr4qf7MmKshr0BuQ3-KBKoujfgwtfDww4nYbyUpdzng@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.10 45/70] fuse: handle idmappings properly in ->write_iter()
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Oct 2024 at 20:23, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>
> [ Upstream commit 5b8ca5a54cb89ab07b0389f50e038e533cdfdd86 ]
>
> This is needed to properly clear suid/sgid.
>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

AFAICS, this commit shouldn't be backported to any kernel.

Hopefully it would do nothing, since idmapped fuse mounts are not
enabled before v6.12, but still...

Thanks,
Miklos

