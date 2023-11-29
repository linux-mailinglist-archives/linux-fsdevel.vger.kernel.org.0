Return-Path: <linux-fsdevel+bounces-4206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C55D7FDD38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 17:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2A51C20954
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260DF2E647
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L+9hVabP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205DED5C
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 06:42:34 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54b450bd014so4901529a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 06:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701268952; x=1701873752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6w05lBhliqG02QD74yDtfVUAWC7biZGqwSccI+QzqRQ=;
        b=L+9hVabPSPZdeBOJqShj6iRPu8VIaNVjCBEn9hfzZcbeVhZD2TxRJpjtwn43P5j71K
         3riUzQT8ydmz8lQvfqrJ2yMA+DDfCSppE888AafpurETPb9fjOE88nEyuIPhDQKDY40K
         Fe1PERK32x0b3lLXaaVEegl7WgUdSlUZeL9cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701268952; x=1701873752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6w05lBhliqG02QD74yDtfVUAWC7biZGqwSccI+QzqRQ=;
        b=q1RUuMSa1QoK+PDAghZuFIO+Nyk19zlWBM8lKVPDj+rV466PACeeAJ6fjFbleuFiNv
         /LapwqI2cn9XYY95ZYNHePYPRYufrLvxVfZqvS/pGUw/mWcOa47hoSeyr+JPL31ke/rs
         HnslzQTOsAAjKk9OOMSFtWm71fBAYCtBpJi9GfIEjthY8eXEudF937lmJpmL7Uv6yciD
         P8bxbcumZkZ/xNtDxxTJtmgutQgGKZRDO4B1IlSl7sy64aNk95Iv/vc68Aq6WWKD2lPp
         DOENo+gJir7En5qrO9LHcd+A1hKTG7i+J5QcKr/Qv41bdn+mGeGzPIOgvomT3KuCYID2
         wzVg==
X-Gm-Message-State: AOJu0YwXH1x0NHpMrOTKNzFnbyQwfqsLWpT7BF/TdzuqYyxKPJl23nCY
	QJtNZ2WwW9tlma+F8s9T/O46lToW8J8rmVchTItpwnau
X-Google-Smtp-Source: AGHT+IGSjmoAhJybhOkEIX/F3Ywm3YKqniym2x37i5OEpWDDIIMG8hevgQciWqQarcgStD7cT1sT7w==
X-Received: by 2002:a50:aaca:0:b0:545:4bf3:ac89 with SMTP id r10-20020a50aaca000000b005454bf3ac89mr14395499edc.23.1701268952369;
        Wed, 29 Nov 2023 06:42:32 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id b19-20020a056402279300b0054b5d5248easm3575656ede.86.2023.11.29.06.42.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 06:42:31 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a00cbb83c82so975238666b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 06:42:31 -0800 (PST)
X-Received: by 2002:a17:906:70c8:b0:9e2:9647:9a54 with SMTP id
 g8-20020a17090670c800b009e296479a54mr11284943ejk.3.1701268950876; Wed, 29 Nov
 2023 06:42:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231101062104.2104951-9-viro@zeniv.linux.org.uk>
 <20231101084535.GG1957730@ZenIV> <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
 <20231101181910.GH1957730@ZenIV> <20231110042041.GL1957730@ZenIV>
 <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
 <ZV2rdE1XQWwJ7s75@gmail.com> <CAHk-=wj5pRLTd8i-2W2xyUi4HDDcRuKfqZDs=Fem9n5BLw4bsw@mail.gmail.com>
 <CAHk-=wg6D_d-zaRfXZ=sUX1fbTJykQ4KxXCmEk3aq73wVk_ORA@mail.gmail.com>
 <CAHk-=wj2ky85K5HYYLeLCP23qyTJpirnpiVSu5gWyT_GRXbJaQ@mail.gmail.com> <ZWctqTvE+JC6T6RK@gmail.com>
In-Reply-To: <ZWctqTvE+JC6T6RK@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Nov 2023 06:42:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wibyYXdVyyoOxZqQK576=r5d02ikCtbJ4-eyEWkh92rPg@mail.gmail.com>
Message-ID: <CAHk-=wibyYXdVyyoOxZqQK576=r5d02ikCtbJ4-eyEWkh92rPg@mail.gmail.com>
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
To: Guo Ren <guoren@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Nov 2023 at 04:25, Guo Ren <guoren@kernel.org> wrote:
>
> > +#if defined(__LITTLE_ENDIAN) && BITS_PER_LONG == 64
> > + #define LOCKREF_ADD(n,x) ((n).lock_count += (unsigned long)(x)<<32)
> > +#else
> > + #define LOCKREF_ADD(n,x) ((n).count += (unsigned long)(x)<<32)
> #define LOCKREF_ADD(n,x) ((n).count += (unsigned long)(x))
> ?

Yes. I obviously only tested the little-endian case, and the BE case
was a bit too much cut-and-paste..

             Linus

