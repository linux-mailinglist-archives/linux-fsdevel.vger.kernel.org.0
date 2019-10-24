Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 421DCE3EE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 00:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbfJXWQV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 18:16:21 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:38566 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbfJXWQV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:16:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 27361609D2DE;
        Fri, 25 Oct 2019 00:16:18 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id luVOrCdfBLvm; Fri, 25 Oct 2019 00:16:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A2689609D2E3;
        Fri, 25 Oct 2019 00:16:17 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id viiE1HXyCX6l; Fri, 25 Oct 2019 00:16:17 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 827E2609D2DE;
        Fri, 25 Oct 2019 00:16:17 +0200 (CEST)
Date:   Fri, 25 Oct 2019 00:16:17 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-ID: <854944926.38488.1571955377425.JavaMail.zimbra@nod.at>
In-Reply-To: <CAJCQCtQhCRPG-UV+pcraCLXM5cVW887uX1UoymQ8=3Mk56w1Ag@mail.gmail.com>
References: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com> <20191023115001.vp4woh56k33b6hiq@pali> <CAJCQCtTZRoDKWj2j6S+_iWJzA+rejZx41zwM=VKgG90fyZhX6w@mail.gmail.com> <20191023171611.qfcwfce2roe3k3qw@pali> <CAFLxGvxCVNy0yj8SQmtOyk5xcmYag1rxe3v7GtbEj8fF1iPp5g@mail.gmail.com> <CAJCQCtTEN50uNmuSz9jW5Kk51TLmB2jfbNGxceNqnjBVvMD9ZA@mail.gmail.com> <CAFLxGvwDraUwZOeWyGfVAOh+MxHgOF--hMu6P4J=P6KRspGsAA@mail.gmail.com> <CAJCQCtQhCRPG-UV+pcraCLXM5cVW887uX1UoymQ8=3Mk56w1Ag@mail.gmail.com>
Subject: Re: Is rename(2) atomic on FAT?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: Is rename(2) atomic on FAT?
Thread-Index: NrDWwQUMFxD9semczhk+jcZ70iTM0Q==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Chris Murphy" <lists@colorremedies.com>
> An: "Richard Weinberger" <richard.weinberger@gmail.com>
> CC: "Chris Murphy" <lists@colorremedies.com>, "Pali Rohár" <pali.rohar@gmail.com>, "linux-fsdevel"
> <linux-fsdevel@vger.kernel.org>
> Gesendet: Donnerstag, 24. Oktober 2019 23:46:43
> Betreff: Re: Is rename(2) atomic on FAT?

> On Thu, Oct 24, 2019 at 12:22 AM Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
>>
>> On Wed, Oct 23, 2019 at 11:56 PM Chris Murphy <lists@colorremedies.com> wrote:
>> > Any atomicity that depends on journal commits cannot be considered to
>> > have atomicity in a boot context, because bootloaders don't do journal
>> > replay. It's completely ignored.
>>
>> It depends on the bootloader. If you care about atomicity you need to handle
>> the journal.
>> There are also filesystems which *require* the journal to be handled.
>> In that case you can still replay to memory.
> 
> I'm vaguely curious about examples of bootloaders that do journal
> replay, only because I can't think of any that apply. Certainly none
> that do replay on either ext4 or XFS. I've got some stale brain cells
> telling me there was at one time JBD code in GRUB for, I think ext3
> journal replay (?) and all of that got ripped out a very long time
> ago. Maybe even before GRUB 2.

U-boot, for example. Of course it does not so for any filesystem, but where
it is needed and makes sense.

Another approach is using Linux as bootloader and kexec another kernel.
That way you can have a full filesystem implementation and bring the filesystem
in a consistent state before reading from it.
 
> 
>> And yes, filesystem implementations in many bootloaders are in beyond
>> shameful state.
> 
> Right. And while that's polite language, in their defence its just not
> their area of expertise. I tend to think that bootloader support is a
> burden primarily on file system folks. If you want this use case
> supported, then do the work. Ideally the upstreams would pair
> interested parties from each discipline to make this happen. But
> anyway, as I've heard it described by file system folks, it may not be
> practical to support it, in which case for the atomic update use case,
> the modern journaled file systems are just flat out disqualified.
> 
> Which again leads me to FAT. We must have a solution that works there,
> even if it's some odd duck like thing, where the FAT ESP is
> essentially a static configuration, not changing, that points to some
> other block device (a different partition and different file system)
> that has the desired behavioral charactersistics.
> 
>> > If a journal is present, is it appropriate to consider it a separate
>> > and optional part of the file system?
>>
>> No. This is filesystem specific.
> 
> I understand it's optional for ext3/4 insofar as it can optionally be
> disabled, where on XFS it's compulsory. But mere presence of a journal
> doesn't mean replay is required, there's a file system specific flag
> that indicates replay is needed for the file system to be valid/cought
> up to date. To what degree a file system indicating journal replace is
> required, but can't be replayed, is still a valid file system isn't
> answered by file system metadata. The assumption is, replay must
> happen when indicated. So if a bootloader flat out can't do that, it
> essentially means the combination of GRUB2, das uboot,
> syslinux/extlinux and ext3/4 or XFS, is *proscribed* if the use case
> requires atomic kernel updates. Given the current state of affairs.
> 
> So that leads me to, what about FAT? i.e. how does this get solved on
> FAT? And does that help us solve it on journaled file systems? If not,
> can it also be generic enough to solve it here? I'm actually not
> convinced it can be solved in journaled file systems at all, unless
> the bootloader can do journal replay, but I'm not a file system expert
> :P

Like I mentioned above, use Linux as bootloader.
Have a minimal Linux kernel which can do kexec and the journaling filesystem
of your choice.

Thanks,
//richard
