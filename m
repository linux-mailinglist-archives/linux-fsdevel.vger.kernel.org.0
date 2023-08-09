Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE9B776512
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 18:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjHIQbD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 12:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHIQbC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:31:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6C210F3;
        Wed,  9 Aug 2023 09:31:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2950F63697;
        Wed,  9 Aug 2023 16:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FEDC433C8;
        Wed,  9 Aug 2023 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691598660;
        bh=Z7n9zJLdl712XVn1Py2iFtPG8LzL7lbCWNuqyD+/A3g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UPQGy8NQtXAAQ4aU3XYZHYnotv5CJersRvEj3UxLTDTNa1yXwNRn0IJiEHo/bl0VP
         UZsTGWxiaK4MtB7dfslKXsWsCHmiZVr63spdJLnJq8JDgcyekVH5Xc7NL7sGLhreu6
         x15cmd+UhtlNWpehU4jYdveXB5k/7G4WPmTr0CQ6bDhyChBFc9/xsm+0Rn2qIx7rJs
         G7MVuLgnF5bvQR49Ipq6cF6+TvuMnXYBCNHAg7UV972mLj2aJnJNB5RVRDI4hEyHex
         /4cPUAWVkqpnS01ZlGmCOld61C8SWimdxp5ttui+xDqTyf2eAGc7ZrzDWG2FklGBAx
         JNZznme+soZDw==
Message-ID: <2cb998ff14ace352a9dd553e82cfa0aa92ec09ce.camel@kernel.org>
Subject: Re: [PATCH v7 05/13] fat: make fat_update_time get its own timestamp
From:   Jeff Layton <jlayton@kernel.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Jan Kara <jack@suse.cz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
Date:   Wed, 09 Aug 2023 12:30:52 -0400
In-Reply-To: <87v8do6y8q.fsf@mail.parknet.co.jp>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
         <20230807-mgctime-v7-5-d1dec143a704@kernel.org>
         <87msz08vc7.fsf@mail.parknet.co.jp>
         <52bead1d6a33fec89944b96e2ec20d1ea8747a9a.camel@kernel.org>
         <878rak8hia.fsf@mail.parknet.co.jp>
         <20230809150041.452w7gucjmvjnvbg@quack3>
         <87v8do6y8q.fsf@mail.parknet.co.jp>
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

On Thu, 2023-08-10 at 00:17 +0900, OGAWA Hirofumi wrote:
> Jan Kara <jack@suse.cz> writes:
>=20
> > Since you are talking past one another with Jeff let me chime in here :=
). I
> > think you are worried about this hunk:
>=20
> Right.
>
> > -	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
> > +	if ((flags & (S_VERSION|S_CTIME|S_MTIME)) && inode_maybe_inc_iversion=
(inode, false))
> >  		dirty_flags |=3D I_DIRTY_SYNC;
> >=20
> > which makes the 'flags' test pass even if we just modified ctime or mti=
me.
> > But do note the second part of the if - inode_maybe_inc_iversion() - so=
 we
> > are going to mark the inode dirty with I_DIRTY_SYNC only if someone que=
ried
> > iversion since the last time we have incremented it.
> >=20
> > So this hunk is not really changing how inode is marked dirty, it only
> > changes how often we check whether iversion needs increment and that sh=
ould
> > be fine (and desirable). Hence lazytime isn't really broken by this in =
any
> > way.
>=20
> OK. However, then it doesn't explain what I asked. This is not same with
> generic_update_time(), only FAT does.
>
> If thinks it is right thing, why generic_update_time() doesn't? I said
> first reply, this was from generic_update_time(). (Or I'm misreading
> updated generic_update_time()?)
>=20

My mistake re: lazytime vs. relatime, but Jan is correct that this
shouldn't break anything there.

The logic in the revised generic_update_time is different because FAT is
is a bit strange. fat_update_time does extra truncation on the timestamp
that it is handed beyond what timestamp_truncate() does.
fat_truncate_time is called in many different places too, so I don't
feel comfortable making big changes to how that works.

In the case of generic_update_time, it calls inode_update_timestamps
which returns a mask that shows which timestamps got updated. It then
marks the dirty_flags appropriately for what was actually changed.

generic_update_time is used across many filesystems so we need to ensure
that it's OK to use even when multigrain timestamps are enabled. Those
haven't been enabled in FAT though, so I didn't bother, and left it to
dirtying the inode in the same way it was before, even though it now
fetches its own timestamps from the clock. Given the way that the mtime
and ctime are smooshed together in FAT, that seemed reasonable.

Is there a particular case or flag combination you're concerned about
here?
--=20
Jeff Layton <jlayton@kernel.org>
