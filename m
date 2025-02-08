Return-Path: <linux-fsdevel+bounces-41296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A8CA2D820
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 19:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407F23A723C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 18:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D981A4E77;
	Sat,  8 Feb 2025 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gATD9lyj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A27F24112E;
	Sat,  8 Feb 2025 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739041029; cv=none; b=OWh1BSL+6A6f9GERdjBLxw+rE7hf/6guhQmOHAYFdE2n/CcS/vJN1y6rdfDPsS9Xe1ScBnSvlG3Of4BldK4QofsW4BYRW0ZhYAJXAB45iRjA6VmDDaY+bkjcOxkWZ9oGnmXUBWz2fLloFmJBTBkrc0HMCFCK7d936fIn/TOlBbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739041029; c=relaxed/simple;
	bh=doCWvBLA+TxAbIJ7ZCHQehWhJJgTPR8DjLa0lEiJKmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/w61Mn7DsogqQCjRzeNyT3KXgm03bPn6V3MTdkA723ip2QQzU+xapUdqmDKMaEyQIqrsVM26A4iOjwFv979h96KAdZV3tzeWLSDHREgUAHB+gqqSXPkhX1trxNRNqO8qgy7Na6E7ME+Ax1soIPg4+HELYsnHUAzfAsi18D9TPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gATD9lyj; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38dd14c99d3so876906f8f.3;
        Sat, 08 Feb 2025 10:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739041026; x=1739645826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdUIYEZ6OxCFGuba76Ad1pkRN9bpibysoIyhG0xc+yE=;
        b=gATD9lyjCshLFa7PpYQQn8BX+vr3X/Z4JFRuDAnPtgShBIvJTYPoXykLSph2QhtU0c
         cH12OFid09+Hc3OS+mvxrGlGHs7DKwRzrMLa62DMntYdV8r/nHtHlkFJMLz4JgPPdgje
         EG03qBQmFVuft5lndRjgvShn6sRwi2FZQ1y/d5X81Br17jfNnKevgHkRlFT9BbZ0JtaU
         T+UTmVs72G/9Y5dYhvbSnXMdGd3HZPgleMkvADyT1ds/xb4BLP18RKoSUwnykv+QOmyh
         9cvrPNifogNGTV8sx9ajF/uFbBj34ke+3crYudbzjbdm9lNz3c6rEyeIfFG26DDn2vNz
         8+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739041026; x=1739645826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdUIYEZ6OxCFGuba76Ad1pkRN9bpibysoIyhG0xc+yE=;
        b=NWuiEP+MIfDVYUJ3E6fC6Djeq6/QjjcPJiwW/nOP3WyhjvyZGiHPBSFRWaz2poutkW
         w4iBe+BwXUUycji6prsnRbxfPDwuO1nGTSirdw/nifCv3RNGfQ25RjQEsHwNwq9cqEXM
         ERR4pfq8oPZsuwFq6Him1WRg+1Ko39DTHGmxA76FJVoapuwQiRYB5ZmAMfX+UySh6HKQ
         psIORdXifZgHzmdqbpuIcuIBV/cwyHIBgedhVrwPgtPEnjtYaW1afeEAQPsgsxa8Ttdz
         TUZnqs8ZTfpy0OPIbFKPvqGP2R2h0JE0ranVBQ5cLksYqEkZRPyW9ef+RfwqLoTeAdHJ
         Mmmg==
X-Forwarded-Encrypted: i=1; AJvYcCUN4wBix5u/94lODzEsoTp/0pToCfbF++HMhOmi0qAyiij7TPP8P3671oCoz4LDKlF3aewigFpW386zy8cY@vger.kernel.org, AJvYcCV7eVe1lmavNE0eSVt3yCmlbkf5CHDR66J3cKepgC2FrfKTLAQUzugikSozlfXRu9sQk0Inzyk3TWQfuJbd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4MmB1IoCo/v+E3woseJEJp7wbuVWNEWUbhLvXWebTvJm7YSpw
	bCFDrDG0TN2gWMvm+PKOckZHkn4cjlmQ+PBv1ZV24Yi+uM/N4zSa
X-Gm-Gg: ASbGncuHSJlt8EbOfvE6lIm9Og6atQHY4KaySoykAOE2CiA3w2V4jvznfum7/TCvZ9q
	IWv2SrTuzD+/7NqtLzCnQuglD4DdHR9dP+E6YbYBZ6IMv+uKqpkv5G/Zaz2FHd+enirZLTo26Se
	0X9mohJ14Np2oZsOvUxur+dr+7GPRRVNEiG22m+haLKd5APLiIvGlUUz+OXikEmUeogmAqUag4B
	frybJI4n0jTJJsG7W7mICMS33zAvIebIvbcRnSdNhd2mLW6xKFP0UrJf8Uu541y4623LzvsQR1o
	MMSUGfypaaUe23L0Bg/8jjSD9jw/kLdUX7R2+IdqfVS5qlW2l0hxDA==
X-Google-Smtp-Source: AGHT+IEgH57hapeWB6O35s4Jro2+v90RtJAClrbe9nhGySA9U/QR5Hj2o2se82wFLuS37dL/7ExVmg==
X-Received: by 2002:a05:6000:2c1:b0:38d:d666:5457 with SMTP id ffacd0b85a97d-38dd66656e8mr1614779f8f.42.1739041025423;
        Sat, 08 Feb 2025 10:57:05 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd2ef7efesm2663243f8f.52.2025.02.08.10.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 10:57:04 -0800 (PST)
Date: Sat, 8 Feb 2025 18:57:03 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>
Subject: Re: [PATCH next 1/1] fs: Mark get_sigset_argpack() __always_inline
Message-ID: <20250208185703.066039ab@pumpkin>
In-Reply-To: <CAHk-=wicUO4WaEE6b010icQPpq+Gk_ZK5V2hF2iBQe-FqmBc3Q@mail.gmail.com>
References: <20250208151347.89708-1-david.laight.linux@gmail.com>
	<CAHk-=wicUO4WaEE6b010icQPpq+Gk_ZK5V2hF2iBQe-FqmBc3Q@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Feb 2025 10:53:38 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

...
> And while looking at this, I note that I made get_sigset_argpack() do
> the masked user access thing, but didn't do the same pattern for
> get_compat_sigset_argpack()

That's in the next patch.
I noticed you'd committed my cmov code.

	David

