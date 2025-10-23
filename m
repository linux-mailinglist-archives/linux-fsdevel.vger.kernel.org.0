Return-Path: <linux-fsdevel+bounces-65341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B384C027E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 18:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC39D4F701B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 16:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156F241760;
	Thu, 23 Oct 2025 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hEDceyO/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B70733DEFD
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761238115; cv=none; b=rDiBBAiNEHTkikWC07/5iUDgrpGtADuXdd7Co0s3qzmTf+EIB9lOewcC0JMauXw6pL9RbvXE/qRNFehoUksNHo28Hnuj587Q6Hk3zaU8Cf0aNWwFxWfVTtG0BLe8c+C+f+eShMa2zd+dyJHcFFQvb/H/rhdH691GeW/NxrSPyh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761238115; c=relaxed/simple;
	bh=FYNuNzJQUfALIIo2OS88M9jsE9SMndEp7YsFIxmAfnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qonpc9o6VpaDTk20CTzQK0wanXs7kGvO1d4dqm6BOMlK2OfBnQKh59ikhB7+e7PcAFUysjn2oh/60RkEARYWt+Cdyr9vueRVcZ5QSNuJ0U2jm+pyTiUUE0mz6jN9mnrpKzndqAoqFFHz2GbEvv2UcDvvbXJ13JR+jp1IM3jybAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hEDceyO/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso1959669a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 09:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761238111; x=1761842911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1hwlgH/Jwm1lgsle2AVf57DwDHh4FIJzLxRgZAsCOEE=;
        b=hEDceyO/wybL7E3lnNPr8mA9Lfjz0sfyP0mYgncLuA2vRlaH99DjR5NTgOltqQrImj
         EPwVZthxBn2NSi9VjSL5x/QI5Me7wOvSBNWlHHFvr187Ec4B+Zx58IzRZgFjvKkg135h
         23sTZSo2aTBYfYmxXKNHlmswfLJAHGVIH+46U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761238111; x=1761842911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hwlgH/Jwm1lgsle2AVf57DwDHh4FIJzLxRgZAsCOEE=;
        b=AsGiRkJUlKb/nl/BB5QynjCDgaB1BzpphNXTNRM5rmx2CQshwvw5JYPl17PBfXtPN5
         kcEX7OTmMzzMVljT5KXY8ruMAFaoJG+FxNsSMGFBP+YqjtdgZvHto2wgFiLAhC/nKtHF
         B1bDkbuGRQM6aAwZLyRAKlhM4xxf25oXo23RJgnnTjg40NK3sT6St3hd/LDV1aA6L9Pd
         Tad7Z3ByqqQ77y0i9Ti7WTixbzR1TR2myUVdIrZJB2nRCAHHz0v64tpS+bcfIaFnDOWe
         3ZYlchv+mR6xS53NTTjBh2r6zON2LuMdNvKV+THhhyqijsjyPX/f/LQspMgWoXrWIoH7
         zdvw==
X-Forwarded-Encrypted: i=1; AJvYcCUXChHLWHFJBdLBOozcjzlBz7x8MYHhXZNObhCI1e8XnEFkrIvz4vJzHIhO+ORuzJWlZzkJu91EuvIijd3f@vger.kernel.org
X-Gm-Message-State: AOJu0YzakBYyHZPJytGs6hWbfXm1q12CKZeH7wHKnSdhU7Z/nutrELFs
	h5g6nOBTs6GozAN19t3x/gqikYvA/hF4zEs9KkzIuNeChpXFHYyANOaeAHc1e0cSB0x/AIq4Q9N
	b69rxickcwg==
X-Gm-Gg: ASbGnct2TREDKPEA9tIYT1qjc2Q8nHam7kjkzzgMo8vJHJxGoCGo32PCbcAkbKfkPAg
	jdajOz+hSTQZV2yNBGvePkRfHKByQsbhIbaHxhrVcC6IdNIFlC4afOyf+oMzNvlXdf9ENzOSgBU
	g9mljt9DVLWfNzmRPuFrcf3Y/O5aDJthB2M7oLVC80eDvBtkrLf2gdr2P2Xj1O4rHbJwZ3R6m9e
	XK+oHcw/V4MIwOiNve7Aa+yrQ/twcXYTseqeNt3aDu8Q4EZd2SeWTSkitFsWX0EZ+eenxen5dW9
	Th7moieFkbQiSIdcDgKODyATPL3aVoaOKtj/y7FOJaLID3P6QgXtDQnAsQJveuBDhJMUF8OU7kF
	BnBifDT4nAI/z7knFzuUnO7SgRFRT4MkvvqgxhCEZzJM1BaO1D7FqeeCx/CSMtddykRoZ4D/Usm
	zaa59zKIIK3pAlbbZlr8qZq3ZMJ984fWJLVypOu4CnDLYRq3Vrrw==
X-Google-Smtp-Source: AGHT+IFgd7zhiK2ygnBlL5a/kyfgi1vmyPMYm1i9cOCFja8WCFw9CRPmS5Aiqs8axAh9bPZn63HFzQ==
X-Received: by 2002:a17:906:6c89:b0:b6c:38d9:6935 with SMTP id a640c23a62f3a-b6c38d96acfmr1135882166b.24.1761238111375;
        Thu, 23 Oct 2025 09:48:31 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d511f7d38sm260344366b.24.2025.10.23.09.48.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 09:48:30 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so241807466b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 09:48:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTh4eF59IGNudbvFKVVyGTw3suxhKBvo9qpTc3oTo7lVpTmW7hKA6GgOxWMVYYJMwtmkTAuHGcw6gpSgsv@vger.kernel.org
X-Received: by 2002:a17:907:2d06:b0:b40:cfe9:ed2c with SMTP id
 a640c23a62f3a-b64769cd245mr2845599166b.64.1761238109574; Thu, 23 Oct 2025
 09:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023082142.2104456-1-linux@rasmusvillemoes.dk> <20251023164408.GB2090923@ax162>
In-Reply-To: <20251023164408.GB2090923@ax162>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Oct 2025 06:48:13 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg6mxof1=egFUDTNEj3__tCWLTbKjYLzxipVCn6ndXr+g@mail.gmail.com>
X-Gm-Features: AWmQ_bnVmNdsK74q7n823FaHLDwrv3TDkm2pnoZHMOtAws8D_7gQ2A_MzQsBWg8
Message-ID: <CAHk-=wg6mxof1=egFUDTNEj3__tCWLTbKjYLzxipVCn6ndXr+g@mail.gmail.com>
Subject: Re: [PATCH] fs/pipe: stop duplicating union pipe_index declaration
To: Nathan Chancellor <nathan@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	David Sterba <dsterba@suse.com>, Nicolas Schier <nsc@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 06:44, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Yeah, this would also be a good conversion example so we could include
> it in kbuild-next with the appropriate Acks. We probably do not want to
> take too many other conversions in the initial pull. If people really
> want to use this in other places for 6.19, we should probably do a
> shared branch for these changes that maintainers could pull into their
> own trees.

Yes. This is a good example of what the use case is and why we're
doing this extension. So Ack both on including it as such, and on the
whole "let's not go overboard with other conversions" thing.

             Linus

