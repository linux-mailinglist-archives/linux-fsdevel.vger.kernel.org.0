Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C054C8430
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 07:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiCAGfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 01:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiCAGfY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:35:24 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE0111C2B
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 22:34:43 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2216YdmG020774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Mar 2022 01:34:40 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 745B815C0038; Tue,  1 Mar 2022 01:34:39 -0500 (EST)
Date:   Tue, 1 Mar 2022 01:34:39 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Changing file system resize patterns
Message-ID: <Yh2+f2n9wvJjeWH4@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Traditionally, most file systems resize features were used to grow the
file system in relatively large chunks --- for example, when a 10 TB
disk is added to a RAID array.  However, cloud and embedded deployment
use case has changed this.

One such new anti-pattern is an initial root file system which is
relatively small (a few GB) and then it is "inflated" by resizing it
to a very large size, by a thousand times or more in some cases.  This
is not unique to the cloud, although it is quite common there.
(Another place where this anti-pattern is used is in some embedded
systems, where an image is dd'ed onto flash, and then expanded by
resizing the file system the first time the system is booted.)

A second anti-pattern is caused by the fact that most clouds charge
for the bytes that are provisioned for the emulated block device, as
opposed to the amount of space that is actually used (if the block
device was using something like a thin-provisioning scheme, as I
suspect many of them do).  So to optimize costs, many customers will
only resize the file system when it is 99% full, and then only grow it
by a small amount each time.  Unfortunately, this tends to really bad
from file system fragmentation perspective.

For the first anti-pattern, I can think of a number of possible ways
we could mitigate the problem.  One might be to change the defaults of
mkfs so that performance won't be that bad when a tiny file system is
grown significantly (e.g., a larger journal, enabling 64-bit block
numbers for ext4, etc.).  Unfortunately, this would waste a lot of
space for a fixed size file system, such as one that placed on a USB
thumb drive.  So perhaps there should be some standardized way for
mkfs to determine whether the file system is one that is likely to be
grown (e.g., a GCE PD, AWS EBS, Azure Managed Disks) so it can
automatically DTRT?

Another possible solution is some kind of standardized format (perhaps
like qemu-img, but one which is documented) which can be used to
transmit a file system image which can be formated to a large
provisioned size, but which can be transmitted in a sparse, efficient
format, and then allow it to be "inflated" to full size of the block
device.

I can't think of a lot of good solutions for the first second
anti-pattern --- although if anyone has suggestions other than user
education, I'd love to hear suggestions.

Cheers,

							- Ted
