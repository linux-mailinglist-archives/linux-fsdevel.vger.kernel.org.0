Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655D942A020
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 10:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhJLIov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 04:44:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235061AbhJLIou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:44:50 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C7C74B025604;
        Tue, 12 Oct 2021 04:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rK3EwTpFj9LRvp36w/iPeujwAgGDeB8sSzAGLI+vZEQ=;
 b=pGidHLBzx7XnxMBwI17SZlst61RfbveN3cLfuPIqdp4IGjOGlxIaphUE3rtkrXRIIDUD
 F5X5H9bh7Pur2SYeKt0sVajbTXvSQNHGqCmVgtK75ALKLhPAAiVZbN04dqtqxZnk4t83
 u2YphOOy5G9D1kVlM7Siek3guh7fI7y/sPCNLI1ZhvlKMa0+4titwlG+IlVxsDh/t4VX
 lhJGXzg43N4r6IzSR5VlyGeICLnA5TYmGy4JiP2wNGaK3MVEe1gHeHCx3GRZ2HpeteNh
 ZVxmRLBkweDJdOydjKPHlw/vieqiIiKUhWwwLQ6K7G1VWgP+5xWo0F+lcdUFibDQq/gb Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn5rtsv5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 04:42:32 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19C8eU0V015379;
        Tue, 12 Oct 2021 04:42:31 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn5rtsv56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 04:42:31 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19C8ZQB0026597;
        Tue, 12 Oct 2021 08:42:28 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3bk2q9e5gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 08:42:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19C8gOVw43778398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 08:42:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69378AE05F;
        Tue, 12 Oct 2021 08:42:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF8EFAE051;
        Tue, 12 Oct 2021 08:42:19 +0000 (GMT)
Received: from [9.43.19.240] (unknown [9.43.19.240])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Oct 2021 08:42:19 +0000 (GMT)
Subject: Re: [RFC 0/5] kernel: Introduce CPU Namespace
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     bristot@redhat.com, christian@brauner.io, ebiederm@xmission.com,
        lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
        mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, containers@lists.linux.dev,
        containers@lists.linux-foundation.org, pratik.r.sampat@gmail.com
References: <20211009151243.8825-1-psampat@linux.ibm.com>
 <20211011101124.d5mm7skqfhe5g35h@wittgenstein>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <a0f9ed06-1e5d-d3d0-21a5-710c8e27749c@linux.ibm.com>
Date:   Tue, 12 Oct 2021 14:12:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211011101124.d5mm7skqfhe5g35h@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hON9CxZwJ3YbnQZQADJaFNG-XDyMh0FS
X-Proofpoint-ORIG-GUID: UE9RlvQyQcG0TApwRdTcpouIkHdRgZ3B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_02,2021-10-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 spamscore=0 suspectscore=0 priorityscore=1501 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110120045
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,
> Thank your for providing a new approach to this problem and thanks for
> summarizing some of the painpoints and current solutions. I do agree
> that this is a problem we should tackle in some form.
>
> I have one design comment and one process related comments.
>
> Fundamentally I think making this a new namespace is not the correct
> approach. One core feature of a namespace it that it is an opt-in
> isolation mechanism: if I do CLONE_NEW* that is when the new isolation
> mechanism kicks. The correct reporting through procfs and sysfs is
> built into that and we do bugfixes whenever reported information is
> wrong.
>
> The cpu namespace would be different; a point I think you're making as
> well further above:
>
>> The control and the display interface is fairly disjoint with each
>> other. Restrictions can be set through control interfaces like cgroups,
> A task wouldn't really opt-in to cpu isolation with CLONE_NEWCPU it
> would only affect resource reporting. So it would be one half of the
> semantics of a namespace.
>
I completely agree with you on this, fundamentally a namespace should
isolate both the resource as well as the reporting. As you mentioned
too, cgroups handles the resource isolation while this namespace
handles the reporting and this seems to break the semantics of what a
namespace should really be.

The CPU resource is unique in that sense, at least in this context,
which makes it tricky to design a interface that presents coherent
information.

> In all honesty, I think cpu resource reporting through procfs/sysfs as
> done today without taking a tasks cgroup information into account is a
> bug. But the community has long agreed that fixing this would be a
> regression.
>
> I think that either we need to come up with new non-syscall based
> interfaces that allow to query virtualized cpu information and buy into
> the process of teaching userspace about them. This is even independent
> of containers.
> This is in line with proposing e.g. new procfs/sysfs files. Userspace
> can then keep supplementing cpu virtualization via e.g. stuff like LXCFS
> until tools have switched to read their cpu information from new
> interfaces. Something that they need to be taught anyway.

I too think that having a brand new interface all together and teaching
userspace about it is much cleaner approach.
On the same lines, if were to do that, we could also add more useful
metrics in that interface like ballpark number of threads to saturate
usage as well as gather more such metrics as suggested by Tejun Heo.

My only concern for this would be that if today applications aren't
modifying their code to read the existing cgroup interface and would
rather resort to using userspace side-channel solutions like LXCFS or
wrapping them up in kata containers, would it now be compelling enough
to introduce yet another interface?

While I concur with Tejun Heo's comment the mail thread and overloading
existing interfaces of sys and proc which were originally designed for
system wide resources, may not be a great idea:

> There is a fundamental problem with trying to represent a resource shared
> environment controlled with cgroup using system-wide interfaces including
> procfs

A fundamental question we probably need to ascertain could be -
Today, is it incorrect for applications to look at the sys and procfs to
get resource information, regardless of their runtime environment?

Also, if an application were to only be able to view the resources
based on the restrictions set regardless of the interface - would there
be a disadvantage for them if they could only see an overloaded context
sensitive view rather than the whole system view?

> Or if we really want to have this tied to a namespace then I think we
> should consider extending CLONE_NEWCGROUP since cgroups are were cpu
> isolation for containers is really happening. And arguably we should
> restrict this to cgroup v2.

Given some thought, I tend to agree this could be wrapped in a cgroup
namespace. However, some more deliberation is definitely needed to
determine if by including CPU isolation here we aren't breaking
another semantic set by the cgroup namespace itself as cgroups don't
necessarily have to have restrictions on CPUs set and can also allow
mixing of restrictions from cpuset and cfs period-quota.

>
>  From a process perspective, I think this is something were we will need
> strong guidance from the cgroup and cpu crowd. Ultimately, they need to
> be the ones merging a feature like this as this is very much into their
> territory.

I agree, we definitely need the guidance from the cgroups and cpu folks
from the community. We would also benefit from guidance from the
userspace community like containers and understand how they use the
existing interfaces so that we can arrive at a holistic view of what
everybody could benefit by.

>
> Christian

Thank you once again for all the comments, the CPU namespace is me
taking a stab trying to highlight the problem itself. Not without
its flaws, having a coherent interface does seem to show benefits as
well.
Hence, if the consensus builds for the right interface for solving this
problem, I would be glad to help in contributing to a solution towards
it.

Thanks,
Pratik



