Return-Path: <linux-fsdevel+bounces-18108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790848B5B19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 16:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9A41C20F73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 14:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6277BB11;
	Mon, 29 Apr 2024 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="in6+d8G3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6068878676
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714400351; cv=none; b=J4N4xPGzZo7hE5UJ88EjIDTy8SK4yslsru0hwjREIgo2Ths/6qs/lVxWz3gLTPJl+IuXHsNDoYRn5uWB2OwUZ5k/0UFYhh0rc239b456+NsZFmOuQBl+0CIiiwcIF5k9mMWib4aZh/D19XhYXI6l5Bc7tkHtj1nFy5D4bOVsNEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714400351; c=relaxed/simple;
	bh=+pIWeNLgdA/47e5YyU3VS4krQ7ri+7pmqYcgj2Q4k9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9xD5I4xdv2Awrg/6TtPKc5vJxfGqdHKMAUHG23WxpVpr6IIN/5EKs+iXO1GDtNB5oILDqkoi0Z19ioqdU6iW8FJpd5P3EYnMVI0XXpHOAPQB8A26tdE6b9t7AsolHPM2LDvqt7i3AMio1ZqiKdAE2HvuhLTrl8LiLOSobh5kvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=in6+d8G3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a58e2740cd7so357792666b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1714400348; x=1715005148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DBg92/2aizpO39+g3BLqX/iwVvGhrSO8MyBZpdatmNQ=;
        b=in6+d8G3tClAVkxLv6pbO1U3ntiTyntpf263tMY01dYObueUZjWxz9vDaSNeVirOmm
         jMuEhE9ycmFus1QdC7SI7c6b+GU03Dspeo2lRv3FiYs9BSVuUPzm3ZWTH3YQmQux1oxQ
         POXVSnmY8AsdFy9MCLNxztENEo9weUvMocoAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714400348; x=1715005148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DBg92/2aizpO39+g3BLqX/iwVvGhrSO8MyBZpdatmNQ=;
        b=bMuPT8vTNxBCXwRFBVP8JJh2PeHKmgT/Hm0QlkqGmhdqkrGAhrf/pShSXzNl5zERZo
         z59Y2yLcJesS5/HQrt0e5lM2Wa/E0sIuzwoSbqnIcVGik9l7FQLohOd5V5w0uTJqTbt1
         yvrlFuBQIPkcXqfeaOoj/LiW7Z0HIQSI6Kdo98/VCPs8v5Cgaq4BqE7qo2Yse3irMOX6
         Pp+oVZYtC4ke+ZbGxs9tUMPjLtKLCva+aAOIRICJt374md+c8Pt4g5qZoq4cGMGMX5BQ
         9v55+XCCX/HF6FX6M7ql8gZPIJWZbn15dZVJAmtsePBdGUI111sDmx+pp7XZsfX6U9oI
         Lweg==
X-Gm-Message-State: AOJu0YzFqpJ8E9UMp5T2L+U71Db6jmN+qZ3tKsvboshNAwM5jwmXW7jt
	C5DS6xmZ6gS//ASPryIpW6caZtN4C7iu8rZzetWhC/RZenudA0SwkAxDkpTEAEKk4CGEmJ4t/mY
	HKmrBvapByOi/qJBE5gNQ9VNIwhgz/Db6AmMgSA==
X-Google-Smtp-Source: AGHT+IECkO328FjAYwwG9/sW/GNBvRMPqLE1TYn0cnu5CPvuf5dyHPGeDF+jxgeyTlR0kwk8u+rm5X/xoJrZAMM9ggs=
X-Received: by 2002:a17:906:3404:b0:a55:aded:200d with SMTP id
 c4-20020a170906340400b00a55aded200dmr8690438ejb.12.1714400347727; Mon, 29 Apr
 2024 07:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZivTjbq+bLypnkPc@gmail.com>
In-Reply-To: <ZivTjbq+bLypnkPc@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 29 Apr 2024 16:18:56 +0200
Message-ID: <CAJfpeguNAEH88aKTSFbEdaa4neUbpXVkbr5-XiAkOEH6ZNUoHQ@mail.gmail.com>
Subject: Re: KCSAN in fuse (fuse_request_end <-> fuse_request_end)
To: Breno Leitao <leitao@debian.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Apr 2024 at 18:18, Breno Leitao <leitao@debian.org> wrote:

> fuse_request_end() reads and writes to ->num_background while holding
> the bg_lock, but fuse_readahead() does not hold any lock before reading
> ->num_background.  That is what KCSAN seems to be complaining about.
>
> Should we get ->bg_lock before reading ->num_background?

Probably not necessary.  Does wrapping that access in READ_ONCE() fix
the complaint?

Thanks,
Miklos

