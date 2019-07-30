Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 144FF79DDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfG3BS7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:18:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34116 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbfG3BS7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:18:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6U18asH095482;
        Tue, 30 Jul 2019 01:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=XxvYue7bVBceMsxkN13hy6rKZxeCJ2EJs2GbcUI00D8=;
 b=OoisJ/Ic7n+om5tgO0HBbg1H05Wnz6mUW0H3UagAHZEhhIn2/n5YXy5KF1+XzTAMBzKj
 ABrUDGNdeh7ldaJEDC7BY+UvXlAJoTiHe7MjFQwjufGuLhCzattYaY6UyrYrF+nLIzXf
 mAVpV1FGbrBzfpBQ3adGUdwyQeHRl5m0slv3Dx2oSUtK73NnuLEue+X9fbOwws15JR9P
 7iOyI1IVEhj0uXK1koMRxHDzeiX3uUX82DdXaeBsKYewT47mTv4Swcltx/STAlgpNE3l
 Ra8GvJj6xbVtHCS/wHywrQlxmDWK/MB5XwOz85fyZ0ntyscQ9Xxqy1vQfpFbkZcSAZnm Ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2u0ejpb0ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 01:18:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6U1IPVX048662;
        Tue, 30 Jul 2019 01:18:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2u0dxqmrug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 01:18:38 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6U1IcuK017200;
        Tue, 30 Jul 2019 01:18:38 GMT
Received: from localhost (/10.159.132.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jul 2019 01:18:37 +0000
Subject: [PATCH v4 0/5] xfs: use the iomap writeback code
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Damien.LeMoal@wdc.com, agruenba@redhat.com
Date:   Mon, 29 Jul 2019 18:18:37 -0700
Message-ID: <156444951713.2682520.8109813555788585092.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=512
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=554 adultscore=0
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

For v4, split the series into smaller pieces.  This third part converts
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
This series breaks up fs/iomap.c by grouping the functions by major
functional area (swapfiles, fiemap, seek hole/data, directio, buffered
io, and page migration) in separate source code files under fs/iomap/.
No functional changes have been made.  Please check the copyrights to
make sure the attribution is correct.

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This has been lightly tested with fstests.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/log/?h=xfs-iomap-writeback
