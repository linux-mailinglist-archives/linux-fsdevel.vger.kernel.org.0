Return-Path: <linux-fsdevel+bounces-3279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0CA7F23FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 03:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33CD281AAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 02:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584BA154B8;
	Tue, 21 Nov 2023 02:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BzZo5dLw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176E3AA
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 18:29:26 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9fffa4c4f43so162131166b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 18:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700533764; x=1701138564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cXgJaCnWAfzXRMpd5bvFRcG7YxYfu713J7p+TxuYhXc=;
        b=BzZo5dLwMvHfTeNlePaiuGR9plst7ykla/uz/HMQ4v0+duA50/oChn6K6bR5qoHyoo
         J832gPn0UCRrx1a1fQa+sl8Ozb5A54tZ6sgQCaOvd92XxbyNsFYVcxrwjkq4qM0+Tmlb
         iluuakBc36seYu+Y69DVFFz2ckpCHrR9JskgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700533764; x=1701138564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXgJaCnWAfzXRMpd5bvFRcG7YxYfu713J7p+TxuYhXc=;
        b=GhVu4FWn4exmtUM86lIoxXm3KjtMQ9/G+32ZlTN5ob3IdzW1nelnTMF9e1QrcvVjGu
         Qy5MiQzifdrq3WE9hOc0h8073VtghafQThYpjBSRRdrSAIl4tFfmdJTnBchzYL5VvVjN
         4dYwaZ1otvRnUFHXITnfBHpGUjBwpxvuCqu3Cjz84j9POq7UPWWQ9gCJGqCvZgy7Cesf
         eKtZt7mJSOPMZ730O276lR2qeJGhWLlkKa7C4vulyM3jGnY7Ikc8UtJjBkSt5OINPsBv
         Z9Bp26CE+NNOk5UwEYu5smQFyIfjU+izONrS0c7Zxzw1z6L4Ft002ybkU3K06R6iB8Fh
         6q9w==
X-Gm-Message-State: AOJu0YzWWKTVBY2u0Cu+esiUeD4EBSglc8/eqrJ73CpuYKEeQpZXUNZC
	opxaLgCc3V5I89XVeXufU49eN2LTLuVe6GXx/Uv2TQ==
X-Google-Smtp-Source: AGHT+IG6xrMxqWkEa4Vl/ZBifThas4+w+ywwYXo/qfd7EVnAXVroKndN1tGG5D9CZ9iIWylB5aDw+g==
X-Received: by 2002:a17:906:10b:b0:9de:32bb:fa96 with SMTP id 11-20020a170906010b00b009de32bbfa96mr7956246eje.9.1700533764421;
        Mon, 20 Nov 2023 18:29:24 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id v27-20020a170906489b00b009d2eb40ff9dsm4567749ejq.33.2023.11.20.18.29.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 18:29:23 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5437d60fb7aso7351164a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 18:29:23 -0800 (PST)
X-Received: by 2002:a50:9ec2:0:b0:542:e844:5c9b with SMTP id
 a60-20020a509ec2000000b00542e8445c9bmr836227edf.13.1700533762984; Mon, 20 Nov
 2023 18:29:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816050803.15660-1-krisman@suse.de> <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner> <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121020254.GB291888@mit.edu>
In-Reply-To: <20231121020254.GB291888@mit.edu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 Nov 2023 18:29:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whb80quGmmgVcsq51cXw9dQ9EfNMi9otL9eh34jVZaD2g@mail.gmail.com>
Message-ID: <CAHk-=whb80quGmmgVcsq51cXw9dQ9EfNMi9otL9eh34jVZaD2g@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Christian Brauner <brauner@kernel.org>, Gabriel Krisman Bertazi <krisman@suse.de>, viro@zeniv.linux.org.uk, 
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org, 
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Nov 2023 at 18:03, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Nov 20, 2023 at 10:07:51AM -0800, Linus Torvalds wrote:
> >     I'm looking at things like
> > generic_ci_d_compare(), and it hurts to see the mindless "let's do
> > lookups and compares one utf8 character at a time". What a disgrace.
> > Somebody either *really* didn't care, or was a Unicode person who
> > didn't understand the point of UTF-8.
>
> This isn't because of case-folding brain damage, but rather Unicode
> brain damage.

No, it really is just stupidity and horribleness.

The thing is, when you check two strings for equality, the FIRST THING
you should do is to just compare them for exactly that: equality.

And no, the way you do that is not by checking each unicode character
one by one.

You do it by just doing a regular memcmp. In fact, you can do even
better than that: while at it, check whether
 (a) all bytes are equal in everything but bit#5
 (b) none of the bytes have the high  bit set
and you have now narrowed down things in a big way. You can do these
things trivially one whole word at a time, and you'll handle 99% of
all input without EVER doing any Unicode garbage AT ALL.

Yes, yes, if you actually have complex characters, you end up having
to deal with that mess. But no, that is *not* an excuse for saying
"all characters are complex".

So no. There is absolutely zero excuse for doing stupid things, except
for "nobody has ever cared, because case folding is so stupid to begin
with that people just expect it to perform horribly badly".

End result:

 - generic_ci_d_compare() should *not* consider the memcmp() to be a
"fall back to this for non-casefolded". You should start with that,
and if the bytes are equal then the strings are equal. End of story.

 - if the bytes are not equal, then the strings *might* still compare
equal if it's a casefolded directory.

 - but EVEN THEN you shouldn't fall back to actually doing UTF-8
decoding unless you saw the high bit being set at some point.

 - and if they different in anything but bit #5 and you didn't see the
high bit, you know they are different.

It's a bit complicated, yes. But no, doing things one unicode
character at a time is just bad bad bad.

               Linus

