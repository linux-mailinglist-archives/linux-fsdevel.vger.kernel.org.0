Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FFE280680
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 20:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732342AbgJASZc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 14:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbgJASZb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:25:31 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC81C0613D0
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2020 11:25:31 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id x1so107831vsf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2020 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/o2zaDKEB+nlw8x9jM4qneRob1OE3zVRXSDsW1T0MI=;
        b=G2vKMTfA3G6kI1RxC0jYCa7m9xiKagRY9nrhsHPdAAat1g80g4bK2bWCCAVH2/UXeD
         dS/gbv1ioTcbmW4/tkWU//l7gXClrMvwmu16Ssmvh6o8CfFGXAzqxnxvEEhlxd+XEj6f
         3oEY3gsIL37ztc0u1PSiSJitXblxMaEOq7CiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/o2zaDKEB+nlw8x9jM4qneRob1OE3zVRXSDsW1T0MI=;
        b=N0l+vwlBHYv+4kEux3iPXotQMR0/tLoV6lulRsJ+/Na7D1S3fIBbcIsP96T+1lCsJB
         8vTqJw7IyonJ93zIuvBaOEwVs/i4sWkQNtOD526/7rcfD1kVRoPPsKttiWyhwrpBwr/f
         KoH+tBIX6tqmpU4LU5lp7W+c0cuAVtaAORyxOMFoTheFQzMf0jdquwaS+i9wZyLWN8Gs
         2McCCar56lC6x64NL+4IQi7i9x+DrZiG3dbNKT9BpokZuvvKK9CTxJ06d0BAqNVSe5bi
         Iiyi71GzQBRLdb1NXefTLOSjkK74ZmU7DdVIa7rErpnsOgQfWEBcr4Can/eD+3sl6N6P
         4pcQ==
X-Gm-Message-State: AOAM5321eDfiyq0e12TTLHmxp/gorxwan8bQThM7aNP4m4fk/LDXC/TI
        pyJJzQ+mvMQOyHGDCTpcIqVHEWmod34CYUwP5ByOwA==
X-Google-Smtp-Source: ABdhPJw7CDiTU/TfgMbnySCKgJl34L56NSYxGwvoMopvMsN51SJxeq7dAFggIc15CJSSKpW9YbY6khf7JV2hX0fjndE=
X-Received: by 2002:a67:6855:: with SMTP id d82mr6276867vsc.46.1601576730975;
 Thu, 01 Oct 2020 11:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR12MB33857B8B2E49DF0DD0C4F950DD5D0@DM6PR12MB3385.namprd12.prod.outlook.com>
 <CAJfpegu6-hKCdEiZxb9KrZUrMT_UozjaWC5qY00xwqqopb=1SA@mail.gmail.com>
 <DM6PR12MB33856CB9CC50BE5D7E9B436DDD540@DM6PR12MB3385.namprd12.prod.outlook.com>
 <DM6PR12MB3385C2556A59B3F33FE8B980DD520@DM6PR12MB3385.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3385C2556A59B3F33FE8B980DD520@DM6PR12MB3385.namprd12.prod.outlook.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 1 Oct 2020 20:25:19 +0200
Message-ID: <CAJfpegv5EckmJ_PCqHc2N3_jHaXfinMwvDNSttYNXcan1wr1fQ@mail.gmail.com>
Subject: Re: [fuse-devel] Cross-host entry caching and file open/create
To:     Ken Schalk <kschalk@nvidia.com>
Cc:     "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 28, 2020 at 11:01 PM Ken Schalk <kschalk@nvidia.com> wrote:
>
> On Aug 26, 2020 Ken Schalk <kschalk@nvidia.com> wrote:
> > On Aug 21, 2020 Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > On Thu, Aug 20, 2020 at 12:24 AM Ken Schalk <kschalk@nvidia.com> wrote:
> > > > If the open flags include O_EXCL, then we're seeing a failure
> > > > with EEXIST without any call to our FUSE filesystem's create
> > > > operation (or any other FUSE operations).  The kernel makes this
> > > > failure decision based on its cached information about the
> > > > previously accessed (now deleted) file.  If the open flags do
> > > > not include O_EXCL, then we're seeing a failure with ENOENT from
> > > > our open operation (because the file does not actually exist
> > > > anymore), with no call to our create operation (because the
> > > > kernel believed that the file existed, causing it to make a FUSE
> > > > open request rather than a FUSE create request).
>
> > > Does the attached patch fix it?
>
> > Thanks very much for your help.  The patch you provided does solve
> > the problem in the O_CREAT|O_EXCL case (by making a lookup call to
> > re-validate the entry of the since deleted file), but not in the
> > O_CREAT case.  (In that case the kernel still winds up making a FUSE
> > open request rather than a FUSE create request.)  I'd like to
> > suggest the slightly different attached patch instead, which
> > triggers re-validation in both cases.

Which is a problem, because that makes O_CREAT on existing files (a
fairly common case) add a new synchronous request, possibly resulting
in a performance regression.

I don't see an easy way this can be fixed, and I'm not sure this needs
to be fixed.

Are you seeing a real issue with just O_CREAT?

Thanks,
Miklos
