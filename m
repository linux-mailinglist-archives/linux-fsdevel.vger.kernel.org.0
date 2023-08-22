Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39093783963
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 07:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjHVFf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 01:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjHVFf2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 01:35:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FB7130;
        Mon, 21 Aug 2023 22:35:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3167760FB4;
        Tue, 22 Aug 2023 05:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2C2C433C7;
        Tue, 22 Aug 2023 05:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692682525;
        bh=0u/LkEF9xPWwwH+3zJUBHtJDhlV+bd1HJH3ZyM1DhmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ER1fmT70yZigtpkEHWQJqqxLOMrz2g+erN497tQb8M/hxgSDzP2CJwIthBDZBl69V
         iFJbfNI13y5ZaSESFGIWN7SBBC6wegrDL3LUQnK0+fykkh3IfRklKofNjquu5OsOyT
         NDqhX9rRRUh9MrccprWOg0r3jMXKrAfJNcqX8cjSdIHgOon86xFTEAyo079I7V2rQM
         BAEz2hlf629zmqVQ1sH5NAwBHnlg7SYtwSWZLJH12gToUoXy8oIJWoMfqtm+6vD197
         wY89pESyG9DlLy2c3ZexV6JSqDXDN4l9ruSiBSIcqWJvk4FMExHckh6N5vk99Z2aAy
         qunFy7v4nNbTw==
Date:   Mon, 21 Aug 2023 22:35:23 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 1/6] block: Add config option to not allow writing to
 mounted devices
Message-ID: <20230822053523.GA8949@sol.localdomain>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704125702.23180-1-jack@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

On Tue, Jul 04, 2023 at 02:56:49PM +0200, Jan Kara wrote:
> Writing to mounted devices is dangerous and can lead to filesystem
> corruption as well as crashes. Furthermore syzbot comes with more and
> more involved examples how to corrupt block device under a mounted
> filesystem leading to kernel crashes and reports we can do nothing
> about. Add tracking of writers to each block device and a kernel cmdline
> argument which controls whether writes to block devices open with
> BLK_OPEN_BLOCK_WRITES flag are allowed. We will make filesystems use
> this flag for used devices.
> 
> Syzbot can use this cmdline argument option to avoid uninteresting
> crashes. Also users whose userspace setup does not need writing to
> mounted block devices can set this option for hardening.
> 
> Link: https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org
> Signed-off-by: Jan Kara <jack@suse.cz>

Can you make it clear that the important thing this patch prevents is writes to
the block device's buffer cache, not writes to the underlying storage?  It's
super important not to confuse the two cases.

Related to this topic, I wonder if there is any value in providing an option
that would allow O_DIRECT writes but forbid buffered writes?  Would that be
useful for any of the known use cases for writing to mounted block devices?

- Eric
