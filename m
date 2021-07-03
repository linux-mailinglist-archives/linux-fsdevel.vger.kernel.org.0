Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884DF3BA736
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jul 2021 06:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhGCEhC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Jul 2021 00:37:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61264 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229728AbhGCEhC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Jul 2021 00:37:02 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1634W2SW001285;
        Sat, 3 Jul 2021 04:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=XQKNkl5VBp4ABP7mK4NgKwcElErO8EjI9fIaqcJRfTc=;
 b=E1y0Q+B1Y8v4X5yKltZdkIJedWyg+AwmUSu+4r/AHHvNgiXeZx5uwMQ/aoVun2IsRXg5
 bB743kiKA1/4YMjPUgAcTGUcF95vHLN0HTyxFYn4Lamo57lqz9OLkqgN6NzxON4wvEeZ
 4SIVdYj2+2vPLPr3prkfvfeZZbeE+DynK0H0WL6ZfDobiUodoa7dYlRi1wFseHQrM7GG
 WuTWoXn5bojvsGzsvn3tmXybTkwG+avA0kOIOXFsmb7mREuwTETZujzY1tQ1X885FjF4
 E8lkN9AXjGaJxa7dw/gRc6tC7gUOX+7sONlkWNbKQamxDDlCJRRRlkI68hftemXfUNMV qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jfgs81en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jul 2021 04:34:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1634UFhx150203;
        Sat, 3 Jul 2021 04:34:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 39jf7k3uyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jul 2021 04:34:27 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1634YQ5h156774;
        Sat, 3 Jul 2021 04:34:26 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3020.oracle.com with ESMTP id 39jf7k3uyg-1;
        Sat, 03 Jul 2021 04:34:26 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     bfields@fieldses.org
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v2 0/2] nfsd: Initial implementation of NFSv4 Courteous Server
Date:   Sat,  3 Jul 2021 00:34:18 -0400
Message-Id: <20210703043420.84549-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iR-Y_u4ytRyor-idQxthRNJcqZ-kwa8T
X-Proofpoint-GUID: iR-Y_u4ytRyor-idQxthRNJcqZ-kwa8T
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi,

This series of patches implement the NFSv4 Courteous Server.

A server which does not immediately expunge the state on lease expiration
is known as a Courteous Server.  A Courteous Server continues to recognize
previously generated state tokens as valid until conflict arises between
the expired state and the requests from another client, or the server
reboots.

The v2 patch includes the following:

. add new callback, lm_expire_lock, to lock_manager_operations to
  allow the lock manager to take appropriate action with conflict lock.

. handle conflicts of NFSv4 locks with NFSv3/NLM and local locks.

. expire courtesy client after 24hr if client has not reconnected.

. do not allow expired client to become courtesy client if there are
  waiters for client's locks.

. modify client_info_show to show courtesy client and seconds from
  last renew.

. fix a problem with NFSv4.1 server where the it keeps returning
  SEQ4_STATUS_CB_PATH_DOWN in the successful SEQUENCE reply, after
  the courtesy client re-connects, causing the client to keep sending
  BCTS requests to server.

TODO:
. handle OPEN conflict with share reservations.

-Dai



