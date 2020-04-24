Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CC51B8267
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 01:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgDXXUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 19:20:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbgDXXUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 19:20:37 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03ON2s8n158321
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 19:20:36 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30jrxp9pyq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2020 19:20:36 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Sat, 25 Apr 2020 00:19:55 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 25 Apr 2020 00:19:50 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03ONKRt452691272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 23:20:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A92D54C04E;
        Fri, 24 Apr 2020 23:20:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A39974C046;
        Fri, 24 Apr 2020 23:20:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.185.245])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 Apr 2020 23:20:24 +0000 (GMT)
Subject: Re: [PATCH 0/5] ext4/overlayfs: fiemap related fixes
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger@dilger.ca, darrick.wong@oracle.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
References: <cover.1587555962.git.riteshh@linux.ibm.com>
 <20200424101153.GC456@infradead.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Sat, 25 Apr 2020 04:50:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200424101153.GC456@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20042423-0008-0000-0000-00000376A465
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042423-0009-0000-0000-00004A987683
Message-Id: <20200424232024.A39974C046@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_13:2020-04-24,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240174
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Christoph,

Thanks for your review comments.

On 4/24/20 3:41 PM, Christoph Hellwig wrote:
> I think the right fix is to move fiemap_check_ranges into all the ->fiemap

I do welcome your suggestion here. But I am not sure of what you are
suggesting should be done as a 1st round of changes for the immediate
reported problem.
So currently these patches take the same approach on overlayfs on how 
VFS does it. So as a fix to the overlayfs over ext4 reported problems in
thread [1] & [2]. I think these patches are doing the right thing.

Also maybe I am biased in some way because as I see these are the right
fixes with minimal changes only at places which does have a direct
problem.

But I do agree that in the second round (as a right approach for the
long term), we could just get rid of fiemap_check_ranges() from
ioctl_fiemap() & ovl_fiemap(), and better add those in all filesystem
specific implementations of ->fiemap() call.
(e.g. ext4_fiemap(), f2fs_fiemap() etc.).

> instances (we only have a few actual implementation minus the wrappers
> around iomap/generic).  
 >
Ok, got it. So for filesystem specific ->fiemap implementations,
we should add fiemap_check_ranges() in there implementations.
And for those FS which are calling iomap_fiemap() or
generic_block_fiemap(), what you are suggesting it to add
fiemap_check_ranges() in iomap_fiemap() & generic_block_fiemap().
Is this understanding correct?


> Then add a version if iomap_fiemap that can pass
> in maxbytes explicitly for ext4, similar to what we've done with various
> other generic helpers.

Sorry I am not sure if I followed it correctly. Help me understand pls.
Also some e.g about "what we've done with various other generic helpers"

iomap_fiemap(), will already get a FS specific inode from which we can
calculate inode->i_sb->s_maxbytes. So why pass maxbytes explicitly?


> 
> The idea of validating input against file systems specific paramaters
> before we call into the fs is just bound to cause problems.
> 
Sure, but as I was saying. The changes you are suggesting will have
changes in all filesystem's individual ->fiemap() implementations.
But as a fix for the reported problem of [1] & [2], I think these
patches could be taken. Once those are merged, I can work on the changes
that you are suggesting.

Does that sound ok to you?


[1]: https://lkml.org/lkml/2020/4/11/46
[2]: 
https://patchwork.ozlabs.org/project/linux-ext4/patch/20200418233231.z767yvfiupy7hwgp@xzhoux.usersys.redhat.com/ 



-ritesh

