Return-Path: <linux-fsdevel+bounces-46458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA1FA89B5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 13:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911F5189D3EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 11:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1977D284680;
	Tue, 15 Apr 2025 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="mlHCvOVR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02931DC9AF
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744714839; cv=none; b=BJpiMszf19T39sN/pc2p98ZXpANyqjjTqbR45l2gLeVEsKgPFuBA/YpqkC8jNBEG5ICE7UfdlLGHOPh1ReLWeTH4YvoC/OWmAwxZgp00U/Z4sv9WVUgvlLGLcjFAli8EMsW879QpcHbJbZJGGljmQLrsm/7qOcqkHEhoC8jsDPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744714839; c=relaxed/simple;
	bh=kg/jtcDPRROvUr4ZY1VtkKgN62WtCiCAwg9ehqfGiTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEVHan4SNiG4hLzgfG2GpL4d0ygLKQUrPvg7lvG2DW9hD8XRr63egLjaiCUxrFQjZAS/zjo5pTF0W/8h4KsaLllqUAr/K5aZ9V02kF0t1UJRfrwyBh+DROmoUYenpzPdqYYHkUD8plMBfCZmIkip0TxOKQlvWsCZS1c/0D1Rte4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=mlHCvOVR; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47677b77725so55941661cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 04:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1744714837; x=1745319637; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lU9d04QPBX89Zip7i2B8jopDscckR7nHgBJf3Mm44wU=;
        b=mlHCvOVRY6oc8ojWX85+5e1vv4l+oHdqPSiH4UK9pFoVIhxsEEb8YutGQVCuO/UHbO
         rlROpQAudx0EX2nvhX6UmMQY7pfs5bzDMrPEopM6InrkgZVafzs6rs5VeOVDEuePEJSB
         OXUU8AQxyYRZLgmg6wf4X58KhaBXjPM1FZdK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744714837; x=1745319637;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lU9d04QPBX89Zip7i2B8jopDscckR7nHgBJf3Mm44wU=;
        b=RWg/z0vq0r/Rh4okYQ7xxAOe+XvOdysQM+zx44goEcNJcjNzwIidRQ/+cy+zzgGcQh
         3L7OBZZMUkk96G+6DTmNhdRDOZjrK31g6UtVAvfI7fsTpb8UcIQdzbGagfbVBP3kir7T
         msqzyT1zILowWP5mp1qFndjM8iI6nURAN6PZ7XiAqQ7BHm3zQjIEcqpLsGZLoTsMXP0C
         dC/XuXvs0cbDcEfjb0Rv7oP3Tz/5EbwbXuH2uvMqJhS3AhOl5I2R8ahOYGWTHySU0ZUr
         tlckfH9xbXd2fZR3nIpm3oxzFflix8amalHuL8hWpkQunUadkCzzWkhN1Foq0H0qq2Y6
         r3Vg==
X-Gm-Message-State: AOJu0YxR33nyE4FtCTfO80KRMuFn9C+++NU1dsqeIawFDepnSDj8gSUH
	61Dm1K3Oiz9j/YaH6MeNHgtuP0RO+T507ap8YmTT21MxDYzqB7vfMX4vgyNn2FxT3gIlj9OnTkO
	8LWA375lQbgEbFgWDbWTUaHXJ5JFpuInpBqq0Zw==
X-Gm-Gg: ASbGncuYwctylPsng//Ybp/yYoJJEy596qM/mRGcyYrTe9dBv7usx9XjUfjSSah3qZW
	NnPk3bTvL9rO1zqtifA9EMCtt0asyymhXbToieEq9WwwD6ZMe1IfE4hIKHhDQpvtTNYMRZMUUD1
	rxNx+VyMzBJhGOTfeNh41t+YqlH4RCYxE=
X-Google-Smtp-Source: AGHT+IESAqlNA3kPbIcr/6Og+2AFeF433xan4Ew0YFR8rd6ERu0crMJvkl2uBNXB09FmOOUrMgJiUHmYx/zhNnqKKKk=
X-Received: by 2002:ac8:7d4d:0:b0:477:d00:b46f with SMTP id
 d75a77b69052e-479775e9b05mr268096251cf.43.1744714836466; Tue, 15 Apr 2025
 04:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220201659.4058460-1-joannelkoong@gmail.com>
In-Reply-To: <20250220201659.4058460-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 15 Apr 2025 13:00:25 +0200
X-Gm-Features: ATxdqUGfsarElwI3kAeeNKaAbR-fjn-Zvut0KBFVwHk7JdTXjinzkOTeKx0xxxg
Message-ID: <CAJfpegsyJFZ17xw3pL8__9Dn-drmjZY5CfjcR1iNn7EiWzfusQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] fuse: Convert 'write' to a bit-field in struct fuse_copy_state
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 21:17, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Use a bitfield for 'write' in struct fuse_copy_state.
> No functional changes.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Applied mini-series.  Thanks.

Miklos

