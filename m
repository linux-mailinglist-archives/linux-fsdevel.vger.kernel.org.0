Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB894B36FD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Feb 2022 19:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiBLSNI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Feb 2022 13:13:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiBLSNH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:13:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6712050B22;
        Sat, 12 Feb 2022 10:13:02 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21C9aHQi029601;
        Sat, 12 Feb 2022 18:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=frNKqwQx8SieiZ4CPyYZKxm9vJXGrBd7eUl0Zc0CchU=;
 b=kdSzTNGxDyyTQJmv2GFqIXxP2FbtJnR3gSCqEtaTjvU9NEfYQRWtR+U7sq6UNqK4doKh
 N1Vp5RZlQez6Ga9biITpNDl7/uXMljX/yW5MWp0I0H69YaYeLzyOqewMOv6QtgdlcS8r
 G2Xd/LyUA6yGc3PmLAqPdxgrDme68LGSXTwyHv3Z7j0wlErT13v/9CVME3LSq+WtrO6A
 ma+QDLXcGsO9A7YaoFuqRdZOhyVFog9qsJaQmPGYwS/3gxq3pj67duQsssH/vokH/Dst
 7Zpvkb9Tu8FHrGZ7w3IvuyXqwYnbuVcD/l/H1JPiGv6/b1yTsEIq6AgpCEIaKSyf5vXC tA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63g110xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Feb 2022 18:12:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21CIBqos120368;
        Sat, 12 Feb 2022 18:12:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 3e66bj2f58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Feb 2022 18:12:58 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21CICvrv121470;
        Sat, 12 Feb 2022 18:12:57 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by userp3020.oracle.com with ESMTP id 3e66bj2f4u-2;
        Sat, 12 Feb 2022 18:12:57 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v13 1/4] fs/lock: documentation cleanup. Replace inode->i_lock with flc_lock.
Date:   Sat, 12 Feb 2022 10:12:52 -0800
Message-Id: <1644689575-1235-2-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1644689575-1235-1-git-send-email-dai.ngo@oracle.com>
References: <1644689575-1235-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: 6AgVbn1JA7OI9MLI-eWqaxb5BZ4urp07
X-Proofpoint-ORIG-GUID: 6AgVbn1JA7OI9MLI-eWqaxb5BZ4urp07
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update lock usage of lock_manager_operations' functions.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 Documentation/filesystems/locking.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 3f9b1497ebb8..aaca0b601819 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -438,13 +438,13 @@ prototypes::
 locking rules:
 
 ======================	=============	=================	=========
-ops			inode->i_lock	blocked_lock_lock	may block
+ops			   flc_lock  	blocked_lock_lock	may block
 ======================	=============	=================	=========
-lm_notify:		yes		yes			no
+lm_notify:		no      	yes			no
 lm_grant:		no		no			no
 lm_break:		yes		no			no
 lm_change		yes		no			no
-lm_breaker_owns_lease:	no		no			no
+lm_breaker_owns_lease:	yes     	no			no
 ======================	=============	=================	=========
 
 buffer_head
-- 
2.9.5

