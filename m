Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0656F83E3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 15:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjEENY0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 09:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjEENYZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 09:24:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE6E1F493;
        Fri,  5 May 2023 06:24:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BBCD02002F;
        Fri,  5 May 2023 13:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683293062;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=87ziaC1ElX2yKfmzIaFLeUyWyEzhqF+7VfRpBodiD3o=;
        b=ajpn/PR7Mft6ovdF8g2DO1spsBnLgc8cU/MAXNsRm0qVPStRuHEpvXQSaakiHnru3sk/UY
        YEP+nHrMBNTzQwgtwqWI2DEH7suT83yCf5TkamjPY1SF8ET7GCXaj00E4SYHj9pqwTML6z
        SO8cSmGNwa/19NROevPysgvBWplDfro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683293062;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=87ziaC1ElX2yKfmzIaFLeUyWyEzhqF+7VfRpBodiD3o=;
        b=DoHtrgkIX45JDTW16SAzK85qg0J6SQypn90kG31CaFPX/JF7EVEOG1VafXfFuOn+RLWfKP
        p8yj2bfBqsY6YLCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 768CD13488;
        Fri,  5 May 2023 13:24:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xHMrHIYDVWQBVAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 05 May 2023 13:24:22 +0000
Date:   Fri, 5 May 2023 15:18:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        nborisov@suse.com
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
Message-ID: <20230505131825.GN6373@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504170708.787361-2-gpiccoli@igalia.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 04, 2023 at 02:07:07PM -0300, Guilherme G. Piccoli wrote:
> Btrfs doesn't currently support to mount 2 different devices holding the
> same filesystem - the fsid is used as a unique identifier in the driver.
> This case is supported though in some other common filesystems, like
> ext4; one of the reasons for which is not trivial supporting this case
> on btrfs is due to its multi-device filesystem nature, native RAID, etc.
> 
> Supporting the same-fsid mounts has the advantage of allowing btrfs to
> be used in A/B partitioned devices, like mobile phones or the Steam Deck
> for example. Without this support, it's not safe for users to keep the
> same "image version" in both A and B partitions, a setup that is quite
> common for development, for example. Also, as a big bonus, it allows fs
> integrity check based on block devices for RO devices (whereas currently
> it is required that both have different fsid, breaking the block device
> hash comparison).
> 
> Such same-fsid mounting is hereby added through the usage of the
> mount option "virtual_fsid" - when such option is used, btrfs generates
> a random fsid for the filesystem and leverages the metadata_uuid
> infrastructure (introduced by [0]) to enable the usage of this secondary
> virtual fsid. But differently from the regular metadata_uuid flag, this
> is not written into the disk superblock - effectively, this is a spoofed
> fsid approach that enables the same filesystem in different devices to
> appear as different filesystems to btrfs on runtime.

Have you evaluated if the metadata_uuid could be used for that? It is
stored on the filesystem image, but could you adapt the usecase to set
the UUID before mount manually (in tooling)?

The metadata_uuid is lightweight and meant to change the appearance of
the fs regarding uuids, verly close to what you describe. Adding yet
another uuid does not seem right so I'm first asking if and in what way
the metadata_uuid could be extended.
