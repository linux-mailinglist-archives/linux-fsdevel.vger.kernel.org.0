Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE5D14E6B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 01:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgAaApF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 19:45:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41404 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbgAaApF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 19:45:05 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00V0dXd9194591;
        Fri, 31 Jan 2020 00:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=QO49yaLlTpavEKGg3qkRs5wkh1oOD1x0YDVwidst4aE=;
 b=A95ia+q/Yzkg6emKpSixNPs0ejz5Ztah+2+nH5EJwmc+RAQ5tQ/Jkoi2j9iNUND6LunF
 T7z2DSK5zTHTC364XB6blAsvrAS2ZB1rJhbFxIGY2LCL7NBY4HJOyALpVtsRqfY/dQML
 r+FxcfM2UNtdjkbXAKCY1fowYrEMvxd3ZceHLz30i2NiRR4ZVhVzjgb4Q7c/izgOY7wz
 7INeEnlM3B6zveIoujcZIgmpLXdfLC1k8nfdR6AUs8UUvHLsYrzotpjA7zm5rIvGLKmq
 W8jinwfdJrwzHnC9zy18Gc193zla4+sTWBJ405Al/CRR5rIcDbwuI4//UI128kqd1WCv dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xrdmqykmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 00:45:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00V0dOxZ140921;
        Fri, 31 Jan 2020 00:45:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2xu8e9x1xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 00:45:00 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00V0ixH8024004;
        Fri, 31 Jan 2020 00:45:00 GMT
Received: from localhost (/10.145.179.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jan 2020 16:44:48 -0800
Date:   Thu, 30 Jan 2020 16:44:47 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-block@vger.kernel.org, martin.petersen@oracle.com,
        Allison Collins <allison.henderson@oracle.com>,
        bob.liu@oracle.com
Subject: [LSF/MM/BPF TOPIC] selectively cramming things onto struct bio
Message-ID: <20200131004447.GA6869@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001310002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001310002
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi everyone,

Several months ago, there was a discussion[1] about enhancing XFS to
take a more active role in recoverying damaged blocks from a redundant
storage device when the block device doesn't signal an error but the
filesystem can tell that something is wrong.

Yes, we (XFS) would like to be able to exhaust all available storage
redundancy before we resort to rebuilding lost metadata, and we'd like
to do that without implementing our own RAID layer.

In the end, the largest stumbling block seems to be how to attach
additional instructions to struct bio.  Jens rejected the idea of adding
more pointers or more bytes to a struct bio since we'd be forcing
everyone to pay the extra memory price for a feature that in the ideal
situation will be used infrequently.

I think Martin Petersen tried to introduce separate bio pools so that we
only end up using larger bios for devices that really need it, but ran
into some difficulty with the usage model for how that would work.  (We
could, in theory, need to attach integrity data *and* retry attributes
to the same disk access).

So I propose a discussion of what exactly are the combinations of bio
attributes that are needed by block layer callers.  IIRC, the DIF/DIX
support code need to be able to attach the integrity data on its own;
whereas XFS already knows which device and which replica it would like
to try.  If the storage isn't total crap it shouldn't need to use the
feature all that often.

While we're on the topic of replica selection and discovery, let's also
bikeshed how to figure out how many replicas are even available.

(Yes, yes, the crazydragon rears his head again...;)

--D

[1] https://lore.kernel.org/linux-block/1543376991-5764-1-git-send-email-allison.henderson@oracle.com/
