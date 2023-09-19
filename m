Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2363A7A5E87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 11:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjISJs3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 05:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjISJs2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:48:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2D1F0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 02:48:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B81A81FDBE;
        Tue, 19 Sep 2023 09:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695116900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ooDwqzIoFCle4RP0G60EfZIrtb3+eHXbrUKZVdyj1M=;
        b=mF0+uEfPNkEjB5AmD9KdttjqkoI15YmrYzmhqRqq37x5/SdGZBMn0DboAVbc8SHOxyBi+9
        /JSjiedZNrDgLOerGUq3IHtdHR1eQjSRjcfgXfV6mhO8Wk+4QQYyjX9VnuQJ+BSQ2+0kYV
        J7ndzvLdLYzgigV7wEI2v5ThmAviAr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695116900;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ooDwqzIoFCle4RP0G60EfZIrtb3+eHXbrUKZVdyj1M=;
        b=nG+mW1dNzrljS8ptD8tPJFtZKB89T4bsS4U+gjmbFshE3am0GM9V59tquX4FhPZG+JML+7
        0gsvwZNofH0baJAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A92ED134F3;
        Tue, 19 Sep 2023 09:48:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gB9HKWRuCWWHNQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 19 Sep 2023 09:48:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 28C89A0759; Tue, 19 Sep 2023 11:48:20 +0200 (CEST)
Date:   Tue, 19 Sep 2023 11:48:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Max Kellermann <max.kellermann@ionos.com>
Subject: Re: inotify maintenance status
Message-ID: <20230919094820.g5bwharbmy2dq46w@quack3>
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com>
 <20230918124050.hzbgpci42illkcec@quack3>
 <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
 <20230918142319.kvzc3lcpn5n2ty6g@quack3>
 <CAOQ4uxic7C5skHv4d+Gek_uokRL8sgUegTusiGkwAY4dSSADYQ@mail.gmail.com>
 <CAOQ4uxjzf6NeoCaTrx_X0yZ0nMEWcQC_gq3M-j3jS+CuUTskSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjzf6NeoCaTrx_X0yZ0nMEWcQC_gq3M-j3jS+CuUTskSA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 18-09-23 21:05:11, Amir Goldstein wrote:
> [Forked from https://lore.kernel.org/linux-fsdevel/20230918123217.932179-1-max.kellermann@ionos.com/]
...
> BTW, before we can really mark inotify as Obsolete and document that
> inotify was superseded by fanotify, there are at least two items on the
> TODO list [1]:

Yeah, as I wrote in the original thread, I don't feel like inotify should
be marked as obsolete (at least for some more time) so we are on the same
page here I think.

> 1. UNMOUNT/IGNORED events
> 2. Filesystems without fid support
> 
> MOUNT/UNMOUNT fanotify events have already been discussed
> and the feature has known users.
> 
> Christian has also mentioned [1] the IN_UNMOUNT use case for
> waiting for sb shutdown several times and I will not be surprised
> to see systemd starting to use inotify for that use case before too long...

Yup, both FAN_UNMOUNT and FAN_IGNORED should be easy. Unlike inotify, I'd
just make these explicit events you can opt into and not something you
always get.

> Regarding the second item on the TODO list, we have had this discussion
> before - if we are going to continue the current policy of opting-in to
> fanotify (i.e. tmpfs, fuse, overlayfs, kernfs), we will always have odd
> filesystems that only support inotify and we will need to keep supporting
> inotify only for the users that use inotify on those odd filesystems.
> 
> OTOH, if we implement FAN_REPORT_DINO_NAME, we could
> have fanotify inode mark support for any filesystem, where the
> pinned marked inode ino is the object id.

Is it a real problem after your work to allow filehandles that are not
necessarily usable for NFS export or open_by_handle()? As far as I remember
fanotify should be now able to handle anything that provides f_fsid in its
statfs(2) call. And as I'm checking filesystems not setting fsid currently are:

afs, coda, nfs - networking filesystems where inotify and fanotify have
  dubious value anyway

configfs, debugfs, devpts, efivarfs, hugetlbfs, openpromfs, proc, pstore,
ramfs, sysfs, tracefs - virtual filesystems where fsnotify functionality is
  quite limited. But some special cases could be useful. Adding fsid support
  is the same amount of trouble as for kernfs - a few LOC. In fact, we
  could perhaps add a fstype flag to indicate that this is a filesystem
  without persistent identification and so uuid should be autogenerated on
  mount (likely in alloc_super()) and f_fsid generated from sb->s_uuid.
  This way we could handle all these filesystems with trivial amount of
  effort.

freevxfs - the only real filesystem without f_fsid. Trivial to handle one
  way or the other.

So I don't think we need new uAPI additions to finish off this TODO item.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
