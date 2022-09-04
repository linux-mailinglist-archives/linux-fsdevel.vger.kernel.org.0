Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEF85AC81B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 01:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiIDXdu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Sep 2022 19:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIDXdt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Sep 2022 19:33:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BD2175BA;
        Sun,  4 Sep 2022 16:33:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4167B384DC;
        Sun,  4 Sep 2022 23:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662334426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7wL1UsufC/2TYfqXALUnz3P66S7/A6vXRUT/r091DT4=;
        b=f8BWz4ljqyxYbb137zDcgOkYYHXQujZkE9DWZOp0lS43pGNbF03cnJy8y/j0uPSNDDrBeb
        9JxCdGcNtLlsrxcmcc2fVrOjflOfpq7TTAu9MriUJ0M0aSXu9aI3ead9L8OTlGiwegbTLL
        BLCMup/Uetf5uyTBu9GSh8KYGb8UYvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662334426;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7wL1UsufC/2TYfqXALUnz3P66S7/A6vXRUT/r091DT4=;
        b=n6SGdhfUq336qP/umCt+2NKS9PG0OdSxLxLz3/qyL73I6lHuHnkHIuCvW7CXZ9/pyUNAdP
        ZwYtsbwVnhCqBCBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C90EF13A6B;
        Sun,  4 Sep 2022 23:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hP36INc1FWOSYAAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 04 Sep 2022 23:33:43 +0000
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
Subject: Re: [PATCH 01/10] VFS: support parallel updates in the one directory.
In-reply-to: <YxOUUEXAbUdFLVKk@ZenIV>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>,
 <166147984370.25420.13019217727422217511.stgit@noble.brown>,
 <YwmS63X3Sm4bhlcT@ZenIV>,
 <166173834258.27490.151597372187103012@noble.neil.brown.name>,
 <YxKaaN9cHD5yzlTr@ZenIV>,
 <166216924401.28768.5809376269835339554@noble.neil.brown.name>,
 <YxK4CiVNaQ6egobJ@ZenIV>, <YxOUUEXAbUdFLVKk@ZenIV>
Date:   Mon, 05 Sep 2022 09:33:40 +1000
Message-id: <166233442086.1168.1631109347260612253@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 04 Sep 2022, Al Viro wrote:
> On Sat, Sep 03, 2022 at 03:12:26AM +0100, Al Viro wrote:
> 
> > Very much so.  You are starting to invent new rules for ->lookup() that
> > just never had been there, basing on nothing better than a couple of
> > examples.  They are nowhere near everything there is.
> 
> A few examples besides NFS and autofs:

Hi Al,
 thanks for these - very helpful.  I will give them due consideration
 when I write relevant documentation to include in the next posting of
 the series.

Thanks a lot,
NeilBrown


> 
> ext4, f2fs and xfs might bloody well return NULL without hashing - happens
> on negative lookups with 'casefolding' crap.
> 
> kernfs - treatment of inactive nodes.
> 
> afs_dynroot_lookup() treatment of @cell... names.
> 
> afs_lookup() treatment of @sys... names.
> 
> There might very well be more - both merged into mainline and in
> development trees of various filesystems (including devel branches
> of in-tree ones - I'm not talking about out-of-tree projects).
> 
> Note, BTW, that with the current rules it's perfectly possible to
> have this kind of fun:
> 	a name that resolves to different files for different processes
> 	unlink(2) is allowed and results depend upon the calling process
> 
> All it takes is ->lookup() deliberately *NOT* hashing the sucker and
> ->unlink() acting according to dentry it has gotten from the caller.
> unlink(2) from different callers are serialized and none of that
> stuff is ever going to be hashed.  d_alloc_parallel() might pick an
> in-lookup dentry from another caller of e.g. stat(2), but it will
> wait for in-lookup state ending, notice that the sucker is not hashed,
> drop it and retry.  Suboptimal, but it works.
> 
> Nothing in the mainline currently does that.  Nothing that I know of,
> that is.  Sure, it could be made work with the changes you seem to
> imply (if I'm not misreading you) - all it takes is lookup
> calling d_lookup_done() on its argument before returning NULL.
> But that's subtle, non-obvious and not documented anywhere...
> 
> Another interesting question is the rules for unhashing dentries.
> What is needed for somebody to do temporary unhash, followed by
> rehashing?
> 
