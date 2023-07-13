Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0D4752DA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 01:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjGMXDM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 19:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbjGMXC1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:02:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1855B30D0;
        Thu, 13 Jul 2023 16:01:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 885EE61BAD;
        Thu, 13 Jul 2023 23:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC563C433AB;
        Thu, 13 Jul 2023 23:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689289312;
        bh=kIvw1OVi/OYz+atwIBCynX0q88XJ1zU1WapHn2pYQP4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ji6lTm8ixvNtDVVdWA3hLyHSMWJKcMADi3bT5BtloRaThTlgVtrnfDXRVZYz43eRu
         e46QVkCnWld61ntI9tgz1GRsuSCFqBU2ObStlUNmu2ITfHTBwbv7vJEVbd4VhZV50Z
         dT95XgUQ0gE/E1uvcZKi9FQTchZ0DfPl+ZI9RB22N2f/MLfNFP/JZ9fevITXI82Nnn
         gxkb+MeSgX88JSRcRtINCznpW+x3Bw6LJRgU7m1nPn5OW1YU0SQ5fO7Mc35+2Am2DI
         3RZxGv1qzyqNs6VT+JidZtfoYQynlt0REEMl5HH24pEX9jmVLyVDYYNkSzsIu+nPLz
         p0XGmDep4V68Q==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Thu, 13 Jul 2023 19:00:56 -0400
Subject: [PATCH v5 7/8] ext4: switch to multigrain timestamps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-mgctime-v5-7-9eb795d2ae37@kernel.org>
References: <20230713-mgctime-v5-0-9eb795d2ae37@kernel.org>
In-Reply-To: <20230713-mgctime-v5-0-9eb795d2ae37@kernel.org>
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
Cc:     Dave Chinner <david@fromorbit.com>, v9fs@lists.linux.dev,
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
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBksIIvy36LZaWXx77QDXekEjnV6herdriJfAZSF
 KRvi1GJeviJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZLCCLwAKCRAADmhBGVaC
 FdpuD/4olF8PfkzpOMhKo0pYakgpPOkYsvbjRlnWul1JeLAyEulDwt7cUm7WvWS7sMfn1nmbiyP
 ZHDXA8DklrSv30kAkd/SL9dBOk9CqQRpnh3gYQN8VNdWNLw39gnLGtNuYCpAfLNo6atBt+fNyyC
 9JTlkqthcsWlIIJg04NUID5P3Jx07BORb0Uye5L4hJyaE1uS3bR9dMrxhAWH4RhuGTPnQOnDXy0
 8jUhXWSuWv5boD0GGnQiwKp0sMI/s08qlD+VHcAKA3ng2vs9Kgpqr37JvvET803NiGk8yj9pL03
 zs0M+o+33FLV8FRVqOh+U+Jx4gU5h0mFwEp9K+Thq8cujHzoq47kEHiEUovgVSQuqftTIVBazJG
 hs4VXOKAnNx4QoIzUmqCsLgvvJMSxUqe1h6CftfWNBb74Gl7VROa7K/9RRLjvfgLUknDQaYmnWs
 uRwFrVVPpco6YGgC+fPrV0+xTVyKEA/2zTAlQWrS7tRu0NtjQWSaQcYgz1Gpc6JaotWcgbi9HFc
 DovY/3/xXCkw7YtqNGLZBg8SMoSWMoDxy7Uwz5OXs5uUpmFp0p1YgTS1GFz/wgOrNTbFHTHc3QX
 hRQiNndjZv+/zFzfH7J5roV04qDMIMAABTOlktx3N/eKz8JCFhz6AePPqjavoMl+dS8drsBe4xd
 SUt6/wNve4Dcx+w==
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

