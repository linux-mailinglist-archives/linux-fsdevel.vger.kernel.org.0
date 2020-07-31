Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3C5234BB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 21:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgGaTmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 15:42:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56088 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaTmg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 15:42:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VJfmfq036480;
        Fri, 31 Jul 2020 19:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=jBXujslfGLcy/uxKVs6euah0Afp+K2q+zLyuafXCuYs=;
 b=V/UmbF9Z6fJS4SNlcf5gW/z+uk4ICCEH8d4bET9Wtn05VqGE/OlnQz5vRv/uaNPNJaLw
 AITqFHUxx8k58B03kImuXfXECS84E2NdizSoF1QGowa4+AA4DNISVFwcOOWODSuMzlSe
 /m9zGzOt6EJY4i2WEv5QRKNIp86f27WCmDKN26BHEv+MR9DzX0S1qSabTHYVXqYtNik6
 aVhd0xjbspLZuw2A7+Sn8WTNNh0Knq+tgBnSU3LrKK3CtvaXShIzu8OrRNvThBujA9P/
 hjigm1cWus2RjREhOdziWMIReYoyuBNkUhGILrwGmBghQ1onIgZdpxQAQJcsokVkwAL4 ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 32mf7036up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Jul 2020 19:41:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VJIc20163330;
        Fri, 31 Jul 2020 19:41:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 32hu64wdy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 19:41:56 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06VJff9C019420;
        Fri, 31 Jul 2020 19:41:42 GMT
Received: from [10.39.235.87] (/10.39.235.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 Jul 2020 12:41:41 -0700
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca,
        christian@kellner.me, areber@redhat.com, cyphar@cyphar.com
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <389f79f9-f1a5-963e-dd05-4d0aaabb5346@oracle.com>
Date:   Fri, 31 Jul 2020 15:41:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310143
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/27/2020 1:11 PM, Anthony Yznaga wrote:
> This patchset adds support for preserving an anonymous memory range across
> exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for
> sharing memory in this manner, as opposed to re-attaching to a named shared
> memory segment, is to ensure it is mapped at the same virtual address in
> the new process as it was in the old one.  An intended use for this is to
> preserve guest memory for guests using vfio while qemu exec's an updated
> version of itself.  By ensuring the memory is preserved at a fixed address,
> vfio mappings and their associated kernel data structures can remain valid.
> In addition, for the qemu use case, qemu instances that back guest RAM with
> anonymous memory can be updated.

I forgot to mention, our use case is not just theoretical.  It has been implemented
and is pretty cool (but I am biased).  The pause time for the guest is in the
100 - 200 msec range.  We submitted qemu patches for review based on the MADV_DOEXEC
proposal.  In case you are curious:
  https://lore.kernel.org/qemu-devel/1596122076-341293-1-git-send-email-steven.sistare@oracle.com/

- Steve

