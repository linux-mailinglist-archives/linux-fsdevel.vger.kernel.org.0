Return-Path: <linux-fsdevel+bounces-13499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0866F87087D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 18:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A38A1C21A9D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 17:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26BC61670;
	Mon,  4 Mar 2024 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UREnqlSD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2335612F7
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574123; cv=none; b=B5tv1ZrN1CPpkX4bU2TuQlg47AFoS0t9wwb2ZvsfsjytbwUX0gpho+CBCWJ33bj70c5Uvj+5a7XMUXVFF67OteMVQXcxEZb1mIvLlNnQO4h2CkykZmqb/7d+NhX5xiyTGbixbXu5pMmrz+ojbEfh1ByHnSlPTrX9mINr2sJYrC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574123; c=relaxed/simple;
	bh=hU2yLMJMJXbgNEPYfx2RPR8hYlJGjYJqjcguiRszWgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTNVfvYuNASarJcj5e1J5648GU4YOn41cruMD09yh0TUo261j61vL4tM9IZGFXB4iyXDcwsgPumEybjMeeyC3D34cmsClUbwu3FJb470BGLbtBwj9lAdeZCFL6LvlJuNeEOl15WDLTH9MCbh8ICZ3mS+VLdpgu59P+NytcwJDtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UREnqlSD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dca3951ad9so45655485ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 09:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709574121; x=1710178921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M7401r6D2cA71znQdJzF80EF2KfSktKnOfloCrndmE8=;
        b=UREnqlSD958HTAgmrhBip/bfGztwZ8eypIZwaQlGTuInTcMW9AqA9D5Y+G3lR8O+k3
         iLRb64wLgf61g6ucctVm/oMVRqC16j+sIhcBLSQBFW0q5g+VkRoclbb0mWfpzl4WHqfa
         V8+lnGHSWFIqmVAf7zS7nUuwlJRJ3lR2h1eVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709574121; x=1710178921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7401r6D2cA71znQdJzF80EF2KfSktKnOfloCrndmE8=;
        b=isUwIuVY+ib/BFmDdcsr0C4zA+Jt0K9VhUgzkhHE+ZlZ7rniHHhd+0DLwygVeRjIDV
         GOtkIlQ+cyvuux9JzbtZ5ZDpkxQBr8tet+syeCiOrK+A8BvUd2BfN7xqEKc1FUK7Lb+E
         qJJNydJbSH8AX7j8UmaWNBG4heHEVf1yayMCpoGYF9XK5JBfRPinaNWIXc+QAEExLLl7
         6+h3wWOd/jmW+f3VcCk+jHe3ErCaTwmCb0KJ2LlDkp8Qr36ss9s+CMQs9H9/v39Cy6bG
         ASAvUbsLya7tY/IHsmdEXjUWhHAXr8zdKKLvkZDbYfQ+4SsE2ygFiySwW/G8IALZI2Ol
         1z2Q==
X-Gm-Message-State: AOJu0Yx2JVFELce56iGIn7A5EqhuQ0D24kuxz1Zs7i+JLuJkDmr5TaGt
	stvsc6pscGR5JWRG6GmkAF4QvVxJm05WjZoOk3oJRsmxFD+s2wOe27DH7v1D6Q==
X-Google-Smtp-Source: AGHT+IGbjTF4ZKwzOe0VNjsw6UtT/zASPWXIHtUxjXFZsMlGN7NGI8dA/FI7NCmH8IqvtDTQ74pfsQ==
X-Received: by 2002:a17:902:6f17:b0:1dc:540f:c5eb with SMTP id w23-20020a1709026f1700b001dc540fc5ebmr9727288plk.51.1709574121089;
        Mon, 04 Mar 2024 09:42:01 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090341c200b001dd0d0d26a4sm2963663ple.147.2024.03.04.09.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:42:00 -0800 (PST)
Date: Mon, 4 Mar 2024 09:42:00 -0800
From: Kees Cook <keescook@chromium.org>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, kernel@collabora.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	Guenter Roeck <groeck@chromium.org>,
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH v2] proc: allow restricting /proc/pid/mem writes
Message-ID: <202403040940.BAFD26EA4@keescook>
References: <20240301213442.198443-1-adrian.ratiu@collabora.com>
 <202403011451.C236A38@keescook>
 <39f23-65e5d580-3-638b0780@155677577>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39f23-65e5d580-3-638b0780@155677577>

On Mon, Mar 04, 2024 at 02:06:43PM +0000, Adrian Ratiu wrote:
> On Saturday, March 02, 2024 01:55 EET, Kees Cook <keescook@chromium.org> wrote:
> > On Fri, Mar 01, 2024 at 11:34:42PM +0200, Adrian Ratiu wrote:
> > > [...]
> > > +# define PROC_PID_MEM_MODE S_IRUSR
> > > +#else
> > > +# define PROC_PID_MEM_MODE (S_IRUSR|S_IWUSR)
> > > +#endif
> > 
> > PROC_PID_MEM_MODE will need to be a __ro_after_init variable, set by
> > early_restrict_proc_mem_write, otherwise the mode won't change based on
> > the runtime setting. e.g.:
> > 
> > #ifdef CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE_DEFAULT_ON
> > mode_t proc_pid_mem_mode __ro_after_init = S_IRUSR;
> > #else
> > mode_t proc_pid_mem_mode __ro_after_init = (S_IRUSR|S_IWUSR);
> > #endif
> > 
> > DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_SECURITY_PROC_MEM_RESTRICT_WRITE_DEFAULT_ON,
> > 			   restrict_proc_mem_write);
> > ...
> > 	if (bool_result) {
> > 		static_branch_enable(&restrict_proc_mem_write);
> > 		proc_pid_mem_mode = S_IRUSR;
> > 	} else {
> > 		static_branch_disable(&restrict_proc_mem_write);
> > 		proc_pid_mem_mode = (S_IRUSR|S_IWUSR);
> > 	}
> > ...
> > 	REG("mem",        proc_pid_mem_mode, proc_mem_operations),
> 
> I'm having trouble implementing this because the proc_pid_mem_mode initializer needs to be a compile-time constant, so I can't set a runtime value in the REG() definition like suggested above.

Ah. Yeah, so I guess just drop the perms change -- you're already
checking the behavior in the open(), so you can just leave the perms
alone.

-- 
Kees Cook

