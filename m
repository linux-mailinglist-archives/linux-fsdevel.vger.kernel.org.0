Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108E5739E26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 12:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjFVKOz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 06:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjFVKOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:14:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FA2DD;
        Thu, 22 Jun 2023 03:14:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2EBF617C7;
        Thu, 22 Jun 2023 10:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2888C433C9;
        Thu, 22 Jun 2023 10:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687428888;
        bh=7+cabg86v1cYpPv8vDJOW5RfunjhlSEWXfJLwIkmtqs=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=bash4qEoN8ysoF4HTnLUBoIb4R/VvEf+WW/D9VIwZ7IkIbfsRZHAuo5DrHgU3mESQ
         YV3L6vJlJ5RLoTi5/71VkN5rQAydrP7yy38zcSGGfwasNdQxjqfQEDJO2KhRfaS72P
         L3pOkZCMNStmacczTh8Bxts4KstAt3iUVQoAzfNq5O0qEkTp/AQ/ZxnvFiOtuM8Rrh
         hGFigQvIDdzAyY8j4H2gTF58blmQ8XCJxFBrtJ8bp21DHjiO/HINP7f4QOOgCaaZnm
         wPOh/3PFD9MITyv48Pm3mcErp57QuFgfhsUJhmJROqlUtadgwIZDzlw31/avwVXFpE
         VwFt0TPP5toFA==
Message-ID: <ad4bfb630128709588164db6f1fd2ef39c31d2a5.camel@kernel.org>
Subject: Re: [PATCH 01/79] fs: add ctime accessors infrastructure
From:   Jeff Layton <jlayton@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Kent <raven@themaw.net>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tyler Hicks <code@tyhicks.com>,
        Ard Biesheuvel <ardb@kernel.org>, Gao Xiang <xiang@kernel.org>,
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
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        David Woodhouse <dwmw2@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>, Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Bob Copeland <me@bobcopeland.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anders Larsen <al@alarsen.net>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Juergen Gross <jgross@suse.com>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Udipto Goswami <quic_ugoswami@quicinc.com>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        John Keeping <john@keeping.me.uk>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Dan Carpenter <error27@gmail.com>,
        Yuta Hayama <hayama@lineo.co.jp>,
        Jozef Martiniak <jomajm@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sandeep Dhavale <dhavale@google.com>,
        Dave Chinner <dchinner@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Aditya Garg <gargaditya08@live.com>,
        Erez Zadok <ezk@cs.stonybrook.edu>,
        Yifei Liu <yifeliu@cs.stonybrook.edu>,
        Yu Zhe <yuzhe@nfschina.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oleg Kanatov <okanatov@gmail.com>,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        xu xin <cgel.zte@gmail.com>, Stefan Roesch <shr@devkernel.io>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Seth Forshee <sforshee@digitalocean.com>,
        Zeng Jingxiang <linuszeng@tencent.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Tom Rix <trix@redhat.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Rik van Riel <riel@surriel.com>,
        Jingyu Wang <jingyuwang_vip@163.com>,
        Hangyu Hua <hbh25y@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-usb@vger.kernel.org,
        v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, autofs@vger.kernel.org,
        linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu,
        ecryptfs@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-unionfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org,
        linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Date:   Thu, 22 Jun 2023 06:14:30 -0400
In-Reply-To: <99b3c749-23d9-6f09-fb75-6a84f3d1b066@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
         <20230621144507.55591-2-jlayton@kernel.org>
         <99b3c749-23d9-6f09-fb75-6a84f3d1b066@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-06-22 at 09:46 +0900, Damien Le Moal wrote:
> On 6/21/23 23:45, Jeff Layton wrote:
> > struct timespec64 has unused bits in the tv_nsec field that can be used
> > for other purposes. In future patches, we're going to change how the
> > inode->i_ctime is accessed in certain inodes in order to make use of
> > them. In order to do that safely though, we'll need to eradicate raw
> > accesses of the inode->i_ctime field from the kernel.
> >=20
> > Add new accessor functions for the ctime that we can use to replace the=
m.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> [...]
>=20
> > +/**
> > + * inode_ctime_peek - fetch the current ctime from the inode
> > + * @inode: inode from which to fetch ctime
> > + *
> > + * Grab the current ctime from the inode and return it.
> > + */
> > +static inline struct timespec64 inode_ctime_peek(const struct inode *i=
node)
>=20
> To be consistent with inode_ctime_set(), why not call this one inode_ctim=
e_get()

In later patches fetching the ctime for presentation may have side
effects on certain filesystems. Using "peek" here is a hint that we want
to avoid those side effects in these calls.

> ? Also, inode_set_ctime() & inode_get_ctime() may be a little more natura=
l. But
> no strong opinion about that though.
>=20

I like the consistency of the inode_ctime_* prefix. It makes it simpler
to find these calls when grepping, etc.

That said, my opinions on naming are pretty loosely-held, so if the
consensus is that the names should as you suggest, I'll go along with
it.
--=20
Jeff Layton <jlayton@kernel.org>
