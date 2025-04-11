Return-Path: <linux-fsdevel+bounces-46239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02D0A85680
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 10:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8FA94C1D08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 08:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9161E293B75;
	Fri, 11 Apr 2025 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="K5krdYlC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B397A290BBB
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744360101; cv=none; b=osMeVm966tsL/XfXItKQT3eQgXJU86cyHVbiAaUWDhYQVY3PkiCCFJo8Tr8YLK7l4aJt3qEYDm1MD27IdBlWMW9KuLMSnRJsJXBTIAiT3a27UGEgYYUAkYOnJNsW7tguQEvPV9MKigI357ODzQBpGVlW1+3tB9QJ01bXd2VFS34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744360101; c=relaxed/simple;
	bh=O/EfSIW4cWyPb2rH3Ro6WEJgCUswl+SOg2WxCdC+5ko=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cV7DNStrmXlTffaN/nvoGF20Dd2M6Gcl7C0sJtPTdrqcy5099RzB5IDu9FS8OB5mw+UzmwECaFZ7N2Nxyw6qJKvah/+N17fuQQB/0MCpalCDct6tEijTA6jENMUchzEcvr418V1wW6ryfbmOQ4zHQ/+exXbXJlyn5ha18MwB9FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=K5krdYlC; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4774d68c670so23968841cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1744360097; x=1744964897; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YkSKxy7ZFlAbtEgT7iRPpwlnC+b+4x8tjORrxdlKnQM=;
        b=K5krdYlCXroQngcYWDMXGmcLWGzT+Q/f246iPp0fxy0wp7U+QVLU0GTj1J4/srP6EN
         FTJbF/PGgdzuwF42BpnvgdvrhNfgS/zqRJsLfV5ifF9jlpEN8uiUB3AL++xmNPT6qaUg
         xOm9QKvIHOefRqyeOKZI7cKx6zvSpNbVb96oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744360097; x=1744964897;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YkSKxy7ZFlAbtEgT7iRPpwlnC+b+4x8tjORrxdlKnQM=;
        b=KJ9WpsSu+QYI9QJlS0cWYNxOt5B78NaYLyGHo5n8t9rM1DteBojdI//IWv5jW68/rG
         4f2I5pHaTqiHfjBfC9Hn56fmcex5tPlydMn6elaQcM+2IlUbI1U7bfSkQInDPPfo4mZ2
         /ZOHMCN0QmlgLT4DTUbWBo3GrBrGlXL3/TvTaFYvpJ6r5BJVYd39GHQf68JQYW9ijCKd
         dYA4AtJ+iVCseJhrDFR3+Qd0tmEPO9oi4kV69m+REm3Awy2tGGAJTCtAYgEpk3soRNen
         i+VzJi73Xdnf/SJwQCTqLoR2nA0XjsAsLb+YDHja/iyX+m7GmsFxaLSU5yja7+JvRiYA
         9dQg==
X-Forwarded-Encrypted: i=1; AJvYcCV2xz4MR7KlAxSAk1OBP6Z2g0e9kbc5LAiqRbpyNiKHxFp5pbMr0u2XeWOR/08sQ6GqUpCxl+WLVhzEx2B5@vger.kernel.org
X-Gm-Message-State: AOJu0YwroKfd3R2lF8ov5rLgbK8VbHHzhO2FzW+2JQHPFHkfmTEHfBlZ
	8kDaAM5Gg/kCE7ENIDo++V9kz4FOfB1Z+Dj7ziNYjg+dkLshcBd1wY+lScXPpGe/nt6/y7tlwbw
	d8+ecPxt4jg+LQWW/n8NAO3y7LLtBuJTLT/Qdag==
X-Gm-Gg: ASbGncs2sgVuHhWWl/M5u5RK145r4Jsn9QIwAet/gV2fKqum/6tcsjZLgnReyM/Zccv
	GsSORaQ14EhoiZ68JtZgIp0biZuW2w9UxQexBV7e7xMIxdOZZYU3yM7RaL/t4InFqAaWAEil8tO
	ZSa9oX6y0KvIAvWL6m4eD1364=
X-Google-Smtp-Source: AGHT+IEM9rU32Q2enCYeri2d252JhnrampGV8po98Cr8FmF+oICw/7ZI6ew1qqQLKEOKEIbPYY978uadq3FgBPZXjPM=
X-Received: by 2002:ac8:5893:0:b0:476:b783:aae8 with SMTP id
 d75a77b69052e-4797756ddbbmr23433771cf.26.1744360097448; Fri, 11 Apr 2025
 01:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 11 Apr 2025 10:28:05 +0200
X-Gm-Features: ATxdqUF59ro4iAD2MykNxWHKeOxmT8-Sc2-u9dr-ty-djEISOYR1wAZx_56W6vQ
Message-ID: <CAJfpegt-EE4RROKDXA3g5GxAYXQrWcLAL1TfTPK-=VmPC7U13g@mail.gmail.com>
Subject: [GIT PULL] overlayfs fixes for 6.15-rc2
To: Christian Brauner <brauner@kernel.org>
Cc: overlayfs <linux-unionfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Christian,

Please pull the following into your fixes branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
tags/ovl-fixes-6.15-rc2

- Fix an missing check for no lowerdir if the datadir+ option was used

- Misc cleanup.

Thanks,
Miklos

---
Giuseppe Scrivano (1):
      ovl: remove unused forward declaration

Miklos Szeredi (1):
      ovl: don't allow datadir only

---
 fs/overlayfs/overlayfs.h | 2 --
 fs/overlayfs/super.c     | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

