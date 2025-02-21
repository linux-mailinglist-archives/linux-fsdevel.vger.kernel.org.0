Return-Path: <linux-fsdevel+bounces-42248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C349A3F7C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 15:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BAA23AF86E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DA9210186;
	Fri, 21 Feb 2025 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSvvOssv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B96320967C;
	Fri, 21 Feb 2025 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149499; cv=none; b=VH2wl3AfkrVu/E1wge/oSk8soPxF4MaONYyi/X3iGg1XiIjRcanTjjNl1/YkQophXHlc1301jS4Ug7dogSSF6rto1123yTEHT/O2G0Dz6yYSlEXwz4P13qZwHP6zszkmosaF7PhrxrbRoeEGxps+1cL47kwhtXyhFgHOUNBYF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149499; c=relaxed/simple;
	bh=KlOFAfwXgVYnkP+0HYSywTYAzwGnknijZouPeXduiOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTvzPff3SudgRPst9DGPF9mPHHJ/E9uI701S3DjDpD9W8lop5J1djNkq5alKSIH+uIQXRaOPgnJA6HTzyotpOU+akGB9KxEHq5bqdT8l1bo6Ak6DWQyy7qGCa5x8y0CeBTX4kE6lIfvqV1Iq1Hdf9UL4NtzYxAzMNUih9fqnKmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSvvOssv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5ded6c31344so3095977a12.1;
        Fri, 21 Feb 2025 06:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740149496; x=1740754296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YaSHAiicQMVxF+e1cjxL0Pgf32H3hq7BXsRBqwBc+UU=;
        b=VSvvOssvGtg7YGEUiGBu2bcBmBDyBMB9fQVcpy+GPfxOZtuBJj4ExpTGRlCd76C6mO
         4rDHwBTDBjh7UZNJ6koBPFgmEzN1wC16LjjbLAPnZizkcL5hi2P41R7f0CJy7XSiIP7y
         H5fMlv4XeBWDoOXpylvTs2m8wY6GJSvWM46Bo9euhUM4E92PkDowFijJ/2zkIl6+XT1O
         FoW4fGiD/I/0XXUmtK37yHoaklzob236PkLfWixicy/VUL95ePaPFA0heqamQyg7pWay
         FheaVYQBRvRDFCBTpJB0zzjqQUDNT5+fRqAcBvJx6PmAavrvg/zD45Q3hvpokItQfmsF
         hd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149496; x=1740754296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaSHAiicQMVxF+e1cjxL0Pgf32H3hq7BXsRBqwBc+UU=;
        b=FzooqNxhK5n/w1dKsyizfXBO64RGOiXBO2lWLn5iVBduMFbB/i2W308Kb101SOQBRL
         +SG39UnUPn4s2MsuuniTgIIZ0NWuR8A5nnYpAXBLPNZL5+U/FyGl3s6pYAAojmlIOJOu
         OZWROb8R+uCriJFQtoCBkcwNkcEXu7ohtVPGyHQn8HDfj7+3/kiw9wMAxPnTRSvVs3yc
         jWQ4F22T1gODOUYeeD0uVYCK5RpC3OWhHYJlZobd854jvQQl6VviJNzQ9+/cF8NaHZ5b
         gRy/umAYoZVQdC2oJCSE3jVDuGeikJDCcK6TiRFnEPZGIgVeDg+edKLMovd7n5Mhnjn4
         rlAg==
X-Forwarded-Encrypted: i=1; AJvYcCUVp3KGy/WTTIc4WtXcAz++EPKVYO+4sZjFz31tastExX5r3mH/k2q7O6INUhHjFOM7CD5vcoC4WYx6vac4@vger.kernel.org, AJvYcCVQjNaQIIrx2GfaxrmYbry2suoeMavQWsUNZ0zC0TIeUDmbgzR5aQBE702uyWyYkEyZQJFAOdy8AHF0E7MEr6Gp@vger.kernel.org, AJvYcCXBF8U/+N7FxTYyl6qXlYNIEmYmgQqCtgvggVnTKjmdSosAoIREl2hPk6kIT9vwvzTnBxhjTWp8jGdRTYmM@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ4y/Ro6StX7lazUtIvQK7b3PfEwOS3FnOrOvgpmzc07R5RSar
	DIyVW2R2xBVTXTZrhb2SV19LPgG/nMut1EkQbZ0rylQNGHYcOMQu
X-Gm-Gg: ASbGncuW4dS4MNOkQR9rJgP7ChP3B7jTDqzNWK8VZO7yUkqY1Jmm+oWiABFxnx8d+tM
	LAEn43dX8sVgofF3FbCeZSwqMel4BuZwkLCBMtgQbUqw869rEFiCln5UJmCb/KLWGfsA5g+p2YE
	urBnMVM/qI8kuF5N/YqKRyIdeuXLpZC3YyDVOEaSe0xEo6Rr3PUhsoKSyIe24Fo8dFoq2ABqJyG
	/YH0QxKAe7fLdK0LDRE9Rw2UyeFD84+ZoPW+9RwFwXH/pZKXnwhC/jYOlCkkT5F/nBvP2WRXcQA
	6esYlw1FOkYrvyu2LDd1110Beuz5S/RwwhtnnHc=
X-Google-Smtp-Source: AGHT+IHZRrShA+k1iG226oPUcIHkWuudqIkFbuurdySBHahKpZucCgMOvOvDNAHTZU5Ka+gDKW42KQ==
X-Received: by 2002:a05:6402:26d2:b0:5dc:80ba:dda1 with SMTP id 4fb4d7f45d1cf-5e0b70df049mr6734748a12.9.1740149496291;
        Fri, 21 Feb 2025 06:51:36 -0800 (PST)
Received: from f (cst-prg-82-23.cust.vodafone.cz. [46.135.82.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9cee79fasm958432266b.129.2025.02.21.06.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:51:35 -0800 (PST)
Date: Fri, 21 Feb 2025 15:51:23 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Ronald Monthero <debug.penguin32@gmail.com>
Cc: al@alarsen.net, keescook@chromium.org, gustavoars@kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] qnx4: fix to avoid panic due to buffer overflow
Message-ID: <gfnn2owle4abn3bhhrmesubed5asqxdicuzypfrcvchz7wbwyv@bdyn7bkpwwut>
References: <20231112095353.579855-1-debug.penguin32@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231112095353.579855-1-debug.penguin32@gmail.com>

On Sun, Nov 12, 2023 at 07:53:53PM +1000, Ronald Monthero wrote:
> qnx4 dir name length can vary to be of maximum size
> QNX4_NAME_MAX or QNX4_SHORT_NAME_MAX depending on whether
> 'link info' entry is stored and the status byte is set.
> So to avoid buffer overflow check di_fname length
> fetched from (struct qnx4_inode_entry *)
> before use in strlen to avoid buffer overflow.
> 

Inspired by removals of reiserfs and sysv I decided to try to whack
qnx4.

This here is the only qnx4-specific change made to the fs in years.

Are you using the filesystem? Perhaps you just playing around fuzzing
and that's how you got there instead?

