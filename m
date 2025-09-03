Return-Path: <linux-fsdevel+bounces-60156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB60B4234C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 16:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC343AB729
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183143126B5;
	Wed,  3 Sep 2025 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkpFwzu6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB832E8B85;
	Wed,  3 Sep 2025 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908900; cv=none; b=X3gO2cxvwRDWvjvjR6zCs4LRv6vA7LzGQYC4idXCnNNYSsPhfwbHgOzKW+zlBINRZ7bXOl5KhdhMs25cW68P9Hil9IZ8IzGwzDxMhs2+bCfaodIUVCaK/WaH/Krj7JNzgISQsTptt9c+/uKIt0IAudRJuCB1hp7ZqpVaYLcND+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908900; c=relaxed/simple;
	bh=7z0O2nG5P8sF45YF4K38XBklUL2KhQ6VXBcBADLg07A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4NKNiN0O3F5a4zHcFhYXdUcoA5WRDvw4awJp/pwYMMrbrEGW/jgTRxdg03LoNeJnwIw0ydIOhZ0RiFAPd7sy25+Wqgpud5f0QCD0PKkbQ5nGFkHJH9XeTtkABE197Jw/kNpe4hWm0M6MLl37K99/Xxa4DWt22sScVb0eGB6O/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkpFwzu6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6188b793d21so8029516a12.3;
        Wed, 03 Sep 2025 07:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756908897; x=1757513697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHLCbxm2qevOsyTY7hfbOkOW4ktOmeHjBjDsV0iAsNU=;
        b=FkpFwzu6UJbj2oumPAqOz8xlDN6CdKoG3N+F6fg7UXbME3N3UDKQPHKBEwZYZ76YBI
         0hiKBbsPJz5XZqmT51SN3oDQk7moiJcuan2Uf6zA2WSU6uQAOV9lIR2UmejnPs5pDW/l
         OGUWtKafQLOhCSKeiUXz4p1vEYtYMY7etFJBEWxSZIgCtPE9+SzsgZpBtfkd9MGecVd8
         5XBruueregsnx8EDRwtabRHwUo1OGbYdnD5FJlAaaAi2XVcs6qRfa+4rhL9ea5Ol+egB
         PSLcsQOqGmWNiD3+ZMT9lTPlFF0a/aMoABguBJamP0yxHf5XgzCQAbxLq9PxLEkJl+9Y
         2GoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908897; x=1757513697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHLCbxm2qevOsyTY7hfbOkOW4ktOmeHjBjDsV0iAsNU=;
        b=IrRVBzYSCW/QZOo0oYbli6ymAsoV/5piEFmb0lsesELjB4jHiJ5wO2EAtI9DZkhjg9
         YoVrCm2YcKNnYFvsIz68rN0zCaTqwraL+yiOE1pyOzrrresXRJLjwHY7jNVJ7c7cksvD
         5xKsO7dh5SAKJFoLlhebBlQN1sbWzTJJM3P60We4WDi3MhkVwav5ZpYbAbuU0AIP7e0w
         SJPu58sHXNiWp3nQQ0N9957YDm+WFfjabQE2lYcdg4cCztrJB4FcpPrU0kMyU/BmhUq3
         WMi47RcJ6VBx3azwKjJr/qYEdnkN1wb1mrPi2AVTqiLAZbY7cu5zjHqa35BhPj+pnYjA
         t77A==
X-Forwarded-Encrypted: i=1; AJvYcCVX7QTbaDurFboia9n6gFWplMj2KuZIgGy8oFqFn3dj4yH4dvbg5+YYjzOV2r+57cc3wWUMP8zSgPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb/eNYOGQqWpahGIFCY6VJU1TQNB3oYQJZRci+gdwwzyDpOXM4
	trTkW5nJWs6hXQvlbPgNh0t8fBsjXSjHrpccPNGdzePCj9Qz9xGm4VrLUOEaFoiauxVwYDQor1u
	/DamLzD7fRkJgKbi7MemWKmYzZtJ+Ws6SKtPM
X-Gm-Gg: ASbGncud3Vi00WVNXFW+mmfSu9KJxbwW9LlsdbixgtDV0MgfYH9+P/JOkdVgJU9r41b
	mQqSSRbl4RAuLJxczIESzAMwOipbc9+fE6OXwQ+/Idwm1+Vs2OzqzSYvohIORbthejdtOvUGX31
	sExZnRI7rmU7QJC1Tzclgh7pbUjmc2BIObOQEsM53bn0FrRDIZyKYNjfF19G4ZDTij7jMrXPJYC
	1DLTMD64JzsrdO7dg==
X-Google-Smtp-Source: AGHT+IExdsquEhg4Y7gn/T31I32x6vp4PP00/sIHuQwzHhGFjnQjuw1ubn2EZCbVr7BAg8ZN3AP7lol3/uimD46c03I=
X-Received: by 2002:a05:6402:51cb:b0:618:2733:1a52 with SMTP id
 4fb4d7f45d1cf-61d26997500mr13189130a12.8.1756908896472; Wed, 03 Sep 2025
 07:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901231457.1179748-1-rdunlap@infradead.org>
 <CAOQ4uxjXvYBsW1Nb2HKaoUg1qi8Pkq1XKtQEbnAvMUGcp7LrZA@mail.gmail.com>
 <5ff4dfe2-271f-4967-bb45-ad59614edc37@infradead.org> <a6246609-3ec0-4e38-8733-b2cf3b8fbd9a@infradead.org>
In-Reply-To: <a6246609-3ec0-4e38-8733-b2cf3b8fbd9a@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 3 Sep 2025 16:14:45 +0200
X-Gm-Features: Ac12FXyjWPU17SHaCP67thoU9lOuY_REmGjEqZhmjb3HYVjgu2ZGEt5MECy2X6E
Message-ID: <CAOQ4uxhN2kPLguMN+VR8qu4AzBzLziFADqJg_dvOOO_gw=GpTw@mail.gmail.com>
Subject: Re: [PATCH v2] uapi/fcntl: define RENAME_* and AT_RENAME_* macros
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, patches@lists.linux.dev, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 2:46=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
>
>
> On 9/2/25 2:31 PM, Randy Dunlap wrote:
> > Hi,
> >
> > On 9/1/25 11:58 PM, Amir Goldstein wrote:
> >> On Tue, Sep 2, 2025 at 1:14=E2=80=AFAM Randy Dunlap <rdunlap@infradead=
.org> wrote:
> >>>
> >>> Define the RENAME_* and AT_RENAME_* macros exactly the same as in
> >>> recent glibc <stdio.h> so that duplicate definition build errors in
> >>> both samples/watch_queue/watch_test.c and samples/vfs/test-statx.c
> >>> no longer happen. When they defined in exactly the same way in
> >>> multiple places, the build errors are prevented.
> >>>
> >>> Defining only the AT_RENAME_* macros is not sufficient since they
> >>> depend on the RENAME_* macros, which may not be defined when the
> >>> AT_RENAME_* macros are used.
> >>>
> >>> Build errors being fixed:
> >>>
> >>> for samples/vfs/test-statx.c:
> >>>
> >>> In file included from ../samples/vfs/test-statx.c:23:
> >>> usr/include/linux/fcntl.h:159:9: warning: =E2=80=98AT_RENAME_NOREPLAC=
E=E2=80=99 redefined
> >>>   159 | #define AT_RENAME_NOREPLACE     0x0001
> >>> In file included from ../samples/vfs/test-statx.c:13:
> >>> /usr/include/stdio.h:171:10: note: this is the location of the previo=
us definition
> >>>   171 | # define AT_RENAME_NOREPLACE RENAME_NOREPLACE
> >>> usr/include/linux/fcntl.h:160:9: warning: =E2=80=98AT_RENAME_EXCHANGE=
=E2=80=99 redefined
> >>>   160 | #define AT_RENAME_EXCHANGE      0x0002
> >>> /usr/include/stdio.h:173:10: note: this is the location of the previo=
us definition
> >>>   173 | # define AT_RENAME_EXCHANGE RENAME_EXCHANGE
> >>> usr/include/linux/fcntl.h:161:9: warning: =E2=80=98AT_RENAME_WHITEOUT=
=E2=80=99 redefined
> >>>   161 | #define AT_RENAME_WHITEOUT      0x0004
> >>> /usr/include/stdio.h:175:10: note: this is the location of the previo=
us definition
> >>>   175 | # define AT_RENAME_WHITEOUT RENAME_WHITEOUT
> >>>
> >>> for samples/watch_queue/watch_test.c:
> >>>
> >>> In file included from usr/include/linux/watch_queue.h:6,
> >>>                  from ../samples/watch_queue/watch_test.c:19:
> >>> usr/include/linux/fcntl.h:159:9: warning: =E2=80=98AT_RENAME_NOREPLAC=
E=E2=80=99 redefined
> >>>   159 | #define AT_RENAME_NOREPLACE     0x0001
> >>> In file included from ../samples/watch_queue/watch_test.c:11:
> >>> /usr/include/stdio.h:171:10: note: this is the location of the previo=
us definition
> >>>   171 | # define AT_RENAME_NOREPLACE RENAME_NOREPLACE
> >>> usr/include/linux/fcntl.h:160:9: warning: =E2=80=98AT_RENAME_EXCHANGE=
=E2=80=99 redefined
> >>>   160 | #define AT_RENAME_EXCHANGE      0x0002
> >>> /usr/include/stdio.h:173:10: note: this is the location of the previo=
us definition
> >>>   173 | # define AT_RENAME_EXCHANGE RENAME_EXCHANGE
> >>> usr/include/linux/fcntl.h:161:9: warning: =E2=80=98AT_RENAME_WHITEOUT=
=E2=80=99 redefined
> >>>   161 | #define AT_RENAME_WHITEOUT      0x0004
> >>> /usr/include/stdio.h:175:10: note: this is the location of the previo=
us definition
> >>>   175 | # define AT_RENAME_WHITEOUT RENAME_WHITEOUT
> >>>
> >>> Fixes: b4fef22c2fb9 ("uapi: explain how per-syscall AT_* flags should=
 be allocated")
> >>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >>> ---
> >>> Cc: Amir Goldstein <amir73il@gmail.com>
> >>> Cc: Jeff Layton <jlayton@kernel.org>
> >>> Cc: Chuck Lever <chuck.lever@oracle.com>
> >>> Cc: Alexander Aring <alex.aring@gmail.com>
> >>> Cc: Josef Bacik <josef@toxicpanda.com>
> >>> Cc: Aleksa Sarai <cyphar@cyphar.com>
> >>> Cc: Jan Kara <jack@suse.cz>
> >>> Cc: Christian Brauner <brauner@kernel.org>
> >>> Cc: Matthew Wilcox <willy@infradead.org>
> >>> Cc: David Howells <dhowells@redhat.com>
> >>> CC: linux-api@vger.kernel.org
> >>> To: linux-fsdevel@vger.kernel.org
> >>>
> >>>  include/uapi/linux/fcntl.h |    9 ++++++---
> >>>  1 file changed, 6 insertions(+), 3 deletions(-)
> >>>
> >>> --- linux-next-20250819.orig/include/uapi/linux/fcntl.h
> >>> +++ linux-next-20250819/include/uapi/linux/fcntl.h
> >>> @@ -156,9 +156,12 @@
> >>>   */
> >>>
> >>>  /* Flags for renameat2(2) (must match legacy RENAME_* flags). */
> >>> -#define AT_RENAME_NOREPLACE    0x0001
> >>> -#define AT_RENAME_EXCHANGE     0x0002
> >>> -#define AT_RENAME_WHITEOUT     0x0004
> >>> +# define RENAME_NOREPLACE (1 << 0)
> >>> +# define AT_RENAME_NOREPLACE RENAME_NOREPLACE
> >>> +# define RENAME_EXCHANGE (1 << 1)
> >>> +# define AT_RENAME_EXCHANGE RENAME_EXCHANGE
> >>> +# define RENAME_WHITEOUT (1 << 2)
> >>> +# define AT_RENAME_WHITEOUT RENAME_WHITEOUT
> >>>
> >>
> >> This solution, apart from being terribly wrong (adjust the source to m=
atch
> >> to value of its downstream copy), does not address the issue that Math=
ew
> >> pointed out on v1 discussion [1]:
> >
> > I didn't forget or ignore this.
> > If the macros have the same values (well, not just values but also the
> > same text), then I don't see why it matters whether they are in some ol=
der
> > version of glibc.
> >
> >> $ grep -r AT_RENAME_NOREPLACE /usr/include
> >> /usr/include/linux/fcntl.h:#define AT_RENAME_NOREPLACE  0x0001
> >>
> >> It's not in stdio.h at all.  This is with libc6 2.41-10
> >>
> >> [1] https://lore.kernel.org/linux-fsdevel/aKxfGix_o4glz8-Z@casper.infr=
adead.org/
> >>
> >> I don't know how to resolve the mess that glibc has created.
> >
> > Yeah, I guess I don't either.
> >
> >> Perhaps like this:
> >>
> >> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> >> index f291ab4f94ebc..dde14fa3c2007 100644
> >> --- a/include/uapi/linux/fcntl.h
> >> +++ b/include/uapi/linux/fcntl.h
> >> @@ -155,10 +155,16 @@
> >>   * as possible, so we can use them for generic bits in the future if =
necessary.
> >>   */
> >>
> >> -/* Flags for renameat2(2) (must match legacy RENAME_* flags). */
> >> -#define AT_RENAME_NOREPLACE    0x0001
> >> -#define AT_RENAME_EXCHANGE     0x0002
> >> -#define AT_RENAME_WHITEOUT     0x0004
> >> +/*
> >> + * The legacy renameat2(2) RENAME_* flags are conceptually also
> >> syscall-specific
> >> + * flags, so it could makes sense to create the AT_RENAME_* aliases
> >> for them and
> >> + * maybe later add support for generic AT_* flags to this syscall.
> >> + * However, following a mismatch of definitions in glibc and since no
> >> kernel code
> >> + * currently uses the AT_RENAME_* aliases, we leave them undefined he=
re.
> >> +#define AT_RENAME_NOREPLACE    RENAME_NOREPLACE
> >> +#define AT_RENAME_EXCHANGE     RENAME_EXCHANGE
> >> +#define AT_RENAME_WHITEOUT     RENAME_WHITEOUT
> >> +*/
> >
> > Well, we do have samples/ code that uses fcntl.h (indirectly; maybe
> > that can be fixed).
> > See the build errors in the patch description.
> >
> >
> >>  /* Flag for faccessat(2). */
> >>  #define AT_EACCESS             0x200   /* Test access permitted for
> >
> > With this patch (your suggestion above):
> >
> > IF a userspace program in samples/ uses <uapi/linux/fcntl.h> without
> > using <stdio.h>, [yes, I created one to test this] and without using
> > <uapi/linux/fs.h> then the build fails with similar build errors:
> >
> > ../samples/watch_queue/watch_nostdio.c: In function =E2=80=98consumer=
=E2=80=99:
> > ../samples/watch_queue/watch_nostdio.c:33:32: error: =E2=80=98RENAME_NO=
REPLACE=E2=80=99 undeclared (first use in this function)
> >    33 |                         return RENAME_NOREPLACE;
> > ../samples/watch_queue/watch_nostdio.c:33:32: note: each undeclared ide=
ntifier is reported only once for each function it appears in
> > ../samples/watch_queue/watch_nostdio.c:37:32: error: =E2=80=98RENAME_EX=
CHANGE=E2=80=99 undeclared (first use in this function)
> >    37 |                         return RENAME_EXCHANGE;
> > ../samples/watch_queue/watch_nostdio.c:41:32: error: =E2=80=98RENAME_WH=
ITEOUT=E2=80=99 undeclared (first use in this function)
> >    41 |                         return RENAME_WHITEOUT;
> >
> > This build succeeds with my version 1 patch (full defining of both
> > RENAME_* and AT_RENAME_* macros). It fails with the patch that you sugg=
ested
> > above.
> >
> > OK, here's what I propose.
> >
> > a. remove the unused and (sort of) recently added AT_RENAME_* macros
> > in include/uapi/linux/fcntl.h. Nothing in the kernel tree uses them.
> > This is:
> >
> > commit b4fef22c2fb9
> > Author: Aleksa Sarai <cyphar@cyphar.com>
> > Date:   Wed Aug 28 20:19:42 2024 +1000
> >     uapi: explain how per-syscall AT_* flags should be allocated
> >
> > These macros should have never been added here IMO.
> > Just putting them somewhere as examples (in comments) would be OK.
> >

I agree.
I did not get this patch from Aleksa,
but I proposed something similar above.

> > This alone fixes all of the build errors in samples/ that I originally
> > reported.
> >
> > b. if a userspace program wants to use the RENAME_* macros, it should
> > #include <linux/fs.h> instead of <linux/fcntl.h>.
> >
> > This fixes the "contrived" build error that I manufactured.
> >
> > Note that some programs in tools/ do use AT_RENAME_* (all 3 macros)
> > but they define those macros locally.
> >
>
> And after more testing, this is what I think works:
>
> a. remove all of the AT_RENAME-* macros from <uapi/linux/fcntl.h>
>    (as above)

ok.

>
> b. put the AT_RENAME_* macros into <uapi/linux/fs.h> like so:
>
> +/* Flags for renameat2(2) (must match legacy RENAME_* flags). */
> +# define AT_RENAME_NOREPLACE RENAME_NOREPLACE
> +# define AT_RENAME_EXCHANGE RENAME_EXCHANGE
> +# define AT_RENAME_WHITEOUT RENAME_WHITEOUT
>
> so that they match what is in upstream glibc stdio.h, hence not
> causing duplicate definition errors.

Disagree.
We do not need to define them at all.

The *only* reason we defined them in fcntl.h is so the
definition will be together with the rest of the AT_ flags.
Now we change that to a comment, but there is no reason to
define them at fs.h. Why would we need to do that?

Thanks,
Amir.

