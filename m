Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9007B412F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 16:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbjI3OvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 10:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjI3Ou6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:50:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB1CB7;
        Sat, 30 Sep 2023 07:50:55 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5046bf37daeso14337382e87.1;
        Sat, 30 Sep 2023 07:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696085453; x=1696690253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laSU2ptF5dJtGJTOfsu2vTDoKsI4bo31YwsLIpMZHsY=;
        b=MwDUKEd6QG0EtvDSCKf1uxGsuk6yCPhM15PYIYhqDJOgasuaT7+4Oh6GiJZ/vmFugy
         lmSCSLc0F+hG3ukOAM3WdNdBnEAtspfwfQIzIK1Wl+hsYj7CnlRK1SN0CwP2toV4bow4
         LCG2gYB2ozawxJ9b/KfUJbxAn6Xa7t4YEVAl9uocXX1Jw3qs6c/EXfaIr8Rz78OCo8KR
         46YxdeGs8zmcFe+Db4BddvMZE57ZBrJ3u+0YeAZwI0lUMX0nfUrsuM9wr1T+Cx+4tFCh
         43LmQPeSUyLxSTkiFSJ67LGdePIyZblA6OKDAQ/vyk5/2yD5+W+J95PEpgI6GVNdDKdn
         9Sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696085453; x=1696690253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laSU2ptF5dJtGJTOfsu2vTDoKsI4bo31YwsLIpMZHsY=;
        b=T8inobxiaergECByFFZ1CXDbC3XpIp10sjfxquseZvUOFeu2160pvxp0AzdP6cwpsW
         2kGV7KJk9GIz1Oj9AnixG0avheyT4r8wY1P+7mDouL4LbpFsN872mecuBdlfe7NvnDab
         GVoo3WnsccIQpZ/XcHAdxWvc0C/REEi9X+IEwN2c1ii0X+WC4DGXGa6GwNPTKxqdIBet
         A334oKWX3Ex4J8ygtgZKUbCrnpRs8SMDnD0/WXU+7QCJl4wyW29GabzCdhVuOYa/0CGr
         fQvavOmh3je7pojydXHqJ+BKy6MuKRDfSGS4f/Azl+4tfeMHRvqFQCuuvAwXMD6ztg51
         hRKA==
X-Gm-Message-State: AOJu0YwxCCE2ZdXfvn+fN9bDB86YP0y09EvvFI143pYlVp4qXIMaSumB
        jxSh19bFZGCMwTmkGL2yJGIgODIRi2Yhl2GhGJQ=
X-Google-Smtp-Source: AGHT+IFKxuEfsWI2Hoye015VefDxXDDWWovJHhYR0GsRnul5m9+uvo7GWv6zNWozBrWHqGB+PwbJIGFbA8W5CapoIHU=
X-Received: by 2002:a05:6512:124a:b0:503:5cd:998b with SMTP id
 fb10-20020a056512124a00b0050305cd998bmr7557694lfb.28.1696085453195; Sat, 30
 Sep 2023 07:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230928110554.34758-1-jlayton@kernel.org> <20230928110554.34758-2-jlayton@kernel.org>
 <6020d6e7-b187-4abb-bf38-dc09d8bd0f6d@app.fastmail.com> <af047e4a1c6947c59d4a13d4ae221c784a5386b4.camel@kernel.org>
 <20230928171943.GK11439@frogsfrogsfrogs> <6a6f37d16b55a3003af3f3dbb7778a367f68cd8d.camel@kernel.org>
 <636661.1695969129@warthog.procyon.org.uk>
In-Reply-To: <636661.1695969129@warthog.procyon.org.uk>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 30 Sep 2023 09:50:41 -0500
Message-ID: <CAH2r5ms14hPaz=Ex2a=Dj0Hz3XxYLRKFj_rHHekznTbNJ_wABQ@mail.gmail.com>
Subject: Re: [PATCH 86/87] fs: switch timespec64 fields in inode to discrete integers
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Anders Larsen <al@alarsen.net>,
        Carlos Llamas <cmllamas@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mattia Dongili <malattia@linux.it>,
        Hugh Dickins <hughd@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Mike Marshall <hubcap@omnibond.com>,
        Paulo Alcantara <pc@manguebit.com>, linux-xfs@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        James Morris <jmorris@namei.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        devel@lists.orangefs.org, Shyam Prasad N <sprasad@microsoft.com>,
        linux-um@lists.infradead.org, Nicholas Piggin <npiggin@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, Jan Kara <jack@suse.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-trace-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>, linux-mm@kvack.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Eric Dumazet <edumazet@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Leon Romanovsky <leon@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>, codalist@coda.cs.cmu.edu,
        Iurii Zaikin <yzaikin@google.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Todd Kjos <tkjos@android.com>,
        Vasily Gorbik <gor@linux.ibm.com>, selinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, reiserfs-devel@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Yue Hu <huyue2@coolpad.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Martijn Coenen <maco@android.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Hao Luo <haoluo@google.com>, Tony Luck <tony.luck@intel.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Nicolas Pitre <nico@fluxnic.net>,
        linux-ntfs-dev@lists.sourceforge.net,
        Muchun Song <muchun.song@linux.dev>,
        linux-f2fs-devel@lists.sourceforge.net,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, gfs2@lists.linux.dev,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Anna Schumaker <anna@kernel.org>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-efi@vger.kernel.org,
        Martin Brandenburg <martin@omnibond.com>,
        ocfs2-devel@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
        platform-driver-x86@vger.kernel.org, Chris Mason <clm@fb.com>,
        linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org,
        Marc Dionne <marc.dionne@auristor.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-afs@lists.infradead.org, Ian Kent <raven@themaw.net>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, coda@cs.cmu.edu,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, autofs@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Gross <markgross@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Eric Paris <eparis@parisplace.org>, ceph-devel@vger.kernel.org,
        Gao Xiang <xiang@kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
        linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>,
        Song Liu <song@kernel.org>, samba-technical@lists.samba.org,
        Steve French <sfrench@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
        Netdev <netdev@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org,
        "David S . Miller" <davem@davemloft.net>,
        Chandan Babu R <chandan.babu@oracle.com>,
        jfs-discussion@lists.sourceforge.net, Jan Kara <jack@suse.cz>,
        Neil Brown <neilb@suse.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Bob Copeland <me@bobcopeland.com>,
        KP Singh <kpsingh@kernel.org>, linux-unionfs@vger.kernel.org,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Fasheh <mark@fasheh.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-serial@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        linux-cifs@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Chao Yu <chao@kernel.org>, apparmor@lists.ubuntu.com,
        Josef Bacik <josef@toxicpanda.com>,
        Tom Talpey <tom@talpey.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        v9fs@lists.linux.dev, David Sterba <dsterba@suse.cz>,
        linux-security-module@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-karma-devel@lists.sourceforge.net,
        linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 29, 2023 at 3:06=E2=80=AFAM David Howells via samba-technical
<samba-technical@lists.samba.org> wrote:
>
>
> Jeff Layton <jlayton@kernel.org> wrote:
>
> > Correct. We'd lose some fidelity in currently stored timestamps, but as
> > Linus and Ted pointed out, anything below ~100ns granularity is
> > effectively just noise, as that's the floor overhead for calling into
> > the kernel. It's hard to argue that any application needs that sort of
> > timestamp resolution, at least with contemporary hardware.
>
> Albeit with the danger of making Steve French very happy;-), would it mak=
e
> sense to switch internally to Microsoft-style 64-bit timestamps with thei=
r
> 100ns granularity?

100ns granularity does seem to make sense and IIRC was used by various
DCE standards in the 90s and 2000s (not just used for SMB2/SMB3 protocol an=
d
various Windows filesystems)


--=20
Thanks,

Steve
