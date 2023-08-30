Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E14578D0DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 02:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239507AbjH3ADt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 20:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239708AbjH3ADm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 20:03:42 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42E01BD;
        Tue, 29 Aug 2023 17:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mhHf9bnOddbdauFdwTiNvB2pCJGntgXJjGP69XrW3To=; b=Bog5SZG0TYg0s2MQQfbUs9uVXk
        XdtKROAwAGEUaoPB8IuJVEXbl9mZlm0jEhEk3H4E+vKRQyFUUSOp4nTdUWPuxI7Hp4HjDNA443+/y
        /0fOLJMKC2WIb2tS4b+Rt+QMGMmK7PEfbf7jtUs42sJFP5+vBQdLHF+vLX+GuQ5QG1n3CXTQMflpP
        3DlTErG3FOwEjKOWr7tFZ3fPuvJ3DhE+vRtnrlv2iBll7kd62LGwN6s1l2hycllZ+6XxX/OrWlMoY
        fxqTZRWZnCLTwYTWHz4AyRowlDGrc1MtyEFAz5FrKLMLieuTK/6uE/WBBD7mLUNv8cYmrCXKVybDc
        uCQ9Bpgw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qb8f7-001xNh-0Q;
        Wed, 30 Aug 2023 00:02:21 +0000
Date:   Wed, 30 Aug 2023 01:02:21 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Eric Van Hensbergen <ericvh@kernel.org>,
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
        Christian Brauner <brauner@kernel.org>,
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
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Anthony Iliopoulos <ailiop@suse.com>, v9fs@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nfs@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        devel@lists.orangefs.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-mtd@lists.infradead.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 1/7] fs: pass the request_mask to generic_fillattr
Message-ID: <20230830000221.GB3390869@ZenIV>
References: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org>
 <20230725-mgctime-v6-1-a794c2b7abca@kernel.org>
 <20230829224454.GA461907@ZenIV>
 <e1c4a6d5001d029548542a1f10425c5639ce28e4.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1c4a6d5001d029548542a1f10425c5639ce28e4.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 29, 2023 at 06:58:47PM -0400, Jeff Layton wrote:
> On Tue, 2023-08-29 at 23:44 +0100, Al Viro wrote:
> > On Tue, Jul 25, 2023 at 10:58:14AM -0400, Jeff Layton wrote:
> > > generic_fillattr just fills in the entire stat struct indiscriminately
> > > today, copying data from the inode. There is at least one attribute
> > > (STATX_CHANGE_COOKIE) that can have side effects when it is reported,
> > > and we're looking at adding more with the addition of multigrain
> > > timestamps.
> > > 
> > > Add a request_mask argument to generic_fillattr and have most callers
> > > just pass in the value that is passed to getattr. Have other callers
> > > (e.g. ksmbd) just pass in STATX_BASIC_STATS. Also move the setting of
> > > STATX_CHANGE_COOKIE into generic_fillattr.
> > 
> > Out of curiosity - how much PITA would it be to put request_mask into
> > kstat?  Set it in vfs_getattr_nosec() (and those get_file_..._info()
> > on smbd side) and don't bother with that kind of propagation boilerplate
> > - just have generic_fillattr() pick it there...
> > 
> > Reduces the patchset size quite a bit...
> 
> It could be done. To do that right, I think we'd want to drop
> request_mask from the ->getattr prototype as well and just have
> everything use the mask in the kstat.
> 
> I don't think it'd reduce the size of the patchset in any meaningful
> way, but it might make for a more sensible API over the long haul.

->getattr() prototype change would be decoupled from that - for your
patchset you'd only need the field addition + setting in vfs_getattr_nosec()
(and possibly in ksmbd), with the remainders of both series being
independent from each other.

What I suggest is

branchpoint -> field addition (trivial commit) -> argument removal
		|
		V
your series, starting with "use stat->request_mask in generic_fillattr()"

Total size would be about the same, but it would be easier to follow
the less trivial part of that.  Nothing in your branch downstream of
that touches any ->getattr() instances, so it should have no
conflicts with the argument removal side of things.
