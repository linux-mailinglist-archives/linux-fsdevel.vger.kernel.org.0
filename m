Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475F82C4B65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 00:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgKYXTx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 18:19:53 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:55928 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbgKYXTx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 18:19:53 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2020 18:19:51 EST
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E8872625DE19;
        Thu, 26 Nov 2020 00:13:45 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3D5H4cUW0l9S; Thu, 26 Nov 2020 00:13:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7ADB5608311C;
        Thu, 26 Nov 2020 00:13:45 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C_ZoIjg1vfYi; Thu, 26 Nov 2020 00:13:45 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4F817625DE19;
        Thu, 26 Nov 2020 00:13:45 +0100 (CET)
Date:   Thu, 26 Nov 2020 00:13:45 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <728548959.34116.1606346025135.JavaMail.zimbra@nod.at>
In-Reply-To: <20201119141659.26176-1-richard@nod.at>
References: <20201119141659.26176-1-richard@nod.at>
Subject: Re: [PATCH 0/5] [RFC] MUSE: Userspace backed MTD
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: MUSE: Userspace backed MTD
Thread-Index: S9/hp4kqudiaTtGCb/4FWtfAvw5CXg==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> When working with flash devices a common task is emulating them to run various
> tests or inspect dumps from real hardware. To achieve that we have plenty of
> emulators in the mtd subsystem: mtdram, block2mtd, nandsim.
> 
> Each of them implements a adhoc MTD and have various drawbacks.
> Over the last years some developers tried to extend them but these attempts
> often got rejected because they added just more adhoc feature instead of
> addressing overall problems.
> 
> MUSE is a novel approach to address the need of advanced MTD emulators.
> Advanced means in this context supporting different (vendor specific) image
> formats, different ways for fault injection (fuzzing) and recoding/replaying
> IOs to emulate power cuts.
> 
> The core goal of MUSE is having the complexity on the userspace side and
> only a small MTD driver in kernelspace.
> While playing with different approaches I realized that FUSE offers everything
> we need. So MUSE is a little like CUSE except that it does not implement a
> bare character device but an MTD.
> 
> To get early feedback I'm sending this series as RFC, so don't consider it as
> ready to merge yet.
> 
> Open issues are:
> 
> 1. Dummy file object
> The logic around fuse_direct_io() expects a file object.
> Unlike FUSE or CUSE we don't have such an object in MUSE because usually an
> MTD is not opened by userspace. The kernel uses the MTD and makes it available
> to filesystems or other layers such as mtdblock, mtdchar or UBI.
> Currently a anon inode is (ab)used for that.
> Maybe there is a better way?

FYI, I'll send an updated series soon. I rewrote the MUSE IO path to not use fuse_direct_io()
which made things much simpler and all hacks go away.

Thanks,
//richard
