Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4334C117241
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 17:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfLIQ6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 11:58:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbfLIQ6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:58:14 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9GlSYB127293
        for <linux-fsdevel@vger.kernel.org>; Mon, 9 Dec 2019 11:58:13 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wrtfqhfc8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2019 11:58:12 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Mon, 9 Dec 2019 16:58:10 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Dec 2019 16:58:04 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB9Gw3NS44696048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Dec 2019 16:58:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D612411C050;
        Mon,  9 Dec 2019 16:58:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01B8111C04A;
        Mon,  9 Dec 2019 16:58:01 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon,  9 Dec 2019 16:58:00 +0000 (GMT)
Date:   Mon, 9 Dec 2019 22:28:00 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Boaz Harrosh <boaz@plexistor.com>, Phil Auld <pauld@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20191115070843.GA24246@ming.t460p>
 <20191115234005.GO4614@dread.disaster.area>
 <20191118092121.GV4131@hirez.programming.kicks-ass.net>
 <20191118204054.GV4614@dread.disaster.area>
 <20191120191636.GI4097@hirez.programming.kicks-ass.net>
 <20191120220313.GC18056@pauld.bos.csb>
 <20191121041218.GK24548@ming.t460p>
 <20191121141207.GA18443@pauld.bos.csb>
 <93de0f75-3664-c71e-9947-5b37ae935ddc@plexistor.com>
 <8c02ab43-3880-68db-f293-9958510fb29e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8c02ab43-3880-68db-f293-9958510fb29e@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19120916-0012-0000-0000-000003733800
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120916-0013-0000-0000-000021AF077F
Message-Id: <20191209165800.GB27229@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_04:2019-12-09,2019-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 mlxscore=0 mlxlogscore=953 suspectscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912090142
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Jens Axboe <axboe@kernel.dk> [2019-11-21 09:19:29]:

> > 
> > I wish there was a flag to wake_up() or to the event object that says
> > to relinquish the remaning of the time-slice to the waiter on same
> > CPU, since I will be soon sleeping.
> 
> Isn't that basically what wake_up_sync() is?
> 

Workqueue don't seem to be using wait_queue_head which is needed when using
wake_up_sync and its related APIs.  Also wake_up_sync would work when the
waking task seems to hand off the CPU and goes to sleep/block. However here,
i.e in fsperf case atleast, the waking thread continues to run after it has
woken the per cpu workqueue.

-- 
Thanks and Regards
Srikar Dronamraju

