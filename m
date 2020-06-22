Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBA020428A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 23:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbgFVVWx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 17:22:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730460AbgFVVWw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:22:52 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05ML2xIt106480;
        Mon, 22 Jun 2020 17:22:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31tysvg7v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 17:22:38 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05ML4WE3112081;
        Mon, 22 Jun 2020 17:22:38 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31tysvg7uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 17:22:38 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05MLFbdJ028588;
        Mon, 22 Jun 2020 21:22:37 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 31sa38q828-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 21:22:37 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05MLMZtg41353574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jun 2020 21:22:36 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E265B6A047;
        Mon, 22 Jun 2020 21:22:35 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CC7D6A051;
        Mon, 22 Jun 2020 21:22:35 +0000 (GMT)
Received: from [9.211.67.55] (unknown [9.211.67.55])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 22 Jun 2020 21:22:35 +0000 (GMT)
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
To:     Tejun Heo <tj@kernel.org>
Cc:     Ian Kent <raven@themaw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <fa22c563-73b7-5e45-2120-71108ca8d1a0@linux.vnet.ibm.com>
 <20200622175343.GC13061@mtj.duckdns.org>
From:   Rick Lindsley <ricklind@linux.vnet.ibm.com>
Message-ID: <82b2379e-36d0-22c2-41eb-71571e992b37@linux.vnet.ibm.com>
Date:   Mon, 22 Jun 2020 14:22:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622175343.GC13061@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_12:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 cotscore=-2147483648 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220137
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/22/20 10:53 AM, Tejun Heo wrote:

> I don't know. The above highlights the absurdity of the approach itself to
> me. You seem to be aware of it too in writing: 250,000 "devices".

Just because it is absurd doesn't mean it wasn't built that way :)

I agree, and I'm trying to influence the next hardware design.  However, what's already out there is memory units that must be accessed in 256MB blocks.  If you want to remove/add a GB, that's really 4 blocks of memory you're manipulating, to the hardware.  Those blocks have to be registered and recognized by the kernel for that to work.

Rick

