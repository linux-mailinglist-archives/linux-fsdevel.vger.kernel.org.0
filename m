Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0876B7173CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 04:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbjEaCfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 22:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjEaCfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 22:35:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90C2118;
        Tue, 30 May 2023 19:35:24 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UNO6gc022134;
        Wed, 31 May 2023 02:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=IhT8Lesv/W588Q8nZKDS144F7/nmgSAZTLEf8tiNpYI=;
 b=Qumgq6GRE+fHmhSjj48R/rk7/RLMxwqXL0sxK6h8exhY6CN0JLPKipxLUmqOJdoBKcus
 4+KGj95XQyzICagSGsYeNcV4dhAGbt60RIqZg8nDlPAC4lr+ClCfPfeP61H1H4nagmkZ
 8ntW6DG6OG/sa9sQvb7ENTIixyan3gM1FGKOEwBDJZryomADkY52I24BhdoT5W1r3KvW
 nJuvZLU2+ecSp9OeW7Y6mjLXn+TaSezkOeiUr5T39aVuyNUH2D2XK1GOZykR/9VWR5p6
 hyrfjW00gJWEM1VGSjN6px9KX+hRU2O+43Gouzefp/bQPJcZ4PCG86Yjph2nRuYFMcC9 xw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmemfnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 02:35:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34V0UZQc000447;
        Wed, 31 May 2023 02:35:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8q99hta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 02:35:19 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34V2TtqV012906;
        Wed, 31 May 2023 02:35:19 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qu8q99hsx-1;
        Wed, 31 May 2023 02:35:19 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/2] NFSD: recall write delegation on GETATTR conflict
Date:   Tue, 30 May 2023 19:35:05 -0700
Message-Id: <1685500507-23598-1-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_18,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=823
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310019
X-Proofpoint-ORIG-GUID: tyrfoEM9hhZuigIy2qPNBhZygtQuJlOR
X-Proofpoint-GUID: tyrfoEM9hhZuigIy2qPNBhZygtQuJlOR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series adds the recall of write delegation when there is
conflict with a GETATTR and a counter in /proc/net/rpc/nfsd to keep
count of this recall.

Changes from v1:

- add comment for nfsd4_deleg_getattr_conflict
- only wait 30ms for delegation to be returned before returing
  NFS4ERR_DELAY
- fix test robot undeclared NFSD_STATS_WDELEG_GETATTR error

Changes from v2:
- call nfsd_open_break_lease for non-nfs lease with F_WRLCK

