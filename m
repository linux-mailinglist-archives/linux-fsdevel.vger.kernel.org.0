Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4917B455F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Oct 2023 07:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjJAFjY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 01:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJAFjX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 01:39:23 -0400
X-Greylist: delayed 2207 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 30 Sep 2023 22:39:18 PDT
Received: from mx08-006a4e02.pphosted.com (mx08-006a4e02.pphosted.com [143.55.148.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD9FC5;
        Sat, 30 Sep 2023 22:39:18 -0700 (PDT)
Received: from pps.filterd (m0316693.ppops.net [127.0.0.1])
        by mx08-006a4e02.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3913gioS006695;
        Sun, 1 Oct 2023 07:02:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iram.es; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to:content-transfer-encoding; s=dkim3;
         bh=5JgHwkJ5bZA+PRufvniyMuRJN1Jr6719sKCuadOAMmw=; b=hDNmwqgug1An
        fvwB2cRTfoutFDu+tai+5nrTyDJGpD0Pkv+UoD9dDHnHHIAd09gz+r02mse1Cs9K
        ZCgOca/WGL5QjFanXXswWHZ9gsDFv9HUsGVbSl0NWG9zgx7F1IrS1vcyAC4I2TBu
        vtCiSXblwT2BOKB168GcAoNAG3zywK5ZIdX9TFP4bHS8GBFExgd9NXibijGF4eid
        NlYGioPXJRFaYlb2eKu0casy5f5iNW/FoS1c0RbxZP9tWhnpwN4+plV0Uq3PyrZu
        vjfbiPtJ7zPzKAVMjvhFWJMgaNJzLRSZANzAdWFrm7A8N1ie1vidQt1Dp6QldrsP
        8q3fZB20SA==
Received: from sim.rediris.es (mta-out04.sim.rediris.es [130.206.24.46])
        by mx08-006a4e02.pphosted.com (PPS) with ESMTPS id 3tewvarrd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 01 Oct 2023 07:02:17 +0200 (MEST)
Received: from sim.rediris.es (localhost.localdomain [127.0.0.1])
        by sim.rediris.es (Postfix) with ESMTPS id 0AB0D182CCF;
        Sun,  1 Oct 2023 07:02:16 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by sim.rediris.es (Postfix) with ESMTP id 86FFB182CCC;
        Sun,  1 Oct 2023 07:02:15 +0200 (CEST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
 mta-out04.sim.rediris.es
Received: from sim.rediris.es ([127.0.0.1])
 by localhost (mta-out04.sim.rediris.es [127.0.0.1]) (amavis, port 10026)
 with ESMTP id qO51DSuhuoLH; Sun,  1 Oct 2023 07:02:14 +0200 (CEST)
Received: from gp-workstation.iram.es (haproxy01.sim.rediris.es [130.206.24.69])
        by sim.rediris.es (Postfix) with ESMTPA id 96282180084;
        Sun,  1 Oct 2023 07:01:58 +0200 (CEST)
Date:   Sun, 1 Oct 2023 07:01:56 +0200
From:   Gabriel Paubert <paubert@iram.es>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Anders Larsen <al@alarsen.net>,
        Carlos Llamas <cmllamas@google.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Mattia Dongili <malattia@linux.it>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Mike Marshall <hubcap@omnibond.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Morris <jmorris@namei.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        devel@lists.orangefs.org, Shyam Prasad N <sprasad@microsoft.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, linux-um@lists.infradead.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kr oah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Jan Kara <jack@suse.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        samba-technical@lists.samba.org,
        Marc Dionne <marc.dionne@auristor.com>,
        Eric Dumazet <edumazet@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Leon Romanovsky <leon@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrii Nakryiko <andrii@kernel.org>, codalist@coda.cs.cmu.edu,
        Iurii Zaikin <yzaikin@google.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        linux-trace-kernel@vger.kernel.org, Todd Kjos <tkjos@android.com>,
        Vasily Gorbik <gor@linux.ibm.com>, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org,
        Sungjong Seo <sj1557.seo@samsung.com>,
        ocfs2-devel@lists.linux.dev, Yue Hu <huyue2@coolpad.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Martijn Coenen <maco@android.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Hao Luo <haoluo@google.com>, Tony Luck <tony.luck@intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Nicolas Pitre <nico@fluxnic.net>,
        linux-ntfs-dev@lists.sourceforge.net,
        Muchun Song <muchun.song@linux.dev>,
        linux-f2fs-devel@lists.sourceforge.net,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Anna Schumaker <anna@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-efi@vger.kernel.org,
        Martin Brandenburg <martin@omnibond.com>,
        Alexei Starovoitov <ast@kernel.org>,
        platform-driver-x86@vger.kernel.or.g,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Chris Mason <clm@fb.com>, linux-mtd@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-afs@lists.infradead.org, Ian Kent <raven@themaw.net>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Miklos Szeredi <miklos@szeredi.hu>, linux-rdma@vger.kernel.org,
        coda@cs.cmu.edu,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, autofs@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Gross <markgross@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Eric Paris <eparis@parisplace.org>, ceph-devel@vger.kernel.org,
        Gao Xiang <xiang@kernel.org>, gfs2@lists.linux.dev,
        linux-nfs@vger.kernel.org, linux-ext4@vger.ker.nel.org,
        Olga Kornievskaia <kolga@netapp.com>,
        Song Liu <song@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        linux-xfs@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
        Bob Peterson <rpeterso@redhat.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org,
        "David S . Miller" <davem@davemloft.net>,
        Chandan Babu R <chandan.babu@oracle.com>,
        jfs-discussion@lists.sourceforge.net, Jan Kara <jack@suse.cz>,
        Neil Brown <neilb@suse.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Bob Copeland <me@bobcopeland.com>,
        KP Singh <kpsingh@kernel.org>, David Sterba <dsterba@suse.cz>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-mm@kvack.org, Andreas Dilger <adilger.kernel@dilger.ca>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Fasheh <mark@fasheh.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Steve French <sfrench@samba.org>, linux-serial@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        linux-cifs@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Chao Yu <chao@kernel.org>, apparmor@lists.ubuntu.com,
        Josef Bacik <josef@toxicpanda.com>,
        Tom Talpey <tom@talpey.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        John Johansen <john.johansen@canonical.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Netdev <netdev@vger.kernel.org>, v9fs@li.sts.linux.dev,
        linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Johannes Thumshirn <jth@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-karma-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Subject: [OT] Re: [PATCH 86/87] fs: switch timespec64 fields in inode to
 discrete integers
Message-ID: <20231001050156.GA3366643@gp-workstation.iram.es>
References: <20230928110554.34758-1-jlayton@kernel.org>
 <20230928110554.34758-2-jlayton@kernel.org>
 <6020d6e7-b187-4abb-bf38-dc09d8bd0f6d@app.fastmail.com>
 <af047e4a1c6947c59d4a13d4ae221c784a5386b4.camel@kernel.org>
 <20230928171943.GK11439@frogsfrogsfrogs>
 <6a6f37d16b55a3003af3f3dbb7778a367f68cd8d.camel@kernel.org>
 <636661.1695969129@warthog.procyon.org.uk>
 <CAH2r5ms14hPaz=Ex2a=Dj0Hz3XxYLRKFj_rHHekznTbNJ_wABQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH2r5ms14hPaz=Ex2a=Dj0Hz3XxYLRKFj_rHHekznTbNJ_wABQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 7g7M4VduddtlWYRAuFdJHm-pjLCEd0SM
X-Proofpoint-GUID: 7g7M4VduddtlWYRAuFdJHm-pjLCEd0SM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-01_02,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=salida_notspam policy=salida score=0 bulkscore=0 impostorscore=0
 mlxlogscore=544 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2310010040
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 30, 2023 at 09:50:41AM -0500, Steve French wrote:
> On Fri, Sep 29, 2023 at 3:06=E2=80=AFAM David Howells via samba-technic=
al
> <samba-technical@lists.samba.org> wrote:
> >
> >
> > Jeff Layton <jlayton@kernel.org> wrote:
> >
> > > Correct. We'd lose some fidelity in currently stored timestamps, bu=
t as
> > > Linus and Ted pointed out, anything below ~100ns granularity is
> > > effectively just noise, as that's the floor overhead for calling in=
to
> > > the kernel. It's hard to argue that any application needs that sort=
 of
> > > timestamp resolution, at least with contemporary hardware.
> >
> > Albeit with the danger of making Steve French very happy;-), would it=
 make
> > sense to switch internally to Microsoft-style 64-bit timestamps with =
their
> > 100ns granularity?
>=20
> 100ns granularity does seem to make sense and IIRC was used by various
> DCE standards in the 90s and 2000s (not just used for SMB2/SMB3 protoco=
l and
> various Windows filesystems)

Historically it probably comes from VMS, where system time and file
timestamps were a 64 bit integer counting in 100ns units starting on MJD
2400000.5 (Nov 17th 1858).

Gabriel

>=20
>=20
> --=20
> Thanks,
>=20
> Steve
 

