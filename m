Return-Path: <linux-fsdevel+bounces-60966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FC8B539C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 18:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15BCD1899A45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 16:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D692C35E4D2;
	Thu, 11 Sep 2025 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NUhA6thO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AA73115BD
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609798; cv=none; b=GrfwufALB6YuqLQAXgRFPDqZ+45ukPu1dy2MxowgBaut4zZq3vDDjatS5I33rjuyBV6qgzQd+DAn+i+Cld0328X7yFo/2ZdwpzL7rxthKC23QV4RROWDDkC1e2BEDUMTstxefC0FQ/qGgERy5CO2RV6etODcLsFQFWA/M9pDOvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609798; c=relaxed/simple;
	bh=xBZRVz6PARR1TaFj3HxYN+PJibH+tkD4Ha4ojpsPTRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3hx0+nW568Xnrluh3Ud2+dIbBCcMzIKFaZ4uu/zpUe1nbMU2tDBkO91VqfFQ5n6YREOAfpCCApTPzwGDiX0vI3dHjlIyg70BIfaQ9H8R9ABzQMvDA3noUp0LJeQ2UrTwEiamCuO15jR9/kikBZfFHb3/nKRSFW++WAfPsKPt+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NUhA6thO; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6228de280ccso2062672a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1757609794; x=1758214594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GPti7ycwxDijfbNVdZ7d+tzQdPTkPvICaHZpGK8FY2E=;
        b=NUhA6thODzl5OpURmQ+3J2fi4oFlUuLeJBIX4K+AeR6GaLlJCXhcaRcLIoZjohCP7W
         SN5LD8o9XBrLPUjX9+EeicHQ0je9yPcepc6iJ/XXe+Qrmd3GPnr2Xyg8FVKEnB1Cfp6F
         O5Osmc9YHQvaRROvSJ6nTl290GSiQ3Ep/FMKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757609794; x=1758214594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPti7ycwxDijfbNVdZ7d+tzQdPTkPvICaHZpGK8FY2E=;
        b=U9BqhSOMMInfYdiye07Yq4NW77ZL331QsAE8kfw5yLp3AwtoeD1AkooXtK+KwGXdFN
         6/IlKoIbyv3fDt/c1KZRKUnecFWtUAQ8DieeyimTGeEcUGNSbKhkwvGEs9lb/f4Z6JMs
         gmbEKrmD8YiL8PUQu/hhqtUUGM/z7NHpOz7/gHsgJcIQGm7YQ9N8Mtzj4lEGydK/euxW
         iBBJPsAslfpnY0dYOHiM3jSv703sO6dAq7j9gn+m8yrQxefXiT89JaAqeDiwHSmwAXaJ
         DT+gcASB86kZy9PjfyOc7LeX5u+oPrQamNiyNBartQyqHbiyM8m2dkwbaT8N4mBJsVpy
         oovw==
X-Gm-Message-State: AOJu0YxbgPjscMVqPbzqHMy+UN66YLdHi8SmssLtzAOtOL9UqQ25ATPT
	90DvXq2og5VLD8GAv18KASA6/AC0wgIK8NB7h4J6vFvmOsaSaBLJk3e49T/qxZMyNQ89Fueao8/
	vQH+F9R0=
X-Gm-Gg: ASbGncsCfa8IluQLiG+1a0EegL+lUB/HZdp1Lb4gOKX5lWdTQg8pCWvYxyvZ7ixHI+7
	KQORaiAMf5dG3LhOEAhvryHSeWmAGtuhorLcd/iOl6PuamRJsNQaFxFtwkU+x3PreVDVu5hxzld
	XkQXUclZlxfSWZ6JyyCz0leOMYvJsTw4ND0Gv+kNirw9PiCc2QmqFANFjut06Jjma+SJYDpdX0d
	Qob5YGP2+ypzpl+ofJnzv6MeVwzeqwkY/S4OhjIgeitZXGTZhmBg3fvkismSBdcgB5xb9DQ69yj
	TNTs8VXZyXNju2EltYPdOdy72PcnjViveQovisTmMCIyNpM/w2DeHjp1RyjooBw0VMmv6WGfeiD
	GqYEI6LiG8QIYjv+a6BR8e021gcS9Bicpq5ihSRACEqEG73uSaShEtvPC78UXZmOHqbW1Go4O
X-Google-Smtp-Source: AGHT+IFymZPZIpoy8aeXTzJDamLupTFc8r+1wxb66vbLZOOlBeXJiBzYWiFnivHtGbFsCKrsVulrAw==
X-Received: by 2002:a17:906:5589:b0:b07:6454:53f7 with SMTP id a640c23a62f3a-b0764545489mr1037872166b.52.1757609794452;
        Thu, 11 Sep 2025 09:56:34 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da542sm173840766b.2.2025.09.11.09.56.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 09:56:33 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b042cc3954fso178440166b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 09:56:32 -0700 (PDT)
X-Received: by 2002:a17:907:6088:b0:b04:dd2:6075 with SMTP id
 a640c23a62f3a-b04b170eacbmr1971744466b.49.1757609791574; Thu, 11 Sep 2025
 09:56:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911050149.GW31600@ZenIV>
In-Reply-To: <20250911050149.GW31600@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Sep 2025 09:56:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6HFD7d_phQS_rsYjQ9xRvXuNCyV=oGy26d6iYt6iiTg@mail.gmail.com>
X-Gm-Features: Ac12FXxicQ4WAB4cvULD0gaIeOT7VeyW2uyyl8b6G93itM1wZRd7N6oDuOhRH6o
Message-ID: <CAHk-=wh6HFD7d_phQS_rsYjQ9xRvXuNCyV=oGy26d6iYt6iiTg@mail.gmail.com>
Subject: Re: [PATCHES] simple part of ->d_name stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, linux-security-module@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Sept 2025 at 22:01, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         So let's make sure that all functions we are passing
> &dentry->d_name are taking const struct qstr * and replace
> ->d_name with an anon union of struct qstr *__d_name and
> const struct qstr *d_name.

Ack, all these patches look ObviouslyCorrect(tm) to me, and seems a
good improvement.

Even if it won't catch the more involved cases that worry you more.

             Linus

