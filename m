Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 950D3A96DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 01:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbfIDXMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 19:12:37 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18618 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfIDXMg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 19:12:36 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d7044e40000>; Wed, 04 Sep 2019 16:12:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 04 Sep 2019 16:12:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 04 Sep 2019 16:12:35 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 23:12:35 +0000
Subject: Re: [RFC PATCH v2 02/19] fs/locks: Add Exclusive flag to user Layout
 lease
To:     <ira.weiny@intel.com>, Andrew Morton <akpm@linux-foundation.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>, Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        <linux-xfs@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-ext4@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-3-ira.weiny@intel.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <69a7c037-6b4b-dbe3-2b42-77f85043b9eb@nvidia.com>
Date:   Wed, 4 Sep 2019 16:12:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809225833.6657-3-ira.weiny@intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567638756; bh=KcHEqM2TNQedobjZznlViJ4AvUuHmWBw0j98IvGFhfc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=G4fn03uVMA7J4UC1m9Yj7DhfsqKE5JCNHVM+oBqTe0AR3ZAlGEFmH7YKmkjPCmtCQ
         LUvXJdUANpLjlNJVqXY9TBqjeHx+L53SCBVVR7cf/kJBTDzGJICMvneFxnJ/bznKdv
         dNrJ4yQD+F1DCobVh03UMVVgaQfrILzPPrM7GeO2NaLVNZG5LHBQIJvvbOmoaMH7bs
         msCDq0E+I3UeIhdWC/toHOT1SlxdWDyKPOg3HjVgFJReZrxpb8PrvSxEcypog9tmYA
         zj992eW84rG8B8gGL5qOlDh0yQONipgKi9UW/dLLh2vAF7f5ffKJVuuRAS6ttv/Rev
         x8kDOD2mdY4mQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/9/19 3:58 PM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Add an exclusive lease flag which indicates that the layout mechanism
> can not be broken.

After studying the rest of these discussions extensively, I think in all
cases FL_EXCLUSIVE is better named "unbreakable", rather than exclusive.

If you read your sentence above, it basically reinforces that idea: "add an
exclusive flag to mean it is unbreakable" is a bit of a disconnect. It 
would be better to say,

Add an "unbreakable" lease flag which indicates that the layout lease
cannot be broken.

Furthermore, while this may or may not be a way forward on the "we cannot
have more than one process take a layout lease on a file/range", it at
least stops making it impossible. In other words, no one is going to
write a patch that allows sharing an exclusive layout lease--but someone
might well update some of these patches here to make it possible to
have multiple processes take unbreakable leases on the same file/range.

I haven't worked through everything there yet, but again:

* FL_UNBREAKABLE is the name you're looking for here, and

* I think we want to allow multiple processes to take FL_UNBREAKABLE
leases on the same file/range, so that we can make RDMA setups
reasonable. By "reasonable" I mean, "no need to have a lead process
that owns all the leases".



thanks,
-- 
John Hubbard
NVIDIA
