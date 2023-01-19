Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7296745E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 23:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjASWY0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 17:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjASWWV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:22:21 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AB8A296E;
        Thu, 19 Jan 2023 14:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NodXgtT7Kqm2OHK9ftwL2Mer6438JWDOA3fsrOWeDMs=; b=VfQbLyZtTR+ngazAn2uCPKHbHP
        pa5/VdIHtAjvfUMyVVlck+P/0NM5Ypm2XplAvBwbl/263Chtw6NRneB2iKg35KzL9nNwzDhk8P5Lt
        CBrWSsBYI0RNPPM6qztzXBD7vduW6FnD8YP/xkoKYPs0abwZGrthaBcp/9ags8nBOLQIJVZpgf2JX
        aWUgbueAnzfI6FiFObZ33mRRNVtvUTgddNPd2jG7cZIUnkmRtNhLX9J1VGs2wR910kEYtyfRnuKXK
        h0orRdlZr4jWmyk8BJP7Vm3Bf+U83Z6lb/VTj13wOntC0ReaSHA0ojR/PI7/V3AEERTTSbYcRSbUp
        Ijo/RWjA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pId66-002sor-0b;
        Thu, 19 Jan 2023 22:09:26 +0000
Date:   Thu, 19 Jan 2023 22:09:26 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Chanudet <echanude@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [RFC PATCH RESEND 1/1] fs/namespace: defer free_mount from
 namespace_unlock
Message-ID: <Y8m/ljQUJOefsD6O@ZenIV>
References: <20230119211455.498968-1-echanude@redhat.com>
 <20230119211455.498968-2-echanude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119211455.498968-2-echanude@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 19, 2023 at 04:14:55PM -0500, Eric Chanudet wrote:
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

Again, NAK.  If a filesystem is expected to be shut down by umount(2),
userland expects it to have been already shut down by the time the
syscall returns.

It's not just visibility in namespace; it's "can I pull the disk out?".
Or "can the shutdown get to taking the network down?", for that matter.
