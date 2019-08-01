Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1348E7E5D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 00:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389858AbfHAWlp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 18:41:45 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38821 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfHAWlo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:41:44 -0400
Received: by mail-vs1-f68.google.com with SMTP id k9so50022864vso.5;
        Thu, 01 Aug 2019 15:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5XjyuY1IE5bAuDy8zOdTVnTt/SvR/4Vs1fx9oFMMshc=;
        b=gw/Os3cgmHDMwyJIYBUCakgb5inJwKkgKLcUQ57kfF7drBu3lG4fPuPe6TmrxqzGpw
         Lb+SCxezW3CSYrsagIfZg90ZE64tWaM8cXp0xWzEPdm+logp3NVEkRzPmO/9+KBs7/L2
         xgMTpARGR+aBmjyz8q8fAJ5CwhBZeMQ3+O9vpn2SZz8mq1yHnZUTc7fiV82oTBVle3TQ
         4uB05vddocJt6q6NyPlsClA91PGnlIHxsXlZlViiBp6LRi+dFjcdwy7g3FAgRvrs94M5
         PIwktB2hj9mVKONIZLbCalf0So8zwoaOFzmtvYelvtgJgtywkfl88goJouo7QcC+4v1g
         XDPA==
X-Gm-Message-State: APjAAAXPUiroXFYg7+qD2dRiN+NATveU29jiEDpnL/oxSmMeWtGIM8Lj
        8tIz0tP3aVgr84hlT6QT0yfBIKku0x0neisneQA=
X-Google-Smtp-Source: APXvYqyS3tqnRdXlhIjQr5O//en4OGiGGm2nRDlOAOntvfhhFl+1tSRtFSPFVobfUrKE7B1PYzPpMSshhx2oM4o7qF4=
X-Received: by 2002:a67:e8c3:: with SMTP id y3mr81458293vsn.94.1564699303236;
 Thu, 01 Aug 2019 15:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <54a35258-081a-71cc-ef1b-9fffcf5e7f9f@nchc.org.tw> <CAB3wodfF=Gc3FbKedU4JBWi8hZLxcBPUtVPipsCVnaHdFXGk8Q@mail.gmail.com>
In-Reply-To: <CAB3wodfF=Gc3FbKedU4JBWi8hZLxcBPUtVPipsCVnaHdFXGk8Q@mail.gmail.com>
From:   =?UTF-8?B?TMOhc3psw7MgQsO2c3rDtnJtw6lueWkgKEdDUyk=?= 
        <gcs@debian.org>
Date:   Fri, 2 Aug 2019 00:41:30 +0200
Message-ID: <CAKjSHr0vTK6En1_n6GwArV0N6=kM=Czbx2SYat9vK71HuyzMAA@mail.gmail.com>
Subject: Re: Bug#921146: Program mksquashfs from squashfs-tools 1:4.3-11 does
 not make use all CPU cores
To:     Phillip Lougher <phillip.lougher@gmail.com>,
        921146@bugs.debian.org, Chris Lamb <lamby@debian.org>
Cc:     hartmans@debian.org, debian-ctte@lists.debian.org,
        Alexander Couzens <lynxis@fe80.eu>,
        linux-fsdevel@vger.kernel.org,
        linux-embedded <linux-embedded@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 1, 2019 at 5:27 PM Phillip Lougher
<phillip.lougher@gmail.com> wrote:
> On Wed, 31 Jul 2019 17:43:44 +0200 Alexander Couzens <lynxis@fe80.eu> wrote:
> > > On Wed, Jul 31, 2019 at 3:06 AM Steven Shiau <steven@nchc.org.tw>
> > > wrote: [...]
> > >  As mentioned in the past, it's the
> > > 0016-remove-frag_deflator_thread.patch that needs either reverted or
> > > fixed by it's original author, Alexander Couzens (added to this mail).
> >
> > Since I've full weeks ahead, I can not make any estimation when
> > I've time to look onto the performance issue.
>
> That patch is a laughable piece of rubbish.  I believe both you
> people (the Debian maintainer and author) are in total denial
> about your incompetence in this matter.  This is obviously just my
> opinion I've formed over the last couple of months, in case you want to
> claim that it is libellous.
 Good to know that you could form your opinion in the last couple of
months as on the other side I didn't know you until last week.

> It is, obvious, from the patch where the problem lies.  You *remove*
> the parallel fragment compressor threads, and move the work onto the
> main thread.
>
> Now what do you think that does?  It completely removes a significant
> amount of the parallelism of Mksquashfs and makes the main thread
> a bottleneck.
>
> This is your fault and your problem, and it lies in your lack of
> understanding.
 Who said we don't know where is the bottleneck? Alexander only stated
he can't work on fixing the bottleneck for some weeks.
While I don't know Alexander in person, according to my information he
contributes to 227 projects. Those programmed in C, C++, Python and
Rust; I wouldn't say he lacks any understanding in code.

> Yet you continually blame your inability to make Mksquashfs work
> correctly on *my* code being old and unmaintained and badly written.
 Never said that 1) mksquashfs doesn't work correctly, 2) it has a
problem which you don't fix and not possible to fix by others because
your code quality is bad. Please prove it where I have said such
things.

> This can be seen from the following excerpt from a post in this
> Debian bug thread made by the Debian maintainer.
>
> "> First of all, as squashfs-tools wasn't written in the last years, when
> > reproducible builds became more famous. So it's not written
> > with reproducible building in mind.
> > For me is reproducible builds more important than using all cpu cores.
> > But I don't use it with gigabytes images.
>  Yeah, it's quite an old software without real development in the recent years."
 Just for the record, this is Debian bugreport #919207 [1] started by
a third person (not me or Alexander), Chris Lamb. Neither written by
me, but Alexander[2]. More importantly it only states that development
goals was not that the result image should always be the same (be
reproducible). It doesn't say anything about code quality.

> " This sounds more complex work than it can be achieved in this week.
> Maybe a complete rewrite would be better then on the long run."
 Written by me, talking _about the patch_ used for the
reproducibility[3] and _not_ about your code, see which part of the
previous email was referred above.

> Constantly pointing the blame at my tools and my code.
 Again, where is the blame on your code? You didn't code it with
reproducibility in mind, but it doesn't mean in any way that your code
would be bad.

> This is typical of the poor worker who chooses to blame everyone
> else but himself.
 Let me ask, who is the one who puff it up, cross post to unrelated
mailing lists (like LKML, which doesn't involved with Debian matters
or squashfs-tools application development)?

> None of that is the case.  50% of the code-base of Squashfs-tools
> was (re-)written in the last 9 years as part of on-going improvements.
> It has also been maintained across that period.
 Until recently the know VCS location was at SourceForge[4]. The last
commit there from 2017-08-15, adding zstd support by Sean Purcell. In
2017 there were eight commits, the one mentioned previously and thinks
like "Make all compressor functions static", "Fix pseudo format error
message", "add pseudo definition format to the help text" and "improve
the error message when filenames with spaces are used" etc. Doesn't
look like a rewrite.

> As for your specific claim that Mksquashfs can't be made to produce
> reproducible builds because it is old and written before reproducible
> builds became popular.  That is abject nonsense.
 Where do you see the statement it can't be made to produce
reproducible images? Again, it only said when you originally coded
squashfs-tools this was not in your goals.

> I added reproducible builds to Mksquashfs.  It took one weekend.
>
> https://github.com/plougher/squashfs-tools/commit/24da0c63c80be64e1adc3f24c27459ebe18a19af
 On June the 30th, 2019 just for the record. For some reason you
didn't notice anyone about this, that you have the correct solution
when talking about this matter[5].

> Squashfs-tools-ng, this is a rogue project masquerading as an
> official new upstream .  It is neither official nor a new upstream.  As
> Squashfs author and maintainer I completely disassociate that project
> with the Squashfs project.
 It has a different name, immediately stating it's "a new set of tools
for working with SquashFS images"[6]. Where do you see it saying it's
the main project for squashfs images and/or your code is no more or
just shouldn't be used? Then your code is under the GPL-2 or later
license meaning it can be changed, extended and/or reimplemented with
a different name. Nothing happened against this license or against
your personal life / promotion.
What else David should add to prevent all of your misunderstandings?

> I also have publicly stated that this project is spreading falsehoods and
> that it is defamatory to me as the Squashfs author and maintainer.
 I still don't see these nor a personal offense against you.

> I have lived for a couple of months with you two people bad-mouthing
> Squashfs tools, it's code-base and my maintenance.
 As for me, I've stated only public facts. Like that two security
vulnerabilities, CVE-2015-4645 and CVE-2015-4646 were reported on July
20, 2015 [7] (maybe even before) and you only fixed these on July 15,
2019 [8] with last bits on July 20, 2019 [9] (exactly) four years
later. Didn't judged you on this or questioned why it took so long if
you are such an active maintainer of squashfs-tools.

> I have absolutely had enough.
>
> I have CC'd this to the Debian project leader and the Debian technical
> commitee, and also to linux-kernel, linux-fsdevel and linux-embedded
> for wider attention.
 Let me add Chris Lamb then the previous Debian Project Leader (also
British just like you [as I know] and you may sit down and talk about
this in person) who asked for the reproducibility patch / build in the
first place.

> What else do I have to do to make you stop bad-mouthing Squashfs?  Sue?
 If you feel yourself better with that, be my guest. I don't know who
is the lawyer of Debian, but I'm sure s/he can show you that it's only
you who dance this storm.

Regards,
Laszlo/GCS
[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=919207#5
[2] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=919207#83
[3] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=919207#88
[4] https://sourceforge.net/p/squashfs/code/ci/e38956b92f738518c29734399629e7cdb33072d3/log/?path=
[5] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=921146#75
[6] https://github.com/AgentD/squashfs-tools-ng
[7] https://lwn.net/Articles/651775/
[8] https://github.com/plougher/squashfs-tools/commit/f95864afe8833fe3ad782d714b41378e860977b1
[9] https://github.com/plougher/squashfs-tools/commit/ba215d73e153a6f237088b4ecb88c702bb4d4183
