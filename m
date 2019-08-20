Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C76595232
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 02:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfHTAHu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 20:07:50 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17228 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbfHTAHt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:07:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5b39d20003>; Mon, 19 Aug 2019 17:07:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 19 Aug 2019 17:07:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 19 Aug 2019 17:07:47 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Aug
 2019 00:07:46 +0000
Received: from [10.2.161.11] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Aug
 2019 00:07:46 +0000
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ;-)
To:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Michal Hocko <mhocko@suse.com>,
        <linux-xfs@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-ext4@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190814101714.GA26273@quack2.suse.cz>
 <20190814180848.GB31490@iweiny-DESK2.sc.intel.com>
 <20190815130558.GF14313@quack2.suse.cz>
 <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
 <20190817022603.GW6129@dread.disaster.area>
 <20190819063412.GA20455@quack2.suse.cz>
 <20190819092409.GM7777@dread.disaster.area>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <ae64491b-85f8-eeca-14e8-2f09caf8abd2@nvidia.com>
Date:   Mon, 19 Aug 2019 17:05:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819092409.GM7777@dread.disaster.area>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566259666; bh=LvsaO/W/E/mixOshAJzHMebgelNBff1xUMLnLN/pLvo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=NsArZvwEDvm66ilI2A1eoZO1p7yAFDlWQdBa+cdoJUp6xnObqdh93g35BKg+RAtqq
         5uv3Rpv0MuFMd/RYZ+O+Jeptq6JJ6o3taZk4nS4LtTZnX4hTh9GqjKQbTdHTwW9HVp
         BL9NB7wfaZ5V4qvIsbaf4YFIY9zcb6TByHfWZ9IgOXgD8Wbil7W1m8ED+j7+rcnkQl
         R38dD9UnwVcboo7pgRnIY03uxeSGgS/jha4G1NHtzdfKimjXq5O1uAc177Y0Z1cbBj
         hv8AgOnUWOj++DPbwNeuv9z8Ol83AEAbe60Oaxg1fbVgjXs2MuIf4ZQL7pw0cVuDcY
         izLC9uCreFx8A==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/19/19 2:24 AM, Dave Chinner wrote:
> On Mon, Aug 19, 2019 at 08:34:12AM +0200, Jan Kara wrote:
>> On Sat 17-08-19 12:26:03, Dave Chinner wrote:
>>> On Fri, Aug 16, 2019 at 12:05:28PM -0700, Ira Weiny wrote:
>>>> On Thu, Aug 15, 2019 at 03:05:58PM +0200, Jan Kara wrote:
>>>>> On Wed 14-08-19 11:08:49, Ira Weiny wrote:
>>>>>> On Wed, Aug 14, 2019 at 12:17:14PM +0200, Jan Kara wrote:
...
> The last close is an interesting case because the __fput() call
> actually runs from task_work() context, not where the last reference
> is actually dropped. So it already has certain specific interactions
> with signals and task exit processing via task_add_work() and
> task_work_run().
> 
> task_add_work() calls set_notify_resume(task), so if nothing else
> triggers when returning to userspace we run this path:
> 
> exit_to_usermode_loop()
>    tracehook_notify_resume()
>      task_work_run()
>        __fput()
> 	locks_remove_file()
> 	  locks_remove_lease()
> 	    ....
> 
> It's worth noting that locks_remove_lease() does a
> percpu_down_read() which means we can already block in this context
> removing leases....
> 
> If there is a signal pending, the task work is run this way (before
> the above notify path):
> 
> exit_to_usermode_loop()
>    do_signal()
>      get_signal()
>        task_work_run()
>          __fput()
> 
> We can detect this case via signal_pending() and even SIGKILL via
> fatal_signal_pending(), and so we can decide not to block based on
> the fact the process is about to be reaped and so the lease largely
> doesn't matter anymore. I'd argue that it is close and we can't
> easily back out, so we'd only break the block on a fatal signal....
> 
> And then, of course, is the call path through do_exit(), which has
> the PF_EXITING task flag set:
> 
> do_exit()
>    exit_task_work()
>      task_work_run()
>        __fput()
> 
> and so it's easy to avoid blocking in this case, too.

Any thoughts about sockets? I'm looking at net/xdp/xdp_umem.c which pins
memory with FOLL_LONGTERM, and wondering how to make that work here.

These are close to files, in how they're handled, but just different
enough that it's not clear to me how to make work with this system.


> 
> So that leaves just the normal close() syscall exit case, where the
> application has full control of the order in which resources are
> released. We've already established that we can block in this
> context.  Blocking in an interruptible state will allow fatal signal
> delivery to wake us, and then we fall into the
> fatal_signal_pending() case if we get a SIGKILL while blocking.
> 
> Hence I think blocking in this case would be OK - it indicates an
> application bug (releasing a lease before releasing the resources)
> but leaves SIGKILL available to administrators to resolve situations
> involving buggy applications.
> 
> This requires applications to follow the rules: any process
> that pins physical resources must have an active reference to a
> layout lease, either via a duplicated fd or it's own private lease.
> If the app doesn't play by the rules, it hangs in close() until it
> is killed.

+1 for these rules, assuming that we can make them work. They are
easy to explain and intuitive.


thanks,
-- 
John Hubbard
NVIDIA
