Return-Path: <linux-fsdevel+bounces-28852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5C596F72C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 16:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3D428725A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 14:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2F01D1730;
	Fri,  6 Sep 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="P3r7zYAr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6681D1F77
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633772; cv=none; b=gefxcL44zsNQV2U0L0ST1AnIdJYIhjMln9nq2QXxLke4BN69f/7nJTH9vKWgPorcdL13ShhbaDRC7YZfFmsueUyqQVXVyVKq2z1y5dRzjax/R6X4CNmEabW41G+d0kWTjGrO7AzNm4NBbWf+uGF6R6PKJKQXDFgBZan0kFvyOoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633772; c=relaxed/simple;
	bh=LJU9AgRZafbRGKRwX9Z9gh0a4h6DSxuz5293f/4NqIc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=t2xl7UQ4Yv2NKWDIYyZD56Y7O5e0NHd25DzTevtGEwKRS7rAhnbXRa94S0xNalBRhgPEEwuSa50HKGpnJppwm/B0XXmmzdNU1m1g0uxN2Cymr2VJS996KtuzVFpwWi8+gzm8LBvzgkIYytdY4Q/ii5sj7m/zDSiwyH2Otdmc8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=P3r7zYAr; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6d7073a39dcso29062487b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2024 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725633770; x=1726238570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OdvfsRmG8gWy8ITHHRQX+/j857fwZkk9D0jFjQ3zW8g=;
        b=P3r7zYAr96F//KkxOCOuOGPLnkLuxkKz1uN7Ct3IxWZaka2u+QdBwSYnW9jqv/7nFF
         N8eYfaQglYSFN7vnmemHCxqJcs29BgRlHDA+iNodNn6qL6q07FddVQpo5YFYGWnxDjO0
         fYvTuLtKyRg+dn+g/LQi7iqCeP5tZ4t6se32+vNJC7FpGcGjZt4399AcxxEUgYDiNm9R
         0Jxw2Ozh3BsDB1jRs8oTLBPXYMcY5rC0+IV75R0/cr28n+/hSmnnhWtc008O6J4xxw7w
         0iTUF+ZKo3rCWqYV6Z8f1KsXECn1JhXTjdhx9vY6GJLpbRRcpsHwgUlZVKrYjHEARfZi
         R95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633770; x=1726238570;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OdvfsRmG8gWy8ITHHRQX+/j857fwZkk9D0jFjQ3zW8g=;
        b=R2+tAjDYwarbM6Gh6EzUUiRdc5J0wAmz2sWVV1ft1nPvBbBVMNufTaGCHDbkm2Aozu
         Gsnb7aIhYns9x+aBaVMEciPiQRoR0S5nVahJyIkWsBe0uXllN7uiN1OvZqLekH2Fl0JL
         ja3RLeK0HNX6HiH6qXd1MLxgt6c7yXi0jhQKiZIYLSzg0jAlYW2iEly1ZL82hRalIpSs
         bdaM9WGcn8C1Ms94vjZ3D2o5eQn3kZUucjsHjpdmJIFKwp8UCOfk2WseMhEsHoTeRZzH
         dufCBL5KercSB1X3n65IWI9/QWcmvu4jHo6T6HbswuQ5JWtjKfLQHr+Xonwd6Q5xhXKP
         4XXg==
X-Gm-Message-State: AOJu0Yz7boZlpQVXzrGIwx7WVrK7JEkqPwToE205WOkUV1b7sn39ypXx
	fnOo0VWhleb7DdYVxAj9wD1OMle1m16nBeYhWDDFYKXRrGjZIxmMhKhM/xlifDlkI+CobFiRZB1
	r+2wAKWdXMj+cVFAUXJa2LpuonFGBxiAO8pqB
X-Google-Smtp-Source: AGHT+IFyloP//56s7Tf2Mkhp9TXcL4TAe7nGoLAX93C+OtFA1ZbwJ+YSP4o3ZpN6+R8XILp2R72j+bk+ZnyMbtqi/sA=
X-Received: by 2002:a05:690c:4d82:b0:6d9:d865:46d0 with SMTP id
 00721157ae682-6db25f4767emr87625127b3.4.1725633769789; Fri, 06 Sep 2024
 07:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Sep 2024 10:42:39 -0400
Message-ID: <CAHC9VhQvbKsSSfGzUGo3e8ov6p-re_Xn_cEbPK0YJ9VhZXP_Bg@mail.gmail.com>
Subject: linux-next commit 0855feef5235 ("fsnotify: introduce pre-content
 permission event")
To: Josef Bacik <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi VFS folks,

When you are making changes that impact a LSM, or the LSM framework
itself, especially if they change the permissions/access-controls in
any way, please make sure you CC the relevant mailing lists.  If you
are unsure which lists you should CC, please consult MAINTAINERS or
use the ./scripts/get_maintainer.pl tool.

Thanks.

-- 
paul-moore.com

