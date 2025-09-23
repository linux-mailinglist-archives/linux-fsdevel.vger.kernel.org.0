Return-Path: <linux-fsdevel+bounces-62521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34992B9740E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 20:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B822F2A6E36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 18:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFFD2E03F3;
	Tue, 23 Sep 2025 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qqdKydAn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EA12D59F7
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758653821; cv=none; b=mYm7THC5OVsTlYCKwdjGP7vS2nUTaNJ4TE/UN19T9IgqWTDDTilVeZWy/KK/ZiYyVHLwTbCDJX74JSm3yvHC7u4O2jwCjXfHI8ozANKaYwNmU4sIcA+ePyWEiSJTqLOblnEE+uxIWwSt5t+ToUiKKQjYPLBcUUAHI3S52/s+HHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758653821; c=relaxed/simple;
	bh=uDFx+7Tt6m0KBD1tdrc8SFB3Uot3XLva9qb9ajxaWY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGlpRHHbJSM7wUdelYRMqm6BLJGUynwcIqZIuMvxVqJqI9ay7EHJ9a8gA6P0Ge3YHIQzlKqlaMPjHN5iudSpmEdbiPJ+ScERWZdPjIlje7Ii+ty1oDoJ0R13apswRRFYTfYQGuZLGIl8munpFyvZiKPsahISIube1OIsIqNOh9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qqdKydAn; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4d53d1e9bd7so7311721cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 11:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758653818; x=1759258618; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxNM9Mb37dbb/SiJhSt7Vl3jHZka75Af9EkUQVZtb5E=;
        b=qqdKydAnMRVCRWfWb7n1QWfudBaKit59wlqDyzIM3Tpp9Vvpk01hnlfS7Xp6ezGkx0
         Gw9iNwSR1cNxu/0KpJyR2wiWn6Pi4xY77FT+Qrx5QATIghAmuT5/scgsDqRQFprZzlTG
         jngePpRzTE8M5rK3mwYwrkLg8BhtnEHV7ozes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758653818; x=1759258618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxNM9Mb37dbb/SiJhSt7Vl3jHZka75Af9EkUQVZtb5E=;
        b=i8I0gI2RfgicB4ZrxEdKhUPAZR3mgHsaEB5uz1KqAUl99CubyPELdkVby/uDXprEOp
         +ViMXiw+n7l+oMhW14tTGv2rHoLriIhkBL8eEC7BEb7rByirNs54FnRFXuhWfBbp9iAW
         5XzcDCzPZygyBchavwY/syeW1qCFjDHLhHavR3ZJAFvgfx1zVzsWu9DJv/hkuleJmFJL
         wU8LqU0kFVlxn5+AoUUTj6HM5kq0yz5kvVY62b/zHtSNQpG7zfoI7xWHGtdLnHAiMX9M
         wDoY7c44OEPHDpXoQIvpVY/hWrwVY0nCUPOwg/rEFw9msfb3jX8oGJiJqZARnuOSuS+t
         SB/w==
X-Forwarded-Encrypted: i=1; AJvYcCVxuu6KvVA26wEe9toWwmq8OOMLfFK6PFUd6oZnU0XJPcCPXwjCeWs8S0hxTh3+5XbLJm4qvsJYGrhF+Bzu@vger.kernel.org
X-Gm-Message-State: AOJu0YyxnL7Cnd+JS4DZZS+6ugm3UXkikmbwZnTUXWKNdL9r34ofdst0
	SFetBNgd0oysYNCJejzKrAuYhzuSuk7bxbrrjOd3/23AzVCGOgGbz1ssnLRQhPNazkl2HsVqyZQ
	FG0lu2LtYIw5S4j6s7Hv8vJrZtcW8Cl+X1boU7VMsBRYBsuV0TT2n
X-Gm-Gg: ASbGncvfJtHwebOsXnG2Vu8Ue9B91FVIoXE1PAXawohyVLH9tlAuT7m/sdUfgAn++iH
	/uUC4+LMw6lqPzd0KMrEqLrekKLSfzEgieNkvt+QRd5ZirbYCifOW6pA4CxEXmASR5Wbp5Q+uPy
	VFqPlfxCDQBaPPX0kRquLUgDyG+CPorOoBGKeLFtHxNORehLGL+6JVBaYbBA5D2f1gpbnQEcaEO
	sXZl0KHNajRTJE7PvDpk1kn0WtolYVlOm9KxYk=
X-Google-Smtp-Source: AGHT+IEUrKLzK566Rl7e78yFY4lfe2DvcLd+aWPgi3Hp92l/GkUmLofyjJvSU8SdP+RLcBfxgYPP7otw8OxaaoPIFgE=
X-Received: by 2002:a05:622a:1442:b0:4d3:55f7:ddcd with SMTP id
 d75a77b69052e-4d36fdef829mr46153821cf.59.1758653818451; Tue, 23 Sep 2025
 11:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
 <175798150070.381990.9068347413538134501.stgit@frogsfrogsfrogs>
 <CAJfpegtW++UjUioZA3XqU3pXBs29ewoUOVys732jsusMo2GBDA@mail.gmail.com> <20250923145413.GH8117@frogsfrogsfrogs>
In-Reply-To: <20250923145413.GH8117@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Sep 2025 20:56:47 +0200
X-Gm-Features: AS18NWA3QczMUqhEwXlbmi3D0vK9ucUWZNSA6Kn3Mm_71aK-n6sNLwsJ3-6KZcg
Message-ID: <CAJfpegsytZbeQdO3aL+AScJa1Yr8b+_cWxZFqCuJBrV3yaoqNw@mail.gmail.com>
Subject: Re: [PATCH 2/8] fuse: flush pending fuse events before aborting the connection
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net, 
	linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 16:54, Darrick J. Wong <djwong@kernel.org> wrote:

> I'm not sure what you're referring to by "special" -- are you asking
> about why I added the touch_softlockup_watchdog() call here but not in
> fuse_wait_aborted()?  I think it could use that treatment too, but once
> you abort all the pending requests they tend to go away very quickly.
> It might be the case that nobody's gotten a warning simply because the
> aborted requests all go away in under 30 seconds.

Maybe I'm not understanding how the softlockup detector works.  I
thought that it triggers if task is spinning in a tight loop.  That
precludes any timeouts, since that means that the task went to sleep.

So what's happening here?

Thanks,
Miklos

