Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6DC58F530
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 02:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiHKAUV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 20:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiHKAUU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 20:20:20 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D68F205E8;
        Wed, 10 Aug 2022 17:20:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-193-158.pa.nsw.optusnet.com.au [49.181.193.158])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 6DC6E62D0D5;
        Thu, 11 Aug 2022 10:20:16 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oLvvo-00BcxQ-Q8; Thu, 11 Aug 2022 10:20:12 +1000
Date:   Thu, 11 Aug 2022 10:20:12 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com
Subject: Re: [PATCH 04/14] xfs: document the user interface for online fsck
Message-ID: <20220811002012.GO3600936@dread.disaster.area>
References: <165989700514.2495930.13997256907290563223.stgit@magnolia>
 <165989702796.2495930.11103527352292676325.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165989702796.2495930.11103527352292676325.stgit@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62f44b40
        a=SeswVvpAPK2RnNNwqI8AaA==:117 a=SeswVvpAPK2RnNNwqI8AaA==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=VwQbUJbxAAAA:8 a=oZbWWg3rAAAA:8
        a=7-415B0cAAAA:8 a=XFyyN51A-Zj4oIqpTBoA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=JYnrc9oPTx9ts3FRaIb5:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 07, 2022 at 11:30:28AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Start the fourth chapter of the online fsck design documentation, which
> discusses the user interface and the background scrubbing service.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  .../filesystems/xfs-online-fsck-design.rst         |  114 ++++++++++++++++++++
>  1 file changed, 114 insertions(+)
> 
> 
> diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
> index d630b6bdbe4a..42e82971e036 100644
> --- a/Documentation/filesystems/xfs-online-fsck-design.rst
> +++ b/Documentation/filesystems/xfs-online-fsck-design.rst
> @@ -750,3 +750,117 @@ Proposed patchsets include `general stress testing
>  <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=race-scrub-and-mount-state-changes>`_
>  and the `evolution of existing per-function stress testing
>  <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=refactor-scrub-stress>`_.
> +
> +4. User Interface
> +=================
> +
> +The primary user of online fsck is the system administrator, just like offline
> +repair.
> +Online fsck presents two modes of operation to administrators:
> +A foreground CLI process for online fsck on demand, and a background service
> +that performs autonomous checking and repair.
> +
> +Checking on Demand
> +------------------
> +
> +For administrators who want the absolute freshest information about the
> +metadata in a filesystem, ``xfs_scrub`` can be run as a foreground process on
> +a command line.
> +The program checks every piece of metadata in the filesystem while the
> +administrator waits for the results to be reported, just like the existing
> +``xfs_repair`` tool.
> +Both tools share a ``-n`` option to perform a read-only scan, and a ``-v``
> +option to increase the verbosity of the information reported.
> +
> +A new feature of ``xfs_scrub`` is the ``-x`` option, which employs the error
> +correction capabilities of the hardware to check data file contents.
> +The media scan is not enabled by default because it may dramatically increase
> +program runtime and consume a lot of bandwidth on older storage hardware.

So '-x' runs a media scrub command? What does that do with software
RAID? Does that trigger parity checks of the RAID volume, or pass
through to the underlying hardware to do physical media scrub? Or
maybe both?

Rewriting the paragraph to be focussed around the functionality
being provided (i.e "media scrubbing is a new feature of xfs_scrub.
It provides .....")

> +The output of a foreground invocation is captured in the system log.

At what log level?

> +The ``xfs_scrub_all`` program walks the list of mounted filesystems and
> +initiates ``xfs_scrub`` for each of them in parallel.
> +It serializes scans for any filesystems that resolve to the same top level
> +kernel block device to prevent resource overconsumption.

Is this serialisation necessary for non-HDD devices?

> +Background Service
> +------------------
> +
> +To reduce the workload of system administrators, the ``xfs_scrub`` package
> +provides a suite of `systemd <https://systemd.io/>`_ timers and services that
> +run online fsck automatically on weekends.

Weekends change depending on where you are in the world, right? So
maybe this should be more explicit?

[....]

> +**Question**: Should the health reporting integrate with the new inotify fs
> +error notification system?

Can the new inotify fs error notification system report complex
health information structures? How much pain is involved in making
it do what we want, considering we already have a health reporting
ioctl that can be polled?

> +**Question**: Would it be helpful for sysadmins to have a daemon to listen for
> +corruption notifications and initiate a repair?

Seems like an obvious extension to the online repair capability.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
