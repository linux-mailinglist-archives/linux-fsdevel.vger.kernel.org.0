Return-Path: <linux-fsdevel+bounces-15048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4A1886571
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 04:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55071F22B71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 03:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADE879CB;
	Fri, 22 Mar 2024 03:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cJwPlfiJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2E34A2C
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 03:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711078029; cv=none; b=tug0MvMdKm/hlKRn/crLYVNG47jRu59YSUonWFFxzU6p8Yw8o698DxF8XuQkYu+dA3sJaUex8IwljDwmIEoq6N6fMW1ZPM6wS8vMUI/dbWkncbfvt7Os/tSJF/CNxQz5m1APKQu/nvkbQYCrh6LocZRhg381YNvghpf73U0GQkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711078029; c=relaxed/simple;
	bh=rA9OLiQVBndIxCqI/RnL35hJtQlSZt3ZhLZoSTUWMn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWiQqVl8U1Q5+imJ+Pns1PyNGsLzu6rMyo1CM0MJchcW6w8EoIj41It18gV93fM8QUbx4WTxxQ+/DesqmOduGjVBFD8P9Tv6XehQGwMnQ4DMeJanMBjW1VJ+xB7k5KRM8RhBqKkWLcaDeeYYwkQR9qDAUjxMshcyIvc/O4ZlmGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cJwPlfiJ; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7cef30fbc5aso75873839f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 20:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711078027; x=1711682827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcsMqmY7811GML8PC3DqwKOCOYs9+H/dHHUmPBVs1BQ=;
        b=cJwPlfiJ+dOFghLSsBStlvkritac8UeE02+QMzZ4ymXYZBH+MTQfqvKmo6wcrALoLU
         +sqc8Hmn5clZ99osXo6fjIt1yMEoKH1Zvz6AuwGCpc0JMTXG4IwclkHajquehTDgKSKo
         3Tzgi7IN7jFfFMdGQJsyh0NJhvD+DHefWFRCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711078027; x=1711682827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcsMqmY7811GML8PC3DqwKOCOYs9+H/dHHUmPBVs1BQ=;
        b=Ga1mEIMIACNJFuPAdhj/MeMdrenowM6OlH2p3zDPSogu6antifWsk+MFTo+WSvIO+M
         Vmph58gDk9eoG2CRYK0IbxfX1rVpJLmfyY+h29RGc64thqBjFGfTX9dZYiGaFQS4tPfN
         2Xfh1uc7OylFds63ZKEtdSgKUCNjlzgr1FaKk3N2fvGJiXlexTs4j0ri5YzVgQt/9h2I
         IHOAs2Nxgsv/634/DyznkYoijmnlu4WK+WsCAbWD/6FBJ0hcjU4m1nupdu6pQoJRx+oU
         Olo1mAc3Fa1x7fXq6k+N4vVIndRHodg30XdIOllqgoten2ed0MUHu+Uv+t314nr2UZMZ
         UWnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNhJ+0K7kmqOu2HQio0FkI4cGHodOgJ+A+JH74XTB4T2TfPW1o5vOjtW6OybJmk4sqh6g7qeE3vbR6GigIk85JUrHCky1/r6u4A7uuPA==
X-Gm-Message-State: AOJu0YyAYrRYpNAuPo5SCfC1jdweDGvxMVAJQMso3NwK6XsnCS7KV/L6
	4yfAXvleUG+gWwAzBbqwAhZtw0mHp4AInJq+BtRFpN/tX5oV2INQMXpC+D1+7v7FThS1bTTTQCE
	=
X-Google-Smtp-Source: AGHT+IFMNGILCIbGOORMV5AHfyreOQC+oqrzNbTvmrzQsA8QnVKKZXTt1rS+A5kiGLdhP2gdpVAEXw==
X-Received: by 2002:a05:6a21:31c8:b0:1a3:7327:2323 with SMTP id zb8-20020a056a2131c800b001a373272323mr1123844pzb.45.1711077544553;
        Thu, 21 Mar 2024 20:19:04 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d0ca00b001dc944299acsm657327pln.217.2024.03.21.20.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 20:19:03 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Rich Felker <dalias@libc.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] exec: fix linux_binprm::exec in transfer_args_to_stack()
Date: Thu, 21 Mar 2024 20:18:48 -0700
Message-Id: <171107752638.466752.7224681033755371253.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320182607.1472887-1-jcmvbkbc@gmail.com>
References: <20240320182607.1472887-1-jcmvbkbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 20 Mar 2024 11:26:07 -0700, Max Filippov wrote:
> In NUMMU kernel the value of linux_binprm::p is the offset inside the
> temporary program arguments array maintained in separate pages in the
> linux_binprm::page. linux_binprm::exec being a copy of linux_binprm::p
> thus must be adjusted when that array is copied to the user stack.
> Without that adjustment the value passed by the NOMMU kernel to the ELF
> program in the AT_EXECFN entry of the aux array doesn't make any sense
> and it may break programs that try to access memory pointed to by that
> entry.
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] exec: fix linux_binprm::exec in transfer_args_to_stack()
      https://git.kernel.org/kees/c/2aea94ac14d1

Take care,

-- 
Kees Cook


