Return-Path: <linux-fsdevel+bounces-12639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4D9862173
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 02:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC784284BE4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 01:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E482A4A05;
	Sat, 24 Feb 2024 01:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GpVX60LN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F341246A2
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708736901; cv=none; b=SfB7c8K+K63oPGE/ts9g+HsEoJ1v7JMMBxDYpgufrxruGuZUUDKA0Hh5zuazRoR33mZZ4nK9W8+uvsZT5ysoL9RJyFKjW9+LApoIYUA+sifhPp/xpjkmHXQ0n/rcBVrmZozC4IArC5O3WmNpSRc0CBjJSMjvNp/fXLZZCt0Xkts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708736901; c=relaxed/simple;
	bh=p5ato4DMryYVxYzXnaJl8fYJ34T6J7eCWMst/m5g6WY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/3tyemWdgCwOj5CgQekFiKmycSChOFMm0+G8Pw/5/3m/fvb1DZtxOPzWWFlYkhnHQVnDGUCFLu0pLWz7va85dj/GzLVaxhM4CASjCVb6XrK1XKSdWnNDHFpoPrjDzRb+RFpiZVJ+fewkME5z6BHHgwZuklsfTTxdgA/zwseAaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GpVX60LN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso1226554b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 17:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708736899; x=1709341699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPbEpUgR3RJJkrT8w1u3P3Cf+PMMA1sVgxWxYwB5BwU=;
        b=GpVX60LNUfW8LZUQX8gTOYL70/+NdMxb5pOYbi00Df4ixjfdkSSt8uxx44hUlc8NEQ
         T1rnJHuJFy9Wcy6dC+7e3wpd8Pf7M1vpziND2d0NZSuaKjT4w1Jka8IdOjgZZxUggeQ8
         dUVkm168EqmGgRvYcBUZ7JqoQKUbhZKsNi5/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708736899; x=1709341699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPbEpUgR3RJJkrT8w1u3P3Cf+PMMA1sVgxWxYwB5BwU=;
        b=EhZbVoI7telvarYOflRCXltCxJF2fSI3CNHNAMMOs5ay0iFIZnGGIZvj8MdV1rYVT1
         L5IBIYk4NJ4oMMzUMWGa7AtlYNBipxJLq1E+lsLB6jsU9ueBOPuRyBDlw9vQEznthxVU
         BYxEeY9XQ32q8+H4aMrSp45EWwM47QZvEBu13zE2chmwGsmycffpOsAexWSue8cxSRlX
         Dv2zmOpMH0ZUoyGzERFV+dKC4qL4LBeyb3PHiT/Ewk0odNpNrkkcDBGaH1iDWlkrbo4B
         Ql3xwcTsEdEvOC2y2FAXbqiRp2zCVb5xbBllM69Ix8Uz08Bw7X/VCOordeCToF4oNAOC
         7Oog==
X-Forwarded-Encrypted: i=1; AJvYcCW+Sqq8+jxpEmkKAKLwgdqy7bbPLhQWGgHrNZiYc1H1tOxHyxg7ZQsFU7hd76TOxkKuPHxQ6vHi/mnP29cK9q/OQnIdsL8lfjk69ea1Kw==
X-Gm-Message-State: AOJu0YzgWhowg5Qm4DycwfcNBWcIFeDu2hWINIIPUUzY9gw5JrcHlC2X
	htNRLNzTTrr5kiKVe+LAehL/08Z2eQyGymEuY6m29bUR3hMMkWI49eXUEAg9Ew==
X-Google-Smtp-Source: AGHT+IFGxAKJP55TZNONgdna+0WFrYvk9AiEzOU4vrvn+NI6VUCOuTPWb5QURWSnotnP6aVhVFRPBA==
X-Received: by 2002:aa7:8883:0:b0:6e0:50cb:5f0a with SMTP id z3-20020aa78883000000b006e050cb5f0amr1649876pfe.12.1708736899436;
        Fri, 23 Feb 2024 17:08:19 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w27-20020aa79a1b000000b006e4891d0e2bsm94905pfj.7.2024.02.23.17.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 17:08:18 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	ebiederm@xmission.com,
	Li kunyu <kunyu@nfschina.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Delete unnecessary statements in remove_arg_zero()
Date: Fri, 23 Feb 2024 17:08:16 -0800
Message-Id: <170873689406.2130928.12246723166795978039.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220052426.62018-1-kunyu@nfschina.com>
References: <20240220052426.62018-1-kunyu@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 20 Feb 2024 13:24:26 +0800, Li kunyu wrote:
> 'ret=0; ' In actual operation, the ret was not modified, so this
> sentence can be removed.
> 
> 

Applied to for-next/execve, thanks!

[1/1] exec: Delete unnecessary statements in remove_arg_zero()
      https://git.kernel.org/kees/c/d3f0d7bbaefd

Take care,

-- 
Kees Cook


