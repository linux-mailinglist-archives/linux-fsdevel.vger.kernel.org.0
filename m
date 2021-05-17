Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7E4383B7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 19:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbhEQRlQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 13:41:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236508AbhEQRlO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 13:41:14 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14HHY9HK109359;
        Mon, 17 May 2021 13:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=IH6PheY3FVLfkb4B496KXTcuSLs3nDYFjkhoA1+u0Us=;
 b=S7+866xZ99W6Nb8X1Eb4nrgjHCtGi0PCZrc2kh8n0xvdE2AmibpOU/02nYhya6F7Lxm3
 tY6AaDXScZjSPXK+X+kfoFsSZyOdVong+RFtS1bvO8DUywQQGDwdR4/q4Z5fwVyjRlLh
 IhkH8FYiMcV/QxrVwA7KBtGhfLOpI/g3nvyVTCbABrWl89FPKEIXAFvXTOCWFmKiIaH6
 U8MvleKY1kdJc69G9zDKWa7BSmDOWPfdqsNDlniSH3DFtUPO+6sysju1z8kkEX9bmEf7
 aLilwuxbnCO+wRqehYXdaCrOVkZYrYO+h2jgmDotlT4BIMJNMxby4wiedF9LtQzygxJu Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38kuwn2125-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 13:39:46 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14HHYKOC110072;
        Mon, 17 May 2021 13:39:46 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38kuwn211j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 13:39:46 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14HHZSUV020452;
        Mon, 17 May 2021 17:39:43 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 38j5x80jeg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 17:39:43 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14HHdfF938928704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 17:39:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F11811C050;
        Mon, 17 May 2021 17:39:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 069D311C04C;
        Mon, 17 May 2021 17:39:40 +0000 (GMT)
Received: from [9.199.40.240] (unknown [9.199.40.240])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 May 2021 17:39:39 +0000 (GMT)
Subject: Re: What sort of inode state does ->evict_inode() expect to see? [was
 Re: 9p: fscache duplicate cookie]
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Luis Henriques <lhenriques@suse.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
References: <YJvb9S8uxV2X45Cu@zeniv-ca.linux.org.uk>
 <YJvJWj/CEyEUWeIu@codewreck.org> <87tun8z2nd.fsf@suse.de>
 <87czu45gcs.fsf@suse.de> <2507722.1620736734@warthog.procyon.org.uk>
 <2882181.1620817453@warthog.procyon.org.uk> <87fsysyxh9.fsf@suse.de>
 <2891612.1620824231@warthog.procyon.org.uk>
 <2919958.1620828730@warthog.procyon.org.uk> <87bl9dwb1r.fsf@suse.de>
 <YJ7oxGY/eosPvCiA@codewreck.org>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <4a83552c-742d-e327-b810-7da43b913daf@linux.ibm.com>
Date:   Mon, 17 May 2021 23:09:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <YJ7oxGY/eosPvCiA@codewreck.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d_x-4vcUZJyzkfdaWd_VWvKhWfGYRIva
X-Proofpoint-GUID: nPgOaz1VVqqUygAfFeohAPRUHEioqNlO
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-17_08:2021-05-17,2021-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105170117
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/15/21 2:46 AM, Dominique Martinet wrote:
> Hi Aneesh,
> 
> I'm going to rely on your memory here... A long, long time ago (2011!),
> you've authored this commit:
> -------
> commit ed80fcfac2565fa866d93ba14f0e75de17a8223e
> Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Date:   Wed Jul 6 16:32:31 2011 +0530
> 
>      fs/9p: Always ask new inode in create
>      
>      This make sure we don't end up reusing the unlinked inode object.
>      The ideal way is to use inode i_generation. But i_generation is
>      not available in userspace always.
>      
>      Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>      Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
> -------
> 
> Do you happen to remember or know *why* you wanted to make sure we don't
> reuse the unlinked inode object?
> 
>

Sorry, I don't recall all the details, hence some of these details may 
not be correct. I did look at the archives to see if we have email 
discussions around the change. I found the below related email thread.

https://lore.kernel.org/lkml/1310402460-5098-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com/


IIRC, this was to avoid picking up wrong inode from the hash? So a 
create is a new object and we want to actually avoid any comparison?
Hence pass a test function that always return false?

-aneesh
