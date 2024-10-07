Return-Path: <linux-fsdevel+bounces-31207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D3F99302B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E44F3B24F2E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610301D89F7;
	Mon,  7 Oct 2024 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LIWPryA0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0171D7E3E
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312931; cv=none; b=KzGj0MV6KyaiDtY7YsqzJ3/0dtG0bOU6m/2PTWD0g83kKqbtphehHdCyJk1xBNyKSZ3tnPdghLG5P+FDNyUhyCrAfomrRO4jo5hyWaTh+95a2JTQ2kCOUdNXSQAlvMeW5bazpQY5Aepcn9sTzM1ERgxBdtoI/alhnjKKTYLFzKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312931; c=relaxed/simple;
	bh=9CwTgWElBJb0LcznUFDVpO7YSKyNZQkxv/GNCyKR/Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDIQETJgBMbfdj3+L0N4M92JA3C6bZfDgFuKpdkRudAOfesEC3V2y8jhSS0dGtCgoFEeW/Jakekt0hca7fEfBylstSNqkADXvB9nOpuSSnDmoAmdAgag2pQ+asjf2tSmtoSw3lWrKYk8PkRGJ/FNcXkLXUXB6aet1gt2E7nwun4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LIWPryA0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a99422929c5so236781466b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728312928; x=1728917728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m5WRDXDsnn8xfUzvyZAlipJKvUJbHPqjoW3kJr/J9Wc=;
        b=LIWPryA0xf+PX3NRlOG8G8B6kla+upAe7zDaJ+qbgn7pyldsdFANeySr9eFrRSf231
         Un09v14WEKsf753LSDqg83VhFVC1fB4Fmov+XnGrLtXd1+OMv43EoVeQeA6j8lYxDdzf
         kp76/FTpOybhUmnAy/Wqiwis+47XBj9rdTRpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728312928; x=1728917728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5WRDXDsnn8xfUzvyZAlipJKvUJbHPqjoW3kJr/J9Wc=;
        b=XBzWIWclpTqZsXoB1KhUvYMcck8HoKXCOTLTOrjrp9o4aBRKIZiQEsB5VV0YbTvkOv
         Q7YkFfb+UzUa7VCfLgtKfxLSVCFj0iAC0kHK17P7+P75dzNv/bxuVtdvsKJg3y1IzMkZ
         hJ8IHq3u8VxTYKhg+Qu4s7H0SHbbTkVbGXqUFUKaeQej33pc8KYjza0h79oubT5ORE99
         3fkDMK6CliViqRx0A9YH0uKbt3xj+Y0rd3V8yUqVjTgQaGtNajHqI7DLsd1zpis0j6Fi
         xLam9nWpFAhcOBI3ALkbeKICMQA7RueKUL8Eyym34wxcVJM0WELGbE9jFqEedWCtRf8o
         697Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdbBGj8iWP+mIwyATTpYWjgbzSKbHX0GfqUKzyq/nN4kMU83dO/FB242rX8iBi+laxI3RGJoCVe4HJ1t/s@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3m6CTPEDSTwK6DPtUopKGfa61dHRF87RcXRxY5v7JA1S1kbPC
	k3c1LbA+eBcbrLVdkG0BUovboPQKI4LOjdp0GAEX3tCquhD8FjnE9gyH2zQD6NXRBy2mTCUJRVr
	s7zh2Pa0faHvZl/5coAP4S9/nt9UraUOF9W1URA==
X-Google-Smtp-Source: AGHT+IGkCl7U41DlnyVIm3YIZPuS3Zah00DcxXpjdIwWfD9jptoyPrrEo3T7JuSRwfhfqKWTkqcavZ1DAEcm3b3d1fs=
X-Received: by 2002:a17:907:9301:b0:a99:389a:63c2 with SMTP id
 a640c23a62f3a-a99389a66edmr753929166b.62.1728312928285; Mon, 07 Oct 2024
 07:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007141925.327055-1-amir73il@gmail.com> <20241007141925.327055-3-amir73il@gmail.com>
 <20241007144338.GL4017910@ZenIV>
In-Reply-To: <20241007144338.GL4017910@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 7 Oct 2024 16:55:16 +0200
Message-ID: <CAJfpegvsA=D_i3mRr9yLUBDQMmKhfbk1cs6Gcd+8Tpq=NVVVwQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] ovl: allocate a container struct ovl_file for ovl
 private context
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 16:43, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Oct 07, 2024 at 04:19:22PM +0200, Amir Goldstein wrote:
> > Instead of using ->private_data to point at realfile directly, so
> > that we can add more context per ovl open file.
>
> Hmm...  That'll cost you an extra deref to get to underlying file.
> Cache footprint might get unpleasant...

Yes, that's an extra deref.  But stacking is bound to greatly increase
the cache footprint anyway, so this doesn't look a serious worry to
me.  I don't think overlayfs is at the point where we are ready to
optimize at the cache access level.

Thanks,
Miklos

