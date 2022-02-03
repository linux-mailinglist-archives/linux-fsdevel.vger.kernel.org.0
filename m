Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74694A8CFF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 21:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353953AbiBCULQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 15:11:16 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54350 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiBCULQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:11:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC127619EB;
        Thu,  3 Feb 2022 20:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F600C340E8;
        Thu,  3 Feb 2022 20:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643919075;
        bh=4BSXxY3IonSFV0/jTnsSKEp9cBSpVvVKAZx5Z73OKBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a1sA23OOTGBzQUsW0WgiQ1AgpsibE0HLS/PRC17y19bQAlaqYDCzSp8gHd/CCb/D6
         nX0UBLUb9gsYhH7R/b5IMiCzWNsapQCa2rVGJtWNVtojtGetuRJo/PHomVV1S8tV2K
         h+aOdjUh9/3aprBno5KlhAn9F0HYgBxtCjPFP9vVllDAesYm+asCe4WhOq1YPDRzkW
         HD1GNrEQ5qlNdJUlNdQc4KVj4wDO2d0+g5rbQQC3TURttI83Z5bTUIDGO99lQEog/9
         8dPLuF5/MxdZhpFyDKG3uqSlCmSm1WEblCRut/gyqaLZdp8t63tzKxnmubDgkc01yv
         REvLg1kFMBKiA==
Date:   Thu, 3 Feb 2022 12:11:12 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] block: add copy offload support
Message-ID: <20220203201112.GC142129@dhcp-10-100-145-180.wdc.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011331570.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <efd2e976-4d2d-178e-890d-9bde1a89c47f@acm.org>
 <alpine.LRH.2.02.2202031310530.28604@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2202031310530.28604@file01.intranet.prod.int.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 03, 2022 at 01:50:06PM -0500, Mikulas Patocka wrote:
> On Tue, 1 Feb 2022, Bart Van Assche wrote:
> > Only supporting copying between contiguous LBA ranges seems restrictive to me.
> > I expect garbage collection by filesystems for UFS devices to perform better
> > if multiple LBA ranges are submitted as a single SCSI XCOPY command.
> 
> NVMe has a possibility to copy multiple source ranges into one destination 
> range. But I think that leveraging this capability would just make the 
> code excessively complex.

The point is to defrag discontiguous blocks into a single range. The
capability loses a major value proposition without multiple sources.
