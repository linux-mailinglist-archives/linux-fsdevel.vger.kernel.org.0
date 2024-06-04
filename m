Return-Path: <linux-fsdevel+bounces-20910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F828FAAF3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 08:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13701F22B17
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28D013791D;
	Tue,  4 Jun 2024 06:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GIAGrUmf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC539801
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717483239; cv=none; b=RPAQ60fcEunfCXxy8ExkwCLtGAa5nEMJfrqzLUgbWnqyK8/khMyAEcxuTIgYeFZON01lM4G6d7iuEcZX04AgYFi+8GfIonfvRkgIYjXVYP17p1RPQXRlSLjUXHoEqlh+eHHcpNoxB/xiDMLibWfjtIqWbgGkGpmT7Je2I3/DsAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717483239; c=relaxed/simple;
	bh=B96cSyLmh3/R1bmmrZtVOU0D9loS2sgoxSCa7FVVj3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VE91mIiFPvSBopRrZIeLMmCBJfhiZdKJdj0OZbbW+G6uL9iZrFhA4cmSXaB4H5RUL6Lso5VwwDdS0uk8EfR6b0v47MD/NVOqIoM+OBc29BJuTteVDFwFhV+n5vMvj8Vm1ZaJ3cDvRn1iJvQjaVC6pB2j/WPztR6sxLbmsxSF9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=GIAGrUmf; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a6fcb823fso1326404a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jun 2024 23:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717483235; x=1718088035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5f4OmmzIAXFC8TbI8vT6o9L+S/7ZnZVbWvcWoWCP7Vs=;
        b=GIAGrUmfGk9NwXXXsCpnA7ui+pv2UgzpRwQpKLlvXQ+KsTmQeRlzzbAeeCmSRjkeB2
         ZO4pi9pckCxHQLCF6eY5eZv5idG9rWxRoBU2p45surgZ/GH1rW2WewOJ8vSfBmbyrUL4
         LZKhQV4TMyYd+Y4YNTJnUbILwpdLGjlEHkimU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717483235; x=1718088035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5f4OmmzIAXFC8TbI8vT6o9L+S/7ZnZVbWvcWoWCP7Vs=;
        b=OjVARUeXjSAwJ17BwuhcR+w/Fug7G+ReQpqxtBIvr45IUQmoCZ2FMYivHYcZSNDsTY
         Qx1+5BS6k2tApVl7Uc4wROZdsH1jkmNuQYrWn2hfv41THneG/B/BA1SgXLuIcuFfq/ej
         DZqCLeZ4qFQusCXfDCvuPb1Wxg9wSxs4Yp1D5n55SMIbL5uSy7sUA86YRcccMwuyo2/F
         fS9hUBuJ7siqtLvFjo0zmajaNilOUJkKpjbtv68bFdyPxzm8QRmFkb7Mn/eUjGFg8tsi
         tPNxNdiCVfUDuyP4C+UJrYkY5mhd+mLRI6A3f7UlxAT79WBGY5Qie3l8lfu663A5zQ9u
         MDYw==
X-Gm-Message-State: AOJu0YyBv8Pa7Ficsrodh1rCx27pIDuZOlAO3hnUeMC5UisYbTGnuShr
	h293fRYhpC7UsKoG3I5IAzTFJjduwuZ9auEKfBvcxxLacJ9wb26RLQdn8z9Alw9YknLj289NZDX
	4eMFFpQTkDhLcux7M38Mp74wSgMTMnXz6vbVBrg==
X-Google-Smtp-Source: AGHT+IGn60dGXff46QxiHKDP7yxJM+KMpo+Ydh/j4MOpppvG/s1eXIQdnCRfU6WADr04h09ghX/YHkiMuCYuuaUCClc=
X-Received: by 2002:a17:907:843:b0:a67:5705:802f with SMTP id
 a640c23a62f3a-a68221570acmr908005766b.75.1717483235036; Mon, 03 Jun 2024
 23:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHB1NaicRULmaq8ks4JCtc3ay3AQ9mG77jc5t_bNdn3wMwMrMg@mail.gmail.com>
In-Reply-To: <CAHB1NaicRULmaq8ks4JCtc3ay3AQ9mG77jc5t_bNdn3wMwMrMg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 4 Jun 2024 08:40:23 +0200
Message-ID: <CAJfpegsELV80nfYUP0CvbE=c45re184T4_WtUEhhfRGVmpmpcQ@mail.gmail.com>
Subject: Re: Is is reasonable to support quota in fuse?
To: JunChao Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 13:37, JunChao Sun <sunjunchao2870@gmail.com> wrote:

> Given these challenges, I would like to inquire about the community's
> perspective on implementing quota functionality at the FUSE kernel
> part. Is it feasible to implement quota functionality in the FUSE
> kernel module, allowing users to set quotas for FUSE just as they
> would for ext4 (e.g., using commands like quotaon /mnt/fusefs or
> quotaset /mnt/fusefs)?  Would the community consider accepting patches
> for this feature?

I would say yes, but I have no experience with quota in any way, so
cannot help with the details.

Thanks,
Miklos

