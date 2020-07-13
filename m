Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D3721D399
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 12:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgGMKMi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 06:12:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38288 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgGMKMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:12:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DA6q8b061943;
        Mon, 13 Jul 2020 10:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=2U0dBovtnLmrjKenn22MueF+IQZXfr34gF72u/WmrJc=;
 b=CznQD6mQ7YbnkNhWgzISBW8h3SJQM6JmDJ5yN8Mu0Z+yFEiWdM79c/mnbgsO4kDTQKz7
 KnYvlGFl5z3P/j1xEJAPj03nrEdR/ANyt7xbKli235+X1/VLmrde/BKG5ky9TKoP607K
 dvU5OccjrpFaafCzvPGDtohokgP9nvM5/8AYIiumRotfCRPqrDO/ud1xNQeUwIU0wnCE
 /ekoFxPi61bebaO9S8JbyPg8ahGeZecVzNzLyHNCKTmVZXKzk/DJjkiHXum9HJY0c4T3
 YG6hgxKBB2nGxttt2CTXqiAKuU6ldf8s3bDINu3utnHkEtWBV8Dcq5MEaPjAmksL3PdA LQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32762n61p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Jul 2020 10:12:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DACYa1009339;
        Mon, 13 Jul 2020 10:12:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 327qbvbcdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jul 2020 10:12:34 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06DACROQ029775;
        Mon, 13 Jul 2020 10:12:27 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jul 2020 03:12:27 -0700
Date:   Mon, 13 Jul 2020 13:12:22 +0300
From:   <dan.carpenter@oracle.com>
To:     dhowells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org
Subject: [bug report] fsinfo: Allow fsinfo() to look up a mount object by ID
Message-ID: <20200713101222.GA246269@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9680 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9680 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 suspectscore=3 phishscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130075
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello David Howells,

The patch 2421474bbbc8: "fsinfo: Allow fsinfo() to look up a mount
object by ID" from Jul 5, 2019, leads to the following static checker
warning:

	fs/fsinfo.c:618 vfs_fsinfo_mount()
	warn: AAA no lower bound on 'mnt_id'

fs/fsinfo.c
   589  static int vfs_fsinfo_mount(int dfd, const char __user *filename,
   590                              struct fsinfo_context *ctx)
   591  {
   592          struct path path;
   593          struct fd f = {};
   594          char *name;
   595          long mnt_id;
                ^^^^^^^^^^^

   596          int ret;
   597  
   598          if (!filename)
   599                  return -EINVAL;
   600  
   601          name = strndup_user(filename, 32);
   602          if (IS_ERR(name))
   603                  return PTR_ERR(name);
   604          ret = kstrtoul(name, 0, &mnt_id);
   605          if (ret < 0)
   606                  goto out_name;
   607          if (mnt_id > INT_MAX)
                    ^^^^^^^^^^^^^^^^
This can be negative.  Why do we need to check this at all?  Can we just
delete this check?

   608                  goto out_name;
   609  
   610          if (dfd != AT_FDCWD) {
   611                  ret = -EBADF;
   612                  f = fdget_raw(dfd);
   613                  if (!f.file)
   614                          goto out_name;
   615          }
   616  
   617          ret = lookup_mount_object(f.file ? &f.file->f_path : NULL,
   618                                    mnt_id, &path);
   619          if (ret < 0)
   620                  goto out_fd;
   621  
   622          ret = vfs_fsinfo(&path, ctx);
   623          path_put(&path);
   624  out_fd:
   625          fdput(f);
   626  out_name:
   627          kfree(name);
   628          return ret;
   629  }

regards,
dan carpenter
