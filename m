Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DA72CF172
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 17:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbgLDQDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 11:03:31 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52354 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729625AbgLDQDa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:03:30 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B4G2R8k023074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Dec 2020 11:02:27 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 19219420136; Fri,  4 Dec 2020 11:02:27 -0500 (EST)
Date:   Fri, 4 Dec 2020 11:02:27 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Xiaoli Feng <xifeng@redhat.com>,
        Sasha Levin <sashal@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH V2] uapi: fix statx attribute value overlap for DAX &
 MOUNT_ROOT
Message-ID: <20201204160227.GA577125@mit.edu>
References: <3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com>
 <20201202160049.GD1447340@iweiny-DESK2.sc.intel.com>
 <CAJfpegt6w4h28VLctpaH46r2pkbcUNJ4pUhwUqZ-zbrOrXPEEQ@mail.gmail.com>
 <641397.1606926232@warthog.procyon.org.uk>
 <CAJfpegsQxi+_ttNshHu5MP+uLn3px9+nZRoTLTxh9-xwU8s1yg@mail.gmail.com>
 <X8flmVAwl0158872@kroah.com>
 <20201202204045.GM2842436@dread.disaster.area>
 <X8gBUc0fkdh6KK01@kroah.com>
 <CAOQ4uxhNvTxEo_-wkHy-KO8Jhz0Amh-g2Nz+PzN_8OODWJPz7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhNvTxEo_-wkHy-KO8Jhz0Amh-g2Nz+PzN_8OODWJPz7w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 03, 2020 at 08:18:23AM +0200, Amir Goldstein wrote:
> Here is a recent example, where during patch review, I requested NOT to include
> any stable backport triggers [1]:
> "...We should consider sending this to stable, but maybe let's merge
> first and let it
>  run in master for a while before because it is not a clear and
> immediate danger..."
>
> As a developer and as a reviewer, I wish (as Dave implied) that I had a way to
> communicate to AUTOSEL that auto backport of this patch has more risk than
> the risk of not backporting.

My suggestion is that we could put something in the MAINTAINERS file
which indicates what the preferred delay time should be for (a)
patches explicitly cc'ed to stable, and (b) preferred time should be
for patches which are AUTOSEL'ed for stable for that subsystem.  That
time might be either in days/weeks, or "after N -rc releases", "after
the next full release", or, "never" (which would be a way for a
subsystem to opt out of the AUTOSEL process).

It should also be possible specify the delay in the trailer, e.g.:

Stable-Defer: <delayspec>
Auto-Stable-Defer: <delayspec>

The advantage of specifying the delay relative to when they show up in
Linus's tree helps deal with the case where the submaintainer might
not be sure when their patches will get pushed to Linus by the
maintainer.

Cheers,

						- Ted
