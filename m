Return-Path: <linux-fsdevel+bounces-3281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2FC7F2476
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 04:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8311C21826
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 03:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D40514F9F;
	Tue, 21 Nov 2023 03:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M4jqM27w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D449EC4
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 19:03:33 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9de7a43bd1aso681214366b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 19:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700535812; x=1701140612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EIi2i2u1rSIPQrzJXn8A5YNmAC8BSlreYh/h3LyEO0w=;
        b=M4jqM27wLFOC0WKHQGhuyC65GFEPIthR/4SChvouUWTU32V0K80HEW1EmZS11j82z3
         Lzw1mPvuLA2WLp8X+0gDbfWqyFgKcRufxKSp+pmpj79+7WKq+scmtCL/cfCz6SRYZlft
         Wa2R5RvAV46Q0WmgtVLfJfvN5kJJnNmLORtmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700535812; x=1701140612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIi2i2u1rSIPQrzJXn8A5YNmAC8BSlreYh/h3LyEO0w=;
        b=AkijLaxiF13TxRm075RYcuGzvk/wBu9KMLM5vBaukO+uJibLxslka3tBham2yd1dmA
         YbmkjinRgZud0Ghikm+Q+alI+SU1q3dFgwPV2IuQb5XenaDiaMvFoLiKRaWCMpcNYRmU
         8Y4j484uP3yFiaxOLyS/jyy9YNTZ9wplod9K14I8HFiIFH3cgENB15fQK6Ocd0gAB4KE
         d0a6dJqW+LwCPjphDcTmeedTDgMJyB9sBr6prNwGar8Dh8zw2rf2AhnZ60d6EW1d0GS3
         QX+4E05bRLTqDeaBXyoqf//17/G2mLuaLRvfeHFj3DfMzClw5zDsYYoD+QCDC8p9aLk3
         xKOA==
X-Gm-Message-State: AOJu0YxeGa2zJaama6Zb050zapEwGSqqMGOvAnDWC7Ky6HjwluJCikb0
	I4mUL3vuQ+nI8Tyy8FBGqMJ679NKltPxd9pFESgyQA==
X-Google-Smtp-Source: AGHT+IHpZa9Qxoc+zqZbTUg+sGXRlCFlIZlFCmGImEbtYSfzDVjHpKu6oFHMJdbT7ePLGhXXx40+6Q==
X-Received: by 2002:a17:907:9486:b0:9c4:6893:ccc5 with SMTP id dm6-20020a170907948600b009c46893ccc5mr7953688ejc.57.1700535812176;
        Mon, 20 Nov 2023 19:03:32 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id n22-20020a170906b31600b009fc6ac28110sm2538750ejz.20.2023.11.20.19.03.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 19:03:31 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5484ef5e3d2so5049513a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 19:03:31 -0800 (PST)
X-Received: by 2002:a05:6402:797:b0:543:8391:a19a with SMTP id
 d23-20020a056402079700b005438391a19amr722096edy.40.1700535810689; Mon, 20 Nov
 2023 19:03:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816050803.15660-1-krisman@suse.de> <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner> <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121020254.GB291888@mit.edu> <CAHk-=whb80quGmmgVcsq51cXw9dQ9EfNMi9otL9eh34jVZaD2g@mail.gmail.com>
In-Reply-To: <CAHk-=whb80quGmmgVcsq51cXw9dQ9EfNMi9otL9eh34jVZaD2g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 Nov 2023 19:03:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh+o0Zkzn=mtF6nB1b-EEcod-y4+ZWtAe7=Mi1v7RjUpg@mail.gmail.com>
Message-ID: <CAHk-=wh+o0Zkzn=mtF6nB1b-EEcod-y4+ZWtAe7=Mi1v7RjUpg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Christian Brauner <brauner@kernel.org>, Gabriel Krisman Bertazi <krisman@suse.de>, viro@zeniv.linux.org.uk, 
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org, 
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Nov 2023 at 18:29, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It's a bit complicated, yes. But no, doing things one unicode
> character at a time is just bad bad bad.

Put another way: the _point_ of UTF-8 is that ASCII is still ASCII.
It's literally why UTF-8 doesn't suck.

So you can still compare ASCII strings as-is.

No, that doesn't help people who are really using other locales, and
are actively using complicated characters.

But it very much does mean that you can compare "Bad" and "bad" and
never ever look at any unicode translation ever.

In a perfect world, you'd use all the complicated DCACHE_WORD_ACCESS
stuff that can do all of this one word at a time.

But even if you end up doing the rules just one byte at a time, it
means that you can deal with the common cases without "unicode
cursors" or function calls to extract unicode characters, or anything
like that. You can still treat things as bytes.

So the top of generic_ci_d_compare() should probably be something
trivial like this:

        const char *ct = name.name;
        unsigned int tcount = name.len;

        /* Handle the exact equality quickly */
        if (len == tcount && !dentry_string_cmp(str, ct, tcount))
                return 0;

because byte-wise equality is equality even if high bits are set.

After that, it should probably do something like

        /* Not byte-identical, but maybe igncase identical in ASCII */
        do {
                unsigned char a, b;

                /* Dentry name byte */
                a = *str;

                /* If that's NUL, the qstr needs to be done too! */
                if (!a)
                        return !!tcount;

                /* Alternatively, if the qstr is done, it needed to be NUL */
                if (!tcount)
                        return 1;
                b = *ct;

                if ((a | b) & 0x80)
                        break;

                if (a != b) {
                        /* Quick "not same" igncase ASCII */
                        if ((a ^ b) & ~32)
                                return 1;
                        a &= ~32;
                        if (a < 'A' || a > 'Z')
                                return 1;
                }

                /* Ok, same ASCII, bytefolded, go to next */
                str++;
                ct++;
                tcount--;
                len--;
        }

and only after THAT should it do the utf name comparison (and only on
the remaining parts, since the above will have checked for common
ASCII beginnings).

And the above was obviously never tested, and written in the MUA, and
may be completely wrong in all the details, but you get the idea. Deal
with the usual cases first. Do the full unicode only when you
absolutely have to.

                Linus

