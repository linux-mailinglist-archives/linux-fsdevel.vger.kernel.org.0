Return-Path: <linux-fsdevel+bounces-1752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37F37DE560
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 18:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8D01C20DD3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 17:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56FD179BF;
	Wed,  1 Nov 2023 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FrBIc0cH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03338DDAF
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 17:30:58 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ED5E4
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 10:30:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso31880a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698859852; x=1699464652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sb6SfZIMOUaFmfdCVbqZgdMWgtpew1/adnZMk6mTecU=;
        b=FrBIc0cHh2VXMZUZiCnKStUyev13ZKDVc5kpeNLyAgaf/oukOTrq3obdPNJ64tJwCU
         lZ5rpTiymPCxpTxlJJ9quvufoIzyQEJUhAcH10RpRMyWZHGVIM3kj9FCzt/pUbQ80dqL
         b/4zTFBcaFkcdGEdBm6GZcjmJ/Kl6fJ9chBPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698859852; x=1699464652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sb6SfZIMOUaFmfdCVbqZgdMWgtpew1/adnZMk6mTecU=;
        b=JepVZKArF/LMoUPdQ+tTBKrx4jIXg99TQJro2BYTgI3f3xaoVVgOdYaHDCzf0w/KW/
         ukr2cVGRJPfmnmxiN+D5/Uensmj3zfZAwDuIfytcjjE+etqWMT351O3EX1LEAAtq42jq
         4eTYwdmZSKVGxJWrmPjKmASoWe5lBmhOe4DqTfFf3jDhwC6Q5mDTwPjZAptHib35BNln
         ooNVU2qyzTdmQGhWBACCihZ5ksiljDkQ1AbjI4HraCuqCF/STMoUkVItfzOdwz9oeq1y
         t9hefk+K5VYRy07eFFmiMOgM18jrg1fZu+NwqF72WrsCyr/SHcqdxBvipgvsIOy044vy
         gV0w==
X-Gm-Message-State: AOJu0YwbQ6aDIUdUKF78mIDd2tUwqLSUjWL43z9TxE7cSoO05zmyud8d
	kXmNJuSnB3wVweP/iE9hgejOpUK8ydpuFOTWkBdT1Q==
X-Google-Smtp-Source: AGHT+IE9hPzlS2ceOp0s4r9th2vVw3UIFP6BeMkLigvwdGHVSDD20nmy0M4xDxhKn0DDgJiZUEB4lA==
X-Received: by 2002:aa7:c2cf:0:b0:540:54ef:43fd with SMTP id m15-20020aa7c2cf000000b0054054ef43fdmr13248078edp.34.1698859852338;
        Wed, 01 Nov 2023 10:30:52 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id ay19-20020a056402203300b00543820cd70asm1277103edb.93.2023.11.01.10.30.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 10:30:51 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9d216597f64so5167666b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 10:30:51 -0700 (PDT)
X-Received: by 2002:a17:906:ef0e:b0:9b2:765b:273b with SMTP id
 f14-20020a170906ef0e00b009b2765b273bmr2574845ejs.70.1698859851309; Wed, 01
 Nov 2023 10:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031061226.GC1957730@ZenIV> <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
 <20231101062104.2104951-9-viro@zeniv.linux.org.uk> <20231101084535.GG1957730@ZenIV>
In-Reply-To: <20231101084535.GG1957730@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 Nov 2023 07:30:34 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
Message-ID: <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
Subject: Re: [PATCH 09/15] fold the call of retain_dentry() into fast_dput()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Oct 2023 at 22:45, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Nov 01, 2023 at 06:20:58AM +0000, Al Viro wrote:
> > Calls of retain_dentry() happen immediately after getting false
> > from fast_dput() and getting true from retain_dentry() is
> > treated the same way as non-zero refcount would be treated by
> > fast_dput() - unlock dentry and bugger off.
> >
> > Doing that in fast_dput() itself is simpler.
>
> FWIW, I wonder if it would be better to reorganize it a bit -

Hmm. Yes. Except I don't love how the retaining logic is then duplicated.

Could we perhaps at least try to share the dentry flag tests between
the "real" retain_dentry() code and the lockless version?

> Another thing: would you mind
>
> #if USE_CMPXCHG_LOCKREF
> extern int lockref_put_return(struct lockref *);
> #else
> static inline int lockref_put_return(struct lockref *l)
> {
>         return -1;
> }
> #endif
>
> in include/linux/lockref.h?  Would be useful on DEBUG_SPINLOCK configs...

The above sounds like a good idea, not only for better code generation
for the debug case, but because it would have possibly made the erofs
misuse more obvious to people.

             Linus

