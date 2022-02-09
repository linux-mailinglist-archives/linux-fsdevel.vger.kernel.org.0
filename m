Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AC94AFF80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 22:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbiBIVyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 16:54:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbiBIVyN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:54:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F01C0F8692
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 13:54:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3CDA51F386;
        Wed,  9 Feb 2022 21:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644443654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=zMm3pfRsYZ+DVGCUf3CG6egjZc7b7/JzTf7Ck8DjvE0=;
        b=1qdjJeNP6S0FbkRHd6MeRL/iu/zT9YX8DcqJZug/Wi5Mu+HYbamonXTkI3rHYJgsGAXuTD
        Kq+c2XOU86evVzcs/pwsF8mWsjycjiz5PE5NlputMW8DhRx4J8Yd7uFu+m8sgm/BHOeth+
        wcOCeTclL3oeO4FbUjdgS3DKPBav4KU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644443654;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=zMm3pfRsYZ+DVGCUf3CG6egjZc7b7/JzTf7Ck8DjvE0=;
        b=EFwPc2L+D60LRC+Ma9aJZZKYpBPGkN5eFmVkznAC/fPeAei+OgbBdLcUMI40SsVNSXEU3C
        EV9i0zTF2xJQsXCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B028613AD9;
        Wed,  9 Feb 2022 21:54:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h7vELwQ4BGK+LwAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Wed, 09 Feb 2022 21:54:12 +0000
Date:   Wed, 9 Feb 2022 15:54:10 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Cc:     dchinner@redhat.com, willy@infradead.org
Subject: [LSF/MM/BPF Topic] Shared memory for shared file extents
Message-ID: <20220209215410.vl5777f7g6utgipt@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Copy-on-write filesystem such as btrfs (or reflinks in XFS/OCFS2) have
files which share extents on disk. Multiple files can have extents
pointing to same physical disk location. When mutliple files share a
common extent and these files are read(), each file will have it's own
copy of the content in the page cache.

The problem is this leads to wastage of memory since multiple
copies of the same content is in memory. The proposal is to have a
common cache which would be used *for reads only* (excluding read before
writes for non page aligned writes).

I would like to discuss the problems which will arise to implement this:
 - strategies to maintain such a shared cache
   - location of the shared cache: device inode or separate inode?
   - all reads go through shared cache OR only shared extents 
     should be in shared cache
 - actions to perform if write occurs at offsets of shared extents
   - should it be CoW'd in memory? OR
   - move the pages from shared cache to inode's cache?
 - what should be done to the pages after writeback. Should they be
   dropped, so further reads are read into shared cache?
 - Shrinking in case of system memory pressure

An initial RFC patch was posted here:
https://lore.kernel.org/all/YXNoxZqKPkxZvr3E@casper.infradead.org/t/

-- 
Goldwyn
