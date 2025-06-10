Return-Path: <linux-fsdevel+bounces-51110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25813AD2CE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 06:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0C977A7F1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 04:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CB325DD12;
	Tue, 10 Jun 2025 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Aj8Rjr//"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E711442E8
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 04:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749531368; cv=none; b=JSCOhj3h66loXixi45Lt/T/iQYnWdjOSAqifIXFVgZIJuHQ/qV/iv08mhADiobk+E+VAbqNaaATM1xBz7DGZ1xDtr1f6+aXgXJUZEFRJEVOfdddKc337ONk2YVZRuvlkYYuEuKT12+zAHLqIYembK8DGv6yK7UPUGxOQOqlnsy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749531368; c=relaxed/simple;
	bh=ACrPjCNMNkwFDXJy7gnBW2xPAwHaQ0JnySCEiCWvtMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfHkXiWLR7rjoDD/aVlh4bk916P6/ecKTm7r384AjZTBpxERShn2H5anp5hisrwAZSnHwe/4uaKN+70e+mRE2ODcbvReZJi5dhSg4KTU1cJTo0BhJDfbsKN1D5iIfyOgf2paByanQQ9HvX1rhU2EPFpbsduuT8AglrpmXgaB5Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Aj8Rjr//; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2d46760950so4950515a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jun 2025 21:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749531366; x=1750136166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qki4u1ARte4A1FCY+DBjuYiE3kbSTbsi4JExJG2FT2E=;
        b=Aj8Rjr//ohdp+oCP2hGvLID7LSE5WbbWWiZOQ/2ylF5AGNgr8QYAqCJe7DpZQvFpBH
         U2RLw3grYXnvy196Z/kg/LdKMWa/gdYcyLENoACUiWYFMIAbYhaLdJXv1yugT+K5m4SG
         tB6mUklR/pc//90QoDmKKuUoylbOgjlDKzJ/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749531366; x=1750136166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qki4u1ARte4A1FCY+DBjuYiE3kbSTbsi4JExJG2FT2E=;
        b=psIr2GNggNIZL8WwYr7hfzqO8VdUCdhYc0FCkruHDJAovX9INj7tobh64E7O/CpTBh
         1Z/MR0e18lfFWkkjftcfyqA35DivUxmoF0k5ghDseVI+XunI5jaHBi+X7/REBd/OIt0u
         exkM7vOW5Vhn/onhKCb4Wl4LjWALmjA95KUOnqNXgbQ02gmNhFvTW8qTxapIS7/pEyv/
         Nt8zNyNnHzvHtP21I4bQwWmCnPvOEH9kmxZ5t3grgSH8k/hH4utpUTlHntQCTwl1x+Ul
         nE8igxNgpyGD1S6rITQLdKuHt+33JEnMNz2KQKX5i66LMUfH7/ADrwYz3SzuSf2mYt0H
         27pg==
X-Forwarded-Encrypted: i=1; AJvYcCUdhDK5ihS3Ou6ZicBNpfTzvNNXJudZZKb3pcJJ3YCC0M3pZLvvCPLakX9jWzzX+RIiS+ogipvVCEkPw1JX@vger.kernel.org
X-Gm-Message-State: AOJu0YwKCHzDhxeFYiYsWkMTiXvqO48GtHCygVvrLWw2hZO/q2VpvDnL
	Lc4InwCQh4kqGAR83FlIFAtCEVS4uZzZ5lv2ADEhlcmrVsQ/PXXCC5vegx2WgRC+Kg==
X-Gm-Gg: ASbGncuSncA3rzYeDuceN2xOAERW3+D+eIRH+rPEI9fROjFm3Q1/pkB8M1klcHLqv5l
	N3SG6H6wB3Nhey0vkpAN0YXNzZYQzT6jidXviSUA0RZBsnt3SLlHqy8UwzapNmpZUQLicNhecLJ
	SermenW1pJAbpt+nqVr+v94UVDjNafOjK6Uv2MeFoKi1ViBcq+dlbrGW1ODczZ16mQN2wsq9z7Q
	wErLRjel/sTpma9QFlwZHfXYbmCRG55ccwZoSKPoQVoVQL9sg/YTicZqgD1PrzaP+NYYsaQfWba
	z8vZNZtOcr+3wF4Lu8x/ACILYmbGtr1+wt0bAer5/fNmyFFO8vvHiBER8jSLseXwuA==
X-Google-Smtp-Source: AGHT+IFSDAss5UN+FP5CfZ0KjyYXiBlN9b2UJ6xKVd1D/6YzHaiPhv0TdnCukpQpMXZECc9dafUTWQ==
X-Received: by 2002:a05:6a21:a616:b0:21f:5532:1e53 with SMTP id adf61e73a8af0-21f55321f30mr8226224637.33.1749531366270;
        Mon, 09 Jun 2025 21:56:06 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:ca42:1883:8c66:702e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0847b9sm6815101b3a.104.2025.06.09.21.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 21:56:05 -0700 (PDT)
Date: Tue, 10 Jun 2025 13:56:01 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fuse: suspend blockers
Message-ID: <chiicm5lwiok5ni6evrohkjvmt3upy5ikm7vdxz5ukops464kg@vf7hr2mprg3i>
References: <jofz5aw5pd2ver3mkwjeljyqsy4htsg6peaezmax4vw4lhvyjp@jphornopqgmr>
 <CAJfpegtNB22Dpi=wX8nBDx=A9SeYZKpZGniJHBBxJBHB3o0nHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtNB22Dpi=wX8nBDx=A9SeYZKpZGniJHBBxJBHB3o0nHQ@mail.gmail.com>

On (25/06/06 10:26), Miklos Szeredi wrote:
> > @@ -241,7 +241,7 @@ static struct fuse_req *fuse_get_req(struct fuse_conn *fc, bool for_background)
> >
> >         if (fuse_block_alloc(fc, for_background)) {
> >                 err = -EINTR;
> > -               if (wait_event_killable_exclusive(fc->blocked_waitq,
> > +               if (wait_event_freezable_killable_exclusive(fc->blocked_waitq,
> >                                 !fuse_block_alloc(fc, for_background)))
> >                         goto out;
> >         }
> 
> This looks fine.  We can turn each wait into a freezable one inside
> fuse.  But that still would leave core locks (inode lock, rename lock,
> page lock, etc) unfreezable.  Turning those into freezable isn't
> realistic...
> 
> But a partial solution might still be better than no solution.

Thanks Miklos, I sent out a simple patch set [1]

[1] https://lore.kernel.org/linux-kernel/20250610045321.4030262-1-senozhatsky@chromium.org

