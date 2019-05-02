Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85E2712136
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 19:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfEBRoT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 13:44:19 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44603 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfEBRoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 13:44:19 -0400
Received: by mail-oi1-f195.google.com with SMTP id t184so2317154oie.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2019 10:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/BTpe1GCpx8WOaWkORwszZW4OhHJBOv4flBT0vFDKI=;
        b=K+zYbDVEHGsN7LT+JkyeVoHRoDKq1uv+m0exMBCnN6O6EZ0vMWIWtQO3uuFJukbIYj
         NCEUjBPo7B4Wl8vaP2U+UFkh5HBDEpwhr4f+PZzHaxi1gbLeJ+3TqytDcCq5lkiNj8no
         IcGf/DKV4cy1y3R+X5HDHsZyKgRXYcsm36DHcIVg7zU7mNHdOrVm1TvYAElhqAB8ihWI
         n3wd/fswLTYgtyClrEIOlIY9AzLxG9Havmtk4bhel0QhmeBsqVezl7Gkh+0QGlD9kpki
         7smri0QSZOzORkMsGRVmZciO57Co9g+ujB49xFWCqYCUv1yUySINlUpQLfw4TWoLHp+n
         uN9w==
X-Gm-Message-State: APjAAAX41kbkaudWPNJNweiFNcrHpexOZxNH9nadaOiiebiiE/qB3wuY
        GTD9JIdAFaoqagV47k6Ani+1jz7WwfHVVz94EV/cyQ==
X-Google-Smtp-Source: APXvYqzkCKVtwDFTAmTjZnr+9E8F6X9oBSJfpx707teMwX2ZIYfEr+1PfRcpNtXqB1Leic/fKOicG15VnaqrRwMWYU0=
X-Received: by 2002:aca:47c8:: with SMTP id u191mr1503973oia.72.1556819058630;
 Thu, 02 May 2019 10:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpeguwUtRWRGmNmimNp-FXzWqMCCQMb24iWPu0w_J0_rOnnw@mail.gmail.com>
 <20161205151933.GA17517@fieldses.org> <CAJfpegtpkavseTFLspaC7svbvHRq-0-7jvyh63+DK5iWHTGnaQ@mail.gmail.com>
 <20161205162559.GB17517@fieldses.org> <CAHpGcMKHjic6L+J0qvMYNG9hVCcDO1hEpx4BiEk0ZCKDV39BmA@mail.gmail.com>
 <266c571f-e4e2-7c61-5ee2-8ece0c2d06e9@web.de> <CAHpGcMKmtppfn7PVrGKEEtVphuLV=YQ2GDYKOqje4ZANhzSgDw@mail.gmail.com>
 <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com>
 <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com>
 <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com>
 <20161206185806.GC31197@fieldses.org> <87bm0l4nra.fsf@notabene.neil.brown.name>
 <CAOQ4uxjYEjqbLcVYoUaPzp-jqY_3tpPBhO7cE7kbq63XrPRQLQ@mail.gmail.com>
 <875zqt4igg.fsf@notabene.neil.brown.name> <8f3ba729-ed44-7bed-5ff8-b962547e5582@math.utexas.edu>
In-Reply-To: <8f3ba729-ed44-7bed-5ff8-b962547e5582@math.utexas.edu>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 2 May 2019 19:44:07 +0200
Message-ID: <CAHc6FU4czPQ8xxv5efvhkizU3obpV_05VEWYKydXDDDYcp8j=w@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
To:     "Goetz, Patrick G" <pgoetz@math.utexas.edu>
Cc:     NeilBrown <neilb@suse.com>, Amir Goldstein <amir73il@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2 May 2019 at 19:27, Goetz, Patrick G <pgoetz@math.utexas.edu> wrote:
> On 5/1/19 10:57 PM, NeilBrown wrote:
> > Support some day support for nfs4 acls were added to ext4 (not a totally
> > ridiculous suggestion).  We would then want NFS to allow it's ACLs to be
> > copied up.
>
> Is there some reason why there hasn't been a greater effort to add NFSv4
> ACL support to the mainstream linux filesystems?  I have to support a
> hybrid linux/windows environment and not having these ACLs on ext4 is a
> daily headache for me.

The patches for implementing that have been rejected over and over
again, and nobody is working on them anymore.

Andreas
