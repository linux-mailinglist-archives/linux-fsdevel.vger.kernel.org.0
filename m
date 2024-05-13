Return-Path: <linux-fsdevel+bounces-19401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135AD8C4A0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 01:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E4B1C20DC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 23:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274AA85934;
	Mon, 13 May 2024 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E+9qOxFo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908FA446BD
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 23:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715642999; cv=none; b=R++54cS1945nZ0+XasB9EimRr2mnTGL4kJJW+Igg09t4oyXgwkdXiv/FNwIn9joS9NNsF3ybTDw98Vk//Jf5WAOlOikgRCrYL37gsvo4vz6phZoAowup6nhTeg3Ux5j+GGucTZl7MwfJtGSMHM0e+iZWTIZrc+L8jsmXtzEsVAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715642999; c=relaxed/simple;
	bh=dH2Gh/VfvRAwRMCapomFJKaaLGs4S106axXfgAQnxwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcI7r6NOe3uGD5friYTZdz8/D7f2OTG1u51Tep0Mo2o3AaEyUy+9mq8AK0KAT5q7wy7kmPGVNKLJDBhtVXm6/vcd0vWEZIXUrMOBvZlJv5rlVrlxOSwZRZvjynpEs+6r3Na3URkrAzQw0IcmDQRDq/C0o/vM+I1R1jsmHSRT/Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E+9qOxFo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ee5235f5c9so38046865ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 16:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715642997; x=1716247797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E1EiMHldIKpnCXznyOw68lbbiSInf8wRIhCrNgk+6Oc=;
        b=E+9qOxFob13JIPIC5cT6NMCA2B4ps+qDxxWCfilA7S4BosMJXZysKJQRzHPAhkm6kQ
         IsDZOw+qy9yXTRrE9gCQv/ZBP/HhNkIDrb+7ggPXTgHLZ+yZy8bOgp0eiXbo2ogJQbVI
         9utsRakgMwoYQhiHPW+GUEmHHs2GddTP48p1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715642997; x=1716247797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1EiMHldIKpnCXznyOw68lbbiSInf8wRIhCrNgk+6Oc=;
        b=OeZgQSA//y8un4FyzVPQjXvXOXIJNqpyEQyAmQ6YZOg8LpTx8zjoEeOt6jRgvUz2tA
         B2CNlpYFY3HnYa1OFml+Kzyrs3BYFq9j4B03mW7u5hsW7gQl4VvLzteAqdMYSXrLpgA/
         5uQ+IYHSm1DlE5Pb10U1hb9rOTIQSYJzlJNYYcDTwZ1psW0TgkSx/CoZO+mIoXR1dmly
         YFrcCF7QJvx342VP/KNmkOD7P03WM6Hba9qYYhnXIIC57+nVdLPSnmuQVjqZLwMuE4JZ
         y7djDkl9Wr07FzG9IKTOnq5a/vh4MwqWz449/2NfkL7+edkIUIv1uNBPj1TS8K9TJyXo
         FWMg==
X-Forwarded-Encrypted: i=1; AJvYcCV4PhTf8A3sg+FKtG28cm0g8Om5RaGfepksSfFYFGqwUtYgpiRAS3M09Ju+VbiGfsB8ouyDh1sWuiXQG7wK3Ue/iYS/JYKokMLeGXvj/w==
X-Gm-Message-State: AOJu0YwpsT91wStLdKKjOfW1F70i4ait5cWFag0Y3/cwsNT8OaxmB2Mp
	RcZ8H3mKm6VV1LY2oT+hWNbBrY8zBA7sgBWHp9MSAn5IrPuxGZnRG3kpvyYiTQ==
X-Google-Smtp-Source: AGHT+IHqChMWCIwa2ur3c5lXZsd7v1cl+KVoR9q/GWMdtWIhwTCr3j8ecpny3TzA+YcBJyw2U0Qsdw==
X-Received: by 2002:a17:902:f60a:b0:1ea:a87f:bd2c with SMTP id d9443c01a7336-1ef4405a80cmr134147885ad.68.1715642996861;
        Mon, 13 May 2024 16:29:56 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30c09sm84557115ad.130.2024.05.13.16.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 16:29:56 -0700 (PDT)
Date: Mon, 13 May 2024 16:29:55 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] fs: fix unintentional arithmetic wraparound in offset
 calculation
Message-ID: <202405131629.9C315328C1@keescook>
References: <20240509-b4-sio-read_write-v2-1-018fc1e63392@google.com>
 <202405131251.6FD48B6A8@keescook>
 <q2qn5kgnfvfcnyfm7slx7tkmib5qftcgj2uufqd4o5vyctj6br@coauvkdhpjii>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q2qn5kgnfvfcnyfm7slx7tkmib5qftcgj2uufqd4o5vyctj6br@coauvkdhpjii>

On Mon, May 13, 2024 at 10:06:59PM +0000, Justin Stitt wrote:
> On Mon, May 13, 2024 at 01:01:57PM -0700, Kees Cook wrote:
> > On Thu, May 09, 2024 at 11:42:07PM +0000, Justin Stitt wrote:
> > >  fs/read_write.c  | 18 +++++++++++-------
> > >  fs/remap_range.c | 12 ++++++------
> > >  2 files changed, 17 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/fs/read_write.c b/fs/read_write.c
> > > index d4c036e82b6c..d116e6e3eb3d 100644
> > > --- a/fs/read_write.c
> > > +++ b/fs/read_write.c
> > > @@ -88,7 +88,7 @@ generic_file_llseek_size(struct file *file, loff_t offset, int whence,
> > >  {
> > >  	switch (whence) {
> > >  	case SEEK_END:
> > > -		offset += eof;
> > > +		offset = min(offset, maxsize - eof) + eof;
> > 
> > This seems effectively unchanged compared to v1?
> > 
> > https://lore.kernel.org/all/CAFhGd8qbUYXmgiFuLGQ7dWXFUtZacvT82wD4jSS-xNTvtzXKGQ@mail.gmail.com/
> > 
> 
> Right, please note the timestamps of Jan's review of v1 and when I sent
> v2. Essentially, I sent v2 before Jan's review of v1 and as such v2 does
> not fix the problem pointed out by Jan (the behavior of seek is
> technically different for VERY LARGE offsets).

Oh! Heh. I was tricked by versioning! ;)

-- 
Kees Cook

