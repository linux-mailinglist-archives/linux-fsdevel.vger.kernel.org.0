Return-Path: <linux-fsdevel+bounces-10612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D96684CCB2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 15:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB8C1C2547F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 14:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670377C092;
	Wed,  7 Feb 2024 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IeGPdI4T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF27E585
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316008; cv=none; b=WxB6F7ffBdPNLrr/mECRHfsx7z1/WRUbDt1XBoefhnnA5ltzZyobh6F89LvQJ51hJ+y63ByBBw3SGVAzhSwcKRVM+uY20u9QSQWBdTIIAKeQ3yAndO5vC9qRbksqVA+ozCbvS+KIB2e5uXijPzEqbzT/LhS8an+FCyyRWWfEKRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316008; c=relaxed/simple;
	bh=SzNba8tns2PjOCy+3sLZurxF77k6eo+WRElh5iR4ztI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qf6lASgtP785hyjoDxkwRXF1J0ZKOej3Tf2C3fwOKsobWyE35V/CJ8hHRT6IrJGIrqybc8W1wRdgxzNXgWyraBkuruxIwMHy9SsNvCvfzVCHiZzdhBlEZXkppQZ9lCQHF6frMd9B5Nr7Uo0jSftOVv7vNSgA7m1DPUCK22X4P8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IeGPdI4T; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e2b48874e7so286198a34.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 06:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707316006; x=1707920806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b35sBEtbFqh3Pg3VieC4+YWlOps4TFS92ag8IjVB+58=;
        b=IeGPdI4TFeAM4ulxEkU2gHnhbbQ8pGMCY83nA4Fvy8kjJUVTAIFOB77bWFuYks4XO1
         Sv2S6PhKyJoifHCQUjHM8z2RYOOP3lt/wdeTDABY4xa2Blk08pu/94I5mCl9V/WiA8rT
         FS58FahLkIwP+3AuhYGXsHmuwNTIVVPB1hbWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316006; x=1707920806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b35sBEtbFqh3Pg3VieC4+YWlOps4TFS92ag8IjVB+58=;
        b=ScSowRYZHEKbnF/VRvsntdZbyR52psbewCbzidMa1cU5cVYp2rpUskd0ufaxPnDiSg
         bEbY5mv+ovC3tfhHDPrfHjcgoqgrPPRAmpa0w5XZ7nK7qgNLUdbFQIkuhG5oQVpIKtr4
         UplXL0b3NKL7vS/GHUK/A2O0ICsaxbNVLXyzHinp+vlotd5LFUVpQJ6c3XYDVvE35Kn8
         2//xQ1OZohahMTzFLyOh5Kr5d4zLcRxWscSPnyoHTWeUaMh0VpVyqLh/3qa3kHwcDVLv
         znNlcTPhgQdg4m48DWLLy0wHcL2xpUvyM7cQHmBkwBXvw0lINR+u30czLN07WXoMO0Jw
         SaVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4vZzHyHtGbEJ78cxctKSwF+ds6GQfrRLiOtzcJK1T/hCFIprtHUDSn3i4G1svtO8Uo5KDs/obDYRyVJol8bAlxkatXWSPd+oZIzefew==
X-Gm-Message-State: AOJu0YyGBwlTvqfpJpB2I193Pj4O1OBaLdBXlcXHRGXFLewHztUVrQdm
	R98ncRuFS5modFHD+2rwMsHeIqPj21j+K4QJSHldQOVdBliceRm3R8w7QcGsOA==
X-Google-Smtp-Source: AGHT+IEDOylu231KDIh4sMA3cVAttvp/AJwj9dEU0mykM819lTgyMUQoFPhnukQ5YsRpK9sDmH7kfA==
X-Received: by 2002:a9d:6b1a:0:b0:6dd:e95f:c6f5 with SMTP id g26-20020a9d6b1a000000b006dde95fc6f5mr5343343otp.37.1707316005810;
        Wed, 07 Feb 2024 06:26:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXGaj4tDR3W6GsuU3ECICUkCbx7bJKhuRe0NK/6JLYesRSbPGzMki3W55ANLUNjbvrac72TncJNOFcFyxhY5rqkQOqOmFajh3nJ/NBiHUKABXgQEYGj/cQhTUF3sTOC9CobPXIaDkuuT0XlUN+uqy6itwZ9NhhKdaC2Gx4Zmu7OPZlhkGBgLSigoppQ5sXWiaubs1ryxuIhVxSP3SGzYFpoj5/FO8LwPJ2MlwMVeR121h12q9xZusZ13My+Bp9Ya+lydQs6FoHKzyenMw1kpRIlJcqejx0fbbQwb0OYhPsedVnlNdXIqidxnSQAe3VU2ARyuovlR8nHSmO1UtvGLIz35ZxzbnnjnRlUodi7ppxgTPBqO4XmzCor85xaKLN
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g24-20020a633758000000b005d68962e1a7sm1563691pgn.24.2024.02.07.06.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:26:45 -0800 (PST)
Date: Wed, 7 Feb 2024 06:26:44 -0800
From: Kees Cook <keescook@chromium.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] fs/exec: remove current->in_execve flag
Message-ID: <202402070626.C4B0476A1@keescook>
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
 <c62a36de-716e-439d-80a2-57e6a3c22db0@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c62a36de-716e-439d-80a2-57e6a3c22db0@I-love.SAKURA.ne.jp>

On Sat, Feb 03, 2024 at 07:53:39PM +0900, Tetsuo Handa wrote:
> Addition of security_execve_abort() hook made it possible to remove
> this flag.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Yay removal! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

