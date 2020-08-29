Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAF2256986
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 19:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgH2RwC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 13:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgH2RwA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 13:52:00 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11087C061236
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2020 10:51:59 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id y3so1293195vsn.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2020 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vwyq9Rwu0GLKAS0zzs1uQayO9tco0ppYPmu9Ng3UHb0=;
        b=Zo4omdxFRu6FQyuAwYLIiwr9iMTRDCM6EkFl3PT1W21m2ZJFCwzLrWmlxsh3h9Fywz
         M0sYjw4uZSilkxZLz3p4Kf1fMu/A0BmhizaW1BWEhEuBwGAmTqOjQg4WLsRU4J+UHLbE
         d79D3ZeEB3JDjKT2DEHesvRRc5E9YDHR6HUOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vwyq9Rwu0GLKAS0zzs1uQayO9tco0ppYPmu9Ng3UHb0=;
        b=Mj6EcIyhZpvB7iZeuOFaY6W3SO1zaZlfpmZ/C67SNeM05lmnxCMKL1LSdExmD3Y2nL
         ZKDKZTb66e53wPB5UKUoQor7EgGi2WXyIXkxAkV79Wzddfhli1ik/2N3z/VZPkBTDy1Y
         trQhU2aoqZefzW1QTB137Aerm9FLbPPgnj+cyja4B0FVUkDWg6ICO/v77kL3mYvtH2pI
         rRfxZmNeSLMaYLVNHihlusYiOtFH0TmbeaX6oh5XInrbkiLoDtusGaQDcbsA0b98XiCv
         yslsIHXoZDgsCaF+InhKZapDs+lXRbBZC2mmjmuMGD90fpUoNm3JtpPJAZnanZG2CKbr
         hZQg==
X-Gm-Message-State: AOAM532RBaOZI4JRat2tTn/MMMGUckZZQNEgE+zVHtBac9KYTf2ktGqz
        hzFHOEXMzbwbu2nKUYSwHy4zoawiL2JNEIBugHZ/Mg==
X-Google-Smtp-Source: ABdhPJyGm+iFcPA/YZoyUmu6czzVVzcFqWChls49UOFmvFHtMDPovbAZrKCi/WJz/c4YCaETgDvCk1c8AjCSQo1hByA=
X-Received: by 2002:a67:edd8:: with SMTP id e24mr2351035vsp.150.1598723518939;
 Sat, 29 Aug 2020 10:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200728105503.GE2699@work-vm> <12480108.dgM6XvcGr8@silver>
 <20200812143323.GF2810@work-vm> <27541158.PQPtYaGs59@silver>
 <20200816225620.GA28218@dread.disaster.area> <20200816230908.GI17456@casper.infradead.org>
 <20200817002930.GB28218@dread.disaster.area> <20200827152207.GJ14765@casper.infradead.org>
 <20200827222457.GB12096@dread.disaster.area> <20200829160717.GS14765@casper.infradead.org>
 <20200829161358.GP1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200829161358.GP1236603@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Sat, 29 Aug 2020 19:51:47 +0200
Message-ID: <CAJfpegu2R21CF9PEoj2Cw6x01xmJ+qsff5QTcOcY4G5KEY3R0w@mail.gmail.com>
Subject: Re: xattr names for unprivileged stacking?
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 29, 2020 at 6:14 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Aug 29, 2020 at 05:07:17PM +0100, Matthew Wilcox wrote:
>

> > > The fact that ADS inodes would not be in the dentry cache and hence
> > > not visible to pathwalks at all then means that all of the issues
> > > such as mounting over them, chroot, etc don't exist in the first
> > > place...
> >
> > Wait, you've now switched from "this is dentry cache infrastructure"
> > to "it should not be in the dentry cache".  So I don't understand what
> > you're arguing for.
>
> Bloody wonderful, that.  So now we have struct file instances with no dentry
> associated with them?  Which would have to be taken into account all over
> the place...

It could have a temporary dentry allocated for the lifetime of the
file and dropped on last dput.  I.e. there's a dentry, but no cache.
Yeah, yeah, d_path() issues, however that one will have to be special
cased anyway.

Thanks,
Miklos
