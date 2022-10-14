Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3DE5FEB63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 11:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJNJPO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 05:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiJNJPM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:15:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F050274363;
        Fri, 14 Oct 2022 02:15:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A54BF1F383;
        Fri, 14 Oct 2022 09:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665738910;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lop39TQqCOXXxSbDsyQkXoUBrxToIIED3a6P4bzyLLs=;
        b=tbFHpqFR6QaOIdTM3EjXqJMH4F2nsfNF1+12MoNCtlTg0QR24CzfGM9L1WDe2QqP2G90WB
        YnyKxp5hvRXQQ4ZVZadq6bTq34yF3s1dHMZ9iK6Tl7j+V9tT5staNs0dZumE4Z9muul4J2
        lypDUS8DsrYcUooJLONUXjF07PQAiss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665738910;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lop39TQqCOXXxSbDsyQkXoUBrxToIIED3a6P4bzyLLs=;
        b=STUhXyiyCDJNq1qGz+0oeqFPiI1DomfdYg0GmUVMYp0/weXSBRVg5jxfDErRWMhIXyWBVy
        YcFijTKScbu3V9Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F10613451;
        Fri, 14 Oct 2022 09:15:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EbSrCp4oSWM1GQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 14 Oct 2022 09:15:10 +0000
Date:   Fri, 14 Oct 2022 11:15:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Hrutvik Kanabar <hrkanabar@gmail.com>
Cc:     Hrutvik Kanabar <hrutvik@google.com>,
        Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        kasan-dev@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH RFC 0/7] fs: Debug config option to disable filesystem
 checksum verification for fuzzing
Message-ID: <20221014091503.GA13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221014084837.1787196-1-hrkanabar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014084837.1787196-1-hrkanabar@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 14, 2022 at 08:48:30AM +0000, Hrutvik Kanabar wrote:
> From: Hrutvik Kanabar <hrutvik@google.com>
> 
> Fuzzing is a proven technique to discover exploitable bugs in the Linux
> kernel. But fuzzing filesystems is tricky: highly structured disk images
> use redundant checksums to verify data integrity. Therefore,
> randomly-mutated images are quickly rejected as corrupt, testing only
> error-handling code effectively.
> 
> The Janus [1] and Hydra [2] projects probe filesystem code deeply by
> correcting checksums after mutation. But their ad-hoc
> checksum-correcting code supports only a few filesystems, and it is
> difficult to support new ones - requiring significant duplication of
> filesystem logic which must also be kept in sync with upstream changes.
> Corrected checksums cannot be guaranteed to be valid, and reusing this
> code across different fuzzing frameworks is non-trivial.
> 
> Instead, this RFC suggests a config option:
> `DISABLE_FS_CSUM_VERIFICATION`. When it is enabled, all filesystems
> should bypass redundant checksum verification, proceeding as if
> checksums are valid. Setting of checksums should be unaffected. Mutated
> images will no longer be rejected due to invalid checksums, allowing
> testing of deeper code paths. Though some filesystems implement their
> own flags to disable some checksums, this option should instead disable
> all checksums for all filesystems uniformly. Critically, any bugs found
> remain reproducible on production systems: redundant checksums in
> mutated images can be fixed up to satisfy verification.
> 
> The patches below suggest a potential implementation for a few
> filesystems, though we may have missed some checksums. The option
> requires `DEBUG_KERNEL` and is not intended for production systems.
> 
> The first user of the option would be syzbot. We ran preliminary local
> syzkaller tests to compare behaviour with and without these patches.
> With the patches, we found a 19% increase in coverage, as well as many
> new crash types and increases in the total number of crashes:

I think the build-time option inflexible, but I see the point when
you're testing several filesystems that it's one place to set up the
environment. Alternatively I suggest to add sysfs knob available in
debuging builds to enable/disable checksum verification per filesystem.

As this may not fit to other filesystems I don't suggest to do that for
all but I am willing to do that for btrfs, with eventual extension to
the config option you propose. The increased fuzzing coverage would be
good to have.
