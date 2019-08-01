Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F877DEBA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 17:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbfHAPXt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 11:23:49 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36544 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbfHAPXr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:23:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id i21so69811178ljj.3;
        Thu, 01 Aug 2019 08:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=9ZCtRO1EfjMBdscr16tVWg4PD3vV4eXgXVgNm+QaIM8=;
        b=Lifoc/9S+ScPBLNEdfgggcKBxgNayI/MmQY3QMeZ3YiCn51pH+DSbRjgFHbX3KXLuD
         kT0ksoEbWbdJkTKbo96qtqrwYjua8wGANO8LPp6KW3cSwP5YcD8fChTQ5F48zsGGiLpw
         zEToFI/V6Bd/EDqIePE6JgCy7GLwLRBMf4024LubyXZFVbcaSOpG6kpbGNksNUSXrdpZ
         jd4MOZ9sVF9DKgN1Pd1x0cEfoPm20WG3AHu7k9ZyLTyHD0nGES3cHYVeJ65/eoOpkf2A
         74tAZtou3FCvN4z+mRv3XeP/67Aw8uYFbgd/xEgWyGSZubZO64ch1Ahx8FHnyCTNJZg+
         HaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=9ZCtRO1EfjMBdscr16tVWg4PD3vV4eXgXVgNm+QaIM8=;
        b=I8MQcDkPj2Q3uwZk+/7MZjfQNDWKX7xvupN46ep8+uT1WA/NFYqkh0rDhns0XXhHC4
         s8yqOItCPsf96AecsSA8YPzacUxoinYUidZ2dqO6ocMdSdWBpORiEIrPAQm6ViSkMJXX
         JsWK7U/uFQYLfTLO7SQ8GsMjq0js16Hf+MtZllcVBos/wsaD0kqZwu3puUTlhwOOL/0m
         isgl6pd1hvppSfDTMIVxpkVsZb8+OYuA9sYdh5g0Uj5PH7Asy+NM5c7HtbuOMOktUZBV
         SSvh0pPixANr00z5Nw65188gKiSuVC+mQisABwgkQlU11TxRSTugcCuGeY2jVnv9BuEq
         UFxQ==
X-Gm-Message-State: APjAAAWjfs78r11xgb/4QUWBYzMLsFYRZpbjj74O2t59ZodDKOfo7iRj
        GtugcfokGfZTvtBaO4WTUJhPDA4b9PCBau0QQMk=
X-Google-Smtp-Source: APXvYqwGiuDLdol7cPKanPh7gLZuN8kHymeW3nXF5KjmcZp7I5lJdCoUUigBeS+zkKE7PSU0buogsjBTll47EG9o8c4=
X-Received: by 2002:a2e:868e:: with SMTP id l14mr20379185lji.16.1564673024673;
 Thu, 01 Aug 2019 08:23:44 -0700 (PDT)
MIME-Version: 1.0
From:   Phillip Lougher <phillip.lougher@gmail.com>
Date:   Thu, 1 Aug 2019 16:23:33 +0100
Message-ID: <CAB3wodfF=Gc3FbKedU4JBWi8hZLxcBPUtVPipsCVnaHdFXGk8Q@mail.gmail.com>
Subject: Bug#921146: Program mksquashfs from squashfs-tools 1:4.3-11 does not
 make use all CPU cores
To:     921146@bugs.debian.org
Cc:     hartmans@debian.org, debian-ctte@lists.debian.org,
        =?UTF-8?B?TMOhc3psw7MgQsO2c3rDtnJtw6lueWkgKEdDUyk=?= 
        <gcs@debian.org>, Alexander Couzens <lynxis@fe80.eu>,
        linux-fsdevel@vger.kernel.org,
        linux-embedded <linux-embedded@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 31 Jul 2019 17:43:44 +0200 Alexander Couzens <lynxis@fe80.eu> wrote=
:
> Hi L=C3=A1szl=C3=B3,
>
> > On Wed, Jul 31, 2019 at 3:06 AM Steven Shiau <steven@nchc.org.tw>
> > wrote: [...]
> >  As mentioned in the past, it's the
> > 0016-remove-frag_deflator_thread.patch that needs either reverted or
> > fixed by it's original author, Alexander Couzens (added to this mail).
>
> Since I've full weeks ahead, I can not make any estimation when
> I've time to look onto the performance issue.
>

That patch is a laughable piece of rubbish.  I believe both you
people (the Debian maintainer and author) are in total denial
about your incompetence in this matter.  This is obviously just my
opinion I've formed over the last couple of months, in case you want to
claim that it is libellous.

It is, obvious, from the patch where the problem lies.  You *remove*
the parallel fragment compressor threads, and move the work onto the
main thread.

Now what do you think that does?  It completely removes a significant
amount of the parallelism of Mksquashfs and makes the main thread
a bottleneck.

This is your fault and your problem, and it lies in your lack of
understanding.

Yet you continually blame your inability to make Mksquashfs work
correctly on *my* code being old and unmaintained and badly written.

This can be seen from the following excerpt from a post in this
Debian bug thread made by the Debian maintainer.

"> First of all, as squashfs-tools wasn't written in the last years, when
> reproducible builds became more famous. So it's not written
> with reproducible building in mind.
> For me is reproducible builds more important than using all cpu cores.
> But I don't use it with gigabytes images.
 Yeah, it's quite an old software without real development in the recent ye=
ars."

and

" This sounds more complex work than it can be achieved in this week.
Maybe a complete rewrite would be better then on the long run."

Constantly pointing the blame at my tools and my code.

This is typical of the poor worker who chooses to blame everyone
else but himself.

None of that is the case.  50% of the code-base of Squashfs-tools
was (re-)written in the last 9 years as part of on-going improvements.
It has also been maintained across that period.

As for your specific claim that Mksquashfs can't be made to produce
reproducible builds because it is old and written before reproducible
builds became popular.  That is abject nonsense.

I added reproducible builds to Mksquashfs.  It took one weekend.

https://github.com/plougher/squashfs-tools/commit/24da0c63c80be64e1adc3f24c=
27459ebe18a19af

> > > Or shall we gradually switch to squashfs-tools-ng is the upstream
> > > is more active:
> > > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D931965
> >  It's under investigation. I'm traveling and will only arrive back
> > home on Sunday evening. Expect more details on this next week.
>
> I also seen the upcoming squashfs-tools-ng rising and quite interested
> to test it and reading the code.
> Depending on tests & the code, I could imagine I'll put my effort and
> time towards squashfs-tools-ng.
>
> @L=C3=A1szl=C3=B3 It should be your call to revert or not. For sure there=
 are
> also downstream users who need reproducible builds (e.g. tails) who
> may also change to squashfs-tools-ng if -ng is the only reproducible
> squashfs generator in debian.
>

Upstream Squashfs-tools now produces reproducible builds.

Squashfs-tools-ng, this is a rogue project masquerading as an
official new upstream .  It is neither official nor a new upstream.  As
Squashfs author and maintainer I completely disassociate that project
with the Squashfs project.

I also have publicly stated that this project is spreading falsehoods and
that it is defamatory to me as the Squashfs author and maintainer.

See:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D931965#29

and

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D931965#34

I have lived for a couple of months with you two people bad-mouthing
Squashfs tools, it's code-base and my maintenance.

I have absolutely had enough.

I have CC'd this to the Debian project leader and the Debian technical
commitee, and also to linux-kernel, linux-fsdevel and linux-embedded
for wider attention.

What else do I have to do to make you stop bad-mouthing Squashfs?  Sue?

Yours

Dr. Phillip Lougher

> Hopefully I'll find time to look into it.
>
> Best Regards,
> lynxis
> --
> Alexander Couzens
>
> mail: lynxis@fe80.eu
> jabber: lynxis@fe80.eu
> gpg: 390D CF78 8BF9 AA50 4F8F  F1E2 C29E 9DA6 A0DF 8604
