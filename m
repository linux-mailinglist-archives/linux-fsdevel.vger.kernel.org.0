Return-Path: <linux-fsdevel+bounces-26727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AD695B70A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E813B23C59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 13:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D806F1CB321;
	Thu, 22 Aug 2024 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CDCN+hzM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DED1DDF4
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334160; cv=none; b=dlUYevUGp+UaYh+6aXrZXsbdVYN+LkBDr5KZm+S0GYduD2RaZulRdI9iDbOoPXx9r16XDa49f8F2pN+l/HbIo+NQsACHYN8AtI5z059zfEt797QUtyN7P5trtKeXtVuyW88tSpdT/TiW+eaDIlerwYxNc12xveGFqnX6dy8C+5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334160; c=relaxed/simple;
	bh=fy3fBkI98PvIF81Q8hoCh4DrGScuJF0lCWVTmmGhfuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSYfLFXLHswHm5vUJZn/18n+GvF6dQFSajZ46p8+LWWdFUjETZxfbpLjFsqx0DYFN8Ro4VwxC4DILTZHdLfTq4GF5FEEq+gavmlJDuMnjRVIEp4lj9txpl6T+83FYri/Q650zIIveuK2nhcobFVp11uf9hnrC26ua0OuW16z9wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CDCN+hzM; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a80eab3945eso92964666b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 06:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724334157; x=1724938957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fy3fBkI98PvIF81Q8hoCh4DrGScuJF0lCWVTmmGhfuk=;
        b=CDCN+hzMx/ZNM0DdCMYAXdSMTIl5SStdTtJednxDh91a61bs+qdEUPiKukuMkS4HK3
         lyXUOigmXth/GnhXqIaRDNF4FaiI9Z8mzG/mLjPT+gUN+Ifi+HqCQPMdtyTtBxYUonl8
         5ddPKwPOL3S4RkthPqHDzjFJzs44QTNRMaJkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334157; x=1724938957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fy3fBkI98PvIF81Q8hoCh4DrGScuJF0lCWVTmmGhfuk=;
        b=uwjHTnxfi1UK0GcE4YvFdibCiyTl/wFdT96I8WeqD39cQUVcmKV/ENlTsaYGvOxNO4
         3LtfuxfG8+MI2VakSDkCroxXCeI24a3/dSmtVwTZdCjy+aDVRH1FdTNcco84H11jb4AS
         Vpszoiu7tgC+y1w2ihiEQfkRKL6BTmdb75/a7iswwD909TgShdNaqAfFLBeDGA+XGrwf
         3EZQ3RWqZsCXwsAW49JFdabTXYUqOLZMVOwhp0h9niyWrFhaV6U1K+o+xdDjNqpAqZCk
         XXEEdC3vCVpAFIU8zn/kmmihpFNKibFqofgQ8Pc7jSGurPS2cbS401J2p8PQnPaQvE7y
         WjyQ==
X-Gm-Message-State: AOJu0Yzv8VFBzl+OlClLlNQ/39slDMqdmb/naI2hSFP2wgqSLY9rTzFw
	ronSiBXCKP7gp3Xy40ua1pqtgRCxpIxlNOPTER2bk8MSQb9RtO1b459DifGGD68kMIHQQc/EXpn
	ys0LBouW0MZYPJGWRrc8HBzk84LAcDnrGx06R+A==
X-Google-Smtp-Source: AGHT+IFi25nFSvIfpvtaevg4zbKt6hkTtNG3GW+4IDNykxi85LBM2FKY9Fn6oGOPHnZw+DYTm+Kj/nbNL9oG8g6HHz8=
X-Received: by 2002:a17:907:97ce:b0:a86:7924:11c0 with SMTP id
 a640c23a62f3a-a867924134amr459967266b.55.1724334156821; Thu, 22 Aug 2024
 06:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814093600.216757-1-yangyun50@huawei.com>
In-Reply-To: <20240814093600.216757-1-yangyun50@huawei.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 15:42:24 +0200
Message-ID: <CAJfpegvpHb1s4eByjwKT6tEy+E8ToNXyke12=5zz3WdV_PDcrQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: add fast path for fuse_range_is_writeback
To: yangyun <yangyun50@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lixiaokeng@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 11:36, yangyun <yangyun50@huawei.com> wrote:
>
> In some cases, the fi->writepages may be empty. And there is no need
> to check fi->writepages with spin_lock, which may have an impact on
> performance due to lock contention. For example, in scenarios where
> multiple readers read the same file without any writers, or where
> the page cache is not enabled.
>
> Also remove the outdated comment since commit 6b2fb79963fb ("fuse:
> optimize writepages search") has optimize the situation by replacing
> list with rb-tree.

Thanks, applied.

Miklos

