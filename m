Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05E07A68FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 18:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjISQbm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 12:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjISQbd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:31:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EAB1A7;
        Tue, 19 Sep 2023 09:31:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A27C433CD;
        Tue, 19 Sep 2023 16:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695141076;
        bh=2YOWI6/JAFOB4t8+Jl1G0UAU2WJNOEKR+ozWrF+wCHw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NSgO9mQ/kogScKOyruXs27QKGb28KeH5iN8518jdQIxYZ9Zq8W5Yeb8HJpLNbIZ40
         EQDdGtIWCMRwCZr+hkVhSKagEDB2fBTdAzDnNexBTyvRGH8+mWpGC7k4O3oOthSODy
         kLPJh5RYmd+l51ixbejRXP63ZyU1UyglaFGETEGRw2BGftvafb/kUzhWZeRY/B1ibo
         Wti21rW2JgdQmcow8/EHQlT7uWQR0pPH/ecD4lkrfORAvjqUH6xcDxBDFUTwISNY24
         GBmtqEOt9wCW1B2y4/2rn4A5SVB2ofaAjm8Z64p+ka1gu4ZTZ9u3KdunqSf9K8+AlP
         OJGP0iADrktsQ==
Message-ID: <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
From:   Jeff Layton <jlayton@kernel.org>
To:     Bruno Haible <bruno@clisp.org>, Jan Kara <jack@suse.cz>,
        Xi Ruoyao <xry111@linuxfromscratch.org>, bug-gnulib@gnu.org
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
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bo b Peterson <rpeterso@redhat.com>,
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
        Amir Goldstein <l@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Tue, 19 Sep 2023 12:31:08 -0400
In-Reply-To: <4511209.uG2h0Jr0uP@nimes>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
         <20230919110457.7fnmzo4nqsi43yqq@quack3>
         <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
         <4511209.uG2h0Jr0uP@nimes>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-09-19 at 16:52 +0200, Bruno Haible wrote:
> Jeff Layton wrote:
> > I'm not sure what we can do for this test. The nap() function is making
> > an assumption that the timestamp granularity will be constant, and that
> > isn't necessarily the case now.
>=20
> This is only of secondary importance, because the scenario by Jan Kara
> shows a much more fundamental breakage:
>=20
> > > The ultimate problem is that a sequence like:
> > >=20
> > > write(f1)
> > > stat(f2)
> > > write(f2)
> > > stat(f2)
> > > write(f1)
> > > stat(f1)
> > >=20
> > > can result in f1 timestamp to be (slightly) lower than the final f2
> > > timestamp because the second write to f1 didn't bother updating the
> > > timestamp. That can indeed be a bit confusing to programs if they com=
pare
> > > timestamps between two files. Jeff?
> > >=20
> >=20
> > Basically yes.
>=20
> f1 was last written to *after* f2 was last written to. If the timestamp o=
f f1
> is then lower than the timestamp of f2, timestamps are fundamentally brok=
en.
>=20
> Many things in user-space depend on timestamps, such as build system
> centered around 'make', but also 'find ... -newer ...'.
>=20


What does breakage with make look like in this situation? The "fuzz"
here is going to be on the order of a jiffy. The typical case for make
timestamp comparisons is comparing source files vs. a build target. If
those are being written nearly simultaneously, then that could be an
issue, but is that a typical behavior? It seems like it would be hard to
rely on that anyway, esp. given filesystems like NFS that can do lazy
writeback.

One of the operating principles with this series is that timestamps can
be of varying granularity between different files. Note that Linux
already violates this assumption when you're working across filesystems
of different types.

As to potential fixes if this is a real problem:

I don't really want to put this behind a mount or mkfs option (a'la
relatime, etc.), but that is one possibility.

I wonder if it would be feasible to just advance the coarse-grained
current_time whenever we end up updating a ctime with a fine-grained
timestamp? It might produce some inode write amplification. Files that
were written within the same jiffy could see more inode transactions
logged, but that still might not be _too_ awful.

I'll keep thinking about it for now.
--=20
Jeff Layton <jlayton@kernel.org>
