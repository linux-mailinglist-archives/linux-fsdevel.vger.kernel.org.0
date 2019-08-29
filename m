Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF60A0FF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 05:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfH2D3Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 23:29:24 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13912 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfH2D3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 23:29:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6746950001>; Wed, 28 Aug 2019 20:29:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 28 Aug 2019 20:29:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 28 Aug 2019 20:29:23 -0700
Received: from [10.2.174.243] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Aug
 2019 03:29:22 +0000
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ;-)
To:     Ira Weiny <ira.weiny@intel.com>, Dave Chinner <david@fromorbit.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, Michal Hocko <mhocko@suse.com>,
        <linux-xfs@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-ext4@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
 <20190821181343.GH8653@ziepe.ca>
 <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
 <20190821194810.GI8653@ziepe.ca>
 <20190821204421.GE5965@iweiny-DESK2.sc.intel.com>
 <20190823032345.GG1119@dread.disaster.area> <20190823120428.GA12968@ziepe.ca>
 <20190824001124.GI1119@dread.disaster.area>
 <20190824050836.GC1092@iweiny-DESK2.sc.intel.com>
 <20190826055510.GL1119@dread.disaster.area>
 <20190829020230.GA18249@iweiny-DESK2.sc.intel.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <3e5c5053-a74a-509c-660c-a6075ed87f11@nvidia.com>
Date:   Wed, 28 Aug 2019 20:27:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829020230.GA18249@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567049365; bh=U2zxSkDmfFQFUW8ITCuFuqzogPoHzY3eUcatrjlA5a8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=br5k4UQ1c3ttyAEINc727xSgtnH39dAWjWSCaXGTLwro1CU1YneuoppDXhLMmA4uD
         aDQ3MTA6HOZLsrWjeRsmclmc+9VuPFDc3mjUYq5LVFTaiCoeFJ5fy4G3b324J/gsUa
         1/2Te/7AfanbM290SQcF7x/TWeee+3u45vwvCyED11F/dogTN4V6SByz3yIloOJ3jT
         cLvs8UFo3vWu0RzGtWuxTuxbTth7a/DwXWriVQxLCn7BVTFeq34iQK1UkdryZj/+oB
         pVGut1zha9UABjnIclmX/RBYsT1gxtKg14OYbEVTjMUr+uzTVtNuUOwSxrEb1ZPXtX
         CMDU/9O7s997Q==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/28/19 7:02 PM, Ira Weiny wrote:
> On Mon, Aug 26, 2019 at 03:55:10PM +1000, Dave Chinner wrote:
>> On Fri, Aug 23, 2019 at 10:08:36PM -0700, Ira Weiny wrote:
>>> On Sat, Aug 24, 2019 at 10:11:24AM +1000, Dave Chinner wrote:
>>>> On Fri, Aug 23, 2019 at 09:04:29AM -0300, Jason Gunthorpe wrote:
...
>>
>> Sure, that part works because the struct file is passed. It doesn't
>> end up with the same fd number in the other process, though.
>>
>> The issue is that layout leases need to notify userspace when they
>> are broken by the kernel, so a lease stores the owner pid/tid in the
>> file->f_owner field via __f_setown(). It also keeps a struct fasync
>> attached to the file_lock that records the fd that the lease was
>> created on.  When a signal needs to be sent to userspace for that
>> lease, we call kill_fasync() and that walks the list of fasync
>> structures on the lease and calls:
>>
>> 	send_sigio(fown, fa->fa_fd, band);
>>
>> And it does for every fasync struct attached to a lease. Yes, a
>> lease can track multiple fds, but it can only track them in a single
>> process context. The moment the struct file is shared with another
>> process, the lease is no longer capable of sending notifications to
>> all the lease holders.
>>
>> Yes, you can change the owning process via F_SETOWNER, but that's
>> still only a single process context, and you can't change the fd in
>> the fasync list. You can add new fd to an existing lease by calling
>> F_SETLEASE on the new fd, but you still only have a single process
>> owner context for signal delivery.
>>
>> As such, leases that require callbacks to userspace are currently
>> only valid within the process context the lease was taken in.
> 
> But for long term pins we are not requiring callbacks.
> 

Hi Ira,

If "require callbacks to userspace" means sending SIGIO, then actually
FOLL_LONGTERM *does* require those callbacks. Because we've been, so
far, equating FOLL_LONGTERM with the vaddr_pin struct and with a lease.

What am I missing here?

thanks,
-- 
John Hubbard
NVIDIA
