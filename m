Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32C12E9E12
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 20:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbhADTZ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 14:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbhADTZ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 14:25:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3DAC061574;
        Mon,  4 Jan 2021 11:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C2RfFgyTIUJ3qaGRExBOoKJAnx9XXnZ037V3ZlmcCCM=; b=QFlpUWpivLWqWvpuL2I15PLMxw
        7nKICxUmiDcc00C2MhIGr+Io/a4yw/4C1kO4jAlrEeZReOPBLuXbloTDymSbT28RVrGBGEYLNJjw/
        ZvVKzF3PIKsLntlBY5E7RvtrqOplF4d7sOCPPPy3EEH38km77z2moOurhk8V2UK4MQwKTbv89A7zk
        9cJpReS46bwYG1cmQUVR4pQrQcGDMKBO+nR1touznhxH9nFzrWv4afWfoKGI7Be8qi2sgAocuFoqV
        fWls+Y2vl/0te40B94CZO2pnFLLvaRJ6zwR1CEBZaBcNzbmoMNbFVJHx4nJKSswxKBPhTDNKw7XDp
        wm86HhVA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kwVSz-000Sri-7A; Mon, 04 Jan 2021 19:24:35 +0000
Date:   Mon, 4 Jan 2021 19:24:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andres Freund <andres@anarazel.de>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: fallocate(FALLOC_FL_ZERO_RANGE_BUT_REALLY) to avoid unwritten
 extents?
Message-ID: <20210104192433.GC22407@casper.infradead.org>
References: <20201230062819.yinrrp6uwfegsqo3@alap3.anarazel.de>
 <X/NpsZ8tSPkCwsYE@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/NpsZ8tSPkCwsYE@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 04, 2021 at 02:17:05PM -0500, Theodore Ts'o wrote:
> One thing to note is that there are some devices which support a write
> zeros operation, but where it is *less* performant than actually
> writing zeros via DMA'ing zero pages.  Yes, that's insane.
> Unfortunately, there are a insane devices out there....

We already have quirks to disable commands, in NVMe, SCSI and ATA.
This sounds like another quirk to throw on the bonfire ("Yes, this
device claims to support Write Zeroes, but don't use it").  Indeed,
NVMe already has precisely this quirk, NVME_QUIRK_DISABLE_WRITE_ZEROES.
