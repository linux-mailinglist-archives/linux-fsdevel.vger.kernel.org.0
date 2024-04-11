Return-Path: <linux-fsdevel+bounces-16644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8648A060A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 04:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861871F2462B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 02:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A295A13B28D;
	Thu, 11 Apr 2024 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HlRizrIc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220AB5F870
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 02:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803212; cv=none; b=X8SGk3CQxPs7jGUB2psu8XnV1eBzr4GRPE4gm0TKN5KE5qyyoL2RW98Y8RByVPZj7HC+h3IIKxkcn3XKo4mzUQpL4M4vncXny//zkO6wpoO2w6hhcZYzb/PGwoCLRuKzFYMC9hYGjrLMD0Vqb7KvWqcWKgPSZpGCza8dvchfQ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803212; c=relaxed/simple;
	bh=nAGR3QwbwJHg0yglTUbnjyXfmhwicyQzUNh2YPI0DmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojIGT/yiu2bhBYPSW4jsSdKAgcQVyh7oKudQkE49HqgYzM3WQGVZvDbX7Dkk2uo1W0+CbPuBEuJcaK+nJj4lDa4jrzW3WCvhDc4h/F3Z9H+Z1RK4V6Wzvd2FG0j8Hu1ukdMLcEiDfFA8qcZTlPZ0Pr+JvlMk/twU0Z5yU9nLkKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HlRizrIc; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so8435362a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 19:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712803208; x=1713408008; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAti3DeKOVRxV5o0JR8+DzuFObIz3rfvlLJ6eRgxroM=;
        b=HlRizrIcZiOIfOk5s2FvIiqGadh73FKZAAWv7A0W39E8VBsm20/IBL8MGo8grVIA+V
         k9P64q+6gNlEHTIFoPJtsnl5DJX1bPNprAHsmtcG7FOmzS8nO0GZrTkB9fldDAaoFME/
         3WogMhL+jCnctmsKBS0Cy70TM3DFA0leBVCoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712803208; x=1713408008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAti3DeKOVRxV5o0JR8+DzuFObIz3rfvlLJ6eRgxroM=;
        b=h0gcjN2kcmbClOFwJk6+yxvlHfI18pC1cHdmbNIDNpe8ZjHgnmF3/YXKm85xWNu/uw
         uByiMCCA8En06MOqW51/B0cVNZ0XclRK+7E1W6x136ChX+xn03gtTnhhHpYmKZzjj1KX
         6Ng5mueeNfJ+chWAVk5Bl92NlCkLhlF9yAZijgVhsGr8PK59iSBE/wOnDpIYqUQIBIXk
         EZz+l7LthE7H55WhnczznNjiafGkTj9HpkZm0oiCnjcNQCwSDbmm0H8pNXZBL1XVwNyX
         XVIOLXz53+RGmPuhCiUwhIClkub1/GOIDaKUEU4cnoMu4b/ezyvsMpEWe/TB3LKReXmn
         01YA==
X-Gm-Message-State: AOJu0YxlEzNHVoCtrO+lPlEO96t4vwkJSRiraHmPZZzNmjtXNvESq8S/
	kwgDCHGb8M/YGE1l3vYNxFni6kTSXmbQ8pW3+nA7L5R5idKkOXwyctcMe8fMbk2fEuQgQkBc/9x
	Ygr1LBQ==
X-Google-Smtp-Source: AGHT+IFlWBYDyc9G+o407gGoRNZfu1DFo7OzVL5KG9IxR4AE6VSolLFJ/AH5QW5As/UzQe91j5bdEg==
X-Received: by 2002:a17:906:250f:b0:a52:1358:c615 with SMTP id i15-20020a170906250f00b00a521358c615mr1898794ejb.7.1712803208206;
        Wed, 10 Apr 2024 19:40:08 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id di18-20020a170906731200b00a4e9359fbe8sm290515ejc.44.2024.04.10.19.40.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 19:40:06 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a52176b2cb6so95043566b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 19:40:06 -0700 (PDT)
X-Received: by 2002:a17:906:184a:b0:a52:882:abaa with SMTP id
 w10-20020a170906184a00b00a520882abaamr2382187eje.76.1712803205798; Wed, 10
 Apr 2024 19:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
In-Reply-To: <20240411001012.12513-1-torvalds@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Apr 2024 19:39:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
Message-ID: <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 17:10, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> +               if (flags & LOOKUP_DFD_MATCH_CREDS) {
> +                       if (f.file->f_cred != current_cred() &&
> +                           !capable(CAP_DAC_READ_SEARCH)) {
> +                               fdput(f);
> +                               return ERR_PTR(-ENOENT);
> +                       }
> +               }

Side note: I suspect that this could possibly be relaxed further, by
making the rule be that if something has been explicitly opened to be
used as a path (ie O_PATH was used at open time), we can link to it
even across different credentials.

IOW, the above could perhaps even be

+               if (flags & LOOKUP_DFD_MATCH_CREDS) {
+                       if (!(f.file->f_mode & FMODE_PATH) &&
+                           f.file->f_cred != current_cred() &&
+                           !capable(CAP_DAC_READ_SEARCH)) {
+                               fdput(f);
+                               return ERR_PTR(-ENOENT);
+                       }
+               }

which would _allow_ people to pass in paths as file descriptors if
they actually wanted to.

After all, the only thing you can do with an O_PATH file descriptor is
to use it as a path - there would be no other reason to use O_PATH in
the first place. So if you now pass it to somebody else, clearly you
are intentionally trying to make it available *as* a path.

So you could imagine doing something like this:

         // Open path as root
         int fd = open('filename", O_PATH);

        // drop privileges
        // setresuid(..) or chmod() or enter new namespace or whatever

        linkat(fd, "", AT_FDCWD, "newname", AT_EMPTY_PATH);

and it would open the path with one set of privileges, but then
intentionally go into a more restricted mode and create a link to the
source within that restricted environment.

Sensible? Who knows. I'm just throwing this out as another "this may
be the solution to our historical flink() issues".

           Linus

