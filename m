Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87666745CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 23:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjASWVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 17:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjASWUp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:20:45 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3C56A40;
        Thu, 19 Jan 2023 14:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p9Z+Yh5j2hHRnI1dTcIkipPU5fNAxSSsh4y2kn8Gq5A=; b=aNssFuNpx0WmIbJlX5P0hvebXE
        nccag5OkWX4/UsWrQTfQ0KYWgsChCf2ZU2kxBZihsIixWpGLFxGfah7boyRB5ladtE9B2qJeoHpMY
        YS/aFgivlkTa1HHPn9sSAJBze726rX1o/kmYazk2HU9OtWLZNjkSkOisVPBAAhY/Qa7WoD7QrSuVl
        +H2eOrM02hbt8DPHFkhGcPGOuMeSK8BXgofuNuCLr9Zge0XrbEjkgo5G5PC1rO9pk0aWBp2vjhsl0
        YisrO0TY6+3sgIgKTA6xLpW9vJ9h8VzM+cNMKfkPhMqU8EFAmFTSPdIv6L8jT94gVcThmOzydGHsA
        0oxri4Nw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pId0N-002smJ-0r;
        Thu, 19 Jan 2023 22:03:31 +0000
Date:   Thu, 19 Jan 2023 22:03:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Chanudet <echanude@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [RFC PATCH 1/1] fs/namespace: defer free_mount from
 namespace_unlock
Message-ID: <Y8m+M/ffIEEWbfmv@ZenIV>
References: <20230119205521.497401-1-echanude@redhat.com>
 <20230119205521.497401-2-echanude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119205521.497401-2-echanude@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 19, 2023 at 03:55:21PM -0500, Eric Chanudet wrote:
> From: Alexander Larsson <alexl@redhat.com>
> 
> Use call_rcu to defer releasing the umount'ed or detached filesystem
> when calling namepsace_unlock().
> 
> Calling synchronize_rcu_expedited() has a significant cost on RT kernel
> that default to rcupdate.rcu_normal_after_boot=1.
> 
> For example, on a 6.2-rt1 kernel:
> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
>            0.07464 +- 0.00396 seconds time elapsed  ( +-  5.31% )
> 
> With this change applied:
> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
>         0.00162604 +- 0.00000637 seconds time elapsed  ( +-  0.39% )
> 
> Waiting for the grace period before completing the syscall does not seem
> mandatory. The struct mount umount'ed are queued up for release in a
> separate list and no longer accessible to following syscalls.

You *really* do not want to have umount(2) return without having
the filesystems shut down.
