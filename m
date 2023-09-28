Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717E37B234C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 19:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjI1RJ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 13:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjI1RJ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:09:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3246DC0;
        Thu, 28 Sep 2023 10:09:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E060C433C8;
        Thu, 28 Sep 2023 17:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695920964;
        bh=zRV/ipMOOeHJFSr00KRb3DbkWuWIfMUsmholMiYqIFk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RTCWP38X/3Qiq9e2eoLruFi6qLhhyLJQrL65PrzDXWj1P7d+rG2Zhi5BPUongplET
         wsh5RnIrkn2G9TM6HAAN0NYZV5F3YR+mvgQFtP+9DfawGUb0VUEGN4ZEWFes0Iqc9f
         GfOE5yeYJ7UoCrij4lXLrG+jRW8wnHjCzfKNNQxN4dSF4K07yMiaZJqV+VHP19Z5O0
         9Eizi+4+cRTlhImq1fbs7Tb7Mmc79AROTIyl6OUF1ztlUjMfm5tqzXneCy0nyt31m3
         teqvuavXAiJG2oyvZuxOiGcbkwGZED723LL7ZyPIvGZsh/B5aAGwbzTt8Xw0FUHUy0
         P2xkFw6PYWKrw==
Message-ID: <555fd53b72742fe8a8d2b67c80502f749631d773.camel@kernel.org>
Subject: Re: [PATCH 86/87] fs: switch timespec64 fields in inode to discrete
 integers
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Jeremy Kerr <jk@ozlabs.org>,
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
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Mattia Dongili <malattia@linux.it>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Ian Kent <raven@themaw.net>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>, Jan Kara <jack@suse.cz>,
        David Woodhouse <dwmw2@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>, Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
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
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
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
        Eric Paris <eparis@parisplace.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, v9fs@lists.linux.dev,
        linux-afs@lists.infradead.org, autofs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, linux-efi@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, gfs2@lists.linux.dev,
        linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-unionfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org,
        linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Date:   Thu, 28 Sep 2023 13:09:08 -0400
In-Reply-To: <20230928110554.34758-2-jlayton@kernel.org>
References: <20230928110554.34758-1-jlayton@kernel.org>
         <20230928110554.34758-2-jlayton@kernel.org>
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

On Thu, 2023-09-28 at 07:05 -0400, Jeff Layton wrote:
> This shaves 8 bytes off struct inode, according to pahole.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/fs.h | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 831657011036..de902ff2938b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -671,9 +671,12 @@ struct inode {
>  	};
>  	dev_t			i_rdev;
>  	loff_t			i_size;
> -	struct timespec64	__i_atime; /* use inode_*_atime accessors */
> -	struct timespec64	__i_mtime; /* use inode_*_mtime accessors */
> -	struct timespec64	__i_ctime; /* use inode_*_ctime accessors */
> +	time64_t		i_atime_sec;
> +	time64_t		i_mtime_sec;
> +	time64_t		i_ctime_sec;
> +	u32			i_atime_nsec;
> +	u32			i_mtime_nsec;
> +	u32			i_ctime_nsec;
>  	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
>  	unsigned short          i_bytes;
>  	u8			i_blkbits;
> @@ -1519,7 +1522,9 @@ struct timespec64 inode_set_ctime_current(struct in=
ode *inode);
>   */
>  static inline struct timespec64 inode_get_ctime(const struct inode *inod=
e)
>  {
> -	return inode->__i_ctime;
> +	struct timespec64 ts =3D { .tv_sec  =3D inode->i_ctime_sec,
> +				 .tv_nsec =3D inode->i_ctime_nsec };
> +	return ts;
>  }
>=20
>
> =20
>  /**
> @@ -1532,7 +1537,8 @@ static inline struct timespec64 inode_get_ctime(con=
st struct inode *inode)
>  static inline struct timespec64 inode_set_ctime_to_ts(struct inode *inod=
e,
>  						      struct timespec64 ts)
>  {
> -	inode->__i_ctime =3D ts;
> +	inode->i_ctime_sec =3D ts.tv_sec;
> +	inode->i_ctime_nsec =3D ts.tv_sec;

Bug above and in the other inode_set_?time_to_ts() functions. This isn't
setting the nsec field correctly.

>  	return ts;
>  }
>=20
>=20


> =20
> @@ -1555,13 +1561,17 @@ static inline struct timespec64 inode_set_ctime(s=
truct inode *inode,
> =20
>  static inline struct timespec64 inode_get_atime(const struct inode *inod=
e)
>  {
> -	return inode->__i_atime;
> +	struct timespec64 ts =3D { .tv_sec  =3D inode->i_atime_sec,
> +				 .tv_nsec =3D inode->i_atime_nsec };
> +
> +	return ts;
>  }
> =20
>  static inline struct timespec64 inode_set_atime_to_ts(struct inode *inod=
e,
>  						      struct timespec64 ts)
>  {
> -	inode->__i_atime =3D ts;
> +	inode->i_atime_sec =3D ts.tv_sec;
> +	inode->i_atime_nsec =3D ts.tv_sec;
>  	return ts;
>  }
> =20
> @@ -1575,13 +1585,17 @@ static inline struct timespec64 inode_set_atime(s=
truct inode *inode,
> =20
>  static inline struct timespec64 inode_get_mtime(const struct inode *inod=
e)
>  {
> -	return inode->__i_mtime;
> +	struct timespec64 ts =3D { .tv_sec  =3D inode->i_mtime_sec,
> +				 .tv_nsec =3D inode->i_mtime_nsec };
> +
> +	return ts;
>  }
> =20
>  static inline struct timespec64 inode_set_mtime_to_ts(struct inode *inod=
e,
>  						      struct timespec64 ts)
>  {
> -	inode->__i_mtime =3D ts;
> +	inode->i_atime_sec =3D ts.tv_sec;
> +	inode->i_atime_nsec =3D ts.tv_sec;

Doh! s/atime/mtime/ in the above lines.

>  	return ts;
>  }
> =20

Both bugs are fixed in my tree.
--=20
Jeff Layton <jlayton@kernel.org>
