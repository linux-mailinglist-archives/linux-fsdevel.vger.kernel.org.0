Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEFC27BE4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 12:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfGaKWF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 06:22:05 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:39918 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726666AbfGaKWF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:22:05 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id E23D943E0B2;
        Wed, 31 Jul 2019 20:22:00 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hslj3-0005u5-Se; Wed, 31 Jul 2019 20:20:53 +1000
Date:   Wed, 31 Jul 2019 20:20:53 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 0/2] mm,thp: Add filemap_huge_fault() for THP
Message-ID: <20190731102053.GZ7689@dread.disaster.area>
References: <20190731082513.16957-1-william.kucharski@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731082513.16957-1-william.kucharski@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=0o9FgrsRnhwA:10
        a=7-415B0cAAAA:8 a=BDTIUSf9NILoYbXAtJgA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 02:25:11AM -0600, William Kucharski wrote:
> This set of patches is the first step towards a mechanism for automatically
> mapping read-only text areas of appropriate size and alignment to THPs
> whenever possible.
> 
> For now, the central routine, filemap_huge_fault(), amd various support
> routines are only included if the experimental kernel configuration option
> 
> 	RO_EXEC_FILEMAP_HUGE_FAULT_THP
> 
> is enabled.
> 
> This is because filemap_huge_fault() is dependent upon the
> address_space_operations vector readpage() pointing to a routine that will
> read and fill an entire large page at a time without poulluting the page
> cache with PAGESIZE entries

How is the readpage code supposed to stuff a THP page into a bio?

i.e. Do bio's support huge pages, and if not, what is needed to
stuff a huge page in a bio chain?

Once you can answer that question, you should be able to easily
convert the iomap_readpage/iomap_readpage_actor code to support THP
pages without having to care about much else as iomap_readpage()
is already coded in a way that will iterate IO over the entire THP
for you....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
