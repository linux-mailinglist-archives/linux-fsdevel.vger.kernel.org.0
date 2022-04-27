Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DC0512431
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 23:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiD0VFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 17:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiD0VFN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:05:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DAD2A722
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 14:02:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 395FE210EC;
        Wed, 27 Apr 2022 21:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651093319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pE9jydTZqt+YFiXAUPwL+X+CFjg0h6p0CmW8RUl4YAI=;
        b=PrxrvleqwkkcK0Tq7EpI0uMXGRx6RrSpWKh+ySRxASXS8y96D3hvz3IB6BbBOZCkJ8RA9H
        U05YqLHbnpqw41iuSQZtZPtg5Ra1PnsjOAHV1Jv+bD+XYhaDDOkRLUu7uA3k4FPeP87W/O
        Dw1fkuHFAIP5DjC/aVg6OASx5cWxG/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651093319;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pE9jydTZqt+YFiXAUPwL+X+CFjg0h6p0CmW8RUl4YAI=;
        b=wsRqNicyDDGSVtgo6b/pEVr8e38eegLCX8/pSgFSErxzcMdFbvc/MbValzXFwcmJg0XD4K
        c4dweuMcRPMy7VDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1479513A39;
        Wed, 27 Apr 2022 21:01:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P2/eA0evaWJLEQAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 27 Apr 2022 21:01:59 +0000
Date:   Wed, 27 Apr 2022 23:01:58 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        willy@infradead.org, Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH v7 3/6] initramfs: add INITRAMFS_PRESERVE_MTIME Kconfig
 option
Message-ID: <20220427230158.009e6b5f@suse.de>
In-Reply-To: <20220426133908.f779a181a11afc4ba56508d9@linux-foundation.org>
References: <20220404093429.27570-1-ddiss@suse.de>
        <20220404093429.27570-4-ddiss@suse.de>
        <20220426133908.f779a181a11afc4ba56508d9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 26 Apr 2022 13:39:08 -0700, Andrew Morton wrote:

> On Mon,  4 Apr 2022 11:34:27 +0200 David Disseldorp <ddiss@suse.de> wrote:
> 
> > initramfs cpio mtime preservation, as implemented in commit 889d51a10712
> > ("initramfs: add option to preserve mtime from initramfs cpio images"),
> > uses a linked list to defer directory mtime processing until after all
> > other items in the cpio archive have been processed. This is done to
> > ensure that parent directory mtimes aren't overwritten via subsequent
> > child creation.
> > 
> > The lkml link below indicates that the mtime retention use case was for
> > embedded devices with applications running exclusively out of initramfs,
> > where the 32-bit mtime value provided a rough file version identifier.
> > Linux distributions which discard an extracted initramfs immediately
> > after the root filesystem has been mounted may want to avoid the
> > unnecessary overhead.
> > 
> > This change adds a new INITRAMFS_PRESERVE_MTIME Kconfig option, which
> > can be used to disable on-by-default mtime retention and in turn
> > speed up initramfs extraction, particularly for cpio archives with large
> > directory counts.
> > 
> > Benchmarks with a one million directory cpio archive extracted 20 times
> > demonstrated:
> > 				mean extraction time (s)	std dev
> > INITRAMFS_PRESERVE_MTIME=y		3.808			 0.006
> > INITRAMFS_PRESERVE_MTIME unset		3.056			 0.004  
> 
> So about 35 nsec per directory?

~750 nsec - I should have clarified that the "20" refers to the number
of runs over which the "mean extraction time" is averaged.

> By how much is this likely to reduce boot time in a real-world situation?

Not much, although my xfstests initramfs images tend to get into the
hundreds of directories. These numbers were captured using QEMU/kvm on
my laptop - I could rerun the benchmark on an old ARM SBC if more data
points are needed.

Cheers, David
