Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33C27AD36A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 10:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjIYIcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 04:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjIYIcR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:32:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E4ABF
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 01:32:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D6FDF1F855;
        Mon, 25 Sep 2023 08:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695630728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cECgfHYcd30ExPyLRB7tcaTke5RApGY6WN8sskXDOBU=;
        b=syuvxSLayCLsSHddvP+tyoAUd8QH/3eVOKtK2dAFVG5oFAYC8ok4IhS9m97Pa1phYwg8Ey
        N27SdWUmkoaKjykYi2E6CO0h0mAYxYZ1eukevfl/PMo6fb6Ik5RfIDZN5GUxbt/TUvoFMb
        PX022kGguN0lCcnycRF/P1kcy7Q4vwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695630728;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cECgfHYcd30ExPyLRB7tcaTke5RApGY6WN8sskXDOBU=;
        b=vJOBkYs/xVoRHe/9Ga/wyLXey0bm8wSMMhXTFH9Wqxaq1HeZE/DxjJlSx6Nzl8DslC+I3r
        IujK+daF8TakNbDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFB3E13A67;
        Mon, 25 Sep 2023 08:32:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5z6oLYhFEWXkYAAAMHmgww
        (envelope-from <chrubis@suse.cz>); Mon, 25 Sep 2023 08:32:08 +0000
Date:   Mon, 25 Sep 2023 10:32:50 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Reuben Hawkins <reubenhwk@gmail.com>, amir73il@gmail.com,
        mszeredi@redhat.com, brauner@kernel.org, lkp@intel.com,
        linux-fsdevel@vger.kernel.org, oliver.sang@intel.com,
        viro@zeniv.linux.org.uk, oe-lkp@lists.linux.dev,
        ltp@lists.linux.it, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3] vfs: fix readahead(2) on block devices
Message-ID: <ZRFFsrgJ9tZQt1Hs@yuki>
References: <20230924050846.2263-1-reubenhwk@gmail.com>
 <ZQ/hGr+o61X1mik9@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQ/hGr+o61X1mik9@casper.infradead.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!
> I realise we could add new test cases _basically_ forever, but I'd like
> to see a little more coverage in test_invalid_fd().  It currently tests
> both pipes and sockets, but we have so many more fd types.  Maybe there
> are good abstractions inside LTP already for creating these?  I'd
> like to see tests that the following also return -EINVAL:
> 
>  - an io_uring fd
>  - /dev/zero
>  - /proc/self/maps (or something else in /proc we can get unprivileged
>    access to)
>  - a directory (debatable!  maybe we should allow prefetching a
>    directory!)

This sounds like a good idea. We do have an API to iterate over
filesystems but not API to iterate over file descriptors, I suppose that
we will need an enum with fd type passed along with the file descriptor
so that we can set the expectations right and then just define a
function that would take the structure and do the test, something as:

enum tst_fd_type {
	TST_FD_IO_URING,
	TST_FD_DEV_ZERO,
	TST_FD_PROC_MAPS,
	...
};

struct tst_fd {
	enum tst_fd_type type;
	int fd;
};

static void test_fd(struct tst_fd *fd)
{
	if (fd->type == TST_FD...)
		TST_EXP_PASS(...);
	else
		TST_EXP_FAIL(...);
}

I can add something like this once we are done with the September LTP
release.

-- 
Cyril Hrubis
chrubis@suse.cz
