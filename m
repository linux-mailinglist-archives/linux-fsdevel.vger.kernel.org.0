Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82F31E4295
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 14:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgE0Mp3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 08:45:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728513AbgE0Mp3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 08:45:29 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RCWOgG067581;
        Wed, 27 May 2020 08:45:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3170c72v4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 08:45:16 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04RCX31u070298;
        Wed, 27 May 2020 08:45:16 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3170c72v3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 08:45:16 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04RCiru1024551;
        Wed, 27 May 2020 12:45:14 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 316ufake6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 12:45:14 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04RCiCXO9372298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 May 2020 12:44:12 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 256D26A051;
        Wed, 27 May 2020 12:44:13 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02E9E6A04D;
        Wed, 27 May 2020 12:44:10 +0000 (GMT)
Received: from [9.211.128.7] (unknown [9.211.128.7])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 27 May 2020 12:44:10 +0000 (GMT)
Subject: Re: [PATCH 0/4] kernfs: proposed locking and concurrency improvement
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Kent <raven@themaw.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <159038508228.276051.14042452586133971255.stgit@mickey.themaw.net>
 <20200525061616.GA57080@kroah.com>
From:   Rick Lindsley <ricklind@linux.vnet.ibm.com>
Message-ID: <1d185eb3-8a85-9138-9277-92400ba03e0a@linux.vnet.ibm.com>
Date:   Wed, 27 May 2020 05:44:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200525061616.GA57080@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 cotscore=-2147483648 priorityscore=1501 impostorscore=0 clxscore=1011
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270091
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/24/20 11:16 PM, Greg Kroah-Hartman wrote:

> Independant of your kernfs changes, why do we really need to represent
> all of this memory with that many different "memory objects"?  What is
> that providing to userspace?
> 
> I remember Ben Herrenschmidt did a lot of work on some of the kernfs and
> other functions to make large-memory systems boot faster to remove some
> of the complexity in our functions, but that too did not look into why
> we needed to create so many objects in the first place.

That was my first choice too.  Unfortunately, I was not consulted on this design decision, however, and now it's out there.  It is, as you guessed, a hardware "feature".  The hw believes there is value in identifying memory in 256MB chunks.  There are, unfortunately, 2^18 or over 250,000 of those on a 64TB system, compared with dozens or maybe even hundreds of other devices.

We considered a revamping of the boot process - delaying some devices, reordering operations and such - but deemed that more dangerous to other architectures.  Although this change is driven by a particular architecture, the changes we've identified are architecture independent.  The risk of breaking something else is much lower than if we start reordering boot steps.

> Also, why do you need to create the devices _when_ you create them?  Can
> you wait until after init is up and running to start populating the
> device tree with them?  That way boot can be moving on and disks can be
> spinning up earlier?

I'm not a systemd expert, unfortunately, so I don't know if it needs to happen *right* then or not.  I do know that upon successful boot, a ps reveals many systemd children still reporting in.  It's not that we're waiting on everybody; the contention is causing a delay in the discovery of key devices like disks, and *that* leads to timeouts firing in systemd rules.  Any workaround bent on dodging the problem tends to get exponentially worse when the numbers change.  We noticed this problem at 32TB, designed some timeout changes and udev options to improve it, only to have both fail at 64TB.  Worse, at 64TB, larger timeouts and udev options failed to work consistently anymore.

There are two times we do coldplugs - once in the initramfs, and then again after we switch over to the actual root.  I did try omitting memory devices after the switchover.  Much faster!  So, why is the second one necessary?  Are there some architectures that need that?  I've not found anyone who can answer that, so going that route presents us with a different big risk.

Rick

