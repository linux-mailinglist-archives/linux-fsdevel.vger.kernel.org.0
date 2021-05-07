Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5290C37655B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 14:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbhEGMmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 08:42:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236890AbhEGMmd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 08:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620391293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+pizb5T4wXio4s+BKjaVq1oW2LlYLV5RKkN72d3SlPY=;
        b=cckZ1Ib//ahxUVuQY9soR+faNHz1L7JCA6Yt6hUss0V0u34i+scOiCCQtLsgUWN347O2pP
        tu84pjcIRX2uF0q9chCLm17V8u10jHuPIuKuhF2/6W4RMkBAoJZrIini6KFou4Y9WIFwWz
        UfQLwxAMGQcR7zwBFBp0cKySiXiqoOA=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-VquRSaPEM7Wf_Eaj4AFWIQ-1; Fri, 07 May 2021 08:41:30 -0400
X-MC-Unique: VquRSaPEM7Wf_Eaj4AFWIQ-1
Received: by mail-yb1-f200.google.com with SMTP id o186-20020a2528c30000b02904f824478356so9820754ybo.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 May 2021 05:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+pizb5T4wXio4s+BKjaVq1oW2LlYLV5RKkN72d3SlPY=;
        b=i4FbPLwbarx1to6h4gTWeAzUmoymRw8FOyrHiQy26mfAe09mTxNTbMZJsua/Fyw1TA
         oX6i+8yHi55+hzZMCETTj8KskD/r6wJV8KHhrQkfQbUTv0To4P7pTq3lGc+hSWm9qMqd
         tbjeUCxv6xP9aQAG/GzbpM2YZ4NPqA2g8E+3XXMHjFG6UcD1RRffEsmvJjTE67WrkYfw
         WN3znaALA6HUl3bvWIj4Nk5B4Dnn0kJIauY4WOfQHIG+q+3+OydBx8JNtTc2j7vpCrPA
         CCmeg6bRDWG3JgDSeRSHO6zDsFPbY3J/tqNlNhcGGe4CT3JhGClm+fujOcX282+ah5yW
         cpRw==
X-Gm-Message-State: AOAM533Vwrf+mweCpS8rgKgZlEpI9GnGIXfEvmkmCxxWViqCuKjvS+d1
        wwYPhhBHWmk8gzTwqHfb9ROTT3ZiZtTgO8O+1hwPaNyu/vcdHyjLUWyRMk7DVifjybUyuRObYl1
        ZwunJ+sWr4XpwXiXO+22NCEgmFm/Neo23kLvoqv72Hw==
X-Received: by 2002:a25:640f:: with SMTP id y15mr13170135ybb.436.1620391290263;
        Fri, 07 May 2021 05:41:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy22p09PEHUGb5fAA49wspHdow+4OHN0qicl6JIPF5XwcGlunbrNF+orAljsopKKKqw1oReB57xfDS4LkuZvuE=
X-Received: by 2002:a25:640f:: with SMTP id y15mr13170115ybb.436.1620391290086;
 Fri, 07 May 2021 05:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210507114150.139102-1-omosnace@redhat.com> <YJUseJLHBdvKYEOK@kroah.com>
 <YJUuoiKFjM8Jdx6U@casper.infradead.org> <YJUvhGV5EW0tsIpP@kroah.com>
In-Reply-To: <YJUvhGV5EW0tsIpP@kroah.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 7 May 2021 14:41:16 +0200
Message-ID: <CAFqZXNv_WWQZPHVhN5oqHVYanxKcXFqu6r=S9=ZTHKf7UNsiKA@mail.gmail.com>
Subject: Re: [PATCH] debugfs: fix security_locked_down() call for SELinux
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 7, 2021 at 2:16 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, May 07, 2021 at 01:12:18PM +0100, Matthew Wilcox wrote:
> > On Fri, May 07, 2021 at 02:03:04PM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, May 07, 2021 at 01:41:50PM +0200, Ondrej Mosnacek wrote:
> > > > Make sure that security_locked_down() is checked last so that a bogus
> > > > denial is not reported by SELinux when (ia->ia_valid & (ATTR_MODE |
> > > > ATTR_UID | ATTR_GID)) is zero.
> > >
> > > Why would this be "bogus"?
> >
> > I presume selinux is logging a denial ... but we don't then actually
> > deny the operation.
>
> That would be nice to note here...

Granted, I didn't do a good job of describing the issue in the patch
description... I'll send a v2 with hopefully a better description.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

