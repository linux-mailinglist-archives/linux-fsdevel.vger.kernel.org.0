Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C9D320E9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 00:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhBUXxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Feb 2021 18:53:36 -0500
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:38331 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229918AbhBUXxf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Feb 2021 18:53:35 -0500
Received: from dread.disaster.area (pa49-179-130-210.pa.nsw.optusnet.com.au [49.179.130.210])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 7E7221ADB51;
        Mon, 22 Feb 2021 10:52:49 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lDyWu-00Fq01-QV; Mon, 22 Feb 2021 10:52:48 +1100
Date:   Mon, 22 Feb 2021 10:52:48 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     SelvaKumar S <selvakuma.s1@samsung.com>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
        damien.lemoal@wdc.com, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, snitzer@redhat.com, selvajove@gmail.com,
        joshiiitr@gmail.com, nj.shetty@samsung.com, joshi.k@samsung.com,
        javier.gonz@samsung.com, kch@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
Message-ID: <20210221235248.GZ4626@dread.disaster.area>
References: <CGME20210219124555epcas5p1334e7c4d64ada5dc4a2ca0feb48c1d44@epcas5p1.samsung.com>
 <20210219124517.79359-1-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219124517.79359-1-selvakuma.s1@samsung.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=JD06eNgDs9tuHP7JIKoLzw==:117 a=JD06eNgDs9tuHP7JIKoLzw==:17
        a=kj9zAlcOel0A:10 a=qa6Q16uM49sA:10 a=pNaSbsGRAAAA:8 a=7-415B0cAAAA:8
        a=bdcsEvdjF_AAMq5uHxAA:9 a=CjuIK1q_8ugA:10 a=k8uaQqolKd8A:10
        a=cz0TccRYsqG1oLvFGeGV:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 19, 2021 at 06:15:13PM +0530, SelvaKumar S wrote:
> This patchset tries to add support for TP4065a ("Simple Copy Command"),
> v2020.05.04 ("Ratified")
> 
> The Specification can be found in following link.
> https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
> 
> Simple copy command is a copy offloading operation and is  used to copy
> multiple contiguous ranges (source_ranges) of LBA's to a single destination
> LBA within the device reducing traffic between host and device.
> 
> This implementation doesn't add native copy offload support for stacked
> devices rather copy offload is done through emulation. Possible use
> cases are F2FS gc and BTRFS relocation/balance.

It sounds like you are missing the most obvious use case for this:
hooking up filesystem copy_file_range() implementations to allow
userspace to offload user data copies to hardware....

Another fs level feature that could use this for hardware
acceleration fallocate(FALLOC_FL_UNSHARE).

These are probably going to be far easier to hook up than filesystem
GC algorithms, and there is also solid data integrity and stress
testing checking infrastructure for these operations via fstests.

> As SCSI XCOPY can take two different block devices and no of source range is
> equal to 1, this interface can be extended in future to support SCSI XCOPY.

That greatly complicates the implementation. do we even care at this
point about cross-device XCOPY at this point?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
