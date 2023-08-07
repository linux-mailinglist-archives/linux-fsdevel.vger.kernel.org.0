Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C5D772F53
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 21:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjHGTkr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 15:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHGTkp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:40:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F0E1BF4;
        Mon,  7 Aug 2023 12:40:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D100F621CE;
        Mon,  7 Aug 2023 19:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC784C0760F;
        Mon,  7 Aug 2023 19:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691437132;
        bh=SoSg4hRs/3AF7gmmZ5KQieVLFGATpnVC2zTweWQTdLU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=KxIu3/cu0khoRWfNJXEJNIHdkniXf13AfUwiYzwbEfIu8g3DBtfZfzYS9IOYy9Gpk
         Bj3cYzwEKlh8g81NTtaccKy7aMqTEYuSZfyn9SEoQUp7kUA4ckYCfHueh6Qfif9NgK
         slFb5wQGYXGFb4CWnSXlLxHUkaQKI2w9y4EhGJbBrVFp5aU9fk7DAWfQl7jLSAfqD1
         UccpkoMfyyMBq4af30lIQ5AB/cwMdmHd6Z3n40C38snUYNYnW8fp27SzSPjzVX5Rmr
         sneuDS6BTX/Zciu9zoJxNLu+PbQqNw9x3B9TP5CDuF4m+Ww8wcMCuyC78gSMsgXucT
         7N0lCiWdDCoMA==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Mon, 07 Aug 2023 15:38:32 -0400
Subject: [PATCH v7 01/13] fs: remove silly warning from current_time
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mgctime-v7-1-d1dec143a704@kernel.org>
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
In-Reply-To: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=648; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=SoSg4hRs/3AF7gmmZ5KQieVLFGATpnVC2zTweWQTdLU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk0Ug9m1G2XKd9FuFQHFpf/xUPtkdl5tYH/twvk
 pTBUT8ItSeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZNFIPQAKCRAADmhBGVaC
 FQz2D/0VAN0+ej/IEUpgqVfQAjQ8iolTJV7E0suDKXij0ebakC68W10jwrlT0yi9VzJjG+zWKlu
 TPi0thiI9CyD/g4niQelv35XmBxU8+fVi3c6QBE+uHc2Ye0nZvMEETJoMoCQ9vWHE0o4DGUU2J0
 26j+6oaILlvI1X0SUof0ithfuve3VLXGJWbNFJiF0l7dGjWrFCmDi1p7+bpTkunQiHaOyb8WO8t
 9XrB4x7Lw8nyVzPkyifucdtKaVzyIgZmBTqfzkjEb4acmJF1j/dKiwiKpIraaYMJEUmwqClF9np
 XnLxTxRAuW/grOiacgsfaNgmBqYN15Sjc04u/Q4I4g2N16lCqkw70LyyWxv++cJHfJPx4W0ZHfC
 R/gn2xIcFEAKBEHArqXew/pH7qG7uDz/b1Tj2mM3gqLV7eTr5JFzSI/7wSktMHXAzgUD24sZiHI
 ynRl73zTIzC6nZMJLAX2n8vToMIHUD3FE7/TSjsZyhMot40Erl6eO12t1dHzizbh3GH2yOW9/Rh
 4vCxMpdrHxu0ThUYFW+V5LTlnES54b+/oIaCI5d+yTMQQ0CzptPaqHEo/3Hn1P6GXDGbu5ddJKI
 KaPeUyTJxHdX5P1JavBBd5+dhqnWjI4y5Jd1sbR9Cl9wKKlVfciVMR5ZT7Ph9rsafHUC49jW/f+
 bi/n8FB4iErM8Ig==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

An inode with no superblock? Unpossible!

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index d4ab92233062..3fc251bfaf73 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2495,12 +2495,6 @@ struct timespec64 current_time(struct inode *inode)
 	struct timespec64 now;
 
 	ktime_get_coarse_real_ts64(&now);
-
-	if (unlikely(!inode->i_sb)) {
-		WARN(1, "current_time() called with uninitialized super_block in the inode");
-		return now;
-	}
-
 	return timestamp_truncate(now, inode);
 }
 EXPORT_SYMBOL(current_time);

-- 
2.41.0

