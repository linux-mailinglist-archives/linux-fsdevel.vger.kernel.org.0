Return-Path: <linux-fsdevel+bounces-5065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7313807B83
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 23:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016C71C20BFC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF4F563BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpedcGrX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BA2D5B
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 13:44:07 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5c2066accc5so165696a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 13:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701899046; x=1702503846; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=emWQ//128IChCAhCT/THcHGJcWxhncZjLzE78FXSX8E=;
        b=fpedcGrXN/s/usHdY5n66hpDB178ztE+Biv+HqogR8yk7FHQhvfPAypMzjmwoH3Jeu
         RQj3AtHr6cSmIK5seDqhgno1Nld+U3e1AuQ0Nss7B9j2MgyI3YQhFgesSPTXNhGZtjA/
         Fg2KaITdLEeyAmGyRZJJ4xgRH3FYX57BljlYj58IT475aJWbNLEe2vR5cZ+TnZ8iT5H3
         ji60uCNHum81RoK9CCRUrShJmxjzqXnrA1SstKerWXkQF7lURFNXqwi8UFuNhmSo7lQG
         5bnygjrk58+gvOacllLHSWymXMsoAZMtVUFlgRsJbUF0OVcjXiC/FElWsk2ARgJdtuCN
         CJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701899046; x=1702503846;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emWQ//128IChCAhCT/THcHGJcWxhncZjLzE78FXSX8E=;
        b=F37lThc9rnkCDeptLW86slyjon1LiVA+PDtoSlKg/EVSsPFhd6qIuJNOd1xdXmgQrs
         WZZlXtm0m19PEMP+lxXDWRJWghP2fLtXNN5CJGt66rWmzHNcKESuy+68EEfHfdX3JxF0
         B/3MU1hN2aTYlNatzueITCCSDbwc6wZOk3A0FH8OZxgY1zEAD8mY4FXMQOGv9Dp8AOHk
         42OYPHpxzfMpvh4XjG/5n2hzzqk2dMEHzabvfyYT5BJutWa+R49Ir/3xjV8X6KLfzdy8
         lokJy3PFQqGAlBEt1ivCerfHgMDfBvVnq6unLezCCe2N5hnseEKhah/D1vtzeo7zqfP/
         EgyQ==
X-Gm-Message-State: AOJu0YwrG6Anz3k7PX7Qt+T+jA/8oWKXoKnrAjDOVp5fAMLEaTNjJ5hk
	61mx5+y9x1ppfPT4tmt/W/+7mA==
X-Google-Smtp-Source: AGHT+IF/KxemxaFFxK+8duX7yz47wLjIg4ovMlgkotFmeA6CuhxmgEGVP9MOvenfubO04eLnbo0Zng==
X-Received: by 2002:a05:6a21:190:b0:187:f343:ab3d with SMTP id le16-20020a056a21019000b00187f343ab3dmr1422332pzb.55.1701899046588;
        Wed, 06 Dec 2023 13:44:06 -0800 (PST)
Received: from localhost ([2804:14d:7e22:803e:f0e2:3ff1:8acc:a2d5])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b001c74df14e6fsm267818plb.284.2023.12.06.13.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:44:06 -0800 (PST)
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-23-201c483bd775@kernel.org>
User-agent: mu4e 1.10.8; emacs 29.1
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
 <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, Oleg
 Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees
 Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, "Rick P.
 Edgecombe" <rick.p.edgecombe@intel.com>, Deepak Gupta
 <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, Szabolcs Nagy
 <Szabolcs.Nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Florian Weimer <fweimer@redhat.com>, Christian
 Brauner <brauner@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 23/39] arm64/mm: Implement map_shadow_stack()
In-reply-to: <20231122-arm64-gcs-v7-23-201c483bd775@kernel.org>
Date: Wed, 06 Dec 2023 18:44:04 -0300
Message-ID: <87a5qnhuqj.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Mark Brown <broonie@kernel.org> writes:

> Since the x86 code has not yet been rebased to v6.5-rc1 this includes
> the architecture neutral parts of Rick Edgecmbe's "x86/shstk: Introduce
> map_shadow_stack syscall".

This paragraph can be dropped now.

-- 
Thiago

