Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735FC204E09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 11:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732077AbgFWJeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 05:34:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732056AbgFWJeL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:34:11 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05N9XRPG171816;
        Tue, 23 Jun 2020 05:33:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31tysr86wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 05:33:59 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05N9Xblc172800;
        Tue, 23 Jun 2020 05:33:57 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31tysr86vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 05:33:57 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05N9PchQ005891;
        Tue, 23 Jun 2020 09:33:55 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01wdc.us.ibm.com with ESMTP id 31sa38p732-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 09:33:55 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05N9XrMV20775172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jun 2020 09:33:53 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE7C0BE04F;
        Tue, 23 Jun 2020 09:33:54 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95A78BE053;
        Tue, 23 Jun 2020 09:33:51 +0000 (GMT)
Received: from [9.211.67.55] (unknown [9.211.67.55])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 23 Jun 2020 09:33:50 +0000 (GMT)
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ian Kent <raven@themaw.net>, Tejun Heo <tj@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
 <20200619153833.GA5749@mtj.thefacebook.com>
 <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
 <20200619222356.GA13061@mtj.duckdns.org>
 <429696e9fa0957279a7065f7d8503cb965842f58.camel@themaw.net>
 <20200622174845.GB13061@mtj.duckdns.org> <20200622180306.GA1917323@kroah.com>
 <2ead27912e2a852bffb1477e8720bdadb591628d.camel@themaw.net>
 <20200623060236.GA3818201@kroah.com>
From:   Rick Lindsley <ricklind@linux.vnet.ibm.com>
Message-ID: <74fb24d0-2b61-27f8-c44e-abd159e57469@linux.vnet.ibm.com>
Date:   Tue, 23 Jun 2020 02:33:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623060236.GA3818201@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_04:2020-06-22,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 cotscore=-2147483648 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006230073
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/22/20 11:02 PM, Greg Kroah-Hartman wrote:

> First off, this is not my platform, and not my problem, so it's funny
> you ask me :)

Weeeelll, not your platform perhaps but MAINTAINERS does list you first and Tejun second as maintainers for kernfs.  So in that sense, any patches would need to go thru you.  So, your opinions do matter.

  
> Anyway, as I have said before, my first guesses would be:
> 	- increase the granularity size of the "memory chunks", reducing
> 	  the number of devices you create.

This would mean finding every utility that relies on this behavior.  That may be possible, although not easy, for distro or platform software, but it's hard to guess what user-related utilities may have been created by other consumers of those distros or that platform.  In any case, removing an interface without warning is a hanging offense in many Linux circles.

> 	- delay creating the devices until way after booting, or do it
> 	  on a totally different path/thread/workqueue/whatever to
> 	  prevent delay at booting

This has been considered, but it again requires a full list of utilities relying on this interface and determining which of them may want to run before the devices are "loaded" at boot time.  It may be few, or even zero, but it would be a much more disruptive change in the boot process than what we are suggesting.

> And then there's always:
> 	- don't create them at all, only only do so if userspace asks
> 	  you to.

If they are done in parallel on demand, you'll see the same problem (load average of 1000+, contention in the same spot.)  You obviously won't hold up the boot, of course, but your utility and anything else running on the machine will take an unexpected pause ... for somewhere between 30 and 90 minutes.  Seems equally unfriendly.

A variant of this, which does have a positive effect, is to observe that coldplug during initramfs does seem to load up the memory device tree without incident.  We do a second coldplug after we switch roots and this is the one that runs into timer issues.  I have asked "those that should know" why there is a second coldplug.  I can guess but would prefer to know to avoid that screaming option.  If that second coldplug is unnecessary for the kernfs memory interfaces to work correctly, then that is an alternate, and perhaps even better solution.  (It wouldn't change the fact that kernfs was not built for speed and this problem remains below the surface to trip up another.)

However, nobody I've found can say that is safe, and I'm not fond of the 'see who screams' test solution.

> You all have the userspace tools/users for this interface and know it
> best to know what will work for them.  If you don't, then hey, let's
> just delete the whole thing and see who screams :)

I guess I'm puzzled by why everyone seems offended by suggesting we change a mutex to a rw semaphore.  In a vacuum, sure, but we have before and after numbers.  Wouldn't the same cavalier logic apply?  Why not change it and see who screams?

I haven't heard any criticism of the patch itself - I'm hearing criticism of the problem.  This problem is not specific to memory devices.  As we get larger systems,  we'll see it elsewhere. We do already see a mild form of this when fibre finds 1000-2000 fibre disks and goes to add them in parallel.  Small memory chunks introduces the problem at a level two orders of magnitude bigger, but eventually other devices will be subject to it too.  Why not address this now?

'Doctor, it hurts when I do this'
'Then don't do that'

Funny as a joke.  Less funny as a review comment.

Rick
