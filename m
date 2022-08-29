Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895515A4168
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 05:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiH2DQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 23:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiH2DQA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:16:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C0217E0D;
        Sun, 28 Aug 2022 20:15:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 347CC3375C;
        Mon, 29 Aug 2022 03:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661742958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tBBKmXPZz0d24U2B8Ubl7UW8mvxOKfSvEgiuL0CK338=;
        b=0oJkLg4Nrt9d2wio0Olr2XkavG7NvjmNYIas8bCPG97ZpoqWvbjIZx9U+UVlyvE1hBpF0r
        +eqoCmq2pSKWaQFkDTbm+CbbmOFwIDjmR8viS0uUwPVMXJZp63GJu1LZ/l2SmU7gm7rcc2
        BUFZxB9Lo/V0d8on+gDO1wzZT5YIc34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661742958;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tBBKmXPZz0d24U2B8Ubl7UW8mvxOKfSvEgiuL0CK338=;
        b=tno6QRbZJDTSXLrCSGOiNlz0HGCByoVPljOzZbN6a6xOnbQ0/k3wih7Ww2XWL5n7zByj7b
        eB/lCufqFM/LExDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A51DF133A6;
        Mon, 29 Aug 2022 03:15:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FcQpGGsvDGNrIQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 29 Aug 2022 03:15:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Al Viro" <viro@zeniv.linux.org.uk>
Cc:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Daire Byrne" <daire@dneg.com>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/10] VFS: add LOOKUP_SILLY_RENAME
In-reply-to: <YwlxiCt3TvzdEhUl@ZenIV>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>,
 <166147984377.25420.5747334898411663007.stgit@noble.brown>,
 <YwlxiCt3TvzdEhUl@ZenIV>
Date:   Mon, 29 Aug 2022 13:15:52 +1000
Message-id: <166174295243.27490.1036858614514220411@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 27 Aug 2022, Al Viro wrote:
> On Fri, Aug 26, 2022 at 12:10:43PM +1000, NeilBrown wrote:
> > When performing a "silly rename" to avoid removing a file that is still
> > open, we need to perform a lookup in a directory that is already locked.
> > 
> > In order to allow common functions to be used for this lookup, introduce
> > LOOKUP_SILLY_RENAME which affirms that the directory is already locked
> > and that the vfsmnt is already writable.
> > 
> > When LOOKUP_SILLY_RENAME is set, path->mnt can be NULL.  As
> > i_op->rename() doesn't make the vfsmnt available, this is unavoidable.
> > So we ensure that a NULL ->mnt isn't fatal.
> 
> This one is really disgusting.  Flag-dependent locking is a pretty much
> guaranteed source of PITA and "magical" struct path is, again, asking for
> trouble.
> 
> You seem to be trying for simpler call graph and you end up paying with
> control flow that is much harder to reason about.
> 
It was mostly about avoiding code duplication.
I'll see if I can find a cleaner way.

Thanks,
NeilBrown
