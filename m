Return-Path: <linux-fsdevel+bounces-27216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FC495F9B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8591C21C39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454D9199245;
	Mon, 26 Aug 2024 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="L1MdCpJO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FD479945
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724700611; cv=none; b=sqTdNaPPL1goq2/A60e6Zqv2F1OuS6z2gsBsx2s2r6qj4x2W/AL+AWOrnuNAy0RNQpobRWWraYaQheKJHv9QLdz/yUljBBTcyO15Sb1N0HZea4OjG37OrqNpWBngK3SBgmoG7U/8UnOlCZ/k9FQauNkgVwkhM9V1TRPpHm63wTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724700611; c=relaxed/simple;
	bh=hcRvwF87oztYXFmspwLvuXVmC1FGdlbdFo9ufr4Pf2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rngFsgCdAclYBMd8NZRk3Tq7YZINK/aXKkmCnT2evFlU4j3YiLXNsdtzggYDEV17wvvnDG1wkn/4KXblH6lHMKNPQiMYM/i1c+mZywRlIFiIbkWyBEEeOxkXy4YG8/nWJvK30PEoIyYFDhvgoQp5lBDfy7+ntWBKIP97eyrbJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=L1MdCpJO; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e1161ee54f7so4967856276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 12:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724700609; x=1725305409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hcRvwF87oztYXFmspwLvuXVmC1FGdlbdFo9ufr4Pf2U=;
        b=L1MdCpJOr+SAZfVyN6Bw8R9asLhnPzW2fHnOV/QyaxtOj1y7Kav8gj0pQHgPoCH8bG
         3imho5EzNu4EAq/EHehBKBTfSlkioWL4jvOo4VLwoNtslIZ4jKDu8Vn7eMkD0OFvgEbz
         dAeYXJl+TxsgzEvBs+5Gn52hAW0EBcSse+++0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724700609; x=1725305409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcRvwF87oztYXFmspwLvuXVmC1FGdlbdFo9ufr4Pf2U=;
        b=nUzKnDC7cvSI2N2Epcdy1qXHaxH4on4sABJcUBAUlZpvI9b4sIO9xOwm3/tqnS0JKk
         woX8HoxLDWH+zILQvbvt7vcDnjnqgHe8+hu/cjYXfHY59e93n3So6nflEgb6WASObYzc
         YV5vWvH7SBosIDcLYCSEz9zN/RfDqVCgYIfUIPkgeczzlHCUEdGj070o4/f4x8UBL7qL
         MRVHPJdEoriaWjUiSOoaZvbbi962ojc2RXi39oiFJDdqsJbh1paD8dlsBszpaEXXOAmc
         3NGcGz3a17Vt1FE5DRcdJ1NWyXO32NllJMoy7ZBMZzR1cYhs+064OTPhteOR2alTnhIj
         kHXg==
X-Gm-Message-State: AOJu0YzpTh04X0GKZsL3xqwEjfNaKTz0MesUfn7qHFLGUYymTvVsr3Pu
	GF+V+AhNY4YmAMiq6rSsUQQgC1XUYArxoGg553r+NBaKyCkJdvmYENiQ+44ySvlFILUu+5H2B16
	D03U4Ue0VCMF2QDs3vwDyfCrr02DGwlP+s4oPSQ==
X-Google-Smtp-Source: AGHT+IH9OKCoXZU4ZY1OpV22CH8LZbAk8o4r/ypIvORd7W0PJgSWCSqUslpmBTkJiaMOKHPlHpoLfy4bG+SLPynCflA=
X-Received: by 2002:a05:6902:dc9:b0:e13:e9ca:7bcc with SMTP id
 3f1490d57ef6-e17a8680788mr10420377276.54.1724700608979; Mon, 26 Aug 2024
 12:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823085146.4017230-1-yangyun50@huawei.com>
In-Reply-To: <20240823085146.4017230-1-yangyun50@huawei.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 26 Aug 2024 21:29:57 +0200
Message-ID: <CAJfpegu-nd9Oa+eeNKbzqtMJOgoFHgxO3fVr=2qt_WZv2EU3-w@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix memory leak in fuse_create_open
To: yangyun <yangyun50@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lixiaokeng@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Aug 2024 at 10:52, yangyun <yangyun50@huawei.com> wrote:
>
> The memory of struct fuse_file is allocated but not freed
> when get_create_ext return error.
>
> Fixes: 3e2b6fdbdc9a ("fuse: send security context of inode on file")
> Cc: stable@vger.kernel.org
> Signed-off-by: yangyun <yangyun50@huawei.com>

Thanks, applied.

Miklos

