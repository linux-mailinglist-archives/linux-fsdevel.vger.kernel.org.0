Return-Path: <linux-fsdevel+bounces-26742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C8595B860
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 16:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9E01F25B04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 14:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7279E1CBE94;
	Thu, 22 Aug 2024 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LSEcGloE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241511C93BC
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336969; cv=none; b=iTom9OpnYRSbFakF7PM7PoaVQycXwDmH6Xxdyj+XC2EpHq4OCZ2jdSpaz0nhzyCbvPiAYqJwcyJQi5t2secEUTOWDg5+YZZWEDXCY/P7Ab0FyubsmufqZOnH8cNLNQBC6EWuifzD1pR6Ot7jBtSoXZd4gbygyP7D3dMW1ICu+ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336969; c=relaxed/simple;
	bh=yq8YOWm31MPhCHGBDhkey78Q/SwB6I8LQLcE5bjfj0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZ2qliu0EODSmLa7JuB3VVj9Btb0DlWqKC9SXK/VHhcOY11ctoQtzn2Li1LwR2TJdzHfFkMog1h2DA2+RMswaxajKvS3CJZ+p1Xk0Xtv26EXygqbeqncTior9TTRzAdMh7Ci9XDiQMXjMNt52j+C/lj1Lhux8BKgtRs24AvqENA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LSEcGloE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a86883231b4so119212966b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 07:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724336965; x=1724941765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yq8YOWm31MPhCHGBDhkey78Q/SwB6I8LQLcE5bjfj0g=;
        b=LSEcGloEQI5DIZ6Da8EOFbh5F9i/yghZYeuDix7Eork6V3VcNiMcXRQEAK7y67EtUB
         x4n/qNPeV/QKYu/bu1tHOG5YRnHGp7diIqkpisyTDfp4eDhx6JzUKGTb6IbgqlyoUz46
         2JlB+1D4HH0Re2TdSPuJda9Hduns8h9mZh/sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724336965; x=1724941765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yq8YOWm31MPhCHGBDhkey78Q/SwB6I8LQLcE5bjfj0g=;
        b=QsXj9a5kY6xqUsjuGMEMKczQFuRXZ//WKpO2YiLvZn7PKzgRMCLRhqm701I3EEoSCP
         I2GuKBDD0PlJF5TKlgHXKTS/nAGSw/0C5Gcfa+/mamb2WrA3d9j65MrMWhPoc8tBtJh3
         gvmrjDAPeINhZqw6YFZQN0dipc2W5vRVBQJQ7j/HpWqQbQNw2Dhb3eO66mhO+RjuIadd
         QZ04AgQpSF3Y+83zRn90TgPzk5nGNidclvdt373OJ92EHoLBW0SEgSYkIloJOHEnAtFI
         JUz1kguV3utf9qFgB5La4FV0cuHNiXh16Tz1QFpqHN+jogdPvRQ3oxeWAX8wlIneY+ky
         f2Ow==
X-Gm-Message-State: AOJu0Yx5xOMP2aAT4IbMCXkHrtuhd51H6VBhyZxleFvhawDkF7vxncZh
	gioOpoc57H+/2hPpA5zWjAfgiAUc52SnFXBeRTRU4czH0yjRqH/qcPJ4lqTyAR96B8YsXxEUZiq
	bXOyJNSNr36Ji+4nYcfmVX25pzygpUAe4yuk7ag==
X-Google-Smtp-Source: AGHT+IHrHu0J+uUBa63q76YlnUDu2hyONi2orrmSzrJ4EBPVRFTufw4odXpjiVy/IvdRaB013c+dmX1+P0XHWb+3Keo=
X-Received: by 2002:a17:907:3ea2:b0:a86:6b97:d95c with SMTP id
 a640c23a62f3a-a8691cbcf08mr144969566b.67.1724336965076; Thu, 22 Aug 2024
 07:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725175334.473546-1-joannelkoong@gmail.com>
In-Reply-To: <20240725175334.473546-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 16:29:13 +0200
Message-ID: <CAJfpegu_u367bywXjsmfDnDLXwx5NGy-o=8X7uDVgyK=WSmUGA@mail.gmail.com>
Subject: Re: [PATCH] fuse: check aborted connection before adding requests to
 pending list for resending
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, winters.zc@antgroup.com, 
	josef@toxicpanda.com, bs_lists@aakef.fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jul 2024 at 19:53, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> There is a race condition where inflight requests will not be aborted if
> they are in the middle of being re-sent when the connection is aborted.
>
> If fuse_resend has already moved all the requests in the fpq->processing
> lists to its private queue ("to_queue") and then the connection starts
> and finishes aborting, these requests will be added to the pending queue
> and remain on it indefinitely.
>
> Fixes: 760eac73f9f6 ("fuse: Introduce a new notification type for resend pending requests")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Applied, thanks.

Miklos

