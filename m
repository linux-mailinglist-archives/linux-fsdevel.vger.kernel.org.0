Return-Path: <linux-fsdevel+bounces-63190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8312FBB0C59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 16:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F32A2A4653
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 14:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA39303C81;
	Wed,  1 Oct 2025 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FlY5Ewtb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A39303A22
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329895; cv=none; b=Bq5d9Kg2ETDq4bDtEdraaQZkAHu/V2ZGfjC+5I0ei/D6teJcwQH3sS4Agywv0ey18AOZ3vQIb+O715Zv21VcBU9W88GaOg9NBw/1BnWpIIlRdT+3Do0HUg+HE8HEWuSU3ZKWV2usMFhbnpuV2S9VoPrk2K8NyWf+sO0n9i9Iw9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329895; c=relaxed/simple;
	bh=Dh9Vk3lsU9opZp6yE7atY739gzW3haUvwNHyRQpKYLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D539ubkW2ULd7LeVyUxoxB/ecqN3HVzYejI67y5iv6cENpbV5BYn0XNsaDgvXwPSfWyhJq/d4WCEYGg+biybFhz5zWfSecQYyk62+0/FKIfYqlB1UT7jY+GBgeO728cxHpYP61SBWovQ7Q6s8V6KFoojz1ObVpV4+7MmDlGHh+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FlY5Ewtb; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-85e76e886a0so557734985a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Oct 2025 07:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1759329891; x=1759934691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dh9Vk3lsU9opZp6yE7atY739gzW3haUvwNHyRQpKYLs=;
        b=FlY5EwtboSAswiFQ1gyPxOmEkZX7rjHrGs5wFPA+MTIxp6nNClNl44/ZiWnA4kpDFH
         yuH89Hx5goWyqtqmadGkhkV7V5qtuxD1lCH26BcJCoGdO1WPez0zuWmfsLfXGKv8B43k
         2zqLOEZ4ofwaFtO3lYl1WVZLjfq06Uw22ZI/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759329891; x=1759934691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dh9Vk3lsU9opZp6yE7atY739gzW3haUvwNHyRQpKYLs=;
        b=Snt2oBcSsZkAkaedcvhYXKAF5OpPAf+oyeoEH3l47fn03nqlAHtNRNmnRAQd7yJZ7Z
         rgE8z+pj1VPw8UHG+DvLvuIrwlBhjEpnIj3D8i9BO6hzpwpg02Oh1UJe6rzJm0gR3LsV
         WaGRS+r2N8mG5tMDUeDADCWrQ6DXe9eSrXMGys+Kv5oa4kc2I1SBI/ZyGU+6uufwbsIi
         LDowV5K4VRqCO/AQRBI98Khut9Si23HU7KWS+LYqJnT6F4H1umjFbIEPvNRt52Iz34ZS
         N3dHDragNwt1cyl/8/l3U2Eokt6ZIPgUfUjO+rbE1k+0wRktQxh/sl9OYqFxzLP3kV66
         FWgA==
X-Forwarded-Encrypted: i=1; AJvYcCVvG9rcvk9lF9A9MqZ3wEHDfYKgDnYI+GMxrDBP/N8k36UUUDQM8SPrlR0Fx3qh2eiGCzV0z+5KQmAbEgVw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx73SkuCgIL3mpslv+tLC5q1jdjmgtlGTzQsYwTr6p+XlxE71zO
	0orrH6mqJ4mH4vuCE5PfndYbcUcGFahvr3DajOXInU/sWqSmJb4LwKaxFFoocSmpSF1L++aHZLQ
	MggDkRzus7PZJerpjGekKYG18X7XeRLmITdlb706Quw==
X-Gm-Gg: ASbGncuNbp9mJPMq4imAOw/3Ugwe567pC6KwT7L1n69AZefyENKA4n3wR3rw0sL1h3Y
	b54bSeCBxjDj5Y/l9aIWQkEQ4O+8isyQcpEzQj/4Vvbad6wkfDXC8Zeo5rbhg5PCynu/2gYalkP
	zGpOH75Bd4GjXXW5W1L4hk68hON4mg0ffwJh4QKaB6D0VhFoJ+FaC57Th6Qzg7HBWK+jZE0uDxv
	KIePU0wY2YiTuiVB8Len9pckKg3nKs7Uc2X7ATLC6ZM1jCm0HhG7QuoM8Ysrsc=
X-Google-Smtp-Source: AGHT+IEyYHojEYwroDNW11OsucxHghsFMn962fyw0ZuaI+QtQp6ib9TfoyVtVolV1YcJhyMwLYRULoG+X+s0YRP6A9Q=
X-Received: by 2002:a05:620a:4722:b0:82a:6774:618c with SMTP id
 af79cd13be357-8737575fefemr549615785a.41.1759329891441; Wed, 01 Oct 2025
 07:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902144148.716383-1-mszeredi@redhat.com> <20250902144148.716383-4-mszeredi@redhat.com>
 <602c8ecc-d802-4a21-9295-8800f7a3cf11@bsbernd.com>
In-Reply-To: <602c8ecc-d802-4a21-9295-8800f7a3cf11@bsbernd.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 1 Oct 2025 16:44:40 +0200
X-Gm-Features: AS18NWBl12YpEp7hZKqQSOFHlh7KZ14KNiEeqywA6rNpBi-sblShI4uvBsiB2WM
Message-ID: <CAJfpegtVJ3W8SzrQ8sYciYxbRQS6+A3HRkSDHzLC84-CPdYPEQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] fuse: add prune notification
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jim Harris <jiharris@nvidia.com>, Yong Ze Chen <yochen@ddn.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 14:29, Bernd Schubert <bernd@bsbernd.com> wrote:

> I also wonder if FUSE_NOTIFY_PRUNE shouldn't handle dir inodes and
> call d_invalidate() to also prune child entries.

d_invalidate unconditionally unhashes the dentry, which this interface
should only do if the dentry is unused.

However, it could call shrink_dcache_parent() before trying to prune the dentry.

Thanks,
Miklos

