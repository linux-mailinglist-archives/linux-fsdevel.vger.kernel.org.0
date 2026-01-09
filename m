Return-Path: <linux-fsdevel+bounces-73023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F10D085EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 10:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37A49303365F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 09:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA72335544;
	Fri,  9 Jan 2026 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JdXx55oa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6903D334C32
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952630; cv=none; b=Sms6UolfDiTzod3Ynj6NrhIfPJcc4FG7jr8PEeOo8bBa5yvHUZebSuABh7dYkRBfKHTG9CszDVRPe/Kk2nj4qwPnP5/2+5WMJhrTmb8WEGhAwRihifZ6+ofcwjPeYVvBjoTyGENASKZcK8uvdvfjqLkqHPcEjtG24kuoSTJTp1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952630; c=relaxed/simple;
	bh=dz7KB5U3gx3viAJcCdLa2VPDIKl8SwY4jJYjy8LTtOI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gvhv8bZFuyVdTCoXrgQcaD4fWvBeYokwcSST30y+eeVDyCEl6k7xT+uuOY+vAPCiqc38GTHbbt++TgxZXxJ74Nxaa0hPh/hPDi2VMNxDNFyNK2Ox2E/LugB/uorwqjqdT8srcb0/Gpl3+LB6nJwNYtwj7RDCJRxb0LUT6/wLsq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JdXx55oa; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-477563e28a3so20001795e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 01:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767952627; x=1768557427; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4RqShnqGsHgQYTVYTqto7aLrJkECk/U5MKTx+2e9Xsk=;
        b=JdXx55oaCiqAeeZvVJgm0yLMdUGQDBXnqu/VYqJudkxuaQ0HGYsIzmjRkgNqpwodTg
         mTWsXx2uyN5sEL6hHY3SjtczdtbTrY8S2kRcFu12YPOZmiGB3eaUdobLxPxVwxW4Us/G
         SSPhuMXV/lK58v3FCczzP6tsHqRYU7OdV0snVQ5/1e+8LUJZkLwEzp1IQ69fvXpy1DaU
         yotALUEM7oZTMQo1zEacndHdhWINAhT8mxR0DeI1Ik4238+XJLmIGtC/7TTlG/iUUXJl
         09sOHc6PF8KVVJjM/wca0UHDfJxbzL94EbbeuXtq2+QDaSYe4RbnaDHu9HGpLyOQzo3a
         7PIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767952627; x=1768557427;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RqShnqGsHgQYTVYTqto7aLrJkECk/U5MKTx+2e9Xsk=;
        b=V31EjRbfOeQJjCvLXgstvmsxKk20+suY1Bn8PIqntL9KpxeajUAM3e6hMLwZ41yebZ
         sgnqYZ7nqE7MHfCqbmx/WsA1jPaY5EZ2EwxGz+y36M8x5/DPEtjJxGcX0ZLZAU0y9vdf
         Mr2tMuD+I0lgeiCaYpr8VMYTtf8P6QQ4qhAFr6UAv1jUHrkTD08zu+c8jkEFWfYpjJwy
         MWNxwCUekTBWuunzD7x7/9sipQBgC2p0E9l0dPV7144rRlG+014p/rJu+ROGNdfgzBLq
         rB4b1b+HBh7zxAT5U3AXOPeqiiTko+GibZpJzUmpb6LvfeTzM2UOmpYX+8nfHTHAoUkL
         aiEA==
X-Forwarded-Encrypted: i=1; AJvYcCWfXhwcZJbjUTiLkCHEmm+bimawTf40OmPm6NjphJeCJu4bJK+Fv/xRabpviPMl77IMvgZvdskIu7BXhf36@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdaa7tI6gooMS0mXZj0fXtBpafpC1jU6nf4j6IMKtbZmn3I3ED
	Yjz3bbKnJCwXUdR1GsDQwQuIUNmcLZALi3fMcQiKglJpRPkmkSzfmvWnUaqFuWVxd74=
X-Gm-Gg: AY/fxX5bCeQhT2YeAHodA6eiZq/HWzYRfqzGRg7oCujA3tHRuanfVBw//3liCrKlHMh
	gStZiamFkKef9v/uyAcTWzMvavUADELmbeVsdVtBseTWDpvBJz1mEJ+7vvXjzfHX2c1gwPZwH3y
	JwU+AIU9Mqzpp53UUYOt9HXgMffrJxe0NOyTrzKUVl46C4kktz2EvaF5jVBIlOJUSghYqSd1c5p
	efo6GlgFu/vpljyuMBFEwgjFFtGn3rI4vg+vyFMT8dmE6lPa8iv15ZWq3RST0/+n9BUzQc5DZGI
	y5wc+jJPZ+Y1i8FdFiwsmD9avCUYMy9/WMiuNJGyAkXS8148dUUoWKYb9ug/leJ6CXcRDVzDX+t
	sUEALOfYFLQWO+Qb/z62mq0n94nS49Giz88Cvhn8j5UekZLFahi9vR7Wh6lu7yhfY2GsHPMSuad
	DoKRgS4CimBhhh1B4LRKpbpAYvH6Q=
X-Google-Smtp-Source: AGHT+IHzh/pNeqZUBGaG4KiRPl2v7SR9G8ylIFzlUQ3MiO5GcK+In2/wGNHZw3ijn2CU17RqJrvdWQ==
X-Received: by 2002:a05:600c:6308:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-47d8486d60dmr81639985e9.9.1767952626449;
        Fri, 09 Jan 2026 01:57:06 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f410c6csm211143335e9.1.2026.01.09.01.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:57:06 -0800 (PST)
Date: Fri, 9 Jan 2026 12:57:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.filename 15/59] fs/namei.c:160 getname_long() warn:
 the 'EMBEDDED_NAME_MAX' macro might need parens
Message-ID: <202601091728.qaU51LaE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.filename
head:   30ba070760d3eb039c6eb91ad17d8c1e13335a7b
commit: 2a0db5f7653b3576c430f8821654f365aaa7f178 [15/59] struct filename: saner handling of long names
config: powerpc64-randconfig-r071-20260109 (https://download.01.org/0day-ci/archive/20260109/202601091728.qaU51LaE-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 10.5.0
smatch version: v0.5.0-8985-g2614ff1a

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202601091728.qaU51LaE-lkp@intel.com/

New smatch warnings:
fs/namei.c:160 getname_long() warn: the 'EMBEDDED_NAME_MAX' macro might need parens

vim +/EMBEDDED_NAME_MAX +160 fs/namei.c

2a0db5f7653b35 Al Viro       2025-11-19  152  static int getname_long(struct filename *name, const char __user *filename)
b8000a3628d80e Al Viro       2025-11-19  153  {
b8000a3628d80e Al Viro       2025-11-19  154  	int len;
2a0db5f7653b35 Al Viro       2025-11-19  155  	char *p __free(kfree) = kmalloc(PATH_MAX, GFP_KERNEL);
b8000a3628d80e Al Viro       2025-11-19  156  	if (unlikely(!p))
2a0db5f7653b35 Al Viro       2025-11-19  157  		return -ENOMEM;
b8000a3628d80e Al Viro       2025-11-19  158  
2a0db5f7653b35 Al Viro       2025-11-19  159  	memcpy(p, &name->iname, EMBEDDED_NAME_MAX);
2a0db5f7653b35 Al Viro       2025-11-19 @160  	len = strncpy_from_user(p + EMBEDDED_NAME_MAX,

It's harmless, but the "p + 192" happens before the
"- sizeof(struct __filename_head)".

b8000a3628d80e Al Viro       2025-11-19  161  				filename + EMBEDDED_NAME_MAX,
b8000a3628d80e Al Viro       2025-11-19  162  				PATH_MAX - EMBEDDED_NAME_MAX);
b8000a3628d80e Al Viro       2025-11-19  163  	if (unlikely(len < 0))
2a0db5f7653b35 Al Viro       2025-11-19  164  		return len;
b8000a3628d80e Al Viro       2025-11-19  165  	if (unlikely(len == PATH_MAX - EMBEDDED_NAME_MAX))
2a0db5f7653b35 Al Viro       2025-11-19  166  		return -ENAMETOOLONG;
2a0db5f7653b35 Al Viro       2025-11-19  167  	name->name = no_free_ptr(p);
2a0db5f7653b35 Al Viro       2025-11-19  168  	return 0;
b8000a3628d80e Al Viro       2025-11-19  169  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


