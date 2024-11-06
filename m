Return-Path: <linux-fsdevel+bounces-33740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DD29BE516
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 12:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263B71C20C30
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 11:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057DF1DE3B3;
	Wed,  6 Nov 2024 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmcXmFIk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3050638DD8;
	Wed,  6 Nov 2024 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890902; cv=none; b=NM+G7KrRuieXIhgvmJsUA5zeLBSCKVQin3m7+rpCTxNc5giITLbLH86cQ0vPHErzIf6YKqM4fAKbslfTrDksRzu8HLZSE8o/IfeT2Iop5WuA17Noti5P9C+DMTiFTHh/3gqiimi+MOugVJGkISqXPuq546gi0kI9vkHcjrwedfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890902; c=relaxed/simple;
	bh=3Ttyl8Nkn8S95rvO5YhBvGG9S2zvLPy1qHxzRNquABU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o00DoGThXgqBCOXtdN35hxqPDwIRd2NrmI4+/wucYw2326BuTM6RCUkmrXQKmGWfDoDZDKo19Il/jYVik8hv5vZnvRnS8f84VvT7lgJwQOtnEXwiEgw+nT7m1y6XV5td3QWcABrXj0Hqt8ncfXf6pl09Gm2PGLQ8+Ob3l56ANpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmcXmFIk; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea16c7759cso3580769a12.1;
        Wed, 06 Nov 2024 03:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730890900; x=1731495700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqoEH4eHRdA69hXRfFE9hVKR0NbklO4CabBdC7IqTJc=;
        b=EmcXmFIkOCNe2zWjeTJdQEgPwDc6lHCxgB7tyjpXmb0bWir9SpJWGbC7svdqcCHh41
         Ro3ayl/vGMju2nEFBTV9x6yXte6wadMTXWmxIo45GxxHln8WZg2bCyfDYRi0LM0Afczw
         s2IaTDpWMdM7TMClMi9ztbQNAy+I85hCWbKwQumocD49nFSdQAmIWy12klmS5lCjsnWa
         sv3Zoq2xzwinYj80gvceinQpu6swMjHt/qWPyzJ2HE2KGh7kDICdZij4Y82sObG9zijE
         gNfxokM0Gk/3W8R5FwtAhepLGIJMAOSwI67fLuYYTRl3FUmw9ZmA+tEweZ39HEt/P2AT
         WjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730890900; x=1731495700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqoEH4eHRdA69hXRfFE9hVKR0NbklO4CabBdC7IqTJc=;
        b=rCtkcSBM2aJsLsdBsDSpoQVquo/VSZFDpuhW/m2TUWRKLp64i+4WTGjjC4MNtQGRxn
         hVMXtSSrxv2BNepo48ureg33mSWk98KdjQuO/bpbq7Vmw/N4tWrR2M1tLCkac44erkHB
         iwByJw8BwwLnBSPNvIiOHd3Kr5/VVRCMdfQsOiPJh/6tz/fgCDF0aCUawwFpDwM7Wzx6
         ohquuXy5yP+bta3WWMetlugp5lsO9M2TqeZoPP35/UKUkqSKcbotijqODWYBqp7ruh1O
         PSCyE9gCM5Z1FtI6XIBSqEfA4JDszZXNBbW2TUCfJfJ4LHRGIsWtJKh3/cuzS5lI8HOJ
         i8Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUToDAQb/JIkYISkkMJO+Fd4gzyO5eGluTCVUqBBN8NKi5XXauz6lDJLDg2j9RvKnQRyeOsh7PzjvnWyUrA@vger.kernel.org, AJvYcCWv3UPiSyqui6ZntDeNLx4LSr3YWkHG6H5Ao/HMT2Ow/IuD8X8nkGbiaM12+qliAv31I5PnrGkierA5RuXr@vger.kernel.org
X-Gm-Message-State: AOJu0YwCqtraBaA1WVENN4fanYY4aPq8GNIUerA/6pQI/fHOk8jcuF7N
	gYEiwEFTA5HOHUFJEeK8MytYIk3MlUD6UTGgQ5WUZGJhyA8SdYT4
X-Google-Smtp-Source: AGHT+IHsn7RTzpS/5JLW0WEmrwF+aaAAWPEDVhUvtIt+NqL7wdHGauXdVTqGEOmkH7X0jRFpW/YGfA==
X-Received: by 2002:a17:90b:540d:b0:2e2:d15c:1a24 with SMTP id 98e67ed59e1d1-2e93c1a6cddmr31712372a91.23.1730890900382;
        Wed, 06 Nov 2024 03:01:40 -0800 (PST)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7ee452aa158sm10977927a12.30.2024.11.06.03.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 03:01:39 -0800 (PST)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: jmoyer@redhat.com
Cc: bcrl@kvack.org,
	brauner@kernel.org,
	jack@suse.cz,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pvmohammedanees2003@gmail.com,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH] fs: aio: Transition from Linked List to Hash Table for Active Request Management in AIO
Date: Wed,  6 Nov 2024 16:31:20 +0530
Message-ID: <20241106110120.11093-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <x491pzwtogw.fsf@segfault.usersys.redhat.com>
References: <x491pzwtogw.fsf@segfault.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> ... and cancelation is only supported by usb gadgetfs.  I'd say submit a
> patch that gets rid of that todo so nobody else wastes time on it.

Absolutely I'll do just that, do you want me to make it a V2
or shall send it as a new patch.

Thanks!

