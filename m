Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B195AF142
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 18:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239172AbiIFQzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 12:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbiIFQyy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:54:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82E68B998;
        Tue,  6 Sep 2022 09:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EEBA615C6;
        Tue,  6 Sep 2022 16:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50A7C433D6;
        Tue,  6 Sep 2022 16:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662482493;
        bh=UM8FCqiqxwUszb19xI6JmSr5O1LQA937PKwpG0lRHnQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=K/YajJy8aDxL8ZMyXUDPsjbij1HOnk6gYe99ppqlZxed4E8KGY2JiYbEixn3ZehDe
         QkUzZ2vMdbB63C3rTOTkHyGxGz9ft2h5m712syxo/TF+7VXYKgstYKasON7VTzG1K7
         Y6Mn5VEpTS3grOER3wctJ9SoNrK9+lyVkOnwlKnbeN4Y3bCz350JQZeGZqCEcD40YS
         VLk6CCF9FQBs1Yd1BMsnt59FM+d+QFTos0cFDdEXzQGx3caflZWImIdrm+ghQLWApD
         ilL9zRr6tMq5mKtHsxwThwO4b6oY3eP7kKu5EMOwRaiLEnpJ6vJfjiD5YGK40E0Fq8
         07oDQPoptpxHw==
Message-ID: <d1ee62062c3f805460b7bdf2776e759be4dba43f.camel@kernel.org>
Subject: Re: [RFC PATCH v2] statx, inode: document the new STATX_INO_VERSION
 field
From:   Jeff Layton <jlayton@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Date:   Tue, 06 Sep 2022 12:41:30 -0400
In-Reply-To: <87ilm066jh.fsf@oldenburg.str.redhat.com>
References: <20220901121714.20051-1-jlayton@kernel.org>
         <874jxrqdji.fsf@oldenburg.str.redhat.com>
         <81e57e81e4570d1659098f2bbc7c9049a605c5e8.camel@kernel.org>
         <87ilm066jh.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-09-06 at 14:17 +0200, Florian Weimer wrote:
> * Jeff Layton:
>=20
> > All of the existing implementations use all 64 bits. If you were to
> > increment a 64 bit value every nanosecond, it will take >500 years for
> > it to wrap. I'm hoping that's good enough. ;)
> >=20
> > The implementation that all of the local Linux filesystems use track
> > whether the value has been queried using one bit, so there you only get
> > 63 bits of counter.
> >=20
> > My original thinking here was that we should leave the spec "loose" to
> > allow for implementations that may not be based on a counter. E.g. coul=
d
> > some filesystem do this instead by hashing certain metadata?
>=20
> Hashing might have collisions that could be triggered deliberately, so
> probably not a good idea.  It's also hard to argue that random
> collisions are unlikely.
>=20

In principle, if a filesystem could guarantee enough timestamp
resolution, it's possible collisions could be hard to achieve. It's also
possible you could factor in other metadata that wasn't necessarily
visible to userland to try and ensure uniqueness in the counter.

Still...

> > It's arguable though that the NFSv4 spec requires that this be based on
> > a counter, as the client is required to increment it in the case of
> > write delegations.
>=20
> Yeah, I think it has to be monotonic.
>=20

I think so too. NFSv4 sort of needs that anyway.

> > > If the system crashes without flushing disks, is it possible to obser=
ve
> > > new file contents without a change of i_version?
> >=20
> > Yes, I think that's possible given the current implementations.
> >=20
> > We don't have a great scheme to combat that at the moment, other than
> > looking at this in conjunction with the ctime. As long as the clock
> > doesn't jump backward after the crash and it takes more than one jiffy
> > to get the host back up, then you can be reasonably sure that
> > i_version+ctime should never repeat.
> >=20
> > Maybe that's worth adding to the NOTES section of the manpage?
>=20
> I'd appreciate that.

Ok! New version of the manpage patch sent. If no one has strong
objections to the proposed docs, I'll send out new kernel patches in the
next day or two.

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>
