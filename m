Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFBFE120E6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 19:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfEBRQE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 13:16:04 -0400
Received: from fieldses.org ([173.255.197.46]:52264 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfEBRQE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 13:16:04 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 9E9321BE3; Thu,  2 May 2019 13:16:03 -0400 (EDT)
Date:   Thu, 2 May 2019 13:16:03 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        NeilBrown <neilb@suse.com>, Amir Goldstein <amir73il@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
Message-ID: <20190502171603.GA1778@fieldses.org>
References: <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com>
 <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com>
 <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com>
 <20161206185806.GC31197@fieldses.org>
 <87bm0l4nra.fsf@notabene.neil.brown.name>
 <CAOQ4uxjYEjqbLcVYoUaPzp-jqY_3tpPBhO7cE7kbq63XrPRQLQ@mail.gmail.com>
 <875zqt4igg.fsf@notabene.neil.brown.name>
 <CAHc6FU52OCCGUnHXOCFTv1diP_5i4yZvF6fAth9=aynwS+twQg@mail.gmail.com>
 <CAJfpegsthQn_=3AQJf7ojxoQBpHMA3dz1fCBjNZXsCA1E0oqnw@mail.gmail.com>
 <CAHpGcML0KuoGSyXyyDnXHkSp3nDnSjJPeZeWEmt8CXxQeojxwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcML0KuoGSyXyyDnXHkSp3nDnSjJPeZeWEmt8CXxQeojxwg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 02, 2019 at 05:08:14PM +0200, Andreas Grünbacher wrote:
> You'll still see permissions that differ from what the filesystem
> enforces, and copy-up would change that behavior.

That's always true, and this issue isn't really specific to NFSv4 ACLs
(or ACLs at all), it already exists with just mode bits.  The client
doesn't know how principals may be mapped on the server, doesn't know
group membership, etc.

That's the usual model, anyway.  Permissions are almost entirely the
server's responsibility, and we just provide a few attributes to set/get
those server-side permissions.

The overlayfs/NFS case is different, I think: the nfs filesystem may be
just a static read-only template for a filesystem that's only ever used
by clients, and for all I know maybe permissions should only be
interpreted on the client side in that case.

--b.
