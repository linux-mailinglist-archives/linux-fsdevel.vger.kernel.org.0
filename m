Return-Path: <linux-fsdevel+bounces-22215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCD6913D3E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 19:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CBC81C21656
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 17:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AFA1836F3;
	Sun, 23 Jun 2024 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzTE++eW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4303F17FAB1
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Jun 2024 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719163339; cv=none; b=i+fEcPKYaOm+YkJv6te/1P+vliADDMrGW/HfkMeK+bX0u5y+pPasaLEHBR+jybTjzTSTB0YNIobd6wbdkBrjcszhvGgdNsjz+7MXfmpDHCkN9pwLV5FdHEhjtTQU0RLFFKtzXGqc5lHE0PRr9Uxjoqp2pfgx7B/vRrv9jB+4Y/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719163339; c=relaxed/simple;
	bh=xooBRgRqU8KkGvbKfnOdVRQ+v9ygph70tvTYpTn32gg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=m/39c6i65gAbPIlnx2I0Folv5k1v1WqRvfGyTemC5ESkaxhc8VTiNaXYoFyE8W2EIvHkBCQvXmgNmPx62zy2azW7gn3OU+SLU7oBDOcnR8Cvg4XBTtrY7Sw9kegOYy0ST73wSSW/fKAJNACeUBO1On/vsFt2a8kK5CyLmuOIJGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzTE++eW; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cdfb69724so1075490e87.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Jun 2024 10:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719163336; x=1719768136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IHEMmRTFlmD9LsIvO/9RxxVs+WA4saKSr9Q41HLgUAo=;
        b=KzTE++eWGwsyzHPg1vK+kV/rqx42KWwz5RYeuCsBoUTL0cbuVbuAL0iU7QLmSmT4hA
         t3r9M3kH5quKud48RndVt0STRbj10hZsqhcfUPPAjchljpUHASHXP6ZtCC5poyRinWiy
         8C9bQ/TKfppBCagAt2pTXLo1wTv11RerKo8soX1q57N8ny2ZDgsAV8/UAHwAYsGZya56
         b0HSp0Hai7nFnb5m2lrB8hkPmGvxdJkeqLo3y5u5+VmOXPl2b5X02vmy6BDHCjn6+5Db
         A0XbT7nLSUT65+BjFmHMESv7WY1pKaMWq3GdZOvPf/pg8UTxph+mdHX0NAr9PEzLdRyj
         XIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719163336; x=1719768136;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHEMmRTFlmD9LsIvO/9RxxVs+WA4saKSr9Q41HLgUAo=;
        b=AEctNc7DjxO0Oo6VWH1lw7XMA6g32rhKGFrk2ZVw2fHEu3DmS70r2/oq46NnDxlwUq
         pX07Ohfcn544qM5FCMu2AhE3sDjyOBEG1xVt+wdk4FIzvgg8Nffz774RBXiDIW5l/m70
         PZUGjmiyWElDVqfPPzOI+O/h5VHGpAdZwENB4lr3TzhM0CTwfmtHw6V61XeNe/Fkwi6s
         1+RZGX7tH7DmPUDwogD+5Mh+xbWcpA7Xt7TnyOHqveRUsZ0wG4tcJakgTVrfeYvhuraR
         xGXMMMJGktGLpsTOZsaTzqERnVKzUA/FjS+7iSiBi/yaavsxYjkXDts9PTlHkX6PY7me
         nYWg==
X-Gm-Message-State: AOJu0YxjRcK+Cbu4j0MZb6DSFsTCNQDkStI2HVgRkhHsHbHesQfo+Jbw
	AVMYWxPI5+eKAGaiT9G3YvKJthMvSlHzxV18lzwuacpsy7+S2hVX6N+79h+l3V1tpz9krSkgy7K
	eod2ROMTk3k/MAUZZlTd2zpk2WHNkQxdJ
X-Google-Smtp-Source: AGHT+IHkUt88d7V3dJMEo8etDaM3cNLbmeIFLnKEY3Ip5JMujAubsrO2Rx0M10Mm/ZUVjHK+S1JgM9AcRiYj6IwYL4M=
X-Received: by 2002:a05:6512:2013:b0:52c:de3a:839f with SMTP id
 2adb3069b0e04-52ce1835762mr1219814e87.20.1719163336081; Sun, 23 Jun 2024
 10:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Sun, 23 Jun 2024 12:22:04 -0500
Message-ID: <CAH2r5mu+8dfmxd3XQJ-XqPhUFAXcYSPsd08kGVU6LxB_-tMsDQ@mail.gmail.com>
Subject: fscache build options
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I noticed this warning in our automated testing for the kernel build
stage (presumably has been there for a while).  Wanted to confirm -
fscache is not intended to be loaded as a module (according to this
warning) ... just gets built into the main kernel build instead if
required by any of the modules

....
HOSTLD scripts/kconfig/conf
.config:885:warning: symbol value '0' invalid for BASE_SMALL
.config:4526:warning: symbol value 'm' invalid for FSCACHE
*
....

-- 
Thanks,

Steve

