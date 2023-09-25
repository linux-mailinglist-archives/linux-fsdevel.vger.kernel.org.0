Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DCC7AD5B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 12:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjIYKRY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 06:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjIYKRX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:17:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED309F;
        Mon, 25 Sep 2023 03:17:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC36C433C8;
        Mon, 25 Sep 2023 10:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695637037;
        bh=iRlJHmpvIWYSQoj21tvtV2DoXT4u3L4h+gWlWYry4PM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NIfRXmW1lLGxqAV/3eDoSAlnVOJLZ47aAU/jKqo58kbnYax2KcWGFD2loAF340lGJ
         sFIB23H5PgnpEhlFlj1gFBkIhw+0As+UPG1MLX3Gj1H4jM6VkUOyRkf8tv/GeGI9HH
         wZDSUZTCY+UdvbGFdSFtWPzEEcVKwfLOSNpiYUm2U8/MPSCmqp2waTGLv3H+UJJZre
         ARpA0/puvMLsKXBC5yWqfaH770rGku8aA3R7DBpURcYI1Iihb0mjWqqTZ4HzIutDX+
         DggWMd4j+g2WtmHR5gnN0TvTiLkHmayeP81udlLo8BZsmg9sPvcH97J0augzlIDXyD
         xcklk5YYnYzOg==
Message-ID: <9b81a1f52b4dc777dbb5259b2e12e90eba0ff507.camel@kernel.org>
Subject: Re: [PATCH v8 0/5] fs: multigrain timestamps for XFS's change_cookie
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Mon, 25 Sep 2023 06:17:14 -0400
In-Reply-To: <169559548777.19404.13247796879745924682@noble.neil.brown.name>
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
        , <20230924-mitfeiern-vorladung-13092c2af585@brauner>
         <169559548777.19404.13247796879745924682@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-09-25 at 08:44 +1000, NeilBrown wrote:
> On Sun, 24 Sep 2023, Christian Brauner wrote:
> > > My initial goal was to implement multigrain timestamps on most major
> > > filesystems, so we could present them to userland, and use them for
> > > NFSv3, etc.
> >=20
> > If there's no clear users and workloads depending on this other than fo=
r
> > the sake of NFS then we shouldn't expose this to userspace. We've tried
> > this and I'm not convinced we're getting anything other than regression=
s
> > out of it. Keep it internal and confined to the filesystem that actuall=
y
> > needs this.
> >=20
>=20
> Some NFS servers run in userspace, and they would a "clear user" of this
> functionality.
>=20

Indeed. Also, all of the programs that we're concerned about breaking
here (make, rsync, etc.) could benefit from proper fine-grained
timestamps:

Today, when they see two identical timestamps on files, these programs
have to assume the worst: rsync has to do the copy, make has to update
the target, etc. With a real distinguishable fine-grained timestamps,
these programs would likely be more efficient and some of these unneeded
operations would be avoided.
--=20
Jeff Layton <jlayton@kernel.org>
