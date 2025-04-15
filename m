Return-Path: <linux-fsdevel+bounces-46464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBA1A89CC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 13:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B701F164F5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 11:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F1727586B;
	Tue, 15 Apr 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="RyYMoJYw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A2214B945
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744717612; cv=none; b=gMhRwPvJVq2WU0XV47nq0WBis3dKh3/aF5VLB5SpX6/GxY9rS6259ujcr5+hlSbFWJe13zpFxTZj3GBVRBmKv3LuGOqo8F6dybKzb509nLl72qc+6nZgp2DzOS5/1RuwdojlPfdVREslNmUtczGZZF8ANopI2zJRDlspcJ9euAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744717612; c=relaxed/simple;
	bh=ww25RK5DWkI3xKlm/vu1TWwzSv6Bg9MuCRJAm3+kUzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYJQngcXFhwQNqj9A3PscLhX6M14or93Dl6D1IRdTolOd/tw+r2At7Hw02VAOKVLHyB7J1YA4xzfI2zWMw//yN8/731TwVdpiRtJ9fXGlIhkt70TblQ47UpGOYGsUKsluRAN6Nc6JnBjUzzRWCg+kCkjAGe/rlONHImycAOzqD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=RyYMoJYw; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47692b9d059so69201981cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 04:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1744717609; x=1745322409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ww25RK5DWkI3xKlm/vu1TWwzSv6Bg9MuCRJAm3+kUzk=;
        b=RyYMoJYwXCJnKBFVazS309zIUcVvgzsYl20B/noDy7aF+UUqTnztskCOsj5/wKt9L0
         TV07I/H4fbXeoNIJ5mpmJLbph0ZH1sJwDQYyv/sUEFqWT0wbWXj4ool6F29f2JBmYrTT
         TdkYYKuVEn4gGkucyLwLPye/dGJ4k8j37P/fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744717609; x=1745322409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ww25RK5DWkI3xKlm/vu1TWwzSv6Bg9MuCRJAm3+kUzk=;
        b=ENA0Jfh/ibGIYl/LXvonfLOd3HSF3ZFr35zHmgoesfQlRIkgD3Zot6j8AgnD9C1008
         YA8Gy/jt+1PBZUfSWjGisrDJsHdKX4n1/38Cpo0cYtOE1p2ZD4atVtebvC8xMv0h/sdB
         41fse/YUHhLmR7x/8LllufrUONOpTbtbkKkpHE1/88Y8uK+6reEKCmW2LWKG2ZDpe1ee
         mjSvOolFTUS5icbFO7hm6cwQynSfMeGCRxgVDSkt+C2mnhNOf5AX1Tvo6lFi8bD1M1xO
         dWROmCQa3fzlkHA++lbFBxBs3s5g2UcOQaVkWkrFR2v0cG4917RDeQBMLa/dAN7iADci
         Tr8A==
X-Gm-Message-State: AOJu0YwbwJPZshYR/ODeZ7Y4SOVbe2kW9gim+d9n3gvE2JKJaWFxHXM7
	LmCbIz05MSMHROQ/Xz5PFehMF9dRNS0drIMhMHeHalo8sfpXB2eOMJVlLxh78GNOlsWWkF/AeP0
	knH5e3I5W9jzZWbjAsZlrL8PkjwysHE/4HuoFUQ==
X-Gm-Gg: ASbGncstuHCC6k88zrsIG5debhehqJ45N5PacN/gDiynOHBNyq9bn1xy/d/n315oVDH
	HHrAUp34ktssTe1l1WifWbzhn2fhADaQo224HT2YTdVQMohNgvsw1OzHozlzymUDjLte5uOZZiJ
	Ag7EwsDN5ZlhT1Ei1i9PDN
X-Google-Smtp-Source: AGHT+IHRwwLiMRUyIKA1DmKu63eUrPV1H9MKBa4mJyp+9vh/S6uEu2wil5mUT5l2/QMdnrioN7mY2+lU/A11JcmcEUE=
X-Received: by 2002:a05:622a:2d2:b0:476:964a:e32e with SMTP id
 d75a77b69052e-4797756f838mr204628121cf.29.1744717608952; Tue, 15 Apr 2025
 04:46:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203193022.2583830-1-joannelkoong@gmail.com>
In-Reply-To: <20250203193022.2583830-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 15 Apr 2025 13:46:38 +0200
X-Gm-Features: ATxdqUGNCVNfnex9ZbZjUiyOIFG3-KEHQ-tuVcaQI6huo_a8HyL0mZdpqXQuXlc
Message-ID: <CAJfpegtoBa1vdLJ1eNKcNk8FWjgVAfPf558mNCtdpqt1XO6NxQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: optimize over-io-uring request expiration check
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Feb 2025 at 20:30, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Currently, when checking whether a request has timed out, we check
> fpq processing, but fuse-over-io-uring has one fpq per core and 256
> entries in the processing table. For systems where there are a
> large number of cores, this may be too much overhead.
>
> Instead of checking the fpq processing list, check ent_w_req_queue
> and ent_in_userspace.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Applied, thanks.

Miklos

