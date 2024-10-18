Return-Path: <linux-fsdevel+bounces-32382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAB59A47AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 22:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA35F1C222EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 20:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751E9204F86;
	Fri, 18 Oct 2024 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="M6iZ3tiJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377C1202F9A
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729282072; cv=none; b=nnLqCw1QKHaPkk4TS31LUwaNRITKntKQ5Mi9E1NQJBB9DMU+OxO3xJ59GS0vKTM+lOud5Fn8TMG07QwSPwIMIy8sYiQqIyq8NYBoy+vDK8tItVV2POdyK24DEnfVq6UHpLkoQZvpcv46GPtI2U5FLMKTx9lIv2sqGWi+OADwhgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729282072; c=relaxed/simple;
	bh=ZO3hsoQeWSx7gJmEi2wytltLfuDIGyn0CVhpJDC8ynY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6sM2KNoZo+9hytHjg571EiE3prKCX2rP8IPf+/wzAbHdT72x/5igEwL+SHXk0NR1uKi24Mp4p7LZpsg/qBMBzEhM3uZOkulTDyRwOy8DhmA7TjQygyvdA+LPSHSsgVeFRYK7ffd26OJLgbnRWhtoFmyHwNoZ3DOanSuvNc31S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=M6iZ3tiJ; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5eb858c4d20so1104230eaf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 13:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1729282070; x=1729886870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2DkIfuhsdwdSUlrU7J4N8xyHZxkETnShte4vmMmVXg=;
        b=M6iZ3tiJvppttpmbpXMszhSaoaose5SRAA3eQnRJMM5JlL5DiYg+suW5ARE4M1fltJ
         C+w8S1FjM5HPEe/UyoR53Fqvrglbf6SXWIFTHeWSt5s9P4wlFkNoyrrv6GjsNoJ1RN/h
         drFn+5MBPZ8Cfuhz7Jb/vODK1D5nEMda74m/ziIT4BwzJDVL0qK2dDNUOcjo4pig8o0d
         pvcza2BPAwqxZUbecwt21oMNj6f9EesufkBsqv1MkZS7zrifZfhFXCgGokTrxySWOuMh
         EQDJWbgld8J3apG6Vd3hATfexPInoSFemIx3o4SHsX71y2dkKEQ8gK7xzSnoyfoOg7SA
         DO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729282070; x=1729886870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2DkIfuhsdwdSUlrU7J4N8xyHZxkETnShte4vmMmVXg=;
        b=qNH8Nx92pcKKz3Lmmspy2+lIpD1cwQ9ZFwP7Ylzywo1nu8a0LFl55mmrR8crJ8fQGC
         OwBuPpFlgQnzcHbhlaCRUJjKlnjB/bOm22qhqbhpdXYTg5qFwFV7nXDw6bNN2UxCKriA
         xM66qR55tGMe8H2P8x9z0mLNNRaCPPhVo4Hy3g+vNdt5z4VwGml6CBVsfPaoQm33a1mo
         0cqlqaM77798YgXTdM7OE/P4IEBG0eKeN9DOHzfCkHj1c0W7XVWC2VaxE5codGmlv1ro
         ng1SjvZ3C6xzuJLuuO/y6R0VkQnSH3scFRsT/wh5otP53ByAbJbNfgC9BTTbjvA48tew
         +bkg==
X-Forwarded-Encrypted: i=1; AJvYcCXHePlT+urCTIsEY9I3OlrXNHM5+tuXwEyUwP9RaBhQvZ+g99tqT9nYsbx80b4fO0UVCySSOi7PJRhnmsWM@vger.kernel.org
X-Gm-Message-State: AOJu0YzNybc+SfQAMrjrMu0Z7BelGDhHWaFjbJA4DISPq7OLilTwCosV
	wntefNxIsLjVw0TqN3ahmaaRFruxP4xVXdAeWMZHNfyac4+EOWyCrgzpCmQw4Yg=
X-Google-Smtp-Source: AGHT+IEVjzijweWXatclrDiJ8Ck7B/908jqXQz/6inTtAi7fKXTI146wHT/Sksh/Auk8BRU+vNk7SQ==
X-Received: by 2002:a05:6358:70cc:b0:1bc:583b:a173 with SMTP id e5c5f4694b2df-1c39dfc7670mr241410155d.10.1729282070205;
        Fri, 18 Oct 2024 13:07:50 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b156fef20asm98486485a.116.2024.10.18.13.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 13:07:48 -0700 (PDT)
Date: Fri, 18 Oct 2024 16:07:47 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, willy@infradead.org,
	kernel-team@meta.com
Subject: Re: [PATCH 00/13] fuse: use folios instead of pages for requests
Message-ID: <20241018200747.GD2473677@perftesting>
References: <20241002165253.3872513-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002165253.3872513-1-joannelkoong@gmail.com>

On Wed, Oct 02, 2024 at 09:52:40AM -0700, Joanne Koong wrote:
> This patchset converts fuse requests to use folios instead of pages. Right
> now, all folios in fuse are one page, but a subsequent patchset will be
> enabling larger-size folios on fuse.
> 
> This patchset has no functional changes and have been run through fstests with
> passthrough_hp.
> 
> This patchset is dependent on (and rebased on top of) Josef's folio conversions
> patchset here:
> https://lore.kernel.org/linux-fsdevel/cover.1727703714.git.josef@toxicpanda.com/

This is a really good example of how to do a big conversion, it was really easy
to review.  Address the few nits and rebase and then you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

