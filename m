Return-Path: <linux-fsdevel+bounces-49784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FD0AC2706
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 18:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7EF11C078F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 16:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9468F296158;
	Fri, 23 May 2025 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtC2zoVS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DC5297121
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015951; cv=none; b=aiAK5+BtfZeA9jC5PupYrbxT1sbxeV8im9ALdIEoxKtyFobW7NzWmGS/Afww/KJb8wNMvypdnV00q+x5UuQYmowgBh1IJqqad7PRmU+84kn683ZQfuMoTzzZ8olR7CLEmOXCyn/MHrC6HKj6Ky06UD7/ETU530yJncU2p6jazZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015951; c=relaxed/simple;
	bh=w7v4Q00cuC1CWK1/Jjho1KP+1sNr53JiDD3gQAcfYsA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GCEBt/J39zpa4bj33v78J951AJFbsxVqSMHDKL9tDyxr98h9BzzUl9jVjzVyiTZHpeSaUbmMsGl2aS5kKD/1NsbfcaqFpDPg72WjYNVm3eLs+2x7962wEG4h8Vm2jHbk5IG+dNYLxAJEIhaoR8X7oLNzBvC3VFuZtGCjncb8s3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gtC2zoVS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4c9024117so64545f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 08:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748015947; x=1748620747; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wdY6jycOSEl/PG9q1T28oSVWH36OAXvUr6Q1hXL9jts=;
        b=gtC2zoVSfjejbciLWNp/FExHKmqK+s2jIUElkKe8k1Z3eZH0Kg33IdXwPDpzvtMWB4
         Ufo5DhLtqlCL+dxJE1SouHczJni7wxmAv/j/CWHGKo7OvKwFz3gGI4yAPuzC4mxirv5U
         dvQPBG8WxFY4bB8w90e+1lzOGZEyE0+8MaQEwfTpySVuXeKcNTOqIeFEjQ5l3JpI4/6x
         jMPIRC8wOtWge6VCOdZyS2JdfXdq5z34fH9My8KsjQEc1Cmnls8BjSAg/ph4ylG+koVE
         iJCe7vfnkv9ljGzLo17SsExiKUfmWeaIHi1glcpclXDlyXphvFnJfnVQGX3UGt0A5z8u
         cM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748015947; x=1748620747;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdY6jycOSEl/PG9q1T28oSVWH36OAXvUr6Q1hXL9jts=;
        b=aiJvelzSIkzqvgDPUAsbekIzsmpXbY55NNSM06sEYslWzL5yvXJvGE3Xxzr3ctpxGH
         RpnKSszHqp8Z5lFq7CGjQFeWwvVMMNeUcwfiVWwAuh5yDymCINkc41AvGSFjm2o0IMln
         p7C6q07JyLMHMrunNI4COJKFHG1oIqL+zpgF2gVMkaOfZb3kMFaj3TUyLydD2UIgri4n
         JQJxaiwdoxWXBoVsqTMCr93jOQ3QfdEgh/LOFB+ZeS618Xucz9+5aKXBf2tsrj+nsYzi
         guZe4YzkSp86W1Yh4eBBKz3VgQdRSlJxzdO/zKe87OSLKBRY0Uqo6M2CQJWCjoK73oBF
         pR+Q==
X-Gm-Message-State: AOJu0YzXfrhphloOcDUbFVlzX6pGAo1qb0/fJs/SdbZOQW9VeftOk5Uk
	MX/gVAPmS9bLeKQhAoiONLyiZAyeTSU1kGsrIuQ0dcWguB0Oxhdt6RIQcaqodN2yVnA=
X-Gm-Gg: ASbGnctZHINWOez8DZrwnxq9DlHTrZ49S6YSLlMxVwA8YN30r6Y28YvhNAQROYt/rfr
	BwZ/58ZHqpycBc0cBk8sPy4N9gU8MT6DKmM1h2IRQDnVFw3WmfGSQgSbhptHvJeK6FpaR/MxHIU
	ADqxN2t0jobhFm5gSnqzZX03p41lApaete1OlWd4V4DIuZQaFpf7a21RMOKaLM+Uc2X5VtDd1KJ
	2xMxvjdQqLaf78CEiA1FwWbxPc9aLN6+YyxDTTBIoOSzqfyy72yuQOVPLK2t8FSW/6L6eGjTUzS
	FvtTsNgNROw0vHwxqx2Z84qblPO9dNt2baisRys3voVRjczbIRbxDSEjn2clEszERPQ=
X-Google-Smtp-Source: AGHT+IGRJ61tncEQYCf7/JzFlK11shMvmI07P7xHhPnBPSS6g1OKFxWvNCz+7rwSMQZvfRuNMImqxg==
X-Received: by 2002:a05:6000:4203:b0:3a3:779d:7421 with SMTP id ffacd0b85a97d-3a4c9dcd935mr101546f8f.0.1748015947536;
        Fri, 23 May 2025 08:59:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a3620dbc6asm25622327f8f.88.2025.05.23.08.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 08:59:07 -0700 (PDT)
Date: Fri, 23 May 2025 18:59:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] fuse: support copying large folios
Message-ID: <aDCbR9VpB3ojnM7q@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Joanne Koong,

This is a semi-automatic email about new static checker warnings.

Commit f008a4390bde ("fuse: support copying large folios") from May
12, 2025, leads to the following Smatch complaint:

    fs/fuse/dev.c:1103 fuse_copy_folio()
    warn: variable dereferenced before check 'folio' (see line 1101)

fs/fuse/dev.c
  1100		struct folio *folio = *foliop;
  1101		size_t size = folio_size(folio);
                                         ^^^^^
The patch adds an unchecked dereference

  1102	
  1103		if (folio && zeroing && count < size)
                    ^^^^^
and it also adds this check for NULL which is too late.

  1104			folio_zero_range(folio, 0, size);
  1105	

regards,
dan carpenter

