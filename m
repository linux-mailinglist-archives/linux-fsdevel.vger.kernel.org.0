Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9482B17B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 10:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgKMJBF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 04:01:05 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49538 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgKMJBB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 04:01:01 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AD8s1GG116406;
        Fri, 13 Nov 2020 09:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Nx83BOGKyKuGT9MpzCD8ZVgyJXvGqxWQN2Gby1mycsw=;
 b=aJuu8wEVcaXWi+KSeOMjrRfApQGtS5nB/tsQ3kssJ9tQmhdahvFJbdigdrf5ueWDFjUU
 UESY3X01uW5nzghEFj9Y+uHVWBLpH9Xpqz+JbTOyNO76NRgEkqRa2+ArWVkHsBgZ13zn
 IKXGN+gxrwIgDY4Bka+kUy7NRFYe2LXWo45aInNCE5/J4+/lDIsLJnPKbriwmHjpRcgK
 VeUL6q3ayF74i3U2yQE5IXlwkZlTUwW7eTdpQVXBTrK6qYcoL1gkTAxYh2xgwcy6j4ft
 fmfKEG43MNUFiSF6m26nbFCTaH5O/eRWY1Beo0b0dCDwigyTjiLbyzrSkf+1Su6djaJn 8w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34nh3b9mpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 09:00:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AD8tE8j168827;
        Fri, 13 Nov 2020 09:00:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34rt57gy16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Nov 2020 09:00:56 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AD90t5s014324;
        Fri, 13 Nov 2020 09:00:55 GMT
Received: from mwanda (/10.175.206.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Nov 2020 01:00:55 -0800
Date:   Fri, 13 Nov 2020 12:00:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     mszeredi@redhat.com
Cc:     linux-fsdevel@vger.kernel.org
Subject: [bug report] fuse: get rid of fuse_mount refcount
Message-ID: <20201113090049.GA95467@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=982 suspectscore=10 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=10
 mlxlogscore=972 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130054
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Miklos Szeredi,

The patch 514b5e3ff45e: "fuse: get rid of fuse_mount refcount" from
Nov 11, 2020, leads to the following static checker warning:

    fs/fuse/virtio_fs.c:1451 virtio_fs_get_tree()
    error: double free of 'fm'

fs/fuse/virtio_fs.c
  1418          if (!fs) {
  1419                  pr_info("virtio-fs: tag <%s> not found\n", fsc->source);
  1420                  return -EINVAL;
  1421          }
  1422  
  1423          err = -ENOMEM;
  1424          fc = kzalloc(sizeof(struct fuse_conn), GFP_KERNEL);
  1425          if (!fc)
  1426                  goto out_err;
  1427  
  1428          fm = kzalloc(sizeof(struct fuse_mount), GFP_KERNEL);
  1429          if (!fm)
  1430                  goto out_err;
  1431  
  1432          fuse_conn_init(fc, fm, get_user_ns(current_user_ns()),
  1433                         &virtio_fs_fiq_ops, fs);
  1434          fc->release = fuse_free_conn;
  1435          fc->delete_stale = true;
  1436          fc->auto_submounts = true;
  1437  
  1438          fsc->s_fs_info = fm;
  1439          sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
  1440          if (fsc->s_fs_info) {
  1441                  fuse_conn_put(fc);
  1442                  kfree(fm);
                        ^^^^^^^^^
Freed here

  1443          }
  1444          if (IS_ERR(sb))
  1445                  return PTR_ERR(sb);
  1446  
  1447          if (!sb->s_root) {
  1448                  err = virtio_fs_fill_super(sb, fsc);
  1449                  if (err) {
  1450                          fuse_conn_put(fc);
  1451                          kfree(fm);
                                ^^^^^^^^^
Double free

  1452                          sb->s_fs_info = NULL;

I'm sort of surprised this is setting "sb->" instead of "fsc->".

  1453                          deactivate_locked_super(sb);
  1454                          return err;
  1455                  }
  1456  
  1457                  sb->s_flags |= SB_ACTIVE;
  1458          }

regards,
dan carpenter
