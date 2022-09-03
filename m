Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B70F5ABC1E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Sep 2022 03:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiICBk6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 21:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiICBk4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 21:40:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4186610F;
        Fri,  2 Sep 2022 18:40:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A5D85CDDD;
        Sat,  3 Sep 2022 01:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662169253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOtyw6vlWTD4GBfJ46VsGKoxC3DDcJeFHhSL1DQkmvE=;
        b=LpKIfTv5HEWEL+Ymq+LnYUN+RHHdZOKMb+wRoNTH7fIDHsYpsokuiiZ+8xRS6DdG+pEBWL
        ylvZ6uaPMDc5dBgyKy9VbUcANvR3HnSDvf5y42BEI1GilGyPIL9BRubjGHRlojBbbRxQ15
        PraZODD7+kzIKFuKSkBqbqruQ4O7yX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662169253;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOtyw6vlWTD4GBfJ46VsGKoxC3DDcJeFHhSL1DQkmvE=;
        b=Z05dagcxqNBT2NgVh8n/tcwXlyfV7BzxSHQAmeuh1SCir53yg0eiDCUb17ln+pEO/QmMTu
        28CdkNY1PMuuuwBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4F88133A7;
        Sat,  3 Sep 2022 01:40:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kLNgH6KwEmOBeAAAMHmgww
        (envelope-from <neilb@suse.de>); Sat, 03 Sep 2022 01:40:50 +0000
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
In-reply-to: <YxKaaN9cHD5yzlTr@ZenIV>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>,
 <166147984370.25420.13019217727422217511.stgit@noble.brown>,
 <YwmS63X3Sm4bhlcT@ZenIV>,
 <166173834258.27490.151597372187103012@noble.neil.brown.name>,
 <YxKaaN9cHD5yzlTr@ZenIV>
Date:   Sat, 03 Sep 2022 11:40:44 +1000
Message-id: <166216924401.28768.5809376269835339554@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 03 Sep 2022, Al Viro wrote:
> On Mon, Aug 29, 2022 at 11:59:02AM +1000, NeilBrown wrote:
> 
> > > When would we get out of __lookup_hash() with in-lookup dentry?
> > > Confused...
> > 
> > Whenever wq is passed in and ->lookup() decides, based on the flags, to do
> > nothing.
> > NFS does this for LOOKUP_CREATE|LOOKUP_EXCL and for LOOKUP_RENAME_TARGET
> 
> Frankly, I would rather do what all other callers of ->lookup() do and
> just follow it with d_lookup_done(dentry), no matter what it returns.
> It's cheap enough...
> 

I don't think that is a good idea.  Once you call d_lookup_done()
(without having first called d_add() or similar) the dentry becomes
invisible to normal path lookup, so another might be created.  But the
dentry will still be used for the 'create' or 'rename' and may then be
added to the dcache - at which point you could have two dentries with the
same name.

When ->lookup() returns success without d_add()ing the dentry, that
means that something else will complete the d_add() if/when necessary.
For NFS, it specifically means that the lookup is effectively being
combined with the following CREATE or RENAME.  In this case there is no
d_lookup_done() until the full operation is complete.

For autofs (thanks for pointing me to that) the operation is completed
when d_automount() signals the daemon to create the directory or
symlink.  In that case there IS a d_lookup_done() call and autofs needs
some extra magic (the internal 'active' list) to make sure subsequent
->lookup requests can see that dentry which is still in the process of
being set up.

It might be nice if the dentry passed to autofs_lookup() could remain
"d_inlookup()" until after d_automount has completed.  Then autofs
wouldn't need that active list.  However I haven't yet looked at how
disruptive such a change might be.

Thanks,
NeilBrown
