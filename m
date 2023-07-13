Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7B2752D89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 01:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjGMXCe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 19:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbjGMXCB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:02:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC5A30FC;
        Thu, 13 Jul 2023 16:01:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E615A61BB9;
        Thu, 13 Jul 2023 23:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF0AC433AB;
        Thu, 13 Jul 2023 23:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689289294;
        bh=1/8G5JaqUI6KuuI2rdJCgZt0gS2ge3CDkWe83TSi7uM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hh00jwFLXVTfcKcYi6RPk6teBq7zejtWeTElcr3hLDz8IAh3S2IemMNuHXvNi3H4F
         QeScQzWiLdKG7tjJSKUXq0nR4EDtj340vqrwNrAGN9Ia5Apqw1huo7Ebzqqr+YuBHl
         S8vH6aKqZUS7hfoeQEutNX1WiQBlgdv6b6HX5VFk8w3yzBCsNmYk/OuKkH4+kmf6Xs
         IYNGYH5akbWDjFEM9PyjTvjKeVnl1B1Cl+gOPyof1qwofcutPAzvLpM0Zt3wUBMvdk
         wMl3V4hvpXSC8ipgZ4JRx+E2h8IU4wBaWS/eUE+Wwxz7Pdirtue9IXVzOudQEM4w2F
         cFAbu66hjm5kA==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Thu, 13 Jul 2023 19:00:53 -0400
Subject: [PATCH v5 4/8] tmpfs: add support for multigrain timestamps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-mgctime-v5-4-9eb795d2ae37@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=769; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1/8G5JaqUI6KuuI2rdJCgZt0gS2ge3CDkWe83TSi7uM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBksIIu7118tb5CNCK7sZ1VFW0yB4BVg1dD3GIAv
 39qas2sg2GJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZLCCLgAKCRAADmhBGVaC
 FUn6D/49/foLE14L6mU0xG1UWjybA4xy86vpS7roooMdiLD221RNkxIE52QBUyp5CX2APfX200C
 xgbwOJEpcptUud3PcBPoF8COlI/ERe5e9OpVHtCre8aWzg7pBf8pyMnE+xoIlAU6CcTJFa9NChV
 Olh6k+5lVwTnIXRD08nJ08naXSWCIsW8EAkrCywfB0ucIPaAdk5yfs6ZWKvzIJMOzvf08q/tyH9
 IPHUxUX0sNKpgXmXfCVLjFp1wKn7r8FJxarJeURYrLr5rWYLdmmuZ3E/WSTwdKR9okSva8BrC+8
 tkEb9EnYwIQbXojiol0Tl6DrLrvHnxRVaDPNi3FrTXczN8j1sYa8/j8LsuuDJUAGBKU/GsZoV6Z
 k8IiUfrDxYkoLOcyjqRFCQVEVVuF/LdfPx20g0wWhX76uRq9NHs1ExBBUfZaYnRhSrGmyGs9DU0
 XElBc5CesLSUUltqLb6O8VK6s1T89MT30rnP5PaV+5o2tpoJN2Dh5OP3DRv6N0IaV51inxOzm+1
 bQZO0+M4M9zfgjIsLAEUgrLh1kmvhU8dp1bTqcY+n6Xy39Cw4o2bXh+v+RGZBC/3Kum9DwFRvus
 MJ1kz5NoZfCBO7DrdUL+sgTN6tbKn57fiTUf2f+6Sk0T5YVQSiZB21hj7z5csvZrdxGKTu7jyCs
 h/2N1SUvw9AsY0w==
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

tmpfs only requires the FS_MGTIME flag.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 654d9a585820..b6019c905058 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4264,7 +4264,7 @@ static struct file_system_type shmem_fs_type = {
 #endif
 	.kill_sb	= kill_litter_super,
 #ifdef CONFIG_SHMEM
-	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
 #else
 	.fs_flags	= FS_USERNS_MOUNT,
 #endif

-- 
2.41.0

