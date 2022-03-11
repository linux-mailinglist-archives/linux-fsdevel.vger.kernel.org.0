Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B5E4D56F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 01:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241590AbiCKAuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 19:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiCKAuJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:50:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCB29FD8;
        Thu, 10 Mar 2022 16:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uYxZAHznPxDG69YtW4XG3s2UEng8dpthSKX9JFM/ivc=; b=ZlVKtnf+J5/YwrXwdNuICI62se
        qH5Gfx3oATvhaCOjrwBT9IbXBrAraUC/RerntzJmGBfq+SLwhs4C8V7Xa3ofgWYBqeLOV9AgNiCYw
        o+QfAvYXr0GG4I+mNuebILfVMzbRoJ6fxOohrXZ8uTVDNkfbHFkpf/BjxDhQUO/M+q6AnYDItsp2e
        5iOIRPfYwx89fxwYmAy52zg6cPAceGRLfT4e87fAVz8sSXyKGj04zNYEMXmp7rLSCYOYgXmymX/kV
        bhrDK/BLcldvM+L4/c3+//EOFb6MLNkDn50FwVz1KwnKCNFEBSXPqqupSVuBD4fLwUL1oS7jpooy5
        jFCzvwYA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSTSs-00ERZL-SG; Fri, 11 Mar 2022 00:49:06 +0000
Date:   Thu, 10 Mar 2022 16:49:06 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Message-ID: <Yiqcgi7G7ZrEbPHV@bombadil.infradead.org>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <20220304001022.GJ3927073@dread.disaster.area>
 <YiKOQM+HMZXnArKT@bombadil.infradead.org>
 <20220304224257.GN3927073@dread.disaster.area>
 <YiKY6pMczvRuEovI@bombadil.infradead.org>
 <20220305073321.5apdknpmctcvo3qj@ArmHalley.localdomain>
 <20220307071229.GR3927073@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307071229.GR3927073@dread.disaster.area>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 07, 2022 at 06:12:29PM +1100, Dave Chinner wrote:
> The generic interface that the kernel provides for zoned storage is
> called ZoneFS. Forget about the fact it is a filesystem, all it
> does is provide userspace with a named zone abstraction for a zoned
> device: every zone is an append-only file.

We seem to be reaching consensus on a path forward to use ZoneFS for
raw access.

> > My point is that there is space for both ZoneFS and raw zoned block
> > device. And regarding !PO2 zone sizes, my point is that this can be
> > leveraged both by btrfs and this raw zone block device.
> 
> On that I disagree - any argument that starts with "we need raw
> zoned block device access to ...." is starting from an invalid
> premise.

This seems reasonable given the possibility to bring folks forward
with ZoneFS.

> We should be hiding hardware quirks from userspace, not
> exposing them further.

ZoneFS requires a block device and such block device cannot be exposed
if the zone size != PO2. So sadly ZoneFS cannot be used by !PO2 ZNS
drives.

> IMO, we want writing zone storage native applications to be simple
> and approachable by anyone who knows how to write to append-only
> files.  We do not want such applications to be limited to people who
> have deep and rare expertise in the dark details of, say, largely
> undocumented niche NVMe ZNS specification and protocol quirks.
>
> ZoneFS provides us with a path to the former, what you are
> advocating is the latter....

That surely simplifies things if we can use ZoneFS!

Some filesystems who want to support zone storage natively have been
extended to do things to help with these quirks. My concerns were the
divergence on approaches to how filesystems use ZNS as well. Do you have
any plans to consider such efforts for XFS or would you rather build on
ZoneFS somehow?

  Luis
