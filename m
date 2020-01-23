Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 853671462D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 08:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgAWHrm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 02:47:42 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:39871 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAWHrm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 02:47:42 -0500
Received: by mail-il1-f194.google.com with SMTP id x5so1425147ila.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 23:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aONRY/cyyRc/eCBGnYGS/BGRewahEifkdxyWXY2AJ1c=;
        b=eu+EYN1Wp3RJTANSlOhUS6cdTKctAMVz1QcDoVMhSqb/WAw+bK/X206V5D5IXo61nW
         IV8gRLuqn5nf7PjijTGFxqYF3eDzjvYB2wuDubCKI8x6RrAhx3JeX4Ny6KUoodAuTTRk
         5WUJehQk8/nR33AxQm1mZLpN93z4IdRvpoZn/2OaKnsOq66+2gZ/2Ua0DP7ZsFnW8h+e
         1dHLXYvy0CZ4WTsXbbjm3bi1Pn5WKfvq3QfyT8jgEU9pX6aMPkFrSpQ6SGEV48VSEjzE
         vcOvGR3zeEp6pnUN0l5dP4t2THcNfkm6PDiezZxVb/G31b1qmQUR9J1HRqTrS9e0L0TU
         mGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aONRY/cyyRc/eCBGnYGS/BGRewahEifkdxyWXY2AJ1c=;
        b=IuUB6mjab3xDRDgCnMvqGXWi7hxA9szKNHATupy0d3+mwbtHl2mI+RqsF1uRsLE7X5
         /z4YWvZ5Qo5I49Y+TKaHhxpapH3qNyF/FzgxF0L8r57C/MSqrFBm2C/UkZf68VZB/P4g
         B4DXNnIgvs6QmijH5o74Wr7VYWTYCCgDJQ6+iKzoguqIAZJFt/IOX6D66bAB/xp7mVuS
         ZYkP2EE+Kat/4m2VpaHK5EQIspPYHHlYloOYYizyacgGM30bWP6Ll2Q9HWepsf2TBxRa
         Rl9P++v5oM+em/pTM6/N1QKR3IZoaWOkWoXa0yVyYbNLnbxOZH4AGeDREVy3wjP5/E6g
         bf4w==
X-Gm-Message-State: APjAAAW9rshScZgioZYFGbf/sIY3Mwbgixc//ed0rvLtx3LynUhSIKz/
        qB8MbCKkO8pOrz12Tlxd//XrEjiwKm+sKr43KMA=
X-Google-Smtp-Source: APXvYqwnxy3I8Y+w53E5h7KZn36dCPYLBFoWtD/G2wO4MVBk/GegSPfe08R4dXOuag+h8b0Eo8aDcdpw/HHXK2htsXM=
X-Received: by 2002:a92:8656:: with SMTP id g83mr1750518ild.9.1579765661695;
 Wed, 22 Jan 2020 23:47:41 -0800 (PST)
MIME-Version: 1.0
References: <20200117202219.GB295250@vader> <20200117222212.GP8904@ZenIV.linux.org.uk>
 <20200117235444.GC295250@vader> <20200118004738.GQ8904@ZenIV.linux.org.uk>
 <20200118011734.GD295250@vader> <20200118022032.GR8904@ZenIV.linux.org.uk>
 <20200121230521.GA394361@vader> <CAOQ4uxgsoGMsNxhmtzZPqb+NshpJ3_P8vDiKpJFO5ZK25jZr0w@mail.gmail.com>
 <20200122221003.GB394361@vader> <20200123034745.GI23230@ZenIV.linux.org.uk> <20200123071639.GA7216@dread.disaster.area>
In-Reply-To: <20200123071639.GA7216@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 23 Jan 2020 09:47:30 +0200
Message-ID: <CAOQ4uxhm3tqgqQPYpkeb635zRLR1CJFDUrwGuCZv1ntv+FszdA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
To:     Dave Chinner <david@fromorbit.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 9:16 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Jan 23, 2020 at 03:47:45AM +0000, Al Viro wrote:
> > On Wed, Jan 22, 2020 at 02:10:03PM -0800, Omar Sandoval wrote:
> >
> > > > Sorry for not reading all the thread again, some API questions:
> > > > - We intend to allow AT_REPLACE only with O_TMPFILE src. Right?
> > >
> > > I wasn't planning on having that restriction. It's not too much effort
> > > for filesystems to support it for normal files, so I wouldn't want to
> > > place an artificial restriction on a useful primitive.
> >

I have too many gray hairs each one for implementing a "useful primitive"
that nobody asked for and bare the consequences.
Your introduction to AT_REPLACE uses O_TMPFILE.
I see no other sane use of the interface.

> > I'm not sure; that's how we ended up with the unspeakable APIs like
> > rename(2), after all...
>
> Yet it is just rename(2) with the serial numbers filed off -
> complete with all the same data vs metadata ordering problems that
> rename(2) comes along with. i.e. it needs fsync to guarantee data
> integrity of the source file before the linkat() call is made.
>
> If we can forsee that users are going to complain that
> linkat(AT_REPLACE) using O_TMPFILE files is not atomic because it
> leaves zero length files behind after a crash just like rename()
> does, then we haven't really improved anything at all...
>
> And, really, I don't think anyone wants another API that requires
> multiple fsync calls to use correctly for crash-safe file
> replacement, let alone try to teach people who still cant rename a
> file safely how to use it....
>

Are you suggesting that AT_LINK_REPLACE should have some of
the semantics I posted in this RFC  for AT_ATOMIC_xxx:
https://lore.kernel.org/linux-fsdevel/20190527172655.9287-1-amir73il@gmail.com/

I admit I did not follow up on performance benchmarks that
you asked on that thread, but I also see the value in a simple API
as opposed to the AIO_FSYNC scheme that you proposed.

Thanks,
Amir.
