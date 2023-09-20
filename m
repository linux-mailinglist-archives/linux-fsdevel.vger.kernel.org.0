Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5AC7A7BFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 13:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjITL5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 07:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbjITL5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:57:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E1C119;
        Wed, 20 Sep 2023 04:56:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677F3C433CD;
        Wed, 20 Sep 2023 11:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695211011;
        bh=v+kxoG9eOGJ5xusIWXasOkiwnORCBCOMs4NdoCLCV+Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Rg4SDYT2G/5iLIMjOccnvEi1JiFZ6DWISJeHQBkraG1wlEzFngIZ40YiKunM8cbSc
         +aGiW2BG1XlefCOYsICZDxSIj/cycJoqoVgH21scC+LvhZuM/I7QY33SH4s37GiB3i
         xx8VoYkq8098drZ1/id4lmBEMu3eQVNXWTxAUaEp2MAhsi3wNH08SmNvjfcYqsJCu1
         KXrrrvTysK40Yb4V8RFHdyvz2X1AZgX3gj24E21SykmhPZrGV8Spjbs29Y+Wz+E6KX
         beC0Mxqh0EOjy/WL/hLY5L03MPDQWMARcGn8Qnl4hdNKDEe2Is8D1IwBJNuuGtXBBF
         rmhEIbbPeuCGA==
Message-ID: <35c28758a9cc28a276a6b4b4ae8a420a1444e711.camel@kernel.org>
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Bruno Haible <bruno@clisp.org>,
        Xi Ruoyao <xry111@linuxfromscratch.org>, bug-gnulib@gnu.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Date:   Wed, 20 Sep 2023 07:56:43 -0400
In-Reply-To: <20230920-raser-teehaus-029cafd5a6e4@brauner>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
         <20230919110457.7fnmzo4nqsi43yqq@quack3>
         <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
         <4511209.uG2h0Jr0uP@nimes>
         <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
         <20230920-leerung-krokodil-52ec6cb44707@brauner>
         <20230920101731.ym6pahcvkl57guto@quack3>
         <317d84b1b909b6c6519a2406fcb302ce22dafa41.camel@kernel.org>
         <20230920-raser-teehaus-029cafd5a6e4@brauner>
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

On Wed, 2023-09-20 at 13:48 +0200, Christian Brauner wrote:
> > > > While we initially thought we can do this unconditionally it turns =
out
> > > > that this might break existing workloads that rely on timestamps in=
 very
> > > > specific ways and we always knew this was a possibility. Move
> > > > multi-grain timestamps behind a vfs mount option.
> > >=20
> > > Surely this is a safe choice as it moves the responsibility to the sy=
sadmin
> > > and the cases where finegrained timestamps are required. But I kind o=
f
> > > wonder how is the sysadmin going to decide whether mgtime is safe for=
 his
> > > system or not? Because the possible breakage needn't be obvious at th=
e
> > > first sight...
> > >=20
> >=20
> > That's the main reason I really didn't want to go with a mount option.
> > Documenting that may be difficult. While there is some pessimism around
> > it, I may still take a stab at just advancing the coarse clock whenever
> > we fetch a fine-grained timestamp. It'd be nice to remove this option i=
n
> > the future if that turns out to be feasible.
> >=20
> > > If I were a sysadmin, I'd rather opt for something like
> > > finegrained timestamps + lazytime (if I needed the finegrained timest=
amps
> > > functionality). That should avoid the IO overhead of finegrained time=
stamps
> > > as well and I'd know I can have problems with timestamps only after a
> > > system crash.
> >=20
> > > I've just got another idea how we could solve the problem: Couldn't w=
e
> > > always just report coarsegrained timestamp to userspace and provide a=
ccess
> > > to finegrained value only to NFS which should know what it's doing?
> > >=20
> >=20
> > I think that'd be hard. First of all, where would we store the second
> > timestamp? We can't just truncate the fine-grained ones to come up with
> > a coarse-grained one. It might also be confusing having nfsd and local
> > filesystems present different attributes.
>=20
> As far as I can tell we have two options. The first one is to make this
> into a mount option which I really think isn't a big deal and lets us
> avoid this whole problem while allowing filesytems exposed via NFS to
> make use of this feature for change tracking.
>=20
> The second option is that we turn off fine-grained finestamps for v6.6
> and you get to explore other options.
>=20
> It isn't a big deal regressions like this were always to be expected but
> v6.6 needs to stabilize so anything that requires more significant work
> is not an option.

Oh, absolutely.

I wasn't proposing to do that work for v6.6. For that, we absolutely
either need the mount option or to just revert the mgtime conversions.

My plan was to take a stab at doing this for a later kernel release.
This is very much a "back to the drawing board" idea. It may not pan out
after all, but if it does then we could consider removing the mount
option at that point.
--=20
Jeff Layton <jlayton@kernel.org>
