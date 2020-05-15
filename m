Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093D71D4CE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 13:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgEOLog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 07:44:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43682 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgEOLog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 07:44:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04FBW7Xt044575;
        Fri, 15 May 2020 11:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=UhhCxoNLJrPMLTNqTO9hZfOma0sVhYCIwfmbTF0mvhY=;
 b=zui8nBDwZj2UG+wfj9pbRBuhZ9tTLh3Nzu00xhYVTWERlUj652Y9JH3SbdqpoJI5UBR9
 lHE+VV2wOUKOG7HY9dVC/9TlJC/0YJIw9TXEthFp6KObFnAjFm9rappANQs2x5BxDjyh
 +aSKiyoZSFIHiaAGC3wUs2A02+e/lgNAYJH59be9xvvcagkmpnJJjVjydZpxSIQ4RuM+
 7AzMgdSrq7DuiUeBxnx8Av4CN92EKb3rrHMC1nBLNjabp/S3P4dHnkKK2wlyDBBQc5V0
 5rFLlktpFFJxkP/KKwUBmvYa02Hufbal6WaTifOiwV14ASZqcAoRUhQ+C3qjrfWl7wwQ 3g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 3100xwteqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 May 2020 11:44:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04FBY9As009657;
        Fri, 15 May 2020 11:44:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3100yept6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 May 2020 11:44:32 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04FBiVIk015056;
        Fri, 15 May 2020 11:44:31 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 May 2020 04:44:31 -0700
Date:   Fri, 15 May 2020 14:44:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     smayhew@redhat.com
Cc:     linux-fsdevel@vger.kernel.org
Subject: [bug report] NFS: Convert mount option parsing to use functionality
 from fs_parser.h
Message-ID: <20200515114426.GA574054@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=3 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005150101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 lowpriorityscore=0
 suspectscore=3 mlxlogscore=999 clxscore=1011 cotscore=-2147483648
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005150101
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Scott Mayhew,

The patch e38bb238ed8c: "NFS: Convert mount option parsing to use
functionality from fs_parser.h" from Dec 10, 2019, leads to the
following static checker warning:

	fs/namespace.c:1011 vfs_kern_mount()
	error: passing non negative 1 to ERR_PTR

fs/namespace.c
   988  struct vfsmount *vfs_kern_mount(struct file_system_type *type,
   989                                  int flags, const char *name,
   990                                  void *data)
   991  {
   992          struct fs_context *fc;
   993          struct vfsmount *mnt;
   994          int ret = 0;
   995  
   996          if (!type)
   997                  return ERR_PTR(-EINVAL);
   998  
   999          fc = fs_context_for_mount(type, flags);
  1000          if (IS_ERR(fc))
  1001                  return ERR_CAST(fc);
  1002  
  1003          if (name)
  1004                  ret = vfs_parse_fs_string(fc, "source",
  1005                                            name, strlen(name));

The nfs_fs_context_parse_param() function returns 1 if ->sloppy is true.
There are no comments explaining what the 1 means, but the comments for
vfs_parse_fs_param() say it should only return zero or negative error
codes.

        opt = fs_parse(fc, nfs_fs_parameters, param, &result);
        if (opt < 0)
                return ctx->sloppy ? 1 : opt;

I feel like this code is buggy, but if it's not then it really needs
some documentation.

  1006          if (!ret)
  1007                  ret = parse_monolithic_mount_data(fc, data);
  1008          if (!ret)
  1009                  mnt = fc_mount(fc);
  1010          else
  1011                  mnt = ERR_PTR(ret);
  1012  
  1013          put_fs_context(fc);
  1014          return mnt;
  1015  }
  1016  EXPORT_SYMBOL_GPL(vfs_kern_mount);

regards,
dan carpenter
