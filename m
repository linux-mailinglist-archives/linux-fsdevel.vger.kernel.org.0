Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587847BA105
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbjJEOm5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 10:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbjJEOhv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:37:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729BD8A4D;
        Thu,  5 Oct 2023 07:03:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4F5C3279D;
        Thu,  5 Oct 2023 12:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696509955;
        bh=OyPYLq8qw3jPUQ7rA5KJM4mXFbg5lNRBN/Aw7zBp+L4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HLWo6k8p032N2hH+EknnrwhrZQgP2503xfFAY8bwfX4utLsM8uym7mbVNhp2BYVKB
         s+jC7tV0VdyNFMcXr4XY5CLzZRiRfhxp64CqGdzalVzcsOoSnWyge2bcwtZbuKVsXb
         cAIURc3dJ/i0srVdjL4Idvbs6WxQC9OWICK9BB4KliJ+5nMgdgpgeBu4MnuTV5WeXI
         Vjk46daoz5mBOebcG99aKmHcDqIUaYKGXsp0lPX1Y3jUxzhzQtjCl8bO1IR8fCyBNi
         sF3RgZTCDtAYO7kM+ZvbtQOT4K9gLYjWwE2RSIlX+8EaNlCspTKPe9DXyjUChbfEaA
         yNqffQfYE4z1w==
Message-ID: <9af5c896da0c39c66d0555879c04c23fd853c9de.camel@kernel.org>
Subject: Re: [PATCH v2 89/89] fs: move i_generation into new hole created
 after timestamp conversion
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Thu, 05 Oct 2023 08:45:53 -0400
In-Reply-To: <CAOQ4uxgtyaBTM1bOSSGmsk+F4ZwsK+-N5ZZ3wAt_nv_E6G3C7Q@mail.gmail.com>
References: <20231004185530.82088-1-jlayton@kernel.org>
         <20231004185530.82088-3-jlayton@kernel.org>
         <CAOQ4uxgtyaBTM1bOSSGmsk+F4ZwsK+-N5ZZ3wAt_nv_E6G3C7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 2023-10-05 at 08:08 +0300, Amir Goldstein wrote:
> On Wed, Oct 4, 2023 at 9:56=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
> >=20
> > The recent change to use discrete integers instead of struct timespec64
> > shaved 8 bytes off of struct inode, but it also moves the i_lock
> > into the previous cacheline, away from the fields that it protects.
> >=20
> > Move i_generation above the i_lock, which moves the new 4 byte hole to
> > just after the i_fsnotify_mask in my setup.
>=20
> Might be good to mention that this hole has a purpose...
>=20
> >=20
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  include/linux/fs.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 485b5e21c8e5..686c9f33e725 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -677,6 +677,7 @@ struct inode {
> >         u32                     i_atime_nsec;
> >         u32                     i_mtime_nsec;
> >         u32                     i_ctime_nsec;
> > +       u32                     i_generation;
> >         spinlock_t              i_lock; /* i_blocks, i_bytes, maybe i_s=
ize */
> >         unsigned short          i_bytes;
> >         u8                      i_blkbits;
> > @@ -733,7 +734,6 @@ struct inode {
> >                 unsigned                i_dir_seq;
> >         };
> >=20
> > -       __u32                   i_generation;
> >=20
> >  #ifdef CONFIG_FSNOTIFY
> >         __u32                   i_fsnotify_mask; /* all events this ino=
de cares about */
>=20
> If you post another version, please leave a comment here
>=20
> +         /* 32bit hole reserved for expanding i_fsnotify_mask to 64bit *=
/
>=20

Sure.

I suppose we could create a union there too if you really want to
reserve it:

	union {
		__u32		i_fsnotify_mask;
		__u64		__i_fsnotify_mask_ext;
	};

--=20
Jeff Layton <jlayton@kernel.org>
