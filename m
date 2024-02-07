Return-Path: <linux-fsdevel+bounces-10614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A1F84CCE5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 15:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E6E1F26A32
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 14:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E1B7E772;
	Wed,  7 Feb 2024 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZAD87+K4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D17A7E765
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316498; cv=none; b=FxQSPN3UezUXaceKILBT1bYAtSD+WXbPTFWehXPegn3LH0ZV0mSo+KYtvY13UXHFmDn66ZdrJV/LHLnTgDL6mlwOm9SlyGH+WnNqSr8sgq7dWn8eQZzpOU5f3NB5GLruQtVbfiVo8vwHEyV0qBostC9TRRR0lG5rv4N4NPlVvVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316498; c=relaxed/simple;
	bh=tdwh1IwErse1HmUo9Au6zB1zOVIh+JAIkT2kw/cysnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZsMeqhW94BeLKFWu4CYw9W4LJcSMra/SFcp2y/bCLfyNPi4xiGtVamM1pSs1S/nX3U0j/nQLq12CcMfkf+D4Vjk44fBBHtOOEmcwZbxI75wzI/OwChGWwY8kfMBSvBQU/SQOs8th3+lPdKSsHZcC+8X3yJTc3/1CcEsVYmvoQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZAD87+K4; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6da9c834646so558339b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 06:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707316496; x=1707921296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3R8hD3LqyYlOdsZNUPeAOakP2zt0WKnTjsDWlY67czw=;
        b=ZAD87+K4uFXA+xaSYcGaTnJzmvepfTfA1i6aah1bq44QOJ7IrFwQi5+fbLCa2vNHIK
         0eduOlP4mI3fAnzlEUIWu/cl5lSYkR/XG7ih74B1/wRev6MAAzw2zUgTMxhwnDgbQOTX
         lVHLBmrwCvSkRhYUwT1dYOQHCL0P96aYx6ems=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316496; x=1707921296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3R8hD3LqyYlOdsZNUPeAOakP2zt0WKnTjsDWlY67czw=;
        b=HRvYnTRfaFtaSIMPoOlkGqNklM5S62a4mejWC6Vl6luYAZ6V+vzLPVen9QOGudUAmS
         0ZBcYq7sLFHOUHN+XPWOU+nsfFrcsSrhhj89HS2r4AX2/KfnJWT0luhV8SUWywN0B8tK
         tWjhWwPRqyNu1YifWn4g8OfC1TSYTbAs2zprhLpp/E4OBtue0HsWdvbF8l7XozvzaTB+
         0Vl9nzZWccKVFKx1Lj/apuDwYlLs2hbZXiz22A25D+pGNz/LCVS68+IDiguLmrNwroLS
         Iqd/4Ba2V2a8J4xoy+4bboWMS8WK6S0E/+e/bne7KG9AugyUMZ8nip5LWiq8TvUQpqRa
         gRHw==
X-Forwarded-Encrypted: i=1; AJvYcCU7jZnd3WDLRA+LBtU1nd5G7tfDZMw7LBKfX43JHEG4o9f1GP/dw8PC1xImltCl4bQG4ZbfiiL1grSSOk30g4WeicGZJYRdh4201KMo7w==
X-Gm-Message-State: AOJu0YzilxVEPRtGu/VGEcV5Hrd7PxOJCdJgZQoMGoOKMQtty1AFr5mq
	zuJzga+UQUYBD0G3soMW9SvT3klCO75w0fEr6j5mBYrOSlR26teAPvZurd2oCHGkV73mZgno4SY
	=
X-Google-Smtp-Source: AGHT+IFLN0XTJrm1FUZSe42FPH8mZKyju5Oldd8AwEeWM2Hi2DzwW/SrXJe1h8jh2+iZLp+GVLYz8Q==
X-Received: by 2002:a62:ce44:0:b0:6e0:54bc:3591 with SMTP id y65-20020a62ce44000000b006e054bc3591mr2664142pfg.10.1707316496274;
        Wed, 07 Feb 2024 06:34:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1MSnZssNcOFyWSASvEJmCtF//dSlLKb/4xNtF+kn2PJ7FhkKbjeic0Jg1UAIPkweoy/XZNzKNzPWznQymiFuWJJkJ9A6+aQrm8ueV0Cakc/frHENuPXvmu6psyj6jmFmlnAADEkvYBnX6zQvwCETO1EgW+1ZH3Oe5QoxjheyVhD88ZhDDeXurfq8qZ1iwc60qT8w=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z1-20020aa79901000000b006e063fe6b1dsm1620884pff.100.2024.02.07.06.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:34:55 -0800 (PST)
Date: Wed, 7 Feb 2024 06:34:55 -0800
From: Kees Cook <keescook@chromium.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Paul Moore <paul@paul-moore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] LSM: add security_execve_abort() hook
Message-ID: <202402070631.7B39C4E8@keescook>
References: <894cc57c-d298-4b60-a67d-42c1a92d0b92@I-love.SAKURA.ne.jp>
 <ab82c3ffce9195b4ebc1a2de874fdfc1@paul-moore.com>
 <1138640a-162b-4ba0-ac40-69e039884034@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138640a-162b-4ba0-ac40-69e039884034@I-love.SAKURA.ne.jp>

On Wed, Feb 07, 2024 at 08:10:55PM +0900, Tetsuo Handa wrote:
> On 2024/02/07 9:00, Paul Moore wrote:
> >> @@ -1223,6 +1223,17 @@ void security_bprm_committed_creds(const struct linux_binprm *bprm)
> >>  	call_void_hook(bprm_committed_creds, bprm);
> >>  }
> >>  
> >> +/**
> >> + * security_execve_abort() - Notify that exec() has failed
> >> + *
> >> + * This hook is for undoing changes which cannot be discarded by
> >> + * abort_creds().
> >> + */
> >> +void security_execve_abort(void)
> >> +{
> >> +	call_void_hook(execve_abort);
> >> +}
> > 
> > I don't have a problem with reinstating something like
> > security_bprm_free(), but I don't like the name security_execve_abort(),
> > especially given that it is being called from alloc_bprm() as well as
> > all of the execve code.  At the risk of bikeshedding this, I'd be much
> > happier if this hook were renamed to security_bprm_free() and the
> > hook's description explained that this hook is called when a linux_bprm
> > instance is being destroyed, after the bprm creds have been released,
> > and is intended to cleanup any internal LSM state associated with the
> > linux_bprm instance.
> > 
> > Are you okay with that?
> 
> Hmm, that will bring us back to v1 of this series.
> 
> v3 was based on Eric W. Biederman's suggestion
> 
>   If you aren't going to change your design your new hook should be:
>           security_execve_revert(current);
>   Or maybe:
>           security_execve_abort(current);
> 
>   At least then it is based upon the reality that you plan to revert
>   changes to current->security.  Saying anything about creds or bprm when
>   you don't touch them, makes no sense at all.  Causing people to
>   completely misunderstand what is going on, and making it more likely
>   they will change the code in ways that will break TOMOYO.
> 
> at https://lkml.kernel.org/r/8734ug9fbt.fsf@email.froward.int.ebiederm.org .

Yeah, I'd agree with Eric on this: it's not about bprm freeing, it's
catching the execve failure. I think the name is accurate -- it mirrors
the abort_creds() call.

-Kees

-- 
Kees Cook

