Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8587A6C7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 22:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjISUqp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 16:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjISUqm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 16:46:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DC8CE;
        Tue, 19 Sep 2023 13:46:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A819FC433C9;
        Tue, 19 Sep 2023 20:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695156393;
        bh=BmRXQZIEgC13FrkspW8zNhSJjLbclay0bgLqEV3Rrl8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=q9KdgZu946MZfw7DxJLZIxiiIbHL9p62pycuILxZHzw8MqP3sd2qzr3E/ZkzfhbEv
         Sv560WUNQE0HlwP/5rEqpm3bw7jCmrV5akvxgau1zBqN4rLOK+/ZjoboBONeleNI+5
         6SP6lExUu15oD0xQisxQolfz9bgwYx59X/D7X0LTGvi5p2a+XVoY+oMnByTr4quQRa
         dZXyYP7t6FAFej2yuwhu+Ce8pxPjyRxtNPk1CXlFaDLgBYYr9H9mjHCggTcasxMD+A
         UZV+ik47sNRSAwVomJhe40/Ndx/tHAngLhTIM40zYtZFnzpPzdTJ314IhHsCYJFhNI
         PFuADp6gLFx9g==
Message-ID: <6e6da8a875a0defec1a0f58314995a6a12dca74e.camel@kernel.org>
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
From:   Jeff Layton <jlayton@kernel.org>
To:     Paul Eggert <eggert@cs.ucla.edu>, Bruno Haible <bruno@clisp.org>,
        Jan Kara <jack@suse.cz>,
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
Date:   Tue, 19 Sep 2023 16:46:25 -0400
In-Reply-To: <c8315110-4684-9b83-d6c5-751647037623@cs.ucla.edu>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
         <20230919110457.7fnmzo4nqsi43yqq@quack3>
         <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
         <4511209.uG2h0Jr0uP@nimes>
         <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
         <c8315110-4684-9b83-d6c5-751647037623@cs.ucla.edu>
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

On Tue, 2023-09-19 at 13:10 -0700, Paul Eggert wrote:
> On 2023-09-19 09:31, Jeff Layton wrote:
> > The typical case for make
> > timestamp comparisons is comparing source files vs. a build target. If
> > those are being written nearly simultaneously, then that could be an
> > issue, but is that a typical behavior?
>=20
> I vaguely remember running into problems with 'make' a while ago=20
> (perhaps with a BSDish system) when filesystem timestamps were=20
> arbitrarily truncated in some cases but not others. These files would=20
> look older than they really were, so 'make' would think they were=20
> up-to-date when they weren't, and 'make' would omit actions that it=20
> should have done, thus screwing up the build.
>=20
> File timestamps can be close together with 'make -j' on fast hosts.=20
> Sometimes a shell script (or 'make' itself) will run 'make', then modify=
=20
> a file F, then immediately run 'make' again; the latter 'make' won't=20
> work if F's timestamp is mistakenly older than targets that depend on it.
>=20
> Although 'make'-like apps are the biggest canaries in this coal mine,=20
> the issue also affects 'find -newer' (as Bruno mentioned), 'rsync -u',=
=20
> 'mv -u', 'tar -u', Emacs file-newer-than-file-p, and surely many other=
=20
> places. For example, any app that creates a timestamp file, then backs=
=20
> up all files newer than that file, would be at risk.
>=20
>=20
> > I wonder if it would be feasible to just advance the coarse-grained
> > current_time whenever we end up updating a ctime with a fine-grained
> > timestamp?
>=20
> Wouldn't this need to be done globally, that is, not just on a per-file=
=20
> or per-filesystem basis? If so, I don't see how we'd avoid locking=20
> performance issues.
>=20

Maybe. Another idea might be to introduce a new timekeeper for
multigrain filesystems, but all of those would likely have to share the
same coarse-grained clock source.

So yeah, if you stat an inode and then update it, any inode written on a
multigrain filesystem within the same jiffy-sized window would have to
log an extra transaction to write out the inode. That's what I meant
when I was talking about write amplification.

>=20
> PS. Although I'm no expert in the Linux inode code I hope you don't mind=
=20
> my asking a question about this part of inode_set_ctime_current:
>=20
> 	/*
> 	 * If we've recently updated with a fine-grained timestamp,
> 	 * then the coarse-grained one may still be earlier than the
> 	 * existing ctime. Just keep the existing value if so.
> 	 */
> 	ctime.tv_sec =3D inode->__i_ctime.tv_sec;
> 	if (timespec64_compare(&ctime, &now) > 0)
> 		return ctime;
>=20
> Suppose root used clock_settime to set the clock backwards. Won't this=
=20
> code incorrectly refuse to update the file's timestamp afterwards? That=
=20
> is, shouldn't the last line be "goto fine_grained;" rather than "return=
=20
> ctime;", with the comment changed from "keep the existing value" to "use=
=20
> a fine-grained value"?

It is a problem, and Linus pointed that out yesterday, which is why I
sent this earlier today:

https://lore.kernel.org/linux-fsdevel/20230919-ctime-v1-1-97b3da92f504@kern=
el.org/T/#u

Bear in mind that we're not dealing with a situation where the value has
not been queried since its last update, so we don't need to use a fine
grained timestamp there (and really, it's preferable not to do so). A
coarse one should be fine in this case.
--=20
Jeff Layton <jlayton@kernel.org>
