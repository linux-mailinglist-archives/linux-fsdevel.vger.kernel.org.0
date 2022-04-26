Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9237B510AAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 22:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355079AbiDZUm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 16:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355103AbiDZUmU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:42:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E394811A9
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 13:39:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2831161483
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 20:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56568C385A4;
        Tue, 26 Apr 2022 20:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651005551;
        bh=Dx1zuvbsWFXqpIq3ojTzJUYRp4bT7OQx1zRNqiAG0oQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ARpCW18UD/aK3I84vLQDP2L94WMT9nnVOkav1IF2Yk5+oHYB16yy1rNBzqBip5puh
         vl+mWq3tg3M4ous2e4ry86Jscmkb4XLf/sDrxR/q45U+38Zt0GQGwM446yZNhWPu3F
         DWFS0hT1NWDpoYS9Bgo7iCnCIvXXE4OOn44FBbik=
Date:   Tue, 26 Apr 2022 13:39:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        willy@infradead.org, Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH v7 3/6] initramfs: add INITRAMFS_PRESERVE_MTIME Kconfig
 option
Message-Id: <20220426133908.f779a181a11afc4ba56508d9@linux-foundation.org>
In-Reply-To: <20220404093429.27570-4-ddiss@suse.de>
References: <20220404093429.27570-1-ddiss@suse.de>
        <20220404093429.27570-4-ddiss@suse.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon,  4 Apr 2022 11:34:27 +0200 David Disseldorp <ddiss@suse.de> wrote:

> initramfs cpio mtime preservation, as implemented in commit 889d51a10712
> ("initramfs: add option to preserve mtime from initramfs cpio images"),
> uses a linked list to defer directory mtime processing until after all
> other items in the cpio archive have been processed. This is done to
> ensure that parent directory mtimes aren't overwritten via subsequent
> child creation.
> 
> The lkml link below indicates that the mtime retention use case was for
> embedded devices with applications running exclusively out of initramfs,
> where the 32-bit mtime value provided a rough file version identifier.
> Linux distributions which discard an extracted initramfs immediately
> after the root filesystem has been mounted may want to avoid the
> unnecessary overhead.
> 
> This change adds a new INITRAMFS_PRESERVE_MTIME Kconfig option, which
> can be used to disable on-by-default mtime retention and in turn
> speed up initramfs extraction, particularly for cpio archives with large
> directory counts.
> 
> Benchmarks with a one million directory cpio archive extracted 20 times
> demonstrated:
> 				mean extraction time (s)	std dev
> INITRAMFS_PRESERVE_MTIME=y		3.808			 0.006
> INITRAMFS_PRESERVE_MTIME unset		3.056			 0.004

So about 35 nsec per directory?

By how much is this likely to reduce boot time in a real-world situation?


