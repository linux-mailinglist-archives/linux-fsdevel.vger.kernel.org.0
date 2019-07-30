Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC40C79DD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfG3BSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:18:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38546 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbfG3BSp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:18:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6U18kQk012336;
        Tue, 30 Jul 2019 01:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=0j4otu+nI9J6XrEnJy0Vt+wQJzrw/JLsTFDwjEDiK/o=;
 b=roGvbf4yhFQbw849gYDsCJaB/LVXFbPSMxHbtY7h41KnAn1OEBmhCV2EsxbdadfDFjIL
 nIMwOKAePHvBIr74pv3hK7zHGySIqQM172nIKcMZGn/nbEk9DLeOrsFo07B6EQY6XgZx
 pHWOhpvCVQShATllyi+HO/nRSOmQClR9h4nbnqngYR47FH0sGGjc/V+hOAptsW94Aee1
 lLjCARGZrH6wN24yE0DHswhetv77pmMWB4Ub3BPEdOY8qVgnRKPmTZbHkCajbvK3ckOJ
 emLqDo3M6Kbdo2PQXb6J3GcTN9NTbwnGPacMjMsTk3dUnD/xgdaJj2sUycgn6YzNZt+Y xA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2u0e1tk5me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 01:18:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6U1IPIW008314;
        Tue, 30 Jul 2019 01:18:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2u0xv7uf73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 01:18:25 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6U1IMvQ017065;
        Tue, 30 Jul 2019 01:18:22 GMT
Received: from localhost (/10.159.132.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jul 2019 18:18:22 -0700
Subject: [PATCH v4 0/2] xfs: use new list helpers in writeback code
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Damien.LeMoal@wdc.com, agruenba@redhat.com
Date:   Mon, 29 Jul 2019 18:18:21 -0700
Message-ID: <156444950159.2682436.1669088240015553674.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=355
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=397 adultscore=0
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

For v4, split the series into smaller pieces.  This second part
refactors some of XFS's writeback code to use the new helpers introduced
in the first part.

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

This has been lightly tested with fstests.  Enjoy!
Comments and questions are, as always, welcome.

--D
