Return-Path: <linux-fsdevel+bounces-41102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F640A2AE91
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 18:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86BE7188A4A9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 17:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322071F419F;
	Thu,  6 Feb 2025 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO0sgRpC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59DA23959E;
	Thu,  6 Feb 2025 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861894; cv=none; b=YdSySHnAnYy1dw15Fz6i5b/HqlxFQh7HOiqClNarGOA5ySfYYGbFSOFTl4J7lrbC3xJVydVUYQwP55t3ZKfDYjGtk23gHvYIoGMU11s1ut8E9+/VnJ8RaEjYDVSshauK9WCzXVByBmCd7EtotfYv8wp5Osn4ZYvaLp4buut/x8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861894; c=relaxed/simple;
	bh=oCZqTlL8IhMzYF8QHzAeY/ak68zHXwXuRtUS0SmXuz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOb7lejMKM40sCDibRNQlreD5wBoRi1D1yuHkxlz1YsToejrIQYkjcL8rFBLsRgJowb5nXziuOcTm+uLnFivSjSNogAkDKh0BN5bnnpPreHzavbjx3Oy4E/vz0fqbqHcja8O5iOISbyABJG6LKb8ZniFe7pd1IprQ2LqHek/svw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO0sgRpC; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dca451f922so2623330a12.2;
        Thu, 06 Feb 2025 09:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738861891; x=1739466691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bE95eWjcQE5OCTHKkqWUFtbmyhrYTo+Rwz/i/lM/c7g=;
        b=WO0sgRpCA3/ccS71lCM0u60XwKI6db0Bst6sXTQYf//3lT75ORcnOiDaE8MPlxLQmx
         MHpBdeVAkwZMC5YytDDY1CnejxG1YjLF5E9+yqLq9SkS09oQt2WTe9L2YfluRhyf/LkZ
         DaM24fX9TEkNy2WH/W/RyQTBDXCqOsxsUQFaQj806AXI8Mx7Ogsxc+XFPSBhjvh05IMY
         +ONpYCIOxMzw+38hhr9Z/fyF0gnQlMggmc3vflDwzbXe0GJFjp0VZ9VhNaHj9kP7z+co
         jZ4yJUiI0tiGltX5WfTR4oh4M/Z/Jltoks0yzOp/j7LXdk+FNDVy1YDVqgFuo+Wa/iIO
         xvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738861891; x=1739466691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bE95eWjcQE5OCTHKkqWUFtbmyhrYTo+Rwz/i/lM/c7g=;
        b=QMH5wLGZra1jqPD2BUsXJ+tTxDZp7Pn7xYiE7bYd7J0P2i4+vtGImvIpSrRmavBeJx
         Nbc5WBP8EX0rttcpM3i+adXmh3mJgZWFtuylV0oQw2lgtzwid3iL1JJIU2S7YHzgHSUW
         56QsrOTGtc9iezBVdveRO1ZoLKqaY4kgOz+9iMDR37jN0xp8P57RR4a0ak2REtnY5E81
         xut8omH+bPQhgmpnYvMjRtAuAJ4M/zZsozZSRnandX7o34aGUzjaHkgZjFWbVuMEXF1g
         qYXA4CAcFZL9fiXU1vFcA/ofLXuN8kamnOM0zqhRpWGJW5fbKJiauECTSiAfrUNWYCvH
         dlwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmOExJT6CgWPtDw30IwMqx/6bqPbWmiHZjy7PsJqtMBb/jitEbosxu3qszVapU7GEQZMs3wbatO8OuLgvQ@vger.kernel.org, AJvYcCVi2bjRh6s4GGq6nh5DKWJACURaHR+qXRPAR0SPCkptbjFqKQe7RtBL9t6I4qShJGD57DDfDDEC6UyWTdnv@vger.kernel.org
X-Gm-Message-State: AOJu0YxV9EN6cwKT2X8GXEy5scKUCbJ5LY/4USd8YKWX8lGkADXUSd+U
	YWVmRWUmUEKN9aaLFtBCI4zyQEAdcH/wxwwIwhgZ6IraHvvPeQs=
X-Gm-Gg: ASbGnctPbzpR8xmGL0prMHdlG1b95czWQsVPc/fWnhGDJ84dmXPHZLTTWk5ndciiqcw
	WVIEK4yMUgfconZU3SpCvwInPMdcl3fuJ5Tr2a7mIqhGpfAAz6Ka0xhbP2n+pNTmooGpNuRWvC9
	yzt+AZIPCRITdQiN3E8WlAPXBAXLfdrZDpaQN/IA8gQy9qJTWc2gCelJo4/YNiNbWQubvLnZ6wY
	xJsFkJ8TkW12KROXJyE8d+S6EmTjzJeJ7SvGr+4NqMdEHJc9x4r8cX5QNkoE3Th5PqVD5tffEeE
	cg==
X-Google-Smtp-Source: AGHT+IFFdkpTQN4f13DnbHWNvERA6p3DeNUCNYLOpAIHJbDVaTFcqiUeTYqaJbJypU2eIV0bKpMkLQ==
X-Received: by 2002:a17:906:6a18:b0:ab7:86ae:4bb8 with SMTP id a640c23a62f3a-ab786ae503fmr28019166b.23.1738861890857;
        Thu, 06 Feb 2025 09:11:30 -0800 (PST)
Received: from p183 ([46.53.254.78])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772fdb84esm125075766b.80.2025.02.06.09.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 09:11:30 -0800 (PST)
Date: Thu, 6 Feb 2025 20:11:28 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: inline getname()
Message-ID: <6cfcd262-0fe4-4398-999c-ade674191edf@p183>
References: <CACVxJT_Qy8uWVn5dESZo8LDj_VSLAhkFfxNaTkD6ZwvYARVo3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACVxJT_Qy8uWVn5dESZo8LDj_VSLAhkFfxNaTkD6ZwvYARVo3Q@mail.gmail.com>

[cc lists and people]

> +static inline struct filename *getname(const char __user *name)
> +{
> + return getname_flags(name, 0);
> +}

This may be misguided. The reason is that if function is used often enough
then all those clears of the second argument bloat icache at the call sites.
Uninlining moves all clears in one place, shrinking callers at the cost of
additional function which (in this case) tail calls into another function.
And tailcalling is quite efficient (essentially free):

	getname:
		xor esi, esi
		jmp getname_flags

