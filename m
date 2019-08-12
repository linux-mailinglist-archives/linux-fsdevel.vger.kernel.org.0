Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5F8A8A932
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 23:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfHLVUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 17:20:20 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4930 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfHLVUU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:20:20 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d51d81e0001>; Mon, 12 Aug 2019 14:20:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 12 Aug 2019 14:20:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 12 Aug 2019 14:20:19 -0700
Received: from MacBook-Pro-10.local (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 21:20:16 +0000
Subject: Re: [RFC PATCH v2 15/19] mm/gup: Introduce vaddr_pin_pages()
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>, Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        <linux-xfs@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-ext4@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-16-ira.weiny@intel.com>
 <6ed26a08-4371-9dc1-09eb-7b8a4689d93b@nvidia.com>
 <20190812210013.GC20634@iweiny-DESK2.sc.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <b4e15390-701d-c6e9-564c-04e6a3effd50@nvidia.com>
Date:   Mon, 12 Aug 2019 14:20:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812210013.GC20634@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565644830; bh=JroT/x6S1SiN0zFyCuj22OCuZxP8/vKF5Bd4ngANWFg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=i3VfG8jwOmXxQPogIwZ3sMCwfa3CGn1sVpvN5L89ZpC8daRGO/R9vtPcQ47P9mJKh
         RafMQn1lyj28wP20RL4bwfklVqGKlcfPAph9NXoIwgiQdHwPgcKbnROYw10gmdDVRB
         1aS4zaWboi6HStNT7Yrmu295QTNK0j6K5HIrCLRwR8jCgH/8n6x020QR0zeCSySUVY
         VAXLG041hhDzAzbF3ygoB+7XO9fFnjFaejfE1ChOqzhEU5/hswkEAbHCgQ7dScaDdG
         w+6XfT+PtAoSQVM3gP/Vv3ydQrcAmDn+XK4KuZZlDuKzgjlPJSCpn8JEDKzDbcX5Uy
         UcyfVCRj6Jjvg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/12/19 2:00 PM, Ira Weiny wrote:
> On Fri, Aug 09, 2019 at 05:09:54PM -0700, John Hubbard wrote:
>> On 8/9/19 3:58 PM, ira.weiny@intel.com wrote:
>>> From: Ira Weiny <ira.weiny@intel.com>
...
> 
> At one point I wanted to (and had in my tree) a new flag but I went away from
> it.  Prior to the discussion on mlock last week I did not think we needed it.
> But I'm ok to add it back in.
> 
> I was not ignoring the idea for this RFC I just wanted to get this out there
> for people to see.  I see that you threw out a couple of patches which add this
> flag in.
> 
> FWIW, I think it would be good to differentiate between an indefinite pinned
> page vs a referenced "gotten" page.
> 
> What you and I have been working on is the former.  So it would be easy to
> change your refcounting patches to simply key off of FOLL_PIN.
> 
> Would you like me to add in your FOLL_PIN patches to this series?

Sure, that would be perfect. They don't make any sense on their own, and
it's all part of the same design idea.

thanks,
-- 
John Hubbard
NVIDIA
