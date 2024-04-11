Return-Path: <linux-fsdevel+bounces-16715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EF18A1C67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 19:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95451C216D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 17:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55552194C60;
	Thu, 11 Apr 2024 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RGdAa4ln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AAA134A6
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852507; cv=none; b=DzUULjYrggpsXPFQW7gejtaA+ajcfPaHslZiIyxdGPfoJc82+uGzCAjF36/d/8T8XES9ojdQkYjKk+/ZMlY0OjC5Aqd1y8BfZoghWKEnMNAu5cTx4/oHUgGiFhayTMpJzQLMwsHXZJb0jsCmtMWIZZD0Gboo+rLngOMDU8NZoZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852507; c=relaxed/simple;
	bh=j8D/Z53nu49+HJajrMHYyo77QiNAWVcuqSGJ2wCUdn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlM9myrmxfWR3DBR6Wunr2ZTQ/zt6CjXe1zkGV0P6YNzpdQmL9858eMJiDax59w8TyIQSvBhkdVbbAaFutXHepIAAPKBvI3rf4M95GbyskYYC7fvPg/ErvD3P1MGOmmSuwrzzHVxD+UGyBBoEXMxLYoxe3EFEhNTcNSmBkKRUVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RGdAa4ln; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51969e780eso1002048166b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712852504; x=1713457304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nb6qBOubwpr++hT5NYcUKi/PePjm+psMH2yQSPywASo=;
        b=RGdAa4lnvTgkAW7khWtzRtNQ5fF5aDOSejl6QAt7HDZ+OBSKNoyoEdibGaUQXMPbY5
         FqvAPKiezRml+b/Xdl7FoF8stv//d4sZwFYv13ZkbJ0b04kPCMSRJcxKAqtYap64kQSK
         FmOBG8NRxmsElismgqtfL/500PAfYtHEpIk+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712852504; x=1713457304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nb6qBOubwpr++hT5NYcUKi/PePjm+psMH2yQSPywASo=;
        b=wzuBOIw/z5Cyl6AzpTsRcGkgd6Co1CaFLWjkI8EFcmA1ahTOYD9mxvGDC+2YtTJDWo
         iU5sjAfRPEMpQGUk0ou8wRDCFhwXPBGi95Qjl4DnnjF9q2d6BsrDY+rR3sD1xgEYmrgF
         VZt0I2/J09/JYh62kEdukWYebOe2jRPCRB2k4a8JkXQTw1teFyTLP7jvFVLvwMvT1Vb+
         y9o0R0KDWh6OgKKDPfiZfJvR/75A00TvfMzY0lIllRuuzYPnpZXJhjx1OG6oyA+6YTL2
         UhnfrFwN+WpWloNs2IhNwQjtmpraIWpa1fQFw7Hz7BnKlhsJMcCPs7Osjk4HgqkI8qqF
         lriQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaLFXK6Bi1XU6UJ3gYZllkGOMiDYmcLexPWCtQyI+tdpkxkcjfu8pvZrI9YNmiXNuvy6TP6bZZAlxU3gtLkw6IGLvXnvy8HQvhka8RaA==
X-Gm-Message-State: AOJu0YxLpYwvTEPfCSjY7c0shjSP88M7coMd6J664JlEYa9DnjknDTZx
	cfd0kZXlgcSqDaLZ/eZ5UiLZoPxItd4vayoyEWz6fL3f4adxvIvtiKqOUGGZ684ptSGtmiTLSHx
	FY5YDPg==
X-Google-Smtp-Source: AGHT+IHEt+8SxD4vrv4qoYSuScRl+BVrMdI4mTA1pZFKnN8qdGsd6pi1BbfJ1H0VK5KKOHvp9YLHfQ==
X-Received: by 2002:a17:906:6851:b0:a4e:2178:d91a with SMTP id a17-20020a170906685100b00a4e2178d91amr105818ejs.59.1712852504200;
        Thu, 11 Apr 2024 09:21:44 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id bm18-20020a170906c05200b00a51b403e30esm893682ejb.90.2024.04.11.09.21.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 09:21:43 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso7035037a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 09:21:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXYr2A/2tg7v7k6Z9AttR0wpVMoQAIPze2/XXJECanOBFc/oi2O6C53TegLsJDqFjMId97BGNoEkPZaeQf7VdbN7bAMhC+X3eJToiHiA==
X-Received: by 2002:a17:907:7e8c:b0:a51:abb0:a8a2 with SMTP id
 qb12-20020a1709077e8c00b00a51abb0a8a2mr167343ejc.42.1712852503153; Thu, 11
 Apr 2024 09:21:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
 <20240411-alben-kocht-219170e9dc99@brauner> <20240411-adressieren-preschen-9ed276614069@brauner>
In-Reply-To: <20240411-adressieren-preschen-9ed276614069@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Apr 2024 09:21:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+8Cq82exnjf1HMsDODHwtnTOmfnGPMUf12ck9F-pyLA@mail.gmail.com>
Message-ID: <CAHk-=wj+8Cq82exnjf1HMsDODHwtnTOmfnGPMUf12ck9F-pyLA@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 05:25, Christian Brauner <brauner@kernel.org> wrote:
>
> Btw, I think we should try to avoid putting this into path_init() and
> confine this to linkat() itself imho. The way I tried to do it was by
> presetting a root for filename_lookup(); means we also don't need a
> LOOKUP_* flag for this as this is mostly a linkat thing.

So I had the exact reverse reaction to your patch - I felt that using
that 'root' thing was the hacky case.

The lookup flag may be limited to linkat(), but it makes the code
smaller and clearer, and avoids having multiple places where we check
dfd.

And that 'root' argument really is the special hacky case, and is not
actually used by any normal system call path, and is meant for
internal kernel use rather than any generic case.

           Linus

