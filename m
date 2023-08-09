Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CF0776BE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 00:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjHIWHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 18:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHIWHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:07:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59164A3;
        Wed,  9 Aug 2023 15:07:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBEB664B0C;
        Wed,  9 Aug 2023 22:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A1FC433C8;
        Wed,  9 Aug 2023 22:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691618857;
        bh=Sbngo3UIZo2TJfFo7ktsW7U9FXdWGIk5Lt7H9K5XFM8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jLUEcluJ8QWu44nwg8FvEto5mxdSD6jhT4hkYGZFSvOuTab/uQF0xUgz8zLDtJscq
         f+HBUBgdFJj3+Y2ejcBWfM2DahqOuHFBxu+LY+Hv0Ofoq0ohoPPQ6mfudIqZwl+oWN
         pLNza58hUz5pcfryyZpEKO+0VcHneBut5CYMVVo+IlIVXRYDByI99w4/3LNaQTR8ZH
         5Tcm+fOwhAMw+LBYRd9XcCm1AD2BTsoO11JuCHNeGAZ3X/S7nnQe6dSMtz75w2+y5t
         1AyLcsRC7pto0A+XhqMGGaQoyj7sZyZ0q03rK2TphlgLtVEfD926pjyggGNcgTjePk
         OQw0IGY/USDEA==
Message-ID: <e4cee2590f5cb9a13a8d4445e550e155d551670d.camel@kernel.org>
Subject: Re: [PATCH v7 05/13] fat: make fat_update_time get its own timestamp
From:   Jeff Layton <jlayton@kernel.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Frank Sorenson <sorenson@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@gl0jj8bn.sched.sma.tdnsstic1.cn>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@telemann.coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Wed, 09 Aug 2023 18:07:29 -0400
In-Reply-To: <87a5v06kij.fsf@mail.parknet.co.jp>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
         <20230807-mgctime-v7-5-d1dec143a704@kernel.org>
         <87msz08vc7.fsf@mail.parknet.co.jp>
         <52bead1d6a33fec89944b96e2ec20d1ea8747a9a.camel@kernel.org>
         <878rak8hia.fsf@mail.parknet.co.jp>
         <20230809150041.452w7gucjmvjnvbg@quack3>
         <87v8do6y8q.fsf@mail.parknet.co.jp>
         <2cb998ff14ace352a9dd553e82cfa0aa92ec09ce.camel@kernel.org>
         <87leek6rh1.fsf@mail.parknet.co.jp>
         <ccffe6ca3397c8374352b002fe01d55b09d84ef4.camel@kernel.org>
         <87h6p86p9z.fsf@mail.parknet.co.jp>
         <edf8e8ca3b38e56f30e0d24ac7293f848ffee371.camel@kernel.org>
         <87a5v06kij.fsf@mail.parknet.co.jp>
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

On Thu, 2023-08-10 at 05:14 +0900, OGAWA Hirofumi wrote:
> Jeff Layton <jlayton@kernel.org> writes:
>=20
> > When you say it "doesn't work the same", what do you mean, specifically=
?
> > I had to make some allowances for the fact that FAT is substantially
> > different in its timestamp handling, and I tried to preserve existing
> > behavior as best I could.
>=20
> Ah, ok. I was misreading some.
>=20
> inode_update_timestamps() checks IS_I_VERSION() now, not S_VERSION.  So,
> if adding the check of IS_I_VERSION() and (S_MTIME|S_CTIME|S_VERSION) to
> FAT?
>=20
> With it, IS_I_VERSION() would be false on FAT, and I'm fine.
>=20
> I.e. something like
>=20
> 	if ((flags & (S_VERSION|S_CTIME|S_MTIME)) && IS_I_VERSION(inode)
> 	    && inode_maybe_inc_iversion(inode, false))
>   		dirty_flags |=3D I_DIRTY_SYNC;
>=20
> Thanks.

If you do that then the i_version counter would never be incremented.
But...I think I see what you're getting at.

Most filesystems that support the i_version counter have an on-disk
field for it. FAT obviously has no such thing. I suspect the i_version
bits in fat_update_time were added by mistake. FAT doesn't set
SB_I_VERSION so there's no need to do anything to the i_version field at
all.

Also, given that the mtime and ctime are always kept in sync on FAT,
we're probably fine to have it look something like this:

--------------------8<------------------
int fat_update_time(struct inode *inode, int flags)=20
{=20
        int dirty_flags =3D 0;

        if (inode->i_ino =3D=3D MSDOS_ROOT_INO)=20
                return 0;

        fat_truncate_time(inode, NULL, flags);
        if (inode->i_sb->s_flags & SB_LAZYTIME)
                dirty_flags |=3D I_DIRTY_TIME;
        else
                dirty_flags |=3D I_DIRTY_SYNC;

        __mark_inode_dirty(inode, dirty_flags);
        return 0;
}=20
--------------------8<------------------

...and we should probably do that in a separate patch in advance of the
update_time rework, since it's really a different change.

If you're in agreement, then I'll plan to respin the series with this
fixed and resend.

Thanks for being patient!
--=20
Jeff Layton <jlayton@kernel.org>
