Return-Path: <linux-fsdevel+bounces-29965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6EA984272
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 11:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C00B1C20DBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4C415666C;
	Tue, 24 Sep 2024 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hvsUmtsg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5803E15382E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171048; cv=none; b=uiGz6RnU5T9hHYheGU0WN/7OGy2Hvig1uNMNjJ55QFJLUb+Adz2Ahm1SYAL+n/wfZZqNa8x6rYwP+m8BzGq9dGDQvsbekTo9wQeSpSpoXO6YTArcLVSdZLQg3IThbZWXcHfUNi3y1I5YxBxQYPV7cB3x12mhydORVaCYZfdYd7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171048; c=relaxed/simple;
	bh=TPc5bkQkXgkp7cAWxKBoi/bOjk+w53847VrssQ8t5Dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/VSpdXIdSNsUnFKJHli8lz1+RvnFHIElArROmHX+mKfe5ZbGknrpXxrET+mZ+a4leTIczciILDDkcPv0xgOw2Y1b0m89hDIB5SZxbwjGzJ1spkHCoD1H2a23eL6Q87qtiOzG1a85SEcetT/tFIbgqmA6Hzwev+FdUoACkhtfBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hvsUmtsg; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a910860e4dcso291018466b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 02:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1727171044; x=1727775844; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8UvRuQTAXzjWSqwkbZts9Am1EQT0otuVnhK1gM2DGaw=;
        b=hvsUmtsgjA1XG/v1tQSQcGXP3XmjL/41O5DDQShHQfjhzuWnU5oepJgCfVE5mNTapb
         oBD8tn9MhLnXz9uUUfiQjIVHefQqXJqDjeiqTQ+zoA++tr+uFbUSRw245OudAwBPP/am
         65SwCMLjZ6Zb7UPt+qNjoss1z5dSJKlzvGtZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727171044; x=1727775844;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UvRuQTAXzjWSqwkbZts9Am1EQT0otuVnhK1gM2DGaw=;
        b=Oj6cQOMB+a97kFeFLQCIuP6Nc45dD+L5f2ujXg6zJ+gjqNmPyRCVJ2+gGZwMYO+wTl
         PKQZqbpJTqOFk/WJJgsXURGMzcsPo2FSShDe2ON1THYo8uGKyuzkWSjif611O3uBqgWq
         3+W2Mn0UFa0UnTm/GOtLGLqzNAgln7nyVIz0ud9fKQHSY+o6NeMdzpHAEMKgV6jnPiwR
         BnupR+QKdNVBPri6CnZVo9jrF8t6FN0MbIgy0PUND9JEPjMt7+W6n+jae84YRz00KHac
         VWU6LfofII+pbJe9bQorlB5cKn2HnLgSp37whUBdVmYxRA9c9hOGCpeId1EBaTdDKCJj
         T7aw==
X-Gm-Message-State: AOJu0YxenCnyRiEhXh3ciL+sM4bat7filX/MzjbOeUxP7naRSRvUu/Hf
	DjWXE1DxW/x4df1a4MiMjhQKK04iTII3OeiS+KSt7fybxb+SzCNApxEtRwHNyUc0dNYGAwbZCXa
	iC/6B6oRGiRmLdruhSrDzNUXnNtIgEBP3qtESBw==
X-Google-Smtp-Source: AGHT+IFvBL5X/jydfLq9bCpQO3gvBLhQ1BsomZ6NnBons7b9TVRt/YHWqhoAihrEbdP57d1ODTjifpY9DGCn7m601aU=
X-Received: by 2002:a17:907:e6d9:b0:a8d:286f:7b46 with SMTP id
 a640c23a62f3a-a90d501adc4mr1434932666b.29.1727171044026; Tue, 24 Sep 2024
 02:44:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923171311.1561917-1-joannelkoong@gmail.com> <20240923171311.1561917-2-joannelkoong@gmail.com>
In-Reply-To: <20240923171311.1561917-2-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 Sep 2024 11:43:52 +0200
Message-ID: <CAJfpegt3OHQkde1rHNwJ7t0FWc2m_8jM7hXc=sh8fdrji4DQXQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] fuse: enable dynamic configuration of fuse max
 pages limit (FUSE_MAX_MAX_PAGES)
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, sweettea-kernel@dorminy.me, 
	jefflexu@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 19:13, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Introduce the capability to dynamically configure the max pages limit
> (FUSE_MAX_MAX_PAGES) through a sysctl. This allows system administrators
> to dynamically set the maximum number of pages that can be used for
> servicing requests in fuse.

Applied (with a minor update, see below), thanks.

> @@ -2077,6 +2085,7 @@ static void fuse_fs_cleanup(void)
>  {
>         unregister_filesystem(&fuse_fs_type);
>         unregister_fuseblk();
> +       fuse_sysctl_unregister();

I moved this to the top of the function to make the order of the
cleanups reverse that of the setups.  I haven't tested this, but I
guess it shouldn't make a difference, so this is just an aesthetic
fix.

Thanks,
Miklos

