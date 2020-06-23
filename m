Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A0A2067BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 00:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbgFWWzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 18:55:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387606AbgFWWzo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 18:55:44 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NMXSu6118547;
        Tue, 23 Jun 2020 18:55:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31un4jhuet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 18:55:34 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05NMXXqt119045;
        Tue, 23 Jun 2020 18:55:34 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31un4jhueh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 18:55:33 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05NMk2CA004349;
        Tue, 23 Jun 2020 22:55:32 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01wdc.us.ibm.com with ESMTP id 31uttt81gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 22:55:32 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05NMtWVw51511560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jun 2020 22:55:32 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EF7428058;
        Tue, 23 Jun 2020 22:55:32 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41C882805C;
        Tue, 23 Jun 2020 22:55:30 +0000 (GMT)
Received: from [9.211.67.55] (unknown [9.211.67.55])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 23 Jun 2020 22:55:30 +0000 (GMT)
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
 <74fb24d0-2b61-27f8-c44e-abd159e57469@linux.vnet.ibm.com>
 <20200623114558.GA1963415@kroah.com>
From:   Rick Lindsley <ricklind@linux.vnet.ibm.com>
Message-ID: <4d6ec768-0481-2b2e-c54e-bd0a5618d6df@linux.vnet.ibm.com>
Date:   Tue, 23 Jun 2020 15:55:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623114558.GA1963415@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_14:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230148
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/23/20 4:45 AM, Greg Kroah-Hartman wrote:

> Sure, but "help, I'm abusing your code interface, so fix your code
> interface and not my caller code" really isn't the best mantra :)

Well, those are your words, not mine.  What we're saying is, "we've 
identified an interface that doesn't scale in this situation, but we 
have a way to make it scale to all known configurations."

 > I am offended as a number of years ago this same user of kernfs/sysfs
 > did a lot of work to reduce the number of contentions in kernfs for
 > this same reason.  After that work was done, "all was good".  Now
 > this comes along again, blaming kernfs/sysfs, not the caller.

Ok. I don't know about the history, but I can tell you "blame" is not 
the word I'd use.  As hardware changes, Linux also changes, and over "a 
number of years" it's not surprising to me if basic assumptions changed 
again and led us back to a place we've been before.  That's not an 
indictment.  It just IS.

 > Memory is only going to get bigger over time, you might want to fix it
 > this way and then run away.  But we have to maintain this for the next
 > 20+ years, and you are not solving the root-problem here.  It will
 > come back again, right?

If hardware vendors insist on dealing with small blocks of memory in 
large aggregates, then yes it could.  You'll have to trust that I am 
also in discussion with hardware architects about how that is a very bad 
architecture and it's time to change decades and think bigger.  Separate 
audience, equally contentious discussion.  But the bottom line is, it's 
out there already and can't be walked back.

Your response here seems to center on "kernfs was never designed for 
that."  If so, we're in agreement.   We're suggesting a way it can be 
extended to be more robust, with no (apparent) side effects.  I'd like 
to discuss the merits of the patch itself.

Rick
