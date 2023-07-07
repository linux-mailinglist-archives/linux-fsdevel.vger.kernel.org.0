Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6C774B128
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 14:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjGGMm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 08:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjGGMmy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:42:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCEC119;
        Fri,  7 Jul 2023 05:42:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E01C61997;
        Fri,  7 Jul 2023 12:42:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F41C433C7;
        Fri,  7 Jul 2023 12:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688733770;
        bh=TyDDLyY/VcXA49d9KRhq25UQSsoE8KWu0+bfyRbBUqg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iyNIEkX0vplHsZRVLrECpVOA1mp+pn1xQk8anv4sNjl819MUB6L7g/QyZr09T8v7X
         4l5fvHniDmWHLBbdiHqiq9H2cTxWHaomnmD4P0h6lKZGmzU4smc5wAjNsqS84NFdll
         SSoDpJcqRJcJOvdAyIR3hUdTdGFP8DMxgpiVSBrtu8xsQGAVo33idlmhxRmj5xte2M
         GXiVu3pw23oyZWMMzp8kXFgZEQukowtqu+nAIcpDxVTKiHudvESqbwGfJcf0AdYGsm
         WEMofoo1motyhtMcUn2DtHPcG7Cqyp0rQarcusFg1CfwsyO+EeEA0qEhKts9ufRMsA
         P6UZP6VS0JBRg==
Message-ID: <5e40891f6423feb5b68f025e31f26e9a50ae9390.camel@kernel.org>
Subject: Re: [PATCH v2 00/89] fs: new accessors for inode->i_ctime
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     jk@ozlabs.org, arnd@arndb.de, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
        cmllamas@google.com, surenb@google.com,
        dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org, bwarrum@linux.ibm.com, rituagar@linux.ibm.com,
        ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com, dsterba@suse.com, dhowells@redhat.com,
        marc.dionne@auristor.com, viro@zeniv.linux.org.uk,
        raven@themaw.net, luisbg@kernel.org, salah.triki@gmail.com,
        aivazian.tigran@gmail.com, ebiederm@xmission.com,
        keescook@chromium.org, clm@fb.com, josef@toxicpanda.com,
        xiubli@redhat.com, idryomov@gmail.com, jaharkes@cs.cmu.edu,
        coda@cs.cmu.edu, jlbec@evilplan.org, hch@lst.de, nico@fluxnic.net,
        rafael@kernel.org, code@tyhicks.com, ardb@kernel.org,
        xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, linkinjeon@kernel.org,
        sj1557.seo@samsung.com, jack@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        hirofumi@mail.parknet.co.jp, miklos@szeredi.hu,
        rpeterso@redhat.com, agruenba@redhat.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        mikulas@artax.karlin.mff.cuni.cz, mike.kravetz@oracle.com,
        muchun.song@linux.dev, dwmw2@infradead.org, shaggy@kernel.org,
        tj@kernel.org, trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, konishi.ryusuke@gmail.com,
        anton@tuxera.com, almaz.alexandrovich@paragon-software.com,
        mark@fasheh.com, joseph.qi@linux.alibaba.com, me@bobcopeland.com,
        hubcap@omnibond.com, martin@omnibond.com, amir73il@gmail.com,
        mcgrof@kernel.org, yzaikin@google.com, tony.luck@intel.com,
        gpiccoli@igalia.com, al@alarsen.net, sfrench@samba.org,
        pc@manguebit.com, lsahlber@redhat.com, sprasad@microsoft.com,
        senozhatsky@chromium.org, phillip@squashfs.org.uk,
        rostedt@goodmis.org, mhiramat@kernel.org, dushistov@mail.ru,
        hdegoede@redhat.com, djwong@kernel.org, dlemoal@kernel.org,
        naohiro.aota@wdc.com, jth@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, hughd@google.com, akpm@linux-foundation.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, john.johansen@canonical.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        jgross@suse.com, stern@rowland.harvard.edu, lrh2000@pku.edu.cn,
        sebastian.reichel@collabora.com, wsa+renesas@sang-engineering.com,
        quic_ugoswami@quicinc.com, quic_linyyuan@quicinc.com,
        john@keeping.me.uk, error27@gmail.com, quic_uaggarwa@quicinc.com,
        hayama@lineo.co.jp, jomajm@gmail.com, axboe@kernel.dk,
        dhavale@google.com, dchinner@redhat.com, hannes@cmpxchg.org,
        zhangpeng362@huawei.com, slava@dubeyko.com, gargaditya08@live.com,
        penguin-kernel@I-love.SAKURA.ne.jp, yifeliu@cs.stonybrook.edu,
        madkar@cs.stonybrook.edu, ezk@cs.stonybrook.edu,
        yuzhe@nfschina.com, willy@infradead.org, okanatov@gmail.com,
        jeffxu@chromium.org, linux@treblig.org, mirimmad17@gmail.com,
        yijiangshan@kylinos.cn, yang.yang29@zte.com.cn,
        xu.xin16@zte.com.cn, chengzhihao1@huawei.com, shr@devkernel.io,
        Liam.Howlett@Oracle.com, adobriyan@gmail.com,
        chi.minghao@zte.com.cn, roberto.sassu@huawei.com,
        linuszeng@tencent.com, bvanassche@acm.org, zohar@linux.ibm.com,
        yi.zhang@huawei.com, trix@redhat.com, fmdefrancesco@gmail.com,
        ebiggers@google.com, princekumarmaurya06@gmail.com,
        chenzhongjin@huawei.com, riel@surriel.com,
        shaozhengchao@huawei.com, jingyuwang_vip@163.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-usb@vger.kernel.org, v9fs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        autofs@vger.kernel.org, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org,
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
Date:   Fri, 07 Jul 2023 08:42:31 -0400
In-Reply-To: <20230705185812.579118-1-jlayton@kernel.org>
References: <20230705185812.579118-1-jlayton@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-07-05 at 14:58 -0400, Jeff Layton wrote:
> v2:
> - prepend patches to add missing ctime updates
> - add simple_rename_timestamp helper function
> - rename ctime accessor functions as inode_get_ctime/inode_set_ctime_*
> - drop individual inode_ctime_set_{sec,nsec} helpers
>=20

After review by Jan and others, and Jan's ext4 rework, the diff on top
of the series I posted a couple of days ago is below. I don't really
want to spam everyone with another ~100 patch v3 series, but I can if
you think that's best.

Christian, what would you like me to do here?

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index bcdb1a0beccf..5f6e93714f5a 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -699,8 +699,7 @@ void ceph_fill_file_time(struct inode *inode, int issue=
d,
 		if (ci->i_version =3D=3D 0 ||
 		    timespec64_compare(ctime, &ictime) > 0) {
 			dout("ctime %lld.%09ld -> %lld.%09ld inc w/ cap\n",
-			     inode_get_ctime(inode).tv_sec,
-			     inode_get_ctime(inode).tv_nsec,
+			     ictime.tv_sec, ictime.tv_nsec,
 			     ctime->tv_sec, ctime->tv_nsec);
 			inode_set_ctime_to_ts(inode, *ctime);
 		}
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 806374d866d1..567c0d305ea4 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -175,10 +175,7 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		vi->chunkbits =3D sb->s_blocksize_bits +
 			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	}
-	inode->i_mtime.tv_sec =3D inode_get_ctime(inode).tv_sec;
-	inode->i_atime.tv_sec =3D inode_get_ctime(inode).tv_sec;
-	inode->i_mtime.tv_nsec =3D inode_get_ctime(inode).tv_nsec;
-	inode->i_atime.tv_nsec =3D inode_get_ctime(inode).tv_nsec;
+	inode->i_mtime =3D inode->i_atime =3D inode_get_ctime(inode);
=20
 	inode->i_flags &=3D ~S_DAX;
 	if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index c007de6ac1c7..1b9f587f6cca 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1351,7 +1351,7 @@ static int exfat_rename(struct mnt_idmap *idmap,
 			exfat_warn(sb, "abnormal access to an inode dropped");
 			WARN_ON(new_inode->i_nlink =3D=3D 0);
 		}
-		EXFAT_I(new_inode)->i_crtime =3D inode_set_ctime_current(new_inode);
+		EXFAT_I(new_inode)->i_crtime =3D current_time(new_inode);
 	}
=20
 unlock:
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index d502b930431b..d63543187359 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -868,64 +868,63 @@ struct ext4_inode {
  * affected filesystem before 2242.
  */
=20
-static inline __le32 ext4_encode_extra_time(struct timespec64 *time)
+static inline __le32 ext4_encode_extra_time(struct timespec64 ts)
 {
-	u32 extra =3D((time->tv_sec - (s32)time->tv_sec) >> 32) & EXT4_EPOCH_MASK=
;
-	return cpu_to_le32(extra | (time->tv_nsec << EXT4_EPOCH_BITS));
+	u32 extra =3D ((ts.tv_sec - (s32)ts.tv_sec) >> 32) & EXT4_EPOCH_MASK;
+	return cpu_to_le32(extra | (ts.tv_nsec << EXT4_EPOCH_BITS));
 }
=20
-static inline void ext4_decode_extra_time(struct timespec64 *time,
-					  __le32 extra)
+static inline struct timespec64 ext4_decode_extra_time(__le32 base,
+						       __le32 extra)
 {
+	struct timespec64 ts =3D { .tv_sec =3D le32_to_cpu(base) };
+
 	if (unlikely(extra & cpu_to_le32(EXT4_EPOCH_MASK)))
-		time->tv_sec +=3D (u64)(le32_to_cpu(extra) & EXT4_EPOCH_MASK) << 32;
-	time->tv_nsec =3D (le32_to_cpu(extra) & EXT4_NSEC_MASK) >> EXT4_EPOCH_BIT=
S;
+		ts.tv_sec +=3D (u64)(le32_to_cpu(extra) & EXT4_EPOCH_MASK) << 32;
+	ts.tv_nsec =3D (le32_to_cpu(extra) & EXT4_NSEC_MASK) >> EXT4_EPOCH_BITS;
+	return ts;
 }
=20
-#define EXT4_INODE_SET_XTIME(xtime, inode, raw_inode)				\
+#define EXT4_INODE_SET_XTIME_VAL(xtime, inode, raw_inode, ts)			\
 do {										\
-	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## _extra))     {\
-		(raw_inode)->xtime =3D cpu_to_le32((inode)->xtime.tv_sec);	\
-		(raw_inode)->xtime ## _extra =3D					\
-				ext4_encode_extra_time(&(inode)->xtime);	\
-		}								\
-	else	\
-		(raw_inode)->xtime =3D cpu_to_le32(clamp_t(int32_t, (inode)->xtime.tv_se=
c, S32_MIN, S32_MAX));	\
+	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## _extra)) {	\
+		(raw_inode)->xtime =3D cpu_to_le32((ts).tv_sec);			\
+		(raw_inode)->xtime ## _extra =3D ext4_encode_extra_time(ts);	\
+	} else									\
+		(raw_inode)->xtime =3D cpu_to_le32(clamp_t(int32_t, (ts).tv_sec, S32_MIN=
, S32_MAX));	\
 } while (0)
=20
+#define EXT4_INODE_SET_XTIME(xtime, inode, raw_inode)				\
+	EXT4_INODE_SET_XTIME_VAL(xtime, inode, raw_inode, (inode)->xtime)
+
+#define EXT4_INODE_SET_CTIME(inode, raw_inode)					\
+	EXT4_INODE_SET_XTIME_VAL(i_ctime, inode, raw_inode, inode_get_ctime(inode=
))
+
 #define EXT4_EINODE_SET_XTIME(xtime, einode, raw_inode)			       \
-do {									       \
-	if (EXT4_FITS_IN_INODE(raw_inode, einode, xtime))		       \
-		(raw_inode)->xtime =3D cpu_to_le32((einode)->xtime.tv_sec);      \
-	if (EXT4_FITS_IN_INODE(raw_inode, einode, xtime ## _extra))	       \
-		(raw_inode)->xtime ## _extra =3D				       \
-				ext4_encode_extra_time(&(einode)->xtime);      \
-} while (0)
+	EXT4_INODE_SET_XTIME_VAL(xtime, &((einode)->vfs_inode), raw_inode, (einod=
e)->xtime)
+
+#define EXT4_INODE_GET_XTIME_VAL(xtime, inode, raw_inode)			\
+	(EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## _extra) ?	\
+		ext4_decode_extra_time((raw_inode)->xtime,				\
+				       (raw_inode)->xtime ## _extra) :		\
+		(struct timespec64) {						\
+			.tv_sec =3D (signed)le32_to_cpu((raw_inode)->xtime)	\
+		})
=20
 #define EXT4_INODE_GET_XTIME(xtime, inode, raw_inode)				\
 do {										\
-	(inode)->xtime.tv_sec =3D (signed)le32_to_cpu((raw_inode)->xtime);	\
-	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## _extra)) {	\
-		ext4_decode_extra_time(&(inode)->xtime,				\
-				       raw_inode->xtime ## _extra);		\
-		}								\
-	else									\
-		(inode)->xtime.tv_nsec =3D 0;					\
+	(inode)->xtime =3D EXT4_INODE_GET_XTIME_VAL(xtime, inode, raw_inode);	\
 } while (0)
=20
+#define EXT4_INODE_GET_CTIME(inode, raw_inode)					\
+do {										\
+	inode_set_ctime_to_ts(inode,						\
+		EXT4_INODE_GET_XTIME_VAL(i_ctime, inode, raw_inode));		\
+} while (0)
=20
 #define EXT4_EINODE_GET_XTIME(xtime, einode, raw_inode)			       \
 do {									       \
-	if (EXT4_FITS_IN_INODE(raw_inode, einode, xtime))		       \
-		(einode)->xtime.tv_sec =3D 				       \
-			(signed)le32_to_cpu((raw_inode)->xtime);	       \
-	else								       \
-		(einode)->xtime.tv_sec =3D 0;				       \
-	if (EXT4_FITS_IN_INODE(raw_inode, einode, xtime ## _extra))	       \
-		ext4_decode_extra_time(&(einode)->xtime,		       \
-				       raw_inode->xtime ## _extra);	       \
-	else								       \
-		(einode)->xtime.tv_nsec =3D 0;				       \
+	(einode)->xtime =3D EXT4_INODE_GET_XTIME_VAL(xtime, &(einode->vfs_inode),=
 raw_inode);	\
 } while (0)
=20
 #define i_disk_version osd1.linux1.l_i_version
@@ -3823,27 +3822,6 @@ static inline int ext4_buffer_uptodate(struct buffer=
_head *bh)
 	return buffer_uptodate(bh);
 }
=20
-static inline void ext4_inode_set_ctime(struct inode *inode, struct ext4_i=
node *raw_inode)
-{
-	struct timespec64 ctime =3D inode_get_ctime(inode);
-
-	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), i_ctime_extra)) {
-		raw_inode->i_ctime =3D cpu_to_le32(ctime.tv_sec);
-		raw_inode->i_ctime_extra =3D ext4_encode_extra_time(&ctime);
-	} else {
-		raw_inode->i_ctime =3D cpu_to_le32(clamp_t(int32_t, ctime.tv_sec, S32_MI=
N, S32_MAX));
-	}
-}
-
-static inline void ext4_inode_get_ctime(struct inode *inode, const struct =
ext4_inode *raw_inode)
-{
-	struct timespec64 ctime =3D { .tv_sec =3D (signed)le32_to_cpu(raw_inode->=
i_ctime) };
-
-	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), i_ctime_extra))
-		ext4_decode_extra_time(&ctime, raw_inode->i_ctime_extra);
-	inode_set_ctime(inode, ctime.tv_sec, ctime.tv_nsec);
-}
-
 #endif	/* __KERNEL__ */
=20
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
index 7935ea6cf92c..f0c0fd507fbc 100644
--- a/fs/ext4/inode-test.c
+++ b/fs/ext4/inode-test.c
@@ -245,9 +245,9 @@ static void inode_test_xtimestamp_decoding(struct kunit=
 *test)
 	struct timestamp_expectation *test_param =3D
 			(struct timestamp_expectation *)(test->param_value);
=20
-	timestamp.tv_sec =3D get_32bit_time(test_param);
-	ext4_decode_extra_time(&timestamp,
-			       cpu_to_le32(test_param->extra_bits));
+	timestamp =3D ext4_decode_extra_time(
+				cpu_to_le32(get_32bit_time(test_param)),
+				cpu_to_le32(test_param->extra_bits));
=20
 	KUNIT_EXPECT_EQ_MSG(test,
 			    test_param->expected.tv_sec,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bbc57954dfd3..c6a837b90af4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4249,7 +4249,7 @@ static int ext4_fill_raw_inode(struct inode *inode, s=
truct ext4_inode *raw_inode
 	}
 	raw_inode->i_links_count =3D cpu_to_le16(inode->i_nlink);
=20
-	ext4_inode_set_ctime(inode, raw_inode);
+	EXT4_INODE_SET_CTIME(inode, raw_inode);
 	EXT4_INODE_SET_XTIME(i_mtime, inode, raw_inode);
 	EXT4_INODE_SET_XTIME(i_atime, inode, raw_inode);
 	EXT4_EINODE_SET_XTIME(i_crtime, ei, raw_inode);
@@ -4858,7 +4858,7 @@ struct inode *__ext4_iget(struct super_block *sb, uns=
igned long ino,
 		}
 	}
=20
-	ext4_inode_get_ctime(inode, raw_inode);
+	EXT4_INODE_GET_CTIME(inode, raw_inode);
 	EXT4_INODE_GET_XTIME(i_mtime, inode, raw_inode);
 	EXT4_INODE_GET_XTIME(i_atime, inode, raw_inode);
 	EXT4_EINODE_GET_XTIME(i_crtime, ei, raw_inode);
@@ -4981,7 +4981,7 @@ static void __ext4_update_other_inode_time(struct sup=
er_block *sb,
 		spin_unlock(&inode->i_lock);
=20
 		spin_lock(&ei->i_raw_lock);
-		ext4_inode_get_ctime(inode, raw_inode);
+		EXT4_INODE_SET_CTIME(inode, raw_inode);
 		EXT4_INODE_SET_XTIME(i_mtime, inode, raw_inode);
 		EXT4_INODE_SET_XTIME(i_atime, inode, raw_inode);
 		ext4_inode_csum_set(inode, raw_inode, ei);
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 2be40ff8a74f..cdd39b6020f3 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1407,9 +1407,7 @@ static int fat_read_root(struct inode *inode)
 	MSDOS_I(inode)->mmu_private =3D inode->i_size;
=20
 	fat_save_attrs(inode, ATTR_DIR);
-	inode->i_mtime.tv_sec =3D inode->i_atime.tv_sec =3D inode_set_ctime(inode=
,
-									0, 0).tv_sec;
-	inode->i_mtime.tv_nsec =3D inode->i_atime.tv_nsec =3D 0;
+	inode->i_mtime =3D inode->i_atime =3D inode_set_ctime(inode, 0, 0);
 	set_nlink(inode, fat_subdirs(inode)+2);
=20
 	return 0;
diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index 36babb78b510..f4eb8d6f5989 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -15,8 +15,7 @@ static void hpfs_update_directory_times(struct inode *dir=
)
 	if (t =3D=3D dir->i_mtime.tv_sec &&
 	    t =3D=3D inode_get_ctime(dir).tv_sec)
 		return;
-	dir->i_mtime.tv_sec =3D inode_set_ctime(dir, t, 0).tv_sec;
-	dir->i_mtime.tv_nsec =3D 0;
+	dir->i_mtime =3D inode_set_ctime(dir, t, 0);
 	hpfs_write_inode_nolock(dir);
 }
=20
@@ -59,11 +58,8 @@ static int hpfs_mkdir(struct mnt_idmap *idmap, struct in=
ode *dir,
 	result->i_ino =3D fno;
 	hpfs_i(result)->i_parent_dir =3D dir->i_ino;
 	hpfs_i(result)->i_dno =3D dno;
-	inode_set_ctime(result,
-			result->i_mtime.tv_sec =3D result->i_atime.tv_sec =3D local_to_gmt(dir-=
>i_sb, le32_to_cpu(dee.creation_date)),
-			0);
-	result->i_mtime.tv_nsec =3D 0;=20
-	result->i_atime.tv_nsec =3D 0;=20
+	result->i_mtime =3D result->i_atime =3D
+		inode_set_ctime(result, local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation=
_date)), 0);
 	hpfs_i(result)->i_ea_size =3D 0;
 	result->i_mode |=3D S_IFDIR;
 	result->i_op =3D &hpfs_dir_iops;
@@ -168,11 +164,8 @@ static int hpfs_create(struct mnt_idmap *idmap, struct=
 inode *dir,
 	result->i_fop =3D &hpfs_file_ops;
 	set_nlink(result, 1);
 	hpfs_i(result)->i_parent_dir =3D dir->i_ino;
-	inode_set_ctime(result,
-			result->i_mtime.tv_sec =3D result->i_atime.tv_sec =3D local_to_gmt(dir-=
>i_sb, le32_to_cpu(dee.creation_date)),
-			0);
-	result->i_mtime.tv_nsec =3D 0;
-	result->i_atime.tv_nsec =3D 0;
+	result->i_mtime =3D result->i_atime =3D
+		inode_set_ctime(result, local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation=
_date)), 0);
 	hpfs_i(result)->i_ea_size =3D 0;
 	if (dee.read_only)
 		result->i_mode &=3D ~0222;
@@ -252,11 +245,8 @@ static int hpfs_mknod(struct mnt_idmap *idmap, struct =
inode *dir,
 	hpfs_init_inode(result);
 	result->i_ino =3D fno;
 	hpfs_i(result)->i_parent_dir =3D dir->i_ino;
-	inode_set_ctime(result,
-			result->i_mtime.tv_sec =3D result->i_atime.tv_sec =3D local_to_gmt(dir-=
>i_sb, le32_to_cpu(dee.creation_date)),
-			0);
-	result->i_mtime.tv_nsec =3D 0;
-	result->i_atime.tv_nsec =3D 0;
+	result->i_mtime =3D result->i_atime =3D
+		inode_set_ctime(result, local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation=
_date)), 0);
 	hpfs_i(result)->i_ea_size =3D 0;
 	result->i_uid =3D current_fsuid();
 	result->i_gid =3D current_fsgid();
@@ -329,11 +319,8 @@ static int hpfs_symlink(struct mnt_idmap *idmap, struc=
t inode *dir,
 	result->i_ino =3D fno;
 	hpfs_init_inode(result);
 	hpfs_i(result)->i_parent_dir =3D dir->i_ino;
-	inode_set_ctime(result,
-			result->i_mtime.tv_sec =3D result->i_atime.tv_sec =3D local_to_gmt(dir-=
>i_sb, le32_to_cpu(dee.creation_date)),
-			0);
-	result->i_mtime.tv_nsec =3D 0;
-	result->i_atime.tv_nsec =3D 0;
+	result->i_mtime =3D result->i_atime =3D
+		inode_set_ctime(result, local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation=
_date)), 0);
 	hpfs_i(result)->i_ea_size =3D 0;
 	result->i_mode =3D S_IFLNK | 0777;
 	result->i_uid =3D current_fsuid();
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 98a78200cff1..2ee21286ac8f 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1422,13 +1422,8 @@ static int isofs_read_inode(struct inode *inode, int=
 relocated)
 			inode->i_ino, de->flags[-high_sierra]);
 	}
 #endif
-
-	inode->i_mtime.tv_sec =3D
-	inode->i_atime.tv_sec =3D inode_set_ctime(inode,
-						iso_date(de->date, high_sierra),
-						0).tv_sec;
-	inode->i_mtime.tv_nsec =3D
-	inode->i_atime.tv_nsec =3D 0;
+	inode->i_mtime =3D inode->i_atime =3D
+		inode_set_ctime(inode, iso_date(de->date, high_sierra), 0);
=20
 	ei->i_first_extent =3D (isonum_733(de->extent) +
 			isonum_711(de->ext_attr_length));
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 3715a3940bd4..8a4fc9420b36 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -501,11 +501,7 @@ static struct inode *V1_minix_iget(struct inode *inode=
)
 	i_gid_write(inode, raw_inode->i_gid);
 	set_nlink(inode, raw_inode->i_nlinks);
 	inode->i_size =3D raw_inode->i_size;
-	inode->i_mtime.tv_sec =3D inode->i_atime.tv_sec =3D inode_set_ctime(inode=
,
-									raw_inode->i_time,
-									0).tv_sec;
-	inode->i_mtime.tv_nsec =3D 0;
-	inode->i_atime.tv_nsec =3D 0;
+	inode->i_mtime =3D inode->i_atime =3D inode_set_ctime(inode, raw_inode->i=
_time, 0);
 	inode->i_blocks =3D 0;
 	for (i =3D 0; i < 9; i++)
 		minix_inode->u.i1_data[i] =3D raw_inode->i_zone[i];
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 7acd3e3fe790..7e7876aae01c 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -255,7 +255,7 @@ static void ovl_file_accessed(struct file *file)
 	if ((!timespec64_equal(&inode->i_mtime, &upperinode->i_mtime) ||
 	     !timespec64_equal(&ctime, &uctime))) {
 		inode->i_mtime =3D upperinode->i_mtime;
-		inode_set_ctime_to_ts(inode, inode_get_ctime(upperinode));
+		inode_set_ctime_to_ts(inode, uctime);
 	}
=20
 	touch_atime(&file->f_path);
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 961b9d342e0e..d89739655f9e 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -322,8 +322,7 @@ static struct inode *romfs_iget(struct super_block *sb,=
 unsigned long pos)
=20
 	set_nlink(i, 1);		/* Hard to decide.. */
 	i->i_size =3D be32_to_cpu(ri.size);
-	i->i_mtime.tv_sec =3D i->i_atime.tv_sec =3D inode_set_ctime(i, 0, 0).tv_s=
ec;
-	i->i_mtime.tv_nsec =3D i->i_atime.tv_nsec =3D 0;
+	i->i_mtime =3D i->i_atime =3D inode_set_ctime(i, 0, 0);
=20
 	/* set up mode and ops */
 	mode =3D romfs_modemap[nextfh & ROMFH_TYPE];
diff --git a/fs/smb/client/fscache.h b/fs/smb/client/fscache.h
index a228964bc2ce..84f3b09367d2 100644
--- a/fs/smb/client/fscache.h
+++ b/fs/smb/client/fscache.h
@@ -56,7 +56,7 @@ void cifs_fscache_fill_coherency(struct inode *inode,
 	cd->last_write_time_sec   =3D cpu_to_le64(cifsi->netfs.inode.i_mtime.tv_s=
ec);
 	cd->last_write_time_nsec  =3D cpu_to_le32(cifsi->netfs.inode.i_mtime.tv_n=
sec);
 	cd->last_change_time_sec  =3D cpu_to_le64(ctime.tv_sec);
-	cd->last_change_time_nsec  =3D cpu_to_le64(ctime.tv_nsec);
+	cd->last_change_time_nsec =3D cpu_to_le32(ctime.tv_nsec);
 }
=20
=20

--=20
Jeff Layton <jlayton@kernel.org>
