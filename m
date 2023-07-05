Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80993748C5E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 20:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjGES7D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 14:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjGES65 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:58:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291511BC0;
        Wed,  5 Jul 2023 11:58:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32DDF616DB;
        Wed,  5 Jul 2023 18:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048E0C433BB;
        Wed,  5 Jul 2023 18:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583530;
        bh=rS7mHrqZmoO2H68n3RxhES3IzDPLPysS3UyH3PinCQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aMKB7Eajzv0HN0RjiqoVKTtlq5KN/eWgB5BWIXdR4yS+qXLo9oJ2A8CvARGhR38SH
         AGVvIkEZAbD+2gqh1hM5AgL3ExspR2noywBNBHZ/Zbz6Jipv98b24C+FbaNuj7Id30
         /vjMmqLNAVgc3TMo2RGbDruAikPadReZuK3KcfWQJbROt+tSH7hONNDFEXZgGO8FCp
         rZUVAJaTqC0bKLSAziTq7i3tC8AVeG/+sFMf01eIn4wnADMCMY5hp3fCv+if/Zhei+
         dNlf5J971crJund4f35sQB+fqWVZ1Rv/WEt2CJNhYXge8soEVT4A/D9IhrSNkZ2pHG
         dVcbUJJd2L7+A==
From:   Jeff Layton <jlayton@kernel.org>
To:     jk@ozlabs.org, arnd@arndb.de, mpe@ellerman.id.au,
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
        xiubli@redhat.com, idryomov@gmail.com, jlayton@kernel.org,
        jaharkes@cs.cmu.edu, coda@cs.cmu.edu, jlbec@evilplan.org,
        hch@lst.de, nico@fluxnic.net, rafael@kernel.org, code@tyhicks.com,
        ardb@kernel.org, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        linkinjeon@kernel.org, sj1557.seo@samsung.com, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
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
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH v2 07/92] fs: add ctime accessors infrastructure
Date:   Wed,  5 Jul 2023 14:58:10 -0400
Message-ID: <20230705185812.579118-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705185812.579118-1-jlayton@kernel.org>
References: <20230705185812.579118-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

struct timespec64 has unused bits in the tv_nsec field that can be used
for other purposes. In future patches, we're going to change how the
inode->i_ctime is accessed in certain inodes in order to make use of
them. In order to do that safely though, we'll need to eradicate raw
accesses of the inode->i_ctime field from the kernel.

Add new accessor functions for the ctime that we use to replace them.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c         | 16 ++++++++++++++++
 include/linux/fs.h | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index d37fad91c8da..21b026d95b51 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2499,6 +2499,22 @@ struct timespec64 current_time(struct inode *inode)
 }
 EXPORT_SYMBOL(current_time);
 
+/**
+ * inode_set_ctime_current - set the ctime to current_time
+ * @inode: inode
+ *
+ * Set the inode->i_ctime to the current value for the inode. Returns
+ * the current value that was assigned to i_ctime.
+ */
+struct timespec64 inode_set_ctime_current(struct inode *inode)
+{
+	struct timespec64 now = current_time(inode);
+
+	inode_set_ctime(inode, now.tv_sec, now.tv_nsec);
+	return now;
+}
+EXPORT_SYMBOL(inode_set_ctime_current);
+
 /**
  * in_group_or_capable - check whether caller is CAP_FSETID privileged
  * @idmap:	idmap of the mount @inode was found from
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 824accb89a91..bdfbd11a5811 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1474,7 +1474,50 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
 	       kgid_has_mapping(fs_userns, kgid);
 }
 
-extern struct timespec64 current_time(struct inode *inode);
+struct timespec64 current_time(struct inode *inode);
+struct timespec64 inode_set_ctime_current(struct inode *inode);
+
+/**
+ * inode_get_ctime - fetch the current ctime from the inode
+ * @inode: inode from which to fetch ctime
+ *
+ * Grab the current ctime from the inode and return it.
+ */
+static inline struct timespec64 inode_get_ctime(const struct inode *inode)
+{
+	return inode->i_ctime;
+}
+
+/**
+ * inode_set_ctime_to_ts - set the ctime in the inode
+ * @inode: inode in which to set the ctime
+ * @ts: value to set in the ctime field
+ *
+ * Set the ctime in @inode to @ts
+ */
+static inline struct timespec64 inode_set_ctime_to_ts(struct inode *inode,
+						      struct timespec64 ts)
+{
+	inode->i_ctime = ts;
+	return ts;
+}
+
+/**
+ * inode_set_ctime - set the ctime in the inode
+ * @inode: inode in which to set the ctime
+ * @sec: tv_sec value to set
+ * @nsec: tv_nsec value to set
+ *
+ * Set the ctime in @inode to { @sec, @nsec }
+ */
+static inline struct timespec64 inode_set_ctime(struct inode *inode,
+						time64_t sec, long nsec)
+{
+	struct timespec64 ts = { .tv_sec  = sec,
+				 .tv_nsec = nsec };
+
+	return inode_set_ctime_to_ts(inode, ts);
+}
 
 /*
  * Snapshotting support.
-- 
2.41.0

