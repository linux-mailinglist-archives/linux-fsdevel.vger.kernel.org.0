Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A082621561D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 13:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgGFLLP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 07:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgGFLLP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:11:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD154C061794;
        Mon,  6 Jul 2020 04:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KlHYEimVGLsKScv6oNv5oiMWJ+UIcIiByEGKOUr0M2k=; b=OildahYhTHa05m+AVwTccdqLCA
        WoBIL9QsRm2jCvbBJL5sZ/9kZAx3UrTSUBv0uVMIkKahxMVntD+kU5hrDWXvMTN1S6RUPO5h3UErd
        40rZYGBqzGxj4fQeAGXv8UBrMTOpLJZaoi7lCv5owU90PbB3wBJmLe7yZNmhro7F7hOFTJozWaOJh
        xK7NXesSvWLY6xXuFr+oI59pd//OImMaxV6paFKLa1pmTnqo2rdUs1L/g6wGs/l7ujNHP63sOteEF
        IHIKvKUr9l0PvR7AESkLaDb19hoJjIyh4LExHZEAGmTcKlMxiJARr7pI/NuOt56rTA5tbjlugHoWS
        fk8x+FOA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsP1j-00049i-UK; Mon, 06 Jul 2020 11:11:12 +0000
Date:   Mon, 6 Jul 2020 12:11:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-man@vger.kernel.org,
        mtk.manpages@gmail.com, shuah@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close
 faster
Message-ID: <20200706111111.GX25523@casper.infradead.org>
References: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
 <20200705021631.GR25523@casper.infradead.org>
 <CAODFU0qwtPTaBRbA3_ufA6N7fajhi61Sp5iE75Shdk25NSOTLA@mail.gmail.com>
 <20200705031208.GS25523@casper.infradead.org>
 <CAODFU0q=nDdx7D1NUxTQshBjqgTCYPpKzog78XZLjoPqnZqXvw@mail.gmail.com>
 <20200705032732.GT25523@casper.infradead.org>
 <CAODFU0rSqQsO9rSiA8Ke=+mk_NgEdFDHPMfmXGSmzmkqQh1KYw@mail.gmail.com>
 <20200705115851.GB1227929@kroah.com>
 <CAODFU0ovM-i=4fNKSzp9SgO_FjPcAOZ0R8S4iRXyGm+QL53C1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODFU0ovM-i=4fNKSzp9SgO_FjPcAOZ0R8S4iRXyGm+QL53C1A@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 06, 2020 at 08:07:46AM +0200, Jan Ziak wrote:
> On Sun, Jul 5, 2020 at 1:58 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > It also is a measurable increase over reading just a single file.
> > Here's my really really fast AMD system doing just one call to readfile
> > vs. one call sequence to open/read/close:
> >
> >         $ ./readfile_speed -l 1
> >         Running readfile test on file /sys/devices/system/cpu/vulnerabilities/meltdown for 1 loops...
> >         Took 3410 ns
> >         Running open/read/close test on file /sys/devices/system/cpu/vulnerabilities/meltdown for 1 loops...
> >         Took 3780 ns
> >
> > 370ns isn't all that much, yes, but it is 370ns that could have been
> > used for something else :)
> 
> I am curious as to how you amortized or accounted for the fact that
> readfile() first needs to open the dirfd and then close it later.
> 
> >From performance viewpoint, only codes where readfile() is called
> multiple times from within a loop make sense:
> 
> dirfd = open();
> for(...) {
>   readfile(dirfd, ...);
> }
> close(dirfd);

dirfd can be AT_FDCWD or if the path is absolute, dirfd will be ignored,
so one does not have to open anything.  It would be an optimisation
if one wanted to read several files relating to the same process:

char dir[50];
sprintf(dir, "/proc/%d", pid);
dirfd = open(dir);
readfile(dirfd, "maps", ...);
readfile(dirfd, "stack", ...);
readfile(dirfd, "comm", ...);
readfile(dirfd, "environ", ...);
close(dirfd);

but one would not have to do that.

