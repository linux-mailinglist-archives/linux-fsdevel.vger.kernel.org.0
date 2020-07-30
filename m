Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385142331F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgG3M0E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 08:26:04 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:22659 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgG3M0D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:26:03 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jul 2020 08:26:02 EDT
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 1E9933FA20;
        Thu, 30 Jul 2020 14:17:50 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=DqHS8RqM;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.923
X-Spam-Level: 
X-Spam-Status: No, score=-2.923 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.824,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nBo2n-c5eens; Thu, 30 Jul 2020 14:17:49 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id ABF163FA05;
        Thu, 30 Jul 2020 14:17:45 +0200 (CEST)
Received: from localhost.localdomain (jfdmzpr03-ext.jf.intel.com [134.134.139.72])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 047E2361FE2;
        Thu, 30 Jul 2020 14:17:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1596111466; bh=iGyJdancEFzCgpEB/a6usgzLP2OYr7hvhwkRRKPMpic=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DqHS8RqMbQzRNtSCinBnECl9eqheZ6A6v/8ioQurPah6QK48G9eUTS7y/tQukkPXI
         mlbIc9xokmoipp8Ig1QeG5KZOh1SmRt770bR+Zc/whzSRhFBd9USMBeEKnfnP8V6HU
         NfAc5Lj/RmEBe0Dqr7v55XqnTJyvUEHSYYA+50cY=
Subject: Re: [PATCH] dma-resv: lockdep-prime address_space->i_mmap_rwsem for
 dma-resv
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Dave Chinner <david@fromorbit.com>, Qian Cai <cai@lca.pw>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20200728135839.1035515-1-daniel.vetter@ffwll.ch>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <38cbc4fb-3a88-47c4-2d6c-4d90f9be42e7@shipmail.org>
Date:   Thu, 30 Jul 2020 14:17:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728135839.1035515-1-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/28/20 3:58 PM, Daniel Vetter wrote:
> GPU drivers need this in their shrinkers, to be able to throw out
> mmap'ed buffers. Note that we also need dma_resv_lock in shrinkers,
> but that loop is resolved by trylocking in shrinkers.
>
> So full hierarchy is now (ignore some of the other branches we already
> have primed):
>
> mmap_read_lock -> dma_resv -> shrinkers -> i_mmap_lock_write
>
> I hope that's not inconsistent with anything mm or fs does, adding
> relevant people.
>
Looks OK to me. The mapping_dirty_helpers run under the i_mmap_lock, but 
don't allocate any memory AFAICT.

Since huge page-table-entry splitting may happen under the i_mmap_lock 
from unmap_mapping_range() it might be worth figuring out how new page 
directory pages are allocated, though.

/Thomas



