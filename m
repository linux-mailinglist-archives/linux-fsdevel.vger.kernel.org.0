Return-Path: <linux-fsdevel+bounces-25167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAB2949825
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 21:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA5F1C21647
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D53142E92;
	Tue,  6 Aug 2024 19:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chBz3oaV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A44580BFF;
	Tue,  6 Aug 2024 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972145; cv=none; b=Ioqz0cO85kaNyU87umZej1l0mjC8x6mer7XlVRCaBVfJcNwPw/jtYvj6noQKGqfvA+HTrn0mwxPuRdEk7edSPzV9+2M0LxXaI/NGLUwFurZ9joCmHEvQultq9HnLkY9Y5G3evaZvAx48NgQLNN5gP94VBirven8aSxdWrzD4pkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972145; c=relaxed/simple;
	bh=s9rPTaztVrfOhHtxuf0ACEj2mdsWUnU9ZZiYXb7t4kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOdzZA0Rw7BoN3JDFzgLXAn9rbWy+/Kcc4u0nABgijfll5115SarrrtMhpg9F2OIPStgx5kg3bBidauWZhTI8X+mAb1vR8/nYQL2PfRKtz6K5R/U05AfZ5XaFTcSjrt6CdMAjTMmTAg284NdpDEWQHbcaur03N2sQQhIOOWoq68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chBz3oaV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7ac449a0e6so86981366b.1;
        Tue, 06 Aug 2024 12:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722972142; x=1723576942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9rPTaztVrfOhHtxuf0ACEj2mdsWUnU9ZZiYXb7t4kM=;
        b=chBz3oaViMF3nyWszWLWSAL3NXFOdKoZ4Sg3hQ8g4O8H3Fw1QCvXVpWh6sAxyLaDyP
         Hu34r43+PKLM0xt2smquNs884K0Gke8yN0KxfuHiqdsU94t5tNT8qJUa4RaGyjAbJCP2
         HZlx9OELJcigfEdZJAWk48wNUJujIWlAcFsvYWIOjYv0X2yWZ5A5KWpS0NSNTYJd+BL6
         K44MoQa8vX8h0+PMwF3ulCtnqAYceehqw4jqOFTkj570Y3TEg4ZDU/ek1ERH5btoIiWw
         6eRvAp6lP/BvfA7V9URq95KwIcPHbV9q/gi65kJ9OtZCRkzXr4r4cXo+h3HCO0Jz9nLO
         /4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722972142; x=1723576942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9rPTaztVrfOhHtxuf0ACEj2mdsWUnU9ZZiYXb7t4kM=;
        b=gY9AJLn15ELRzMfuuyN6jbDbJsR7GS31jT+Qo5Q4A7VE/EHVPkxSuPrUfqviY4ULN+
         orDCGHuBIoQdCIBpVzWTvisewWV47iqw1zOSTm6qhfwoKVHNORKf2uG/H6IrhAIJws9q
         LJZs4P1hdgJMLrnbQgxCNmpKqBljTKIpUQ+RkT72zopLeCynHwWAkWkRJ9fvidVQ6MFz
         csDDSBoC93tQigIe45ONv1n/jF6Di4s5y3GsmVD1n/AzU8pO2g8jq7TdmkeUd5heV4og
         6COZY9Qyp+PgHLgINOqKoqjeFooo6EBmnA9aRhzEfXAKOXW+A6wBnwNSjylA2OgwSPGb
         kJlw==
X-Forwarded-Encrypted: i=1; AJvYcCV9/7436nBkOoKq448TGKN7cyK2H4hncX3dV3hGYIhxzi/nmo+4PH7AgJmoWxJZjY57hq5fzT4ZBM/sBeMUgOJkpMVaSufNlIMJq+N2MiPOdU+Zqqr0BRSTGX8vTizCf3KLwJ9iaU92Y3QuLA==
X-Gm-Message-State: AOJu0YyP/V597YwRhYxjCGXFNUHYfG7AArI0uQzQfI7tVI/A8u8RKQ2N
	e4FRkPfQoQcVs7fTcQ9S8LY0L51DAZqflJzzfSfvH1+YgZUG55fvUC63IetXvsgrw/wuOlhVIQ7
	Ut2oMgOSuJw2OyKi04Lvd3fekBfs=
X-Google-Smtp-Source: AGHT+IFqqBSVVYsN4AwkyrkvpWuHa8xOwsou3MrNf3m9cKjAVctVI6VEn2DZjf4jQMOq/+072uv012kgRFCOA5WGlJI=
X-Received: by 2002:a17:907:c0e:b0:a7d:3672:a594 with SMTP id
 a640c23a62f3a-a7dc50ff21cmr1182085466b.61.1722972141477; Tue, 06 Aug 2024
 12:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
 <CAGudoHF9nZMfk_XbRRap+0d=VNs_i8zqTkDXxogVt_M9YGbA8Q@mail.gmail.com> <87ikwdtqiy.fsf@linux.intel.com>
In-Reply-To: <87ikwdtqiy.fsf@linux.intel.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 6 Aug 2024 21:22:09 +0200
Message-ID: <CAGudoHHu42+VP6snbtg9gXog0UYaMv68eekxYt+2=5arrhZffg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
To: Andi Kleen <ak@linux.intel.com>
Cc: Jeff Layton <jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 9:11=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wrot=
e:
>
> Mateusz Guzik <mjguzik@gmail.com> writes:
> >
> > I would bench with that myself, but I temporarily don't have handy
> > access to bigger hw. Even so, the below is completely optional and
> > perhaps more of a suggestion for the future :)
> >
> > I hacked up the test case based on tests/open1.c.
>
> Don't you need two test cases? One where the file exists and one
> where it doesn't. Because the "doesn't exist" will likely be slower
> than before because it will do the lookups twice,
> and it will likely even slow single threaded.
>
> I assume the penalty will also depend on the number of entries
> in the path.
>
> That all seem to be an important considerations in judging the benefits
> of the patch.
>

This is why I suggested separately running "unlink1" which is
guaranteed to create a file every time -- all iterations will fail the
proposed fast path.

Unless you meant a mixed variant where only some of the threads create
files. Perhaps worthwhile to add, not hard to do (one can switch the
mode based on passed worker number).

--=20
Mateusz Guzik <mjguzik gmail.com>

