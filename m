Return-Path: <linux-fsdevel+bounces-8796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7FE83B156
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 19:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA579B21D6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 18:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0129A13173B;
	Wed, 24 Jan 2024 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LvxCozCJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949B477F36
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121792; cv=none; b=jeuS27Q37AFyvIbbN/VybiGM15ki48QH+JTAKlQT/Sb3i/PITdEAU7I2WwIwzfHiJ/5A0kKC5ckfwAQIAl/CLhLa4kKLkYj6jreGNtZVkyisn6SU2XTkO/TOelYG60gqi6G2ssTRbihkQlccr2H69UVTOgm0GbVqpXWiwM8Ei2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121792; c=relaxed/simple;
	bh=wqAoM+vnRLBDC1XOpRXjStl/mwRygxMK00IvXTenBD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPOJZk2HRxmd0i7qnfFvNiW8+o6N2lg8LkzFLP5zJpYqA43/LNwGSOb+gTBC3AJOyKZS18vKYaj3bKUWUVcq5jET5XzEf7TMZzvip75lU+mJuGbWSSaEqxK3WC0kJn3nnibc8Abd7kHxieyeP1LLXZKBkqS35vRiM2p48UizOf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LvxCozCJ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso6374357e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 10:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706121788; x=1706726588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eIHekvVYBLIGPdIn9vTMueIBPI0zST9Cmf/UAo0UXLM=;
        b=LvxCozCJtMX1NqTRHcZxwCh+0Okc1JsL+NIPxBWDkRaeQ2EDdgU+X8O7B1DQplrP9K
         eQlroXa6CKPURKS8Cr+G/lOKTlIGLUiKYYoLjre+CkMqwBEjgWe3G7FVQ6Ec5baFysHk
         KTuNccgGtkY05grhYLKNJHzdz2NG3QoXhzTW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706121788; x=1706726588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIHekvVYBLIGPdIn9vTMueIBPI0zST9Cmf/UAo0UXLM=;
        b=aZM9nXiMiF/eoSq+mu9zxVxBO0rvAzgKw/pFcOK9A22D8kzCR0+smg7KwC7mlirhtQ
         ezHkTRILz60TzM2wL/T4E0BOPpJQvEVAZFUqp3SWFibS4xaYxBkNQzNJt+7zxjn70f3I
         yEsff90QbzkogFEzzRk9wNVmWhkWzKPPOvWDJKRCnbSiQRUnf9UnxtW8qewVRBsCRDAV
         npCIr0Y9S7yU7tNhhCXUrtR9idiwfvXYhEFYP6qWQhwnzD8V9uvkEc0OvxWG0F8dHnxG
         Yo48MyEwO38iMZscny9pMhLXCfiTCJoLKzF6ny/gQ4m0qrvLuyVIEgZERZncf7dqMYa6
         hOAA==
X-Gm-Message-State: AOJu0YynIWAqReTppaeMUToEGI/Ky7xSELsH62pw0JFJU3P+8Oeeqv4F
	WSUBoMmb0TbeoaIERNfNlK/e6KgyBBW0daSYNHWgL2vpV2F9Og1MIyFdWf1pc7hIuY+si1KXD5o
	hrOIAVg==
X-Google-Smtp-Source: AGHT+IGLp3O8HTpje564pp72nSTq7rrMU2vw7spTwoqqGfRlKPpAsKNs7YYPShPtfAz+Ua6HTw3ZTA==
X-Received: by 2002:a05:6512:3881:b0:50e:3907:46b7 with SMTP id n1-20020a056512388100b0050e390746b7mr3019395lft.107.1706121788276;
        Wed, 24 Jan 2024 10:43:08 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id u10-20020ac248aa000000b0051005e75ec5sm552495lfg.158.2024.01.24.10.43.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 10:43:07 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf2adac1ccso8985841fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 10:43:07 -0800 (PST)
X-Received: by 2002:a2e:b803:0:b0:2cd:39ec:c325 with SMTP id
 u3-20020a2eb803000000b002cd39ecc325mr1027012ljo.73.1706121787376; Wed, 24 Jan
 2024 10:43:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119202544.19434-1-krisman@suse.de> <20240119202544.19434-2-krisman@suse.de>
 <CAHk-=whW=jahYWDezh8PeudB5ozfjNpdHnek3scMAyWHT5+=Og@mail.gmail.com>
 <87mssywsqs.fsf@mailhost.krisman.be> <CAHk-=wh+4Msg7RKv6mvKz2LfNwK24zKFhnLUyxsrKzsXqni+Kg@mail.gmail.com>
 <87ttn2sip7.fsf_-_@mailhost.krisman.be>
In-Reply-To: <87ttn2sip7.fsf_-_@mailhost.krisman.be>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 10:42:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi9MDF97MGwJv_2V5QLE=f6ShgfKWUPomVKsCKYmAU9XQ@mail.gmail.com>
Message-ID: <CAHk-=wi9MDF97MGwJv_2V5QLE=f6ShgfKWUPomVKsCKYmAU9XQ@mail.gmail.com>
Subject: Re: [PATCH v4] libfs: Attempt exact-match comparison first during
 casefolded lookup
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: ebiggers@kernel.org, viro@zeniv.linux.org.uk, tytso@mit.edu, 
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 10:13, Gabriel Krisman Bertazi <krisman@suse.de> wrote:
>
> Just for completeness, below the version I intend to apply to
> unicode/for-next , which is the v2, plus the comments you and Eric
> requested. That is, unless something else comes up.

Looks ok to me.

My one comment is actually unrelated to the new code, just because the
patch touches this code too:

>         if (len <= DNAME_INLINE_LEN - 1) {
>                 memcpy(strbuf, str, len);
>                 strbuf[len] = 0;
> -               qstr.name = strbuf;
> +               str = strbuf;
>                 /* prevent compiler from optimizing out the temporary buffer */
>                 barrier();

The reason for this whole mess is that allegedly utf8_strncasecmp() is
not safe if the buffer changes under it.

At least that's what the comment says.

But honestly, I don't see it.

I think the whole "copy to a stable buffer" code can and should just
be removed as voodoo programming.

*If* the buffer is actually changing, the name lookup code will just
retry, so whether the return value is correct or not is irrelevant.

All that matters is that the code honors the str/len constraint, and
not blow up - even if the data inside that str/len buffer might not be
stable.

I don't see how the utf8 code could possibly mess up.

That code goes back to commit

  2ce3ee931a09 ("ext4: avoid utf8_strncasecmp() with unstable name")
  fc3bb095ab02 ("f2fs: avoid utf8_strncasecmp() with unstable name")

and I think it's bogus.

Eric - the string *data* may be unsafe, but the string length passed
to the utf8 routines is not changing any more (since it was loaded
long ago).

And honestly, no amount of "the data may change" should possibly ever
cause the utf8 code to then ignore the length that was passed in.

                Linus

