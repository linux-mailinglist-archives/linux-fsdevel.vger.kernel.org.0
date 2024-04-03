Return-Path: <linux-fsdevel+bounces-16050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E41278975D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 19:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD66AB2692E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 17:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638AB15219A;
	Wed,  3 Apr 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TCCp6BSw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B28D1514F6
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163596; cv=none; b=JPMRbebkaIGHqE4Uh4SqRJldNXAgKTbRzWzBBFKQWKaawTgTefvP0T2o4l4PwB5Gn1r4kJn5INf//hN6RMsgEXgXyyax97K15WO2+6QDaMQMJ2aoAuomSfDt3NWIhqhhhuznJ99rAEZ6wfU7P3fVrK6P6Zw1LgBmbKEVSJ4Yd+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163596; c=relaxed/simple;
	bh=1QHEDPpqFRVTaMitRFRECKns1ULA3ceFkMwOdLkg8FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbUqYyIF4cLqQu8QtqaNW8wRIEB6CxclmPo/LHGCBduDarVxPQGL2YerPHAjZqQYhJxE50Uhav3j3PTBxEJztTUNDefLiDhG6XA3e8pp3eL8M0Cp2yIn3lZRMMYLB5CL9TexM+FPGSVG8lxdta5Kz1Fx8D6/BfH4+xVeqbIZuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TCCp6BSw; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56df8e6a376so74533a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Apr 2024 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712163593; x=1712768393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9zZqVSe49xG+Cuf6x2/pIzSVIeoqPFNTQJEfQlqHLac=;
        b=TCCp6BSwTIKImCa6ejUZOPRl8RsaJEURQMAwwU7IHez/VMYlGRhnn9pSN9ctNafl5+
         6iHtQuJA4ZXkg4Ce42HjQ660rSmAhMRbGLX1VBWYeMrG/P9SYdN7TXCF970dSrzMsUPd
         a2WRC79HWKBeNYRUnQL8ddgSmlswDktck7p7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712163593; x=1712768393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zZqVSe49xG+Cuf6x2/pIzSVIeoqPFNTQJEfQlqHLac=;
        b=JTh0nY6DTzF5gQHYX5OEE5q/fDLTU7GDeK2obNKkl9tXXusPKwobBrdy0ueGlwH2lo
         EqTXUB79cxeIdT7CqVoAY0BRHyXxGnFmQX/d1qI9I7jj+UWOS7aN1n+jHtgE9DZhP6a9
         y+x5hLMAsjuCJSHMyCR8XMGsvn6mL+OosVvjDYb6cXgWsg/6+Sll6pNQ0tiQbcznEFar
         W60EM0ELkL2bWRW1hx6XwzLS6gOM4Pcl31wrbDkmm1/aL1oFaCUI/qRhiupYxBlxAtiR
         8ngUNMqnk3mDXh80B2bX1tWqcYB8Zr/ikyZe3Wx3vuJqnoVWlYAK4rTDOcDiz97/Moeq
         ZXlw==
X-Forwarded-Encrypted: i=1; AJvYcCXkCpdhoHSvgZNwMvYW29114SEQ5uSjmhTT5iGYKBcA8R+CZoxI8hTA+lPQsMky8MjZaoDuwywBnQFu6WpO3DI4SHTT4kGl+BdEUvHNCA==
X-Gm-Message-State: AOJu0YyI+6NYBr0jmCWW/mUB0dEmQLebhTFB8PHSxJYvg0u402AThSqU
	GQODOoa2byJIPOtM82ius0A2STuRRGlbMQK0Rd0+6m0J7CMSaUIWpC1iRuc8fC6cDoZXM1ilmgx
	+1hWo6g==
X-Google-Smtp-Source: AGHT+IFB4Szd2FG8tJsaD37v+0dvP4YfvljwpNTHYBFfTgwoERkTelitbKx6isu/tkPioxHJQS/j8Q==
X-Received: by 2002:a50:c059:0:b0:56b:d013:a67e with SMTP id u25-20020a50c059000000b0056bd013a67emr202803edd.18.1712163593330;
        Wed, 03 Apr 2024 09:59:53 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id cs9-20020a0564020c4900b0056c56d18d07sm7810903edb.48.2024.04.03.09.59.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 09:59:52 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so2159147a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Apr 2024 09:59:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaFuoEKsis374pWRcbGGlKs/9P+8LMctsAQICqvzpNTPrwbsoVcxnJVBUb203eRjZX/KkT5s+zZDM9ZjS+0fJOCDL4bYTeH+V1Fc6hkQ==
X-Received: by 2002:a17:906:4f0f:b0:a47:3afd:4739 with SMTP id
 t15-20020a1709064f0f00b00a473afd4739mr2945922eju.6.1712163592316; Wed, 03 Apr
 2024 09:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403090749.2929667-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240403090749.2929667-1-roberto.sassu@huaweicloud.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Apr 2024 09:59:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjG-V-9USyDTWqUhY7YxEwSfwC9yA7LJkT7uGbHHFZeYQ@mail.gmail.com>
Message-ID: <CAHk-=wjG-V-9USyDTWqUhY7YxEwSfwC9yA7LJkT7uGbHHFZeYQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v3] security: Place security_path_post_mknod()
 where the original IMA call was
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-integrity@vger.kernel.org, pc@manguebit.com, 
	Roberto Sassu <roberto.sassu@huawei.com>, Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 02:10, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> Move security_path_post_mknod() where the ima_post_path_mknod() call was,
> which is obviously correct from IMA/EVM perspective. IMA/EVM are the only
> in-kernel users, and only need to inspect regular files.

Thanks, applied,

              Linus

