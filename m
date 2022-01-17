Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8824490946
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 14:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbiAQNPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 08:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiAQNPF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:15:05 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96621C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jan 2022 05:15:05 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id v1so21350079ioj.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jan 2022 05:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gPKU1zeN3T1GgQN58eSxhdaO1MqN1wWtekgN4XOECNE=;
        b=IjkwiGLPAQg4Cpq3DTbv/jg3uwKqnYVM4tQM1MVCyYAtdVTbZ+uci1ABGBDWISaTIr
         GT1To9Gw5jqQkAMYVZyMoZRwDqGNxxVpsTkAwIAXw5S+ypP7heOaLcnMAoihrQgrsIrY
         fTgsMZgx/HGq8za4ItCuTvSPRM1R48n05voRgPdpITbUWRsL3C/kpDiWzJUnQF2gSrTH
         ouwzAtLKRlKgoPGoVYFLFPMkLUq5Y6aJHistXBZCXmlZXTf8vQic1lO9/XfwIVUynkyQ
         xgFDVf+2MHwXsqvb5fVP+G7FZ/dLpakcuCV5qffcFeFYLS+3LASLLOy29APXrhit1KzS
         7OcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gPKU1zeN3T1GgQN58eSxhdaO1MqN1wWtekgN4XOECNE=;
        b=5fI/MMNWGWSygHld18HvaDVueMoHf3p+a66RVyd5TD5AusxUOa3tYktk/HM0BiMSHt
         02E5a6kXFHFARpx938w2ZgKb/qVac044BpW++yAORaUaUJNYZ1pQEIGbZ2WNRoB3SHtN
         THgf7QbE/FfiPBbdYsOlUxN2p9xyBssdafpF35dQzQBUZeXIz6kRiY5RPdi6/qD8P/3e
         jfblhVnF90odOTOo2f+KmiEA0DYdiJAuaxnU1ITU5A3qkkec3RdzrB/R4RZABPtY2cP8
         4n171DB7MX+mEmafvvsXlz4yWIxAo87exvE99LeprOnx9ly+xSDmud/7x3kfWYRzQey3
         ojMA==
X-Gm-Message-State: AOAM533cnHrK/p+PieC2EdP9kUaHS12+v22Qm7ZiuG9KLbAjDrNRmmFj
        hJJ9XhjWck2vPXI2uG0792/2l7OTbnPtF99xlHQ=
X-Google-Smtp-Source: ABdhPJzapeLwtS56fbJ5zaNdVBTbwkU4Li1rJEAzoJHOw1YuvmP/ZCFvvbjaR4/DvwxnKrfbY+vui4g2B6cgM0hydBg=
X-Received: by 2002:a02:9564:: with SMTP id y91mr9678879jah.1.1642425304987;
 Mon, 17 Jan 2022 05:15:04 -0800 (PST)
MIME-Version: 1.0
References: <YeI7duagtzCtKMbM@visor> <CAOQ4uxjiFewan=kxBKRHr0FOmN2AJ-WKH3DT2-7kzMoBMNVWJA@mail.gmail.com>
 <YeNyzoDM5hP5LtGW@visor> <CAOQ4uxhaSh4cUMENkaDJij4t2M9zMU9nCT4S8j+z+p-7h6aDnQ@mail.gmail.com>
 <YeTVx//KrRKiT67U@visor>
In-Reply-To: <YeTVx//KrRKiT67U@visor>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 17 Jan 2022 15:14:53 +0200
Message-ID: <CAOQ4uxibWbjFJ2-0qoARuyd2WD9PEd9HZ82knB0bcy8L92TOag@mail.gmail.com>
Subject: Re: Potential regression after fsnotify_nameremove() rework in 5.3
To:     Ivan Delalande <colona@arista.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 17, 2022 at 4:34 AM Ivan Delalande <colona@arista.com> wrote:
>
> On Sun, Jan 16, 2022 at 12:14:01PM +0200, Amir Goldstein wrote:
> > On Sun, Jan 16, 2022 at 3:20 AM Ivan Delalande <colona@arista.com> wrote:
> >> On Sat, Jan 15, 2022 at 09:50:20PM +0200, Amir Goldstein wrote:
> >>> On Sat, Jan 15, 2022 at 5:11 AM Ivan Delalande <colona@arista.com> wrote:
> >>>> Sorry to bring this up so late but we might have found a regression
> >>>> introduced by your "Sort out fsnotify_nameremove() mess" patch series
> >>>> merged in 5.3 (116b9731ad76..7377f5bec133), and that can still be
> >>>> reproduced on v5.16.
> >>>>
> >>>> Some of our processes use inotify to watch for IN_DELETE events (for
> >>>> files on tmpfs mostly), and relied on the fact that once such events are
> >>>> received, the files they refer to have actually been unlinked and can't
> >>>> be open/read. So if and once open() succeeds then it is a new version of
> >>>> the file that has been recreated with new content.
> >>>>
> >>>> This was true and working reliably before 5.3, but changed after
> >>>> 49246466a989 ("fsnotify: move fsnotify_nameremove() hook out of
> >>>> d_delete()") specifically. There is now a time window where a process
> >>>> receiving one of those IN_DELETE events may still be able to open the
> >>>> file and read its old content before it's really unlinked from the FS.
> >>>
> >>> This is a bit surprising to me.
> >>> Do you have a reproducer?
> >>
> >> Yeah, I was using the following one to bisect this. It will print a
> >> message every time it succeeds to read the file after receiving a
> >> IN_DELETE event when run with something like `mkdir /tmp/foo;
> >> ./indelchurn /tmp/foo`. It seems to hit pretty frequently and reliably
> >> on various systems after 5.3, even for different #define-parameters.
> >>
> >
> > I see yes, it's a race between fsnotify_unlink() and d_delete()
> > fsnotify_unlink() in explicitly required to be called before d_delete(), so
> > it has the d_inode information and that leaves a windows for opening
> > the file from cached dentry before d_delete().
> >
> > I would rather that we try to address this not as a regression until
> > there is proof of more users that expect the behavior you mentioned.
> > I would like to provide you an API to opt-in for this behavior, because
> > fixing it for everyone may cause other workloads to break.
> >
> > Please test the attached patch on top of v5.16 and use
> > IN_DELETE|IN_EXCL_UNLINK as the watch mask for testing.
> >
> > I am assuming that it would be possible for you to modify the application
> > and add the IN_EXCL_UNLINK flag and that your application does not
> > care about getting IN_OPEN events on unlinked files?
> >
> > My patch overloads the existing flag IN_EXCL_UNLINK with a new
> > meaning. It's a bit of a hack and we can use some other flag if we need to
> > but it actually makes some sense that an application that does not care for
> > events on d_unlinked() files will be guaranteed to not get those events
> > after getting an IN_DELETE event. It is another form of the race that you
> > described.
> >
> > Will that solution work out for you?
>
> Yeah, sounds perfect for us, and adding IN_EXCL_UNLINK to our
> applications is fine indeed. I've tested the 5.16 patch on my laptop
> with the reproducer and can't reproduce the issue. I've also tried the
> 5.10 patch on our products and also stop seeing the issue both with
> the reproducer but also with our internal applications and test cases
> that made us look into this initially. So this looks like a good fix on
> our side at least.
>

I am glad the patch addresses your issue.
However, I am not sure if I should even post it upstream,
unless more people ask for it.

My point of view is that IN_DELETE does not have enough
information for an "invalidate file" message.
FAN_DELETE, otoh, with recently merged FAN_REPORT_TARGET_FID
includes an information record with the unique and non-reusable file id of the
unlinked inode.

That should allow your application to correctly invalidate the state files
that it accesses on kernel >= v5.17.

Jan, do you have a different opinion?

Thanks,
Amir.
