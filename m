Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D45177D4A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 18:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgCCRW1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 12:22:27 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39327 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729404AbgCCRW1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:22:27 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 023HM9dR009316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Mar 2020 12:22:13 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 818CE42045B; Tue,  3 Mar 2020 12:22:09 -0500 (EST)
Date:   Tue, 3 Mar 2020 12:22:09 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     lampahome <pahome.chen@mirlab.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: why do we need utf8 normalization when compare name?
Message-ID: <20200303172209.GB61444@mit.edu>
References: <CAB3eZfv4VSj6_XBBdHK12iX_RakhvXnTCFAmQfwogR34uySo3Q@mail.gmail.com>
 <20200302103754.nsvtne2vvduug77e@yavin>
 <20200302104741.b5lypijqlbpq5lgz@yavin>
 <CAB3eZfuAXaT4YTBSZ4sGe=NP8=71OT8wu7zXMzOjkd4NzjtXag@mail.gmail.com>
 <20200303070928.aawxoyeq77wnc3ts@yavin>
 <CAB3eZfu1=-FwJTnnH=sfg=J2gkeF0bgMs43V5tSkxdqP+m+R9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB3eZfu1=-FwJTnnH=sfg=J2gkeF0bgMs43V5tSkxdqP+m+R9A@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 03, 2020 at 06:13:56PM +0800, lampahome wrote:
> 
> > And yes, once the strings are normalised and encoded as UTF-8 you then
> > do a byte-by-byte comparison (if the comparison is case-insensitive then
> > fs/unicode/... will case-fold the Unicode symbols during normalisation).
> 
> What I'm confused is why encoded as utf-8 after normalize finished?
> From above, turn "ñ" (U+00F1) and "n◌̃" (U+006E U+0303) into the same
> Unicode string. Then why should we just compare bytes from normalized.

For the same reason why we don't upcase or downcase all of the letters
in a directory with case-folding.  The term for this is
"case-preserving, case-insensitive" matching.  So that means that if
you save a file as "Makefile", ls will return "Makefile", and not
"MAKEFILE" or "makefile".

Of course, if you delete or truncate "makefile", it will affect the
file stored in the directory as "Makefile", and the file system will
not allow a directory with case-folding enabled to contain "makefile"
and "Makefile" at the same time.

Simiarly, with normalization, we preserve the existing utf-8 form
(both the composed and decomposed forms are valid utf-8), but we
compare without taking the composition form into account.

Cheers,

					- Ted

P.S.  Some people may hate this, but if the goal is interoperability
with how Windows and MacOS does things, this is basically what they do
as well.  (Well, mostly; MacOS is a little weird for historical
reasons.)

P.P.S.  And before you comment on it, as one Internationalization
expert once said, I18N *is* complicated.  It truly would be easier to
teach all of the world to speak a single language and use it as the
"Federation Standard" language, ala Star Trek.  For better or for
worse, that's not happening, and so we deal with the world as it is,
not as we would like it to be.  :-)

