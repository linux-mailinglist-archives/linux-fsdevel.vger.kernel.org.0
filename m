Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1575621AF3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 18:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbiKHRnd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Nov 2022 12:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiKHRnb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:43:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065562669
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Nov 2022 09:43:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 49C922236D;
        Tue,  8 Nov 2022 17:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667929407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fFpkVndgvsqEYK2160brGpLwx/3cfx9Kks2Ym2V5INA=;
        b=yQSb5T9exB819XSZWj2WAnbZUNPhsysI7Dd2vjTrMHp4wh8olPc4YimZW+G0gwV0hJl3lR
        +IErioO/JXoxSgU0mxwL4hEgfNXTXqzM3YNZ2a3cxCp4Kg9RIXHL3avuGSbAsl9wNhRqe6
        Eim9/vkMPNEIR5/VKYatYLkjPrcN2UI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667929407;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fFpkVndgvsqEYK2160brGpLwx/3cfx9Kks2Ym2V5INA=;
        b=mgqxeWLbFKd6+QX7VyrqRDxOELY+pefRk9DVekG9CkBT86h0GeGVbs8OdaJ8eyoQk6NP8S
        OQt1IKwbI8h9FqCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C313139F1;
        Tue,  8 Nov 2022 17:43:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eRmsDj+VamNZJAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 08 Nov 2022 17:43:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9D874A0704; Tue,  8 Nov 2022 18:43:26 +0100 (CET)
Date:   Tue, 8 Nov 2022 18:43:26 +0100
From:   Jan Kara <jack@suse.cz>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.com>,
        Eric Sandeen <sandeen@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] [RFC] shmem: user and group quota support for tmpfs
Message-ID: <20221108174326.hkgtrt72rpkmelyq@quack3>
References: <20221108133010.75226-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108133010.75226-1-lczerner@redhat.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 08-11-22 14:30:08, Lukas Czerner wrote:
> people have been asking for quota support in tmpfs many times in the past
> mostly to avoid one malicious user, or misbehaving user/program to consume
> all of the system memory. This has been partially solved with the size
> mount option, but some problems still prevail.
> 
> One of the problems is the fact that /dev/shm is still generally unprotected
> with this and another is administration overhead of managing multiple tmpfs
> mounts and lack of more fine grained control.
> 
> Quota support can solve all these problems in a somewhat standard way
> people are already familiar with from regular file systems. It can give us
> more fine grained control over how much memory user/groups can consume.
> Additionally it can also control number of inodes and with special quota
> mount options introduced with a second patch we can set global limits
> allowing us to replace the size mount option with quota entirely.
> 
> Currently the standard userspace quota tools (quota, xfs_quota) are only
> using quotactl ioctl which is expecting a block device. I patched quota [1]
> and xfs_quota [2] to use quotactl_fd in case we want to run the tools on
> mount point directory to work nicely with tmpfs.
> 
> The implementation was tested on patched version of xfstests [3].
> 
> Thoughts?

Thanks for the work Lukas! I have one general note regarding this quota
support: IMO it is pointless to try to retrofit how quota files work on
block-based filesystems to tmpfs. All the bothering with converting between
on-disk and in-mem representation, formatting of btree nodes is just
pointless waste of CPU and code.

I think much simpler approach would be to keep some internal rbtree with
quota structures carrying struct mem_dqblk and id. Then your .acquire_dquot
handler will fill in quota information from the structure and
.release_dquot will copy new data into the structure.

So basically all operations you'd need to provide in your implementation
are .acquire_dquot, .release_dquot, and .get_next_id. And then you'll
probably need to define new quota format with .read_file_info callback
filling in some limits of the format (and some other stub callbacks doing
nothing). If there's too much boilerplate code doing nothing, we can have a
look into making quota core more clever to make life simpler for in-memory
filesystems (hidden behind something like DQUOT_QUOTA_IN_MEMORY flag in
struct quota_info) but currently I don't think it will be too bad.

								Honza

> [1] https://github.com/lczerner/quota/tree/quotactl_fd_support
> [2] https://github.com/lczerner/xfsprogs/tree/quotactl_fd_support
> [3] https://github.com/lczerner/xfstests/tree/tmpfs_quota_support
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
