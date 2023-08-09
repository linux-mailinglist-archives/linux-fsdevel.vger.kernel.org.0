Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19ADA7767DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 21:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjHITEx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 15:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjHITEw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:04:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868D8E71;
        Wed,  9 Aug 2023 12:04:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8AFC644A1;
        Wed,  9 Aug 2023 19:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB107C433C7;
        Wed,  9 Aug 2023 19:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691607890;
        bh=alXrKPD5fHXeJn9UjHKim4LKQU7HoozYjQglaZ1xXaI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AneNvnqJ20CJmKiEgeASfLx4NSIFXV4j2vtzAKGnX32iLsSf9A43S7wAfHVHbYQQP
         h3ON9dJJ2d4zasDcG0OHa5a1AfenYnO+uoesgXhOt+soOjJtmmxlhUNc5QuXKGuVOg
         rulv+awus9qyVEIGRttUpq9Lcin2kAZfB093o2LczBjmWrzPbu4HcAMNS3Ib4zj45p
         3u7x0mQLZuZR6+lN5gsi60S8IiOPzBT4vt1n3+KsBq67CA1z2KjKobM8vv+qdWmPsN
         ddnXMIFOGmdQH1E3uRbvXBai78DI/EAYz+8n3M9qwxNTsQtwGjIcAPpzsM/ELjqang
         5ERP9Tcme3DHA==
Message-ID: <edf8e8ca3b38e56f30e0d24ac7293f848ffee371.camel@kernel.org>
Subject: Re: [PATCH v7 05/13] fat: make fat_update_time get its own timestamp
From:   Jeff Layton <jlayton@kernel.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
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
Date:   Wed, 09 Aug 2023 15:04:42 -0400
In-Reply-To: <87h6p86p9z.fsf@mail.parknet.co.jp>
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
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-08-10 at 03:31 +0900, OGAWA Hirofumi wrote:
> Jeff Layton <jlayton@kernel.org> writes:
>=20
> > On Thu, 2023-08-10 at 02:44 +0900, OGAWA Hirofumi wrote:
> > > Jeff Layton <jlayton@kernel.org> writes:
> > >=20
> > That would be wrong. The problem is that we're changing how update_time
> > works:
> >=20
> > Previously, update_time was given a timestamp and a set of S_* flags to
> > indicate which fields should be updated. Now, update_time is not given =
a
> > timestamp. It needs to fetch it itself, but that subtly changes the
> > meaning of the flags field.
> >=20
> > It now means "these fields needed to be updated when I last checked".
> > The timestamp and i_version may now be different from when the flags
> > field was set. This means that if any of S_CTIME/S_MTIME/S_VERSION were
> > set that we need to attempt to update all 3 of them. They may now be
> > different from the timestamp or version that we ultimately end up with.
> >=20
> > The above may look to you like it would always cause I_DIRTY_SYNC to be
> > set on any ctime or mtime update, but inode_maybe_inc_iversion only
> > returns true if it actually updated i_version, and it only does that if
> > someone issued a ->getattr against the file since the last time it was
> > updated.
> >=20
> > So, this shouldn't generate any more DIRTY_SYNC updates than it did
> > before.
>=20
> Again, if you claim so, why generic_update_time() doesn't work same? Why
> only FAT does?
>=20
> Or I'm misreading generic_update_time() patch?
>=20

When you say it "doesn't work the same", what do you mean, specifically?
I had to make some allowances for the fact that FAT is substantially
different in its timestamp handling, and I tried to preserve existing
behavior as best I could.

--=20
Jeff Layton <jlayton@kernel.org>
