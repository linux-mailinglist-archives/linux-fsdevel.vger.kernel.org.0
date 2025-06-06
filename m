Return-Path: <linux-fsdevel+bounces-50820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF94ACFE38
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 10:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7DD189B5B6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CECE285412;
	Fri,  6 Jun 2025 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="RwgGFdy4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C76189F43
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749198396; cv=none; b=M/jBN35uHELKtHEIxYv19oN10K8vbWuUiaroDHAF9HeillNQPWScXVyFb6gTc3yZyfNlM2MiSjU1azc9t/gLiqWGAq8JToOYQC0ulJRaoooeGilT5jmPxTb/GJViu21ESEtBjbYjAKgVdNulGPmMivVYwsrtsRCf2R8/ICFNCyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749198396; c=relaxed/simple;
	bh=Lk/4bNgje+km5ELpEXzFEGafBzt8r05auPYlzNrBk8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVXeZH3g/rd8PG3ql8uCvz/Hffi1H5Ep0UR0aruSZHKPdY8MXOd2y7u889WqCXmrQ6tUQnXth4pCuYM+C6MjSVdOTxXsbRCcoYkgWtYl5pFRjAbl5E0WMTjR7/SNEaeptM/IWTEve1cCicpGzl3KW2QZ4ZM3YU1PAI/WE8WR4a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=RwgGFdy4; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a3db0666f2so39661421cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jun 2025 01:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1749198392; x=1749803192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/82TyWvrgWW43lzxaEpfXgvxvM8+gL7hQaGtQ71+kKU=;
        b=RwgGFdy48ql4SziPDIvVyRssev0HoWX4EdXDOd1L3JZc0LtACCC9aXPEYNDg2Is/so
         KuJN0odSR/eW+FvkPrCb5yEA5EUJQ6niuiO2y3lmQfoHLJ8S7HZrvoiyGHKm6W/rFfzY
         t8ttcleLr/9tTiZuAh8SD7slLX/tFFmJp8QEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749198392; x=1749803192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/82TyWvrgWW43lzxaEpfXgvxvM8+gL7hQaGtQ71+kKU=;
        b=Ujfsr+mlEHjzrmsYmxkaL5gzZoAhTZOhQ4FSViAjBAN2oPOBEkWvGLkaV3jYu5Lx/J
         2s5TWRomidM/N7j1BVjLFMUM0Sy4Jbx9GAjw9zr4vniQDFkWoJQw70xnnZpd0R/zMqbY
         wZqhsFF/0yRvcMox7TV55xGI2j5FAGGYvQxteL0kdezigBqXUWyB15Jf1uUC/ao4+zL7
         oKn3m2LuldjNV2Q4c2Tb69t9xJApO5dBo1RHqbgr63toTKCa21l3yrc9RmQJwtfYV6rC
         sn178tu/8h8nT99VzQeIauLrQV+qXed5G2Aaz3qXbuqXuok7HIZmRfm/zoKQEobxP1w6
         1+WA==
X-Gm-Message-State: AOJu0Yz3GfrX2ZVTTzqG8IzPtSgK81GPyPZ9MAIhKoRQ2uvKAWhNWbLt
	8fSLELiN8dnb8BspLz/zwBQcKEY4qeurVFCo7Ffo+5xZuGjjQHVC+yjt54XSXsn8oJBdwlbw1go
	O5VwgmiI6KRrb+GB36VdVj2euubQetVzUHEo9S0bTrw==
X-Gm-Gg: ASbGnctPMlGsMLXR1CP8AWRLtMlKjRqrgF7nJSb8kUr74uFuF1ILNVgyie+1ymBacfK
	bwUnGff2iJye/iNLxUJfmtO+1vn4XY7goENgNXo74bawj30ayRdcdlH5MdRy3VBriJC581VbL/n
	H0ZGlCJej3oHsiWBQsN1P2/7x16zb6WJZY3e8IXwgH+g==
X-Google-Smtp-Source: AGHT+IGBbi1c+tA0gmzvVBVmYU7L9J/QhtafZyTFlLLqiw79nw0P2vMwUHhQmJer78X7KJBrKFe2wFSw2pFlN2i6t+Y=
X-Received: by 2002:a05:622a:4a15:b0:4a4:3b41:916c with SMTP id
 d75a77b69052e-4a5b9a38b4bmr49387721cf.17.1749198391790; Fri, 06 Jun 2025
 01:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <jofz5aw5pd2ver3mkwjeljyqsy4htsg6peaezmax4vw4lhvyjp@jphornopqgmr>
In-Reply-To: <jofz5aw5pd2ver3mkwjeljyqsy4htsg6peaezmax4vw4lhvyjp@jphornopqgmr>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 6 Jun 2025 10:26:20 +0200
X-Gm-Features: AX0GCFsh9T8XrzmD5kl2B3MmZjfNpAHi77kyIUl6LTG8TtxdLikYxjk_YHqZDoY
Message-ID: <CAJfpegtNB22Dpi=wX8nBDx=A9SeYZKpZGniJHBBxJBHB3o0nHQ@mail.gmail.com>
Subject: Re: fuse: suspend blockers
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Jun 2025 at 07:57, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Hi,
>
> We are seeing a number of cases when blocked fuse requests prevent
> the system from suspending, which is a little important on laptops.
> Usually something like this:
>
> [ 36.281038] Freezing user space processes
> [ 56.284961] Freezing user space processes failed after 20.003 seconds (1 tasks refusing to freeze, wq_busy=0):
> [ 56.285069] task:secagentd state:D stack:0 pid:1792 ppid:1711 flags:0x00004006
> [ 56.285084] Call Trace:
> [ 56.285091] <TASK>
> [ 56.285111] schedule+0x612/0x2230
> [ 56.285136] fuse_get_req+0x108/0x2d0
> [ 56.285179] fuse_simple_request+0x40/0x630
> [ 56.285203] fuse_getxattr+0x15d/0x1c0
> [...]
>
> Which looks like wait_event_killable_exclusive() in fuse_get_req().
> And we were wondering if we could do something about it.  For example,
> perhaps, something like:
>
> ---
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index f182a4ca1bb32..587cea3a0407d 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -241,7 +241,7 @@ static struct fuse_req *fuse_get_req(struct fuse_conn *fc, bool for_background)
>
>         if (fuse_block_alloc(fc, for_background)) {
>                 err = -EINTR;
> -               if (wait_event_killable_exclusive(fc->blocked_waitq,
> +               if (wait_event_freezable_killable_exclusive(fc->blocked_waitq,
>                                 !fuse_block_alloc(fc, for_background)))
>                         goto out;
>         }

This looks fine.  We can turn each wait into a freezable one inside
fuse.  But that still would leave core locks (inode lock, rename lock,
page lock, etc) unfreezable.  Turning those into freezable isn't
realistic...

But a partial solution might still be better than no solution.

Thanks,
Miklos

