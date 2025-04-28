Return-Path: <linux-fsdevel+bounces-47476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B49EA9E658
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 04:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA8617A5817
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 02:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DBC18D643;
	Mon, 28 Apr 2025 02:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E6teud58"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2690E42A89
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 02:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745808829; cv=none; b=ei3EVWprHyPgL3ynXh+hwM8sWC44rslEquNmM3vntsNGI/Yqo6KwNgj2uWF9/RMp3ciZFGcEeOGVvT19l8ZPAEhj5/s8f4MGy5yMgpxQPma0mc4cGujI74B8caZU79QXHtavMykdu415vd1YlrRL7y1IgHcSWfJ7Ht0DCi8IA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745808829; c=relaxed/simple;
	bh=UYBN6HdnwtEXdHHUY5kI3syKqrU1cYLpXW7HNGKUdm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTtM+phEkJ6WfIzGEVulaQYGg3wE3tBvZwGjldDmKANBgow0WTMEXb0VISk+UqQAX2HdJy6MjgOMPG4aWxQzi86eeT6yAsrfCTzdjL5TR7sDZoUVszjvCvaGVxjLWbYl8aqnfEoA2QF6Pr2yf+tchudHMFzqa2E554/8qJMjBeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E6teud58; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso710275466b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Apr 2025 19:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1745808824; x=1746413624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6iPnRBaGFfe17FMavfrpmiKhUoHcfBaVv2/5epCw8RU=;
        b=E6teud58tC7rqAvnj7LJl+M8T8G8ehEvbekGLhT4mu8rfaNJOgc0s3Y/9K74MZoSRL
         E/1cDnxWiKZ0EzLve2oYdnFMHF5VKKUNfIUVTKUY6MzppRwCXBX4QT8N6kwe5sfdUs6p
         TKoyn3PbNL/ltlu/804BEpUHAGMxGS6i02P1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745808824; x=1746413624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6iPnRBaGFfe17FMavfrpmiKhUoHcfBaVv2/5epCw8RU=;
        b=aO/+lPT5UlXBiyRzWWniA9wOloldakgTAkFnRC0jJOSs312V5rXtkNbbMBFz9khkCz
         8gu8BrgD5WmthcC1UKt4MsTPeWeAX+C5X5qI5P+joUGf9+IFPeR86BU/IM2GPg56Nzyf
         4RRX/nxqgRgTxAf6rnYk8R7yN03YS9FXhedpQqRQOKcn/OQR4L+5T5JtqugFl193WbGb
         UaCDo2y4SmKWpbTxi2+coNGKEnjZUxNUdcmzBkhD2iGjUAzDjqIxOKDIoa/+ERdsjT6e
         R90YJUrbTAy3x7VVdcdD6TpUVNmCwtOgdEzGiQk+DZnFcL0Gi9n2MS+/EWqOyQok1taw
         Qokg==
X-Forwarded-Encrypted: i=1; AJvYcCWgDuq+Y7sbUHTQARLj/IvyaOei7q8dRhgfswC5/+EBBpn5VmBSM26prd/7eyh83KgUE/c6PKDpwHDJVBS6@vger.kernel.org
X-Gm-Message-State: AOJu0YxMY88lKvgjNIzxb3+QtTby/y/GNe23XHRdOU5VcHdcnv0yHBe4
	5xl6ElTTLwav9G1RfipQMzcI8VAQ0Ao0nBkbmGpDB1ZXBNRgMLUqTJoUr8jyw5yB5wXpEgep17y
	gZeE=
X-Gm-Gg: ASbGncsvXFzutLocPZSAWthQl8pvvUFQNOdp7MpMe2S93wEd8kEeOmisD1KUUP9cMhe
	lRnfa5shJ6/bwrt4al9M6gWiXFOO0KbVF86s26pbpEuH6tMUVPTiJP2eBb67KWpzfVoFlKLu/Ar
	YWfknZzsnWQU8aUfswdUdk9Pw4meIPXYzknABcuhxjNOhQJCVMBPGgbpuP9NZWGmp7nqhuoQfRt
	Y1Bb/eYKgprSA0HLMamzj/EryYdVrCaJl4xDHbp9ZK/ZEAMLwubQ7TuGf4NDXmQk8Alf4kNMyMz
	sfB2TtYpJAkfYZHKh0A81N03lzh18I1nZHCNwPKIk6wsYQEhM0NcI/6LgZdxLA/OKR/JKx/gefw
	oJM2yUYZ7qs0BLGE=
X-Google-Smtp-Source: AGHT+IHT81s65NUsCrQ2Z90JboPXH7PGorObO/mRWCCqGB9PtNHtX+bMW2ZYb1kmIfrmsaZ9SS51VA==
X-Received: by 2002:a17:906:c110:b0:aca:a688:fb13 with SMTP id a640c23a62f3a-ace71178f01mr952608266b.36.1745808824149;
        Sun, 27 Apr 2025 19:53:44 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecf8603sm535117566b.112.2025.04.27.19.53.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Apr 2025 19:53:43 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ace94273f0dso237574166b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Apr 2025 19:53:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUG6X9Y+/w0p/TuOm66Zwrd5XREggU8KlI2VJ5qIQaqC/6tDBsFLlzmdUdVcWTkA1JZ9JxO0NkBiWKlaHQS@vger.kernel.org
X-Received: by 2002:a17:907:1c89:b0:ac1:db49:99a3 with SMTP id
 a640c23a62f3a-ace7133c2d4mr947487766b.40.1745808823097; Sun, 27 Apr 2025
 19:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <aAvlM1G1k94kvCs9@casper.infradead.org> <ahdxc464lydwmyqugl472r3orhrj5dasevw5f6edsdhj3dm6zc@lolmht6hpi6t>
 <20250428013059.GA6134@sol.localdomain> <ytjddsxe5uy4swchkn2hh56lwqegv6hinmlmipq3xxinqzkjnd@cpdw4thi3fqq>
 <5ea8aeb1-3760-4d00-baac-a81a4c4c3986@froggi.es> <20250428022240.GC6134@sol.localdomain>
 <dorhk5yr66eemxszl6hrujiqxnpera5kpvkkd4ebumh6xc3q2c@gtvl3cjfqfln>
In-Reply-To: <dorhk5yr66eemxszl6hrujiqxnpera5kpvkkd4ebumh6xc3q2c@gtvl3cjfqfln>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 27 Apr 2025 19:53:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgtibpSH3+th-YjbQUSZVMbGNxG87oBDeqx+UkbHWejGw@mail.gmail.com>
X-Gm-Features: ATxdqUGcdKhwN_XGkfQCtIIDjIKiRGyOs20GwmO8dm7_o5J-qX3JKlU0UN9-k6M
Message-ID: <CAHk-=wgtibpSH3+th-YjbQUSZVMbGNxG87oBDeqx+UkbHWejGw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Eric Biggers <ebiggers@kernel.org>, Autumn Ashton <misyl@froggi.es>, 
	Matthew Wilcox <willy@infradead.org>, "Theodore Ts'o" <tytso@mit.edu>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 27 Apr 2025 at 19:34, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Do you mean to say that we invented yet another incompatible unicode
> casefolding scheme?
>
> Dear god, why?

Oh, Unicode itself comes with multiple "you can do this" schemes.

It's designed by committee, and meant for different situations and
different uses.  Because the rules for things like sorting names are
wildly different even for the same language, just for different
contexts.

Think of Unicode as "several decades of many different people coming
together, all having very different use cases".

So you find four different normalization forms, all with different use-cases.

And guess what? The only actual *valid* scheme for a filesystem is
none of the four. Literally. It's to say "we don't normalize".

Because the normalization forms are not meant to be some kind of "you
should do this".

They are meant as a kind of "if you are going to do X, then you can
normalize into form Y, which makes doing X easier". And often the
normalized form should only ever be an intermediate _temporary_ form
for doing comparisons, not the actual form you save things in.

Sadly, people so often get it wrong.

For example, one very typical "you got it wrong, because you didn't
understand the problem" case is to do comparisons by normalizing both
sides (in one of the normalization forms) and then doing the
comparison in that form.

And guess what? 99.9% of the time, you just wasted enormous amounts of
time, because you could have done the comparison first *without* any
normalization at all, because equality is equality even when neither
side is normalized.

And the *common* case is that you are comparing things that are in the
same form. For example, in filesystem operations, 99.999% of the time
when you do a 'stat()' the *source* of the 'stat()' is typically a
'readdir()' operation. So you are going to be using the same exact
form that the filesystem ALREADY HAD, and it's going to be an exact
match, and there will NEVER EVER be any case folding issues in those
situations.

But the "simplistic" way to do it is to always normalize - which
involves allocating temporary storage for the new form, doing a fairly
expensive transformation including case folding, and then comparing
those things.

Christ.

The pure and incompetence in case-insensitivity *hurts*.

And what is so sad is that all of this is self-inflicted damage by
filesystem people who SHOULD NOT HAVE DONE THE COMPLEXITY IN THE FIRST
PLACE!

It's a classic case of

  "Doctor, doctor, it hurts when I hit myself in the balls with this hammer"

and then people wonder why I still claim the answer still remains -
and always will remain - "Don't do that then".

               Linus

