Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A826FEA609
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 23:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfJ3WQK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 18:16:10 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:46108 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfJ3WQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 18:16:09 -0400
Received: by mail-il1-f195.google.com with SMTP id m16so3540408iln.13;
        Wed, 30 Oct 2019 15:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6aG6jaBQjykZMmoKoaVIScDbAeprHhorDd6ERUFUGTc=;
        b=F/WgYu38dQJ2we3ACG0fFRAum6GXnziWqvKxwc8o0MXX4MEMwQjV5ERndrF8qyP56o
         v1SGNFDy6uxA/Qt380IHl6jVwBQlM2/PcH3LoRrBS/B/d32S9STTGSiPf8zyyv0dWAG/
         kIyzrcu1RagGogthigCxLj//XMUBsTIdMniQ1B8oZfLrdg2F/l0T3xzIkDP7PvV/D6r/
         kGcWQCxBhCGCy/pFiwiGNyQFPrOyy1tea67MLK7UErHj9vUy4GXdkkTjdqfF2UeV4oHo
         r2CdQkzRIUGOD0TXx1oG8704nL8dDxiPNuyeoNx0Zh654jg3a1ExuijDav1Y2jU6SLrR
         ss8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6aG6jaBQjykZMmoKoaVIScDbAeprHhorDd6ERUFUGTc=;
        b=GZdgG2YVsLv1tHRBDRWwOfWGdQ+GnTvUi8rY6pBZpzFf51VMCRL/wWHoUyyS2ICf1Z
         yZLmqO9zJRKaePIAajBgb/1p73BoMmNsmSbtbK9t8yqvclLEtZ00lLFfidf+m+Jp5uW3
         ysaSKgDtuTMflGkO4e90AgGOZNufn/AKzZ8p5Bq4cdbCZ1bvilYEcSq+sc4uOxhPRcti
         rxmSEMiY4ZVH2O18eg/ARV98zBgUfCCin3al2BJOBvPVTO02O1AzqKdLgTmagZxQacgX
         JBtNG2O41xZQNG51DBWVHUrXpB7v7W2n0yJ9mZkXrP8KfNd7Bi/JxEPxQIWxMEL7lcPW
         NQPg==
X-Gm-Message-State: APjAAAU1RrSKfItOOhsCed499ApftW2gakTY+NNfJvkD+AHLUUffM4WF
        i8JBQBzVP9I3xCfixgl/HzbY6tdMNNraYi4+VT0=
X-Google-Smtp-Source: APXvYqwv8oUCajfo1pOFHmNy6b86xLBgxyYuXpSl7PVowx/iM+uUjWJhp9J3RH+BSJI98acLMwAdZJwdE8J8nyDheQA=
X-Received: by 2002:a92:8703:: with SMTP id m3mr2573584ild.131.1572473768596;
 Wed, 30 Oct 2019 15:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
 <CAOi1vP97DMX8zweOLfBDOFstrjC78=6RgxK3PPj_mehCOSeoaw@mail.gmail.com> <4892d186-8eb0-a282-e7e6-e79958431a54@rasmusvillemoes.dk>
In-Reply-To: <4892d186-8eb0-a282-e7e6-e79958431a54@rasmusvillemoes.dk>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 30 Oct 2019 23:16:23 +0100
Message-ID: <CAOi1vP9paV2-2_S0NgfbZDE6+5kqHXVc9xabHVC-2Ss1MmXkCg@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 30, 2019 at 9:35 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 30/10/2019 17.19, Ilya Dryomov wrote:
> > On Thu, Oct 24, 2019 at 11:49 AM David Howells <dhowells@redhat.com> wrote:
> >>  /*
> >> - * We use a start+len construction, which provides full use of the
> >> - * allocated memory.
> >> - * -- Florian Coosmann (FGC)
> >> - *
> >> + * We use head and tail indices that aren't masked off, except at the point of
> >> + * dereference, but rather they're allowed to wrap naturally.  This means there
> >> + * isn't a dead spot in the buffer, provided the ring size < INT_MAX.
> >> + * -- David Howells 2019-09-23.
> >
> > Hi David,
> >
> > Is "ring size < INT_MAX" constraint correct?
>
> No. As long as one always uses a[idx % size] to access the array, the
> only requirement is that size is representable in an unsigned int. Then
> because one also wants to do the % using simple bitmasking, that further
> restricts one to sizes that are a power of 2, so the end result is that
> the max size is 2^31 (aka INT_MAX+1).

I think the fact that indices are free running and wrap at a power of
two already restricts you to sizes the are a power of two, independent
of how you do masking.  If you switch to a[idx % size], size still has
to be a power of two for things to work when idx wraps.  Consider:

  size = 6
  head = tail = 4294967292, empty buffer

  push  4294967292 % 6 = 0
  push  4294967293 % 6 = 1
  push  4294967294 % 6 = 2
  push  4294967295 % 6 = 3
  push           0 % 6 = 0  <-- expected 4, overwrote a[0]

>
> > I've never had to implement this free running indices scheme, but
> > the way I've always visualized it is that the top bit of the index is
> > used as a lap (as in a race) indicator, leaving 31 bits to work with
> > (in case of unsigned ints).  Should that be
> >
> >   ring size <= 2^31
> >
> > or more precisely
> >
> >   ring size is a power of two <= 2^31
>
> Exactly. But it's kind of moot since the ring size would never be
> allowed to grow anywhere near that.

Thanks for confirming.  Even if it's kind of moot, I think it should be
corrected to avoid confusion.

                Ilya
