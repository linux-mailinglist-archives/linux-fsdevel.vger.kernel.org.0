Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059705A4159
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 05:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiH2DKm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 23:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiH2DKM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:10:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD34E3ED77;
        Sun, 28 Aug 2022 20:09:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B849433907;
        Mon, 29 Aug 2022 03:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661742551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o3++mKzz7hERM5Mb7Tdk97SHqozn0mvn+1hqgH12L1w=;
        b=cMe+PbYLIGxia+uP9ejOsmr8IkPUBIhxgfpfR89faf9912FvEZNGocOwKktNHmUpjtIhM/
        lfk/JsgjdYoe91r/QStr5q+Ts1Li5nX7lMWlQajGuhU/BqhDtWdRRv3V8KbYumOi8iTUyk
        evT+ZVL17RgJqKNc3Qz15EPyw0CrnUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661742551;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o3++mKzz7hERM5Mb7Tdk97SHqozn0mvn+1hqgH12L1w=;
        b=jaJRdBnq2gSammVoWJlz6ow2/8sW8Csa2EvLviSvu7rxBYw1FRjWSrLVWd7X5QDRlzqZlY
        06R2TrNgeQO2idDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3EC7D133A6;
        Mon, 29 Aug 2022 03:09:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id syyyOtQtDGPJHwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 29 Aug 2022 03:09:08 +0000
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
Subject: Re: [PATCH 06/10] VFS: support concurrent renames.
In-reply-to: <YwmZveDR7Igur0m0@ZenIV>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>,
 <166147984375.25420.13018600986239729815.stgit@noble.brown>,
 <YwmZveDR7Igur0m0@ZenIV>
Date:   Mon, 29 Aug 2022 13:08:58 +1000
Message-id: <166174253873.27490.14474856398076056074@noble.neil.brown.name>
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
> > Allow object can now be renamed from or to a directory in which a create
> > or unlink is concurrently happening.
> > 
> > Two or more renames with the one directory can also be concurrent.
> > s_vfs_rename_mutex still serialises lookups for cross-directory renames,
> > but the renames themselves can proceed concurrently.
> 
> Wha...?  <checks>
> Not true, fortunately - you *do* hold ->s_vfs_rename_mutex over the
> rename itself.  If not for that, it would be utterly broken.
> And I don't care for NFS server rejecting that - we are *NOT* taking
> loop prevention logics into every filesystem.  It's highly non-local
> and trying to handle it with your per-dentry flags is going to be
> painful as hell, if at all possible.
> 

I don't know what happened there - I let myself get confused somewhere
in the process.  You are of course right that s_vfs_rename_mutex is held
the whole time.  I wasn't intending to try to change that.

> > +	if (d1 < d2) {
> > +		ok1 = d_lock_update_nested(d1, p1, last1, I_MUTEX_PARENT);
> > +		ok2 = d_lock_update_nested(d2, p2, last2, I_MUTEX_PARENT2);
> > +	} else {
> > +		ok2 = d_lock_update_nested(d2, p2, last2, I_MUTEX_PARENT);
> > +		ok1 = d_lock_update_nested(d1, p1, last1, I_MUTEX_PARENT2);
> > +	}
> 
> Explain, please.  What's that ordering about?
> 
Deadlock avoidance, just like in the same-directory case.

But I guess as s_vfs_rename_mutex is held, ordering cannot matter.
I'll remove the ordering.

Thanks,
NeilBrown
