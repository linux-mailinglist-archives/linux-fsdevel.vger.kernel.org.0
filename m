Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C5F3B6D42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 06:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhF2EK1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 00:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhF2EK0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 00:10:26 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A1CC061574;
        Mon, 28 Jun 2021 21:07:59 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id l5so8885404iok.7;
        Mon, 28 Jun 2021 21:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2OLpHQcLUDzz8wANdYkE5PCGVg+CpMUGu9tDBaii+8w=;
        b=DTabtqMwxTdt10+cOAgeCLbWdx0H5Nzpsk55Yxg1CFAX3eS5ceEwv5l48LcR1SVuu3
         6NztnR91VyCuvVkxDbBG4UKKGnJJXEvJObrXGKMsvMaLqM7aET+e8e/jaEEvONMVF7Hb
         diaipTgsDjwMyX8Ny2biBRlFcL8dSqO6zcda/oEnqAXX6vzd/jxr0eUMm7TNAdCB4FWV
         LLBVmnusi/tr39kCQza9k0mUCKKV+dsSPoJ/0HKB0mLkumjOQdlrUOGrsA324MtqMGyR
         2fSQLZdRouASDMGJZd3NnmlDiWTThTUcvEFnTvc1kHdMQyKstbgeWI2U3DBps2UMqP06
         6idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2OLpHQcLUDzz8wANdYkE5PCGVg+CpMUGu9tDBaii+8w=;
        b=o6AO603GNkg3FHTN7Lne+eHelG2LjWD+wg23VdW5vTcCyqnGk/yi17rJ2ABVOPLEFE
         hxO3K9z/xxmDy8uBtgNB2erx8a3gxGWDpZCrywxkZkIrbSzGbl5yJBGDcI1JodeteD1I
         vaZb/GyN9T3WN7HyWUy9cYZcXsTwAupv9ZLGkXbeqhw+zNAwBJvh/G+BEiDnnBuyqkEX
         7NEdf7PVInvYF3xOypvThMRygP0tVvYXbzFtjHUUUb+VyNYbTa6lv25LGEmj2sLoCkXA
         W8k246QgtC7KaILedZ798QV/6dIKMqs6TuvAVI+GKu/iY+17gcli3/t4Adxpe6/QAu1L
         ERZA==
X-Gm-Message-State: AOAM533bvjCjdM09DsHYCnhOKjzGeTBPeWLVvBQ0JqsOWeOqkE8d+pbu
        iao8G+SJjTppwU5uXABDVj2WOEaT73ZmNq+yXKI=
X-Google-Smtp-Source: ABdhPJxrbyuclkmfiV3y9eCwhl8v6C76MdgBau7qRukywfJeUKurL8ITzrL1nQlI+Gk897OQLCMDe8ETjmWzwWL76/w=
X-Received: by 2002:a5d:8b03:: with SMTP id k3mr2191134ion.203.1624939678673;
 Mon, 28 Jun 2021 21:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210628194908.GB6776@fieldses.org> <9f1263b46d5c38b9590db1e2a04133a83772bc50.camel@hammerspace.com>
 <20210629011200.GA14733@fieldses.org> <162493102550.7211.15170485925982544813@noble.neil.brown.name>
In-Reply-To: <162493102550.7211.15170485925982544813@noble.neil.brown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 29 Jun 2021 07:07:47 +0300
Message-ID: <CAOQ4uxj-YLrsvCE1d8+OEYQpfZeENK71OWR02G3JtLoZx92H1g@mail.gmail.com>
Subject: Re: automatic freeing of space on ENOSPC
To:     NeilBrown <neilb@suse.de>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 4:45 AM NeilBrown <neilb@suse.de> wrote:
>
> On Tue, 29 Jun 2021, bfields@fieldses.org wrote:
> > On Tue, Jun 29, 2021 at 12:43:14AM +0000, Trond Myklebust wrote:
> > > How about just setting up a notification for unlink on those files, the
> > > same way we set up notifications for close with the NFSv3 filecache in
> > > nfsd?
> >
> > Yes, that'd probably work.  It'd be better if we didn't have to throw
> > away unlinked files when the client expires, but it'd still be an
> > incremental improvement over what we do now.
>
> I wonder how important this is.  If an NFS client unlinks a file that it
> has open, it will be silly_renamed, and if the client then goes silent,
> it might never be removed.  So we already theoretically have a
> possibilty of ENOSPC due to silent clients.  Have we heard of this
> becoming a problem?
> Is there reason to think that the Courteous server changes will make
> this problem more likely?
>

To me, stale silly renamed files sounds like a problem worth fixing
not as an excuse to create another similar problem.

w.r.t pre-ENOSPC notification, I don't know of such notification
in filesystems. It exists for some thin-provisioned storage devices
(thinp as well I think), but that is not very useful for nfsd.

OTOH, ENOSPC is rarely a surprising event.
I believe you can get away with tunable for nfsd, such as
% of available storage space that may consumed for
"opportunistic caching".

Polling for available storage space every least time or so
in case there are possibly forgotten unlinked files should be
sufficient for any practical purpose IMO.

Thanks,
Amir.
