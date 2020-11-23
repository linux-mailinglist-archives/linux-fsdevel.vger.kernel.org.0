Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7B92C181C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 23:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbgKWWCH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 17:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbgKWWCG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 17:02:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0789C0613CF;
        Mon, 23 Nov 2020 14:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mhCpis23NqY63c8NxX6Wxg38gWQuSreQ5clgMaAKViA=; b=PaJdSMiw4iN/I92Z9bYbMfvscb
        9HdMsduPzdTIWJyB7e51N3arRZiy6S9g2BEVESuiG4aHlFqUVtzpiHADx5/vpdb4EsfqzxwQaJ501
        8X4XZ1f5cae1Gtb2wfzzBtKYWL7eHl8h08lFMoGtaHk3ITOOet0NdKxNtaDLhK8dVho/V1FEmI6tA
        6veew9XNjrE/VaddCQg6FI8xVBEcLcBX2HPiuKZyg3iAna/mlju19wC6xuBdRs/tvvZwJ74mYuWUm
        UrjkO13j9FbNlho28eMkAfhgPXwyhed3yB0Sd18s9qs6YQGExCsFAOXewM+LpBP5pCPAVNO8gNi0w
        dA3THayQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khJtZ-0005K1-So; Mon, 23 Nov 2020 22:01:13 +0000
Date:   Mon, 23 Nov 2020 22:01:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        osalvador@suse.de, song.bao.hua@hisilicon.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 00/21] Free some vmemmap pages of hugetlb page
Message-ID: <20201123220113.GW4327@casper.infradead.org>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120084202.GJ3200@dhcp22.suse.cz>
 <6b1533f7-69c6-6f19-fc93-c69750caaecc@redhat.com>
 <20201120093912.GM3200@dhcp22.suse.cz>
 <eda50930-05b5-0ad9-2985-8b6328f92cec@redhat.com>
 <55e53264-a07a-a3ec-4253-e72c718b4ee6@oracle.com>
 <20201123073842.GA27488@dhcp22.suse.cz>
 <37f4bf02-c438-9fbd-32ea-8bedbe30c4da@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37f4bf02-c438-9fbd-32ea-8bedbe30c4da@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 01:52:13PM -0800, Mike Kravetz wrote:
> On 11/22/20 11:38 PM, Michal Hocko wrote:
> > On Fri 20-11-20 09:45:12, Mike Kravetz wrote:
> >> Not sure if I agree with that last statement.  Database and virtualization
> >> use cases from my employer allocate allocate hugetlb pages after boot.  It
> >> is shortly after boot, but still not from boot/kernel command line.
> > 
> > Is there any strong reason for that?
> 
> The reason I have been given is that it is preferable to have SW compute
> the number of needed huge pages after boot based on total memory, rather
> than have a sysadmin calculate the number and add a boot parameter.

Oh, I remember this bug!  I think it was posted publically, even.
If the sysadmin configures, say, 90% of the RAM to be hugepages and
then a DIMM fails and the sysadmin doesn't remember to adjust the boot
parameter, Linux does some pretty horrible things and the symptom is
"Linux doesn't boot".

