Return-Path: <linux-fsdevel+bounces-32193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037299A23D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 15:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5801C211B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 13:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2F81DE2BF;
	Thu, 17 Oct 2024 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="axJOx5ry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317031DD865
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 13:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171926; cv=none; b=abbaYOjbP3tEGGfKCmtzhAgnoAttS8H8uY1klq8+2EeCFFzPOR1BxIX65Vupi64PFhiTatSAmMRdwT7ekcZdDEDyK3RMIRbAZA86kAt13celPABfZvYedU9QLbIGOxRQb6H6uTtmR4MmpnneQjTKedV3HOMRuTLYm5c5QECcMZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171926; c=relaxed/simple;
	bh=CXDG0CpMACRsM/Px0sOzeda6OG2ZRxsTCzzNq8UopGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0Mo1A0yO3HYZXYqMkv3A7iYvsSz+2YhuJbwAcwU++xT/bAQu1F0c8xkljrnp2SgTACH8isbmgg4KfXqf7gmJCB8YajiZ2lkjT/dpm9iGcb2bBppJlpwXPaXLWA326F2f8CD/UV20k6d1gZ4sX6p50CwguT5eUFUSQJU8QRFvR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=axJOx5ry; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso122237766b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 06:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729171920; x=1729776720; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n0xUPg8DerCIz6V/HZF0+CcXh6twcld8dn75u2EFj8s=;
        b=axJOx5rynkJIfuSWwyAw5/pnXMgINMCI8CuygYLPi/nGeLryQ8NI7giUPlIDOM2TKW
         vVYyL7x8qXvlreV74SATqkQzRJJOSQXGeyrrpU8pbKRwAfUs1Lh84NIZVr0WsqtK+kP0
         GNrwGfkrWVBBeAWr9MO/KxZwbU97mmrOLfQf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729171920; x=1729776720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0xUPg8DerCIz6V/HZF0+CcXh6twcld8dn75u2EFj8s=;
        b=ZSBxAF6O51QsN12RB19VwJ5onuIGyBqvfc2gns84IT9Jd3JkLxa4luDbC7J+nHDvjv
         Zlzsq4DdE8mUrwb8DhC9mmOLKlapxUZCODIGU9Kai0rUy1Fe+7LIRZqjs4n5Pgip7okI
         E0njown7c55Ejaqd6NYFaL+oB+iFppqE87lenoGrRo0VB/IYuaT/aQp56ORl2fQbALsn
         pkiuG9P/IfaHpSbJJYiZnfFGdeWY6JZitk6nE/juOL1ZPXbwrmTMHS/btcNdS0qOb+2n
         4L9/XHVdGQyJqsKUMbcdWodTSZYBAt9fsV/nBU39yr3fTtoRQ47XPiw1sI9llRTgD46o
         GjIA==
X-Forwarded-Encrypted: i=1; AJvYcCWL5WAXE9MyTvCyO7r70X2cowyDN3xkv3M9Jy5RvcRdppokglXvz5W36inE4GheCHBQ3stlPio9fvpptmyo@vger.kernel.org
X-Gm-Message-State: AOJu0YziLSsEwMolA61A421E1k5f60Kip+FSEyklinwFVWZuaojm+Scz
	8fIEfXKUIHkhmAtcpdSHuMxfpXA+31sXNAQm24rfiOrR7PBiya/YxqoqpNl0HcK2+wBPbr+Opp2
	LJyn4EAM1kEZti5oZ1rIKQ74Bga0wvc/yjg/pMQ==
X-Google-Smtp-Source: AGHT+IGnYz1Jvyo4kGJFPIYiCi4UEaEAM278v9qTw7npdTih6yLvzsINdaYPGhYg0uO8kLo+J7xJ9yhFtdjqdXsFMR8=
X-Received: by 2002:a17:907:724f:b0:a99:ee83:2b19 with SMTP id
 a640c23a62f3a-a99ee832da8mr1656551466b.35.1729171920287; Thu, 17 Oct 2024
 06:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com> <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com>
 <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
 <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com>
 <tgjnsph6wck3otk2zss326rj6ko2vftlc3r3phznswygbn3dtg@lxn7u3ojszzk>
 <CAJfpegvd-5h5Fx4=s-UwmbusA9_iLmGkk7+s9buhYQFsN76QNw@mail.gmail.com> <g5qhetudluazn6phri4kxxa3dgg6diuffh53dbhkxmjixzpk24@slojbhmjb55d>
In-Reply-To: <g5qhetudluazn6phri4kxxa3dgg6diuffh53dbhkxmjixzpk24@slojbhmjb55d>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 17 Oct 2024 15:31:48 +0200
Message-ID: <CAJfpegvUJazUFEa_z_ev7BQGDoam+bFYOmKFPRkuFwaWjUnRJQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Oct 2024 at 23:27, Shakeel Butt <shakeel.butt@linux.dev> wrote:

> Why is it bad? I can understand fuse server getting blocked on fuse
> folios is bad but why it is bad for other applications/tasks? I am
> wondering network filesystems have to handle similar situation then why
> is it bad just for fuse?

You need privileges (physical access) to unplug the network cable.
You don't need privileges (in most setups) to run a fuse server.

> It might be a bit more than sprinkling. The reclaim code has to activate
> the folio to avoid reclaiming the folio in near future. I am not sure
> what we will need to do for move_pages() syscall.

Maybe move_pages() is okay, because it is explicitly targeting a fuse
mmap.   Is this the only way to trigger MIGRATE_SYNC?

Thanks,
Miklos

