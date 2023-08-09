Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC007767EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 21:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjHITFd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 15:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHITFb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:05:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DE7E71;
        Wed,  9 Aug 2023 12:05:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B6A964095;
        Wed,  9 Aug 2023 19:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5CFC433C8;
        Wed,  9 Aug 2023 19:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691607929;
        bh=4GKDaia1VeW/OijfJXE9UHIufNesebWNQDy9LU2whYI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gEyeaJZ4RUWChIryvRrKWbHk6CbM8eHu0rqtHvzvba6SSDpBpPtag+D6BMw4GFw2n
         hFXK4OEbm0L9R1B4K8eNiaiBDtquinDOVTFyiDIMSP6pKYqwvVgkMBHyc14BMMGMP8
         zAV3KdTeX3lKcSKjE5oKnAjO29eKsnCAgTvUvEsF/+3xUpWxGZvbyls48Ed9vXaSwV
         DcuV4QvGf703nsP6BpmM4kVysUgEr6LDinf8/zizcxdQ20sie+EHfzuPrXj/APOCtH
         91Mo4Dg4M0l0SApVPB8n1GBtVl5sn3TKwCbUSa9ZQiDyJiArJw0iRB7MWozIYejid0
         q+2d4Xd9I1nbw==
Message-ID: <cbc98eb171d6ccacb24213af7d0ae91094d39780.camel@kernel.org>
Subject: Re: [PATCH v7 08/13] fs: drop the timespec64 argument from
 update_time
From:   Jeff Layton <jlayton@kernel.org>
To:     Mike Marshall <hubcap@omnibond.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Wed, 09 Aug 2023 15:05:21 -0400
In-Reply-To: <CAOg9mST=WFAjEwS9eNi_huoUpBvPy3R3fbFVTLUeFZAv6BJEEQ@mail.gmail.com>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
         <20230807-mgctime-v7-8-d1dec143a704@kernel.org>
         <20230809-segeln-pflaumen-460b81bd2d3a@brauner>
         <CAOg9mST=WFAjEwS9eNi_huoUpBvPy3R3fbFVTLUeFZAv6BJEEQ@mail.gmail.com>
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

Yes. It's in Christian's vfs.ctime branch:

https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=3Dvfs.ct=
ime

On Wed, 2023-08-09 at 14:38 -0400, Mike Marshall wrote:
> I've been following this patch on fsdevel... is there a
> remote I could fetch with a branch that has this in it?
>=20
> -Mike
>=20
> On Wed, Aug 9, 2023 at 8:32=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> >=20
> > On Mon, Aug 07, 2023 at 03:38:39PM -0400, Jeff Layton wrote:
> > > Now that all of the update_time operations are prepared for it, we ca=
n
> > > drop the timespec64 argument from the update_time operation. Do that =
and
> > > remove it from some associated functions like inode_update_time and
> > > inode_needs_update_time.
> > >=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/bad_inode.c           |  3 +--
> > >  fs/btrfs/inode.c         |  3 +--
> > >  fs/btrfs/volumes.c       |  4 +---
> > >  fs/fat/fat.h             |  3 +--
> > >  fs/fat/misc.c            |  2 +-
> > >  fs/gfs2/inode.c          |  3 +--
> > >  fs/inode.c               | 30 +++++++++++++-----------------
> > >  fs/overlayfs/inode.c     |  2 +-
> > >  fs/overlayfs/overlayfs.h |  2 +-
> > >  fs/ubifs/file.c          |  3 +--
> > >  fs/ubifs/ubifs.h         |  2 +-
> > >  fs/xfs/xfs_iops.c        |  1 -
> > >  include/linux/fs.h       |  4 ++--
> >=20
> > This was missing the conversion of fs/orangefs orangefs_update_time()
> > causing the build to fail. So at some point kbuild will yell here.
> > Fwiw, I've fixed that up in-tree.

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
