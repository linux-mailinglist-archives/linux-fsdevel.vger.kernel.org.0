Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61DCB79DCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbfG3BSH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:18:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37758 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfG3BSG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:18:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6U18ntf012356;
        Tue, 30 Jul 2019 01:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=YMEbQB3CgMezonBMjtxlJ+ByA7dcYkltQwj8WsCaJ9I=;
 b=Qbrb9DAjVZKyXrlXRRZwjQlQlVpe1t5054mQEgHi3AnTguD2rMAraYU+maOYP6hhtW8z
 LVSLp7pYtN6TUpTnkTX4h2pmInw/tdBYrLg3d6Fro3KQaWPwrk+3LhSQ5qPc0aWBM8iS
 09kktShwWY0zKVLeVQe8y2FO4a0uEZNgq+QpRWGL3p+PH5fyWj32VvhykA5ueNIVavEi
 J0jB8r1WRgSA1z8RUFjWMWygSZxWmgFFRJFABeOl5X5PJbfMid/l3Q0HLDTUqSk6PkCS
 YhCoc0QcsJ855EqyOKQwx9Ir4nKGqzzCuj7rK9BtJ66zq941XfsjTJo9VgKz/QRxWZAh 5Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2u0e1tk5jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 01:17:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6U1DAjf034107;
        Tue, 30 Jul 2019 01:17:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2u0dxqmrd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 01:17:42 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6U1Heh4016674;
        Tue, 30 Jul 2019 01:17:40 GMT
Received: from localhost (/10.159.132.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jul 2019 18:17:40 -0700
Subject: [PATCH v4 0/6] iomap: lift the xfs writepage code into iomap
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Damien.LeMoal@wdc.com, agruenba@redhat.com
Date:   Mon, 29 Jul 2019 18:17:40 -0700
Message-ID: <156444945993.2682261.3926017251626679029.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=843
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300010
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=885 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300010
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

>From Christoph:

This series cleans up the xfs writepage code and then lifts it to
fs/iomap/ so that it could be use by other file systems.  I've been
wanting to [do] this for a while so that I could eventually convert gfs2
over to it, but I never got to it.  Now Damien has a new zonefs file
system for semi-raw access to zoned block devices that would like to use
the iomap code instead of reinventing it, so I finally had to do the
work.

>From Darrick:

For v4, split the series into smaller pieces.  This first part builds
out the new iomap writeback infrastructure needed for gfs2 and zonedfs.
The second part will refactor some of XFS's writeback code to use the
new helpers introduced in the first part; and the third part converts
XFS to use the iomap writeback code.

Changes since v2:
 - rebased to v5.3-rc1
 - folded in a few changes from the gfs2 enablement series

Changes since v1:
 - rebased to the latest xfs for-next tree
 - keep the preallocated transactions for size updates
 - rename list_pop to list_pop_entry and related cleanups
 - better document the nofs context handling
 - document that the iomap tracepoints are not a stable API

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This has been lightly tested with fstests.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/log/?h=iomap-writeback
