Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3F75A3E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 20:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfF1Sfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 14:35:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56252 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfF1SfY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:35:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SIYK1M108856;
        Fri, 28 Jun 2019 18:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=X31Rdwe/fJpCbRhxiN4E1CTNpfH8gWc+Lmuymkd/7tU=;
 b=WWSHrZeTQOM2DQMjPusLnbXcDxVxeA7M7u1P3I/zNSt4gy9JnK7FgAfgnlSMApe7aoCf
 UrjDRHAnOJSBfQz+kwR193dOjvcS/GSszyqd+ONkce1jQZPFLIc3vqR1Db9gKVE0gHAR
 w2CCi2s3uloN0ogQYmAz9DbxZmZDx8yOSbDiNfwtsfWFxWfVPk2Ny1aPtA7Bw/XcmhTF
 OwA72SmJsRoonPVrE56vGDCCt7L9Pjed/Y2RRHx9FrpohlEeoYdL5sWbWPOswBHNtWiM
 n5ce9/hTY/ZxX1MoMaAAZK2Bg3jIUbqSGNjuzE1Q7keq4fbTzhLB3bQgK/nAoJ0iOFqe tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t9brtq3k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 18:35:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SIYwDR152445;
        Fri, 28 Jun 2019 18:35:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2t9p6w237k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 18:35:13 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5SIZCEb027315;
        Fri, 28 Jun 2019 18:35:13 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Jun 2019 11:35:12 -0700
Subject: [PATCH v2 0/2] vfs: make active swap files unwritable
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, akpm@linux-foundation.org, tytso@mit.edu,
        viro@zeniv.linux.org.uk, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Fri, 28 Jun 2019 11:35:11 -0700
Message-ID: <156174691124.1557844.14293659081769020256.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280209
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280210
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

I discovered that it's possible for userspace to write to active swap
files and swap devices.  While activated, the kernel effectively holds
an irrevocable (except by swapoff) longterm lease on the storage
associated with the swap device, so we need to shut down this vector for
memory corruption of userspace programs.

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This has been lightly tested with fstests.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=immutable-swapfiles

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=immutable-swapfiles
