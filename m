Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979047A609B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 13:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjISLFH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 07:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjISLFF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:05:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EB6130;
        Tue, 19 Sep 2023 04:04:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 163C61FDBE;
        Tue, 19 Sep 2023 11:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695121498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2a6e2yyPMgqeI3y+2Rnc2fZeeo+kgiK2m70Hco9fnr4=;
        b=cJr+PwvUYyZH2t3upcBw0eryf4DE/LlFfn7Ufm2eAWd1VY02qygFmTzBIaJahVSz94O4Vb
        yGqIOI0jCW0Ip0Sk2rToBmP3VAYVKS3al3oLycPIe7d7v/sSOaNYyizpxk5ZIrSJFN93/P
        SUBM4OkiK17iPKtzTKMO612fqmtdvLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695121498;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2a6e2yyPMgqeI3y+2Rnc2fZeeo+kgiK2m70Hco9fnr4=;
        b=meYxUUYPlIj0HPS4xS8OLRDZWnsHTMsdExQo9ACa74+dnEYe0U3v8eAO6qjvM08RQNmwM8
        rVywJglnBJnDHgDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C72D013458;
        Tue, 19 Sep 2023 11:04:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TL5uMVmACWVNYAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 19 Sep 2023 11:04:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 11C86A0759; Tue, 19 Sep 2023 13:04:57 +0200 (CEST)
Date:   Tue, 19 Sep 2023 13:04:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xi Ruoyao <xry111@linuxfromscratch.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Jan Kara <jack@suse.cz>, bug-gnulib@gnu.org
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
Message-ID: <20230919110457.7fnmzo4nqsi43yqq@quack3>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
 <20230807-mgctime-v7-12-d1dec143a704@kernel.org>
 <bf0524debb976627693e12ad23690094e4514303.camel@linuxfromscratch.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf0524debb976627693e12ad23690094e4514303.camel@linuxfromscratch.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 19-09-23 15:05:24, Xi Ruoyao wrote:
> On Mon, 2023-08-07 at 15:38 -0400, Jeff Layton wrote:
> > Enable multigrain timestamps, which should ensure that there is an
> > apparent change to the timestamp whenever it has been written after
> > being actively observed via getattr.
> > 
> > For ext4, we only need to enable the FS_MGTIME flag.
> 
> Hi Jeff,
> 
> This patch causes a gnulib test failure:
> 
> $ ~/sources/lfs/grep-3.11/gnulib-tests/test-stat-time
> test-stat-time.c:141: assertion 'statinfo[0].st_mtime < statinfo[2].st_mtime || (statinfo[0].st_mtime == statinfo[2].st_mtime && (get_stat_mtime_ns (&statinfo[0]) < get_stat_mtime_ns (&statinfo[2])))' failed
> Aborted (core dumped)
> 
> The source code of the test:
> https://git.savannah.gnu.org/cgit/gnulib.git/tree/tests/test-stat-time.c
> 
> Is this an expected change?

Kind of yes. The test first tries to estimate filesystem timestamp
granularity in nap() function - due to this patch, the detected granularity
will likely be 1 ns so effectively all the test calls will happen
immediately one after another. But we don't bother setting the timestamps
with more than 1 jiffy (usually 4 ms) precision unless we think someone is
watching. So as a result timestamps of all stamp1 and stamp2 files are
going to be equal which makes the test fail.

The ultimate problem is that a sequence like:

write(f1)
stat(f2)
write(f2)
stat(f2)
write(f1)
stat(f1)

can result in f1 timestamp to be (slightly) lower than the final f2
timestamp because the second write to f1 didn't bother updating the
timestamp. That can indeed be a bit confusing to programs if they compare
timestamps between two files. Jeff?

								Honza


> > Acked-by: Theodore Ts'o <tytso@mit.edu>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ext4/super.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index b54c70e1a74e..cb1ff47af156 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -7279,7 +7279,7 @@ static struct file_system_type ext4_fs_type = {
> >  	.init_fs_context	= ext4_init_fs_context,
> >  	.parameters		= ext4_param_specs,
> >  	.kill_sb		= kill_block_super,
> > -	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
> > +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP |
> > FS_MGTIME,
> >  };
> >  MODULE_ALIAS_FS("ext4");
> >  
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
