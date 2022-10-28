Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D91B6118E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 19:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJ1RJI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 13:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiJ1RIw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:08:52 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8243A237969;
        Fri, 28 Oct 2022 10:06:28 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 8EE1B2190;
        Fri, 28 Oct 2022 17:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976621;
        bh=j4ORUvqVhkK0F9A+1IIYdz9n48bqtuNM+OM62p7TIGk=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=FHK05avF9oE6RAvXO72+smY9XzEcWpcd80DLIpUH4SCCjl7G27Y0tZBQqFrtZkUmC
         RhuYbADIpVVOD8nzqYHqHx0Rvo4TFH3lgBTZu5wnL/cVOSDBhm7ya6qud8Xjf14NBF
         l7oJOIH2e8iz+EPBGa5axGM1GAPkuk2x578Q1cpI=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 8C4DEDD;
        Fri, 28 Oct 2022 17:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976780;
        bh=j4ORUvqVhkK0F9A+1IIYdz9n48bqtuNM+OM62p7TIGk=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=VKPh8fFOP+7Fw3rPiiEKH9CCeDSs5ZvaGd1IiP8dtrS3+NZHgD3SeaduCWNeyrUWc
         cnMoDaHYeclz5Pr1PfDD2dQVKRZopW9/AujhVUa5PCSHs9AbAUnr/vxIUAe28TwW4r
         FzQBMAFo7+z/SHdkd4InHtmDmLbDuzxyVjxTdF1g=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 28 Oct 2022 20:06:20 +0300
Message-ID: <2753fbab-c602-9bad-1f93-65c050461703@paragon-software.com>
Date:   Fri, 28 Oct 2022 20:06:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 10/14] fs/ntfs3: Fix incorrect if in ntfs_set_acl_ex
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
In-Reply-To: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We need to update ctime too with mode.
Fixes xfstest generic/307

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/xattr.c | 7 +++----
  1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 385c50831a8d..bead9c3059ce 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -637,10 +637,9 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
  		err = 0; /* Removing non existed xattr. */
  	if (!err) {
  		set_cached_acl(inode, type, acl);
-		if (inode->i_mode != mode) {
-			inode->i_mode = mode;
-			mark_inode_dirty(inode);
-		}
+		inode->i_mode = mode;
+		inode->i_ctime = current_time(inode);
+		mark_inode_dirty(inode);
  	}
  
  out:
-- 
2.37.0


