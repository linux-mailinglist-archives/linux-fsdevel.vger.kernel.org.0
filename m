Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27A4356DF2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 15:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241481AbhDGN5P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 09:57:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:42460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231180AbhDGN5O (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:57:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617803824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pwO1DsR3SPZxNfUe3od4dUeQ81IfvuFB83507+tgJSo=;
        b=TqfScE0QVTZ5+ZdbtUGTHTiCO8/jJyFNR70Jx7Fe3iPxfmCROuP6POiD3jZspSl0W0Lzh6
        uSTtT5AACi1E9QVY0iN5M2dUxkQApYMzlnLoTl04PRsZpqsJveetcL5fEcuchi7qtXGqvj
        cWiWcJ4pKHXEOmzZvYwWtld0qfaasPM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EA95CAE6D;
        Wed,  7 Apr 2021 13:57:03 +0000 (UTC)
Date:   Wed, 7 Apr 2021 15:57:02 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Bharata B Rao <bharata@linux.ibm.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
Message-ID: <YG26LlJJTuZ5UrJ5@dhcp22.suse.cz>
References: <20210405054848.GA1077931@in.ibm.com>
 <YG2diKMPNSK2cMyG@dhcp22.suse.cz>
 <20210407134342.GA1386511@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407134342.GA1386511@in.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 07-04-21 19:13:42, Bharata B Rao wrote:
> On Wed, Apr 07, 2021 at 01:54:48PM +0200, Michal Hocko wrote:
> > On Mon 05-04-21 11:18:48, Bharata B Rao wrote:
> > > Hi,
> > > 
> > > When running 10000 (more-or-less-empty-)containers on a bare-metal Power9
> > > server(160 CPUs, 2 NUMA nodes, 256G memory), it is seen that memory
> > > consumption increases quite a lot (around 172G) when the containers are
> > > running. Most of it comes from slab (149G) and within slab, the majority of
> > > it comes from kmalloc-32 cache (102G)
> > 
> > Is this 10k cgroups a testing enviroment or does anybody really use that
> > in production? I would be really curious to hear how that behaves when
> > those containers are not idle. E.g. global memory reclaim iterating over
> > 10k memcgs will likely be very visible. I do remember playing with
> > similar setups few years back and the overhead was very high.
> 
> This 10k containers is only a test scenario that we are looking at.

OK, this is good to know. I would definitely recommend looking at the
runtime aspect of such a large scale deployment before optimizing for
memory footprint. I do agree that the later is an interesting topic on
its own but I do not expect such a deployment on small machines so the
overhead shouldn't be a showstopper. I would be definitely interested
to hear about the runtime overhead. I do expect some interesting
finidings there.

Btw. I do expect that memory controller will not be the only one
deployed right?

-- 
Michal Hocko
SUSE Labs
