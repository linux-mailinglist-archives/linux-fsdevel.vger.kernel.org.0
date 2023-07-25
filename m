Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A20761CC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 17:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjGYPA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 11:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjGYPAG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:00:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797E92116;
        Tue, 25 Jul 2023 07:59:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F416F6178E;
        Tue, 25 Jul 2023 14:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A85C433C8;
        Tue, 25 Jul 2023 14:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690297170;
        bh=kIvw1OVi/OYz+atwIBCynX0q88XJ1zU1WapHn2pYQP4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=G4lNe8OgwdzIy+DkoO8bA4V3fq2HfOynEvqBH0FZcXI5mjKRSEQ1SVjY1pHApZqUk
         LmVSxl1WUBGP7yGLH/ATsMnAnQMEPU+QAPGj8qdwUCRyUhAcUv0FTDqFlH73mrgqZw
         FzXbD+KfSe8VN284suFEL1YtHLX5tEg7JJkEkQGz0MGrxMX8CR2SkfzChxuDfyTNeS
         ZXRDShsOopX0jA288qfXuKjqRRyiZ1CyY3mdX/g1AczrOzezsb6EzZ2F8AGwPXdDYp
         PORRSahQS9CPN8wTXE5yLGawxDIeRTErDdxD6OfHFhzLgjKl8kPDh2mkBPRjnVLKHw
         ehvrosoKitaHg==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Tue, 25 Jul 2023 10:58:19 -0400
Subject: [PATCH v6 6/7] ext4: switch to multigrain timestamps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230725-mgctime-v6-6-a794c2b7abca@kernel.org>
References: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org>
In-Reply-To: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org>
To:     Eric Van Hensbergen <ericvh@kernel.org>,
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
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
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
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=843; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=kIvw1OVi/OYz+atwIBCynX0q88XJ1zU1WapHn2pYQP4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBkv+MkANALyeokJ5uPYYXrLhMbqAMD2+dQLEEeI
 3QOMYBSSseJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZL/jJAAKCRAADmhBGVaC
 FecsEADEGQ4YyezueKIIr3iE+LoOFLQ0lVcEMPslgKBrcsoHAYDw4xIHTfiRLmJTS/QKl6qdQ/d
 FSIkPrBSo4busWekGlohEMVxhED8IPediFhHYC1BJu3i2vSmxv2wo9z3DGJxddYsn1yasB7Jh8X
 V82bCE/S8+YwWBe/sU9UHYXIA/E18x/9Ut0FSPmZUwXbasPrZoaYGahxEDFFvONFPxKYVH6MIwn
 K4eVmycva/cc9eg3aJ9IoKpjm2lHJ6SlHwQREAxcyQZ+Tz4LAI9NG4I0N4mft7VwVj05wY4iuMV
 lkaoxH/4D3tYZmIldIJ9HahAnA+IlU9dZ/4YPR7iaTlZNdGssfn5cvsTHNjvp00H6KNNnr3nKEg
 JOy94wl7Ir1GrUPEDT1u+XQipTMQxiFjTQLc+igYmNNY+nLJu1edF6ewi3eMTP81b6gmzOHenud
 CQ3qmNNoiiQu5pItfIvt0j+K74oTiUZzOqrMqtEgUQ3flSJL2acI1UnY4m1h0JIEygBAMmXN/Ga
 6TPHXNSLdiIKa44+muGKEdIXTv22lvk6eI3L4mwE12/sKh5INo3rOJmQKNhtubYrUtLDSvrLCQa
 a/tcAz4eG/zd6PdcWTx1yg8GKnXbxqwHniAFlSBVM+ziSpqGTe2fxM3iHanHqv1hysy6sBXln6X
 HdxNyY7YiReYS0Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

For ext4, we only need to enable the FS_MGTIME flag.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b54c70e1a74e..cb1ff47af156 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7279,7 +7279,7 @@ static struct file_system_type ext4_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= kill_block_super,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 MODULE_ALIAS_FS("ext4");
 

-- 
2.41.0

