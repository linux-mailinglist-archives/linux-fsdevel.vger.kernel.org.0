Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA827020DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 02:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbjEOAxn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 May 2023 20:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbjEOAxl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 May 2023 20:53:41 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428AE10E5
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 May 2023 17:53:40 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34F0rLMG007147
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 May 2023 20:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1684112005; bh=L6HHq6ZAyzeutQBofPRqcZwswoC2oa4/hxe5wJgAjtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ZKVIe9ThChkwC/r2+RUBtTEIbeCj0gFVK0HKldu7DKaAH6K0twQPg/nqnH+XHxgfQ
         TVq/kPMeTicYV4z1Dz24CjatyeY/tIeL/Gu2qh6lshg8nlwf6ADYGj9Ey9MiGQAFLU
         0EWk/GZGcbDNAvkfI6JPGlKIrWx20oVGIoXBXYCWpW3Wx6tgKVjVfuxQubwn/6iCdh
         GtCIbyCKiiczJ3IibP0dQH/mHhQHY+GIYL9WSch92OV5Wx1oGqLrYLMC1jvcFeXoin
         GObVZ3UpdNgUrjQyWsNvzF7vpAl63C5dUiXhxN6YaCa+XheOD5wEWjc6S8ubVRNEmd
         S3zKVYcPojd3w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CE9E915C04AC; Sun, 14 May 2023 20:53:21 -0400 (EDT)
Date:   Sun, 14 May 2023 20:53:21 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     syzbot <syzbot+cbb68193bdb95af4340a@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, elic@nvidia.com, jasowang@redhat.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, parav@nvidia.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_setattr
Message-ID: <20230515005321.GB1903212@mit.edu>
References: <000000000000a74de505f2349eb1@google.com>
 <000000000000a9377e05fbac4945@google.com>
 <20230514163907-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230514163907-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 14, 2023 at 04:39:36PM -0400, Michael S. Tsirkin wrote:
> On Sun, May 14, 2023 at 12:24:32PM -0700, syzbot wrote:
> > syzbot has bisected this issue to:
> > 
> > commit a3c06ae158dd6fa8336157c31d9234689d068d02
> > Author: Parav Pandit <parav@nvidia.com>
> > Date:   Tue Jan 5 10:32:03 2021 +0000
> > 
> >     vdpa_sim_net: Add support for user supported devices
> > 
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> I don't see how this can be related, I don't think the test setup uses
> vdpa sim at all.

Yeah, it's totally bogus.  You can see it by looking at the bisection
log[1].

[1] https://syzkaller.appspot.com/text?tag=Log&x=16e372c6280000

The initial bisection logs make it clear that it is *trivially* easy
to reproduce, and that the failure signature is:

crashed: possible deadlock in {ext4_xattr_set_handle,ext4_setattr,ext4_xattr_set_handle}

However, somewhere in the bisection, we start seeing this:

run #0: boot failed: WARNING in kvm_wait
run #1: boot failed: WARNING in kvm_wait
run #2: OK
run #3: OK
run #4: OK
run #5: OK
run #6: OK
run #7: OK
run #8: OK
run #9: OK

This is a completely different failure signature, and the "WARNING in
kvm_wait" should be ignored, and this should be considered a "git
bisect good".  However, the syzkaller bisection doesn't understand
this, and so it gets sent down the primrose path.  :-(

Unfortunately, there isn't a good way to tell the syzkaller bisection,
"go home, your drunk", and to tell it to try again, perhaps with a
human-supplied discriminator of what should be considered a valid
failure signature.

In the ideal world, a human should be able to give it a setup set of
bisection "good" and "bad" commits, along with a regexp for what a
failure should look like, and perhaps with a hint of how many tries it
should use before assuming that a bisection result is "good", and to
teach it to assume that the bisection has "bad" after seeing a single
failure signature.

If the above is too much to ask, in the slightly-less-ideal world,
there would be a way to give "#syz test" a count argument, so we could
have syzkaller try N times, for when we need to do a manual bisection
using "#syz test"....

						- Ted
