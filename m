Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223AE485794
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 18:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242487AbiAERpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 12:45:24 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58606 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237699AbiAERpU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:45:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 02AC0CE0451;
        Wed,  5 Jan 2022 17:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C534C36AE0;
        Wed,  5 Jan 2022 17:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641404717;
        bh=Q3V6GchDz78dmmg78l3g/qEnjx4BoPVZZK1V2rhQnWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ofv2KE4rUB3IDE5zL0LXmcN71knBnGoHLvDV2Kto/Au/uS6xKi4fnQx0ec7kw172w
         BbDNFOrbPnuJOnu/tQCE3V9lQ2JSWQ1I1m7/yWycIU8F9uEsfOdXaldGfOgLh1Xgpb
         D3biVEQT9XNIZXsP9hMsWsnfhqjojMiwV0zHGZ1smVOUaE0AlOMQDfH+Vwpzjde+IZ
         4EI8Mn5CNoE2cfdgQzkACRm6y5W/dHKF/2rQvfDraCSyxaoyV29AuGF8wzBFLrrjtU
         Mhcf9BXbMVP9aEwYgBR/xsrhHli0xmRbJ4N5MsmsisGMstkwuV+eqF9nmkciju8Qzq
         y0rPZl0QRkSeA==
Date:   Wed, 5 Jan 2022 09:45:17 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        david <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH v9 01/10] dax: Use percpu rwsem for
 dax_{read,write}_lock()
Message-ID: <20220105174517.GI31606@magnolia>
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
 <20211226143439.3985960-2-ruansy.fnst@fujitsu.com>
 <CAPcyv4gkxuFRGh57nYrpS8mXo+5j-7=KGNn-gULgLGthZQPo2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gkxuFRGh57nYrpS8mXo+5j-7=KGNn-gULgLGthZQPo2g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 04, 2022 at 02:44:08PM -0800, Dan Williams wrote:
> On Sun, Dec 26, 2021 at 6:35 AM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
> >
> > In order to introduce dax holder registration, we need a write lock for
> > dax.
> 
> As far as I can see, no, a write lock is not needed while the holder
> is being registered.
> 
> The synchronization that is needed is to make sure that the device
> stays live over the registration event, and that any in-flight holder
> operations are flushed before the device transitions from live to
> dead, and that in turn relates to the live state of the pgmap.
> 
> The dax device cannot switch from live to dead without first flushing
> all readers, so holding dax_read_lock() over the register holder event
> should be sufficient.

...and perhaps add a comment describing that this is what the
synchronization primitive is really protecting against?  The first time
I read through this patchset, I assumed the rwsem was protecting
&dax_hosts and was confused when I saw the one use of dax_write_lock.

--D

> If you are worried about 2 or more potential
> holders colliding at registration time, I would expect that's already
> prevented by block device exclusive holder synchronization, but you
> could also use cmpxchg and a single pointer to a 'struct dax_holder {
> void *holder_data, struct dax_holder_operations *holder_ops }'. If you
> are worried about memory_failure triggering while the filesystem is
> shutting down it can do a synchronize_srcu(&dax_srcu) if it really
> needs to ensure that the notify path is idle after removing the holder
> registration.
> 
> ...are there any cases remaining not covered by the above suggestions?
