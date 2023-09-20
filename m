Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D737A88C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 17:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbjITPph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 11:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbjITPpf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:45:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224E7A3;
        Wed, 20 Sep 2023 08:45:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF6E422037;
        Wed, 20 Sep 2023 15:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695224727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gw0GfkzEv5qjhmPaYmrLrmVLcBgiouetaUVK1NJf9SE=;
        b=gDmHlI6XIITA9cWR7273bMWfTaFm79ZWCKV9DUbgwsMsYlQtttv7ABQywrVa7BRoFxk5Vs
        fY8Ytovd+JgcWaHYYF/cazBOkeQAnuEbAgfy+zWX2EEn3UHUxNv8SLgNC/S16/CAgBAqvG
        jDzYA0P8qRNq8WfC9VqpMNAjW8ajDQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695224727;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gw0GfkzEv5qjhmPaYmrLrmVLcBgiouetaUVK1NJf9SE=;
        b=486eKcFxONt6Xlrpd7pWWA685BmUhAvAAZoUWjfk3k5wgXtMAG8bbabr8rPv7UJw6UUY7B
        IV+4KbXuBo0SdmBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA9FC13A64;
        Wed, 20 Sep 2023 15:45:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sEc2KZcTC2VITwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 20 Sep 2023 15:45:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 33A59A077D; Wed, 20 Sep 2023 17:45:27 +0200 (CEST)
Date:   Wed, 20 Sep 2023 17:45:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Bruno Haible <bruno@clisp.org>,
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
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
Message-ID: <20230920154527.pkwot4nu2nzrnamd@quack3>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
 <20230919110457.7fnmzo4nqsi43yqq@quack3>
 <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
 <4511209.uG2h0Jr0uP@nimes>
 <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
 <20230920-leerung-krokodil-52ec6cb44707@brauner>
 <20230920101731.ym6pahcvkl57guto@quack3>
 <317d84b1b909b6c6519a2406fcb302ce22dafa41.camel@kernel.org>
 <20230920124823.ghl6crb5sh4x2pmt@quack3>
 <ca82af4d6a72d7f83223c0ddd74fd9f7bcfa96b1.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca82af4d6a72d7f83223c0ddd74fd9f7bcfa96b1.camel@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 20-09-23 10:12:03, Jeff Layton wrote:
> On Wed, 2023-09-20 at 14:48 +0200, Jan Kara wrote:
> > On Wed 20-09-23 06:35:18, Jeff Layton wrote:
> > > On Wed, 2023-09-20 at 12:17 +0200, Jan Kara wrote:
> > > > If I were a sysadmin, I'd rather opt for something like
> > > > finegrained timestamps + lazytime (if I needed the finegrained timestamps
> > > > functionality). That should avoid the IO overhead of finegrained timestamps
> > > > as well and I'd know I can have problems with timestamps only after a
> > > > system crash.
> > > 
> > > > I've just got another idea how we could solve the problem: Couldn't we
> > > > always just report coarsegrained timestamp to userspace and provide access
> > > > to finegrained value only to NFS which should know what it's doing?
> > > > 
> > > 
> > > I think that'd be hard. First of all, where would we store the second
> > > timestamp? We can't just truncate the fine-grained ones to come up with
> > > a coarse-grained one. It might also be confusing having nfsd and local
> > > filesystems present different attributes.
> > 
> > So what I had in mind (and I definitely miss all the NFS intricacies so the
> > idea may be bogus) was that inode->i_ctime would be maintained exactly as
> > is now. There will be new (kernel internal at least for now) STATX flag
> > STATX_MULTIGRAIN_TS. fill_mg_cmtime() will return timestamp truncated to
> > sb->s_time_gran unless STATX_MULTIGRAIN_TS is set. Hence unless you set
> > STATX_MULTIGRAIN_TS, there is no difference in the returned timestamps
> > compared to the state before multigrain timestamps were introduced. With
> > STATX_MULTIGRAIN_TS we return full precision timestamp as stored in the
> > inode. Then NFS in fh_fill_pre_attrs() and fh_fill_post_attrs() needs to
> > make sure STATX_MULTIGRAIN_TS is set when calling vfs_getattr() to get
> > multigrain time.
> 
> > I agree nfsd may now be presenting slightly different timestamps than user
> > is able to see with stat(2) directly on the filesystem. But is that a
> > problem? Essentially it is a similar solution as the mgtime mount option
> > but now sysadmin doesn't have to decide on filesystem mount how to report
> > timestamps but the stat caller knowingly opts into possibly inconsistent
> > (among files) but high precision timestamps. And in the particular NFS
> > usecase where stat is called all the time anyway, timestamps will likely
> > even be consistent among files.
> > 
> 
> I like this idea...
> 
> Would we also need to raise sb->s_time_gran to something corresponding
> to HZ on these filesystems?

I was actually confused a bit about how timestamp_truncate() works. The
jiffie granularity is just direct consequence of current_time() using
ktime_get_coarse_real_ts64() and not of timestamp_truncate().
sb->s_time_gran seems to be more about the on-disk format so it doesn't
seem like a great idea to touch it. So probably we can just truncate
timestamps in generic_fillattr() to HZ granularity unconditionally.

> If we truncate the timestamps at a granularity corresponding to HZ before
> presenting them via statx and the like then that should work around the
> problem with programs that compare timestamps between inodes.

Exactly.

> With NFSv4, when a filesystem doesn't report a STATX_CHANGE_COOKIE, nfsd
> will fake one up using the ctime. It's fine for that to use a full fine-
> grained timestamp since we don't expect to be able to compare that value
> with one of a different inode.

Yes.

> I think we'd want nfsd to present the mtime/ctime values as truncated,
> just like we would with a local fs. We could hit the same problem of an
> earlier-looking timestamp with NFS if we try to present the actual fine-
> grained values to the clients. IOW, I'm convinced that we need to avoid
> this behavior in most situations.

I wasn't sure if there's a way to do this within NFS - i.e., if the value
communicated via NFSv3 protocol (I know v4 has a special change cookie
field for it) that gets used for detecting need to revalidate file contents
isn't the one presented to client's userspace as ctime. If there's a way to
do this then great, I'm all for presenting truncated timestamps even for
NFS.

> If we do this, then we technically don't need the mount option either.

Yes, that was my hope.

> We could still add it though, and have it govern whether fill_mg_cmtime
> truncates the timestamps before storing them in the kstat.

Well, if we decide these timestamps are useful for userspace as well, I'd
rather make that a userspace visible STATX flag than a mount option. So
applications aware of the pitfalls can get high precision timestamps
without possibly breaking unaware applications.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
