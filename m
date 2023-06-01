Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A39F71A2B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 17:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbjFAP2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 11:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjFAP2f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:28:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17371E5C;
        Thu,  1 Jun 2023 08:28:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A484321999;
        Thu,  1 Jun 2023 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685633266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bzP3jLe8H8GOVTU+gtWIF9QQ1w/ZlpecHavzqINdb94=;
        b=gOv8ln8aI+gXFZjWVdmCA8Wjxd4LICDM5AcA4HSkflUYb41Mcds6Sig/+gvw1r+us6LFoO
        kVxojpvhhIe6pB3ye46OJCnKyH8RZgj7hBe/YL9nHIGq4Dz3fwiNpUvsP1RR+d1U0PwiX7
        f67hxyD7bPdnQhqhQaCuY/jq4Qu3bLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685633266;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bzP3jLe8H8GOVTU+gtWIF9QQ1w/ZlpecHavzqINdb94=;
        b=2SzoaO5XBuvNM4t9ZY5UOUFL7l/socW8dcuNJwrzQ6bLiNuaC9FS97mPz/t3+MWR1OT01Q
        UvfkwX48LkI2rvCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9558513441;
        Thu,  1 Jun 2023 15:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qntwJPK4eGSLbAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 01 Jun 2023 15:27:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 18AC5A0754; Thu,  1 Jun 2023 17:27:46 +0200 (CEST)
Date:   Thu, 1 Jun 2023 17:27:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/6] ext4: Remove ext4 locking of moved directory
Message-ID: <20230601152746.kqykcztndxvxbbf7@quack3>
References: <20230601104525.27897-1-jack@suse.cz>
 <20230601105830.13168-1-jack@suse.cz>
 <20230601145222.GB1069561@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601145222.GB1069561@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-06-23 10:52:22, Theodore Ts'o wrote:
> On Thu, Jun 01, 2023 at 12:58:21PM +0200, Jan Kara wrote:
> > Remove locking of moved directory in ext4_rename2(). We will take care
> > of it in VFS instead. This effectively reverts commit 0813299c586b
> > ("ext4: Fix possible corruption when moving a directory") and followup
> > fixes.
> 
> Remind me --- commit 0813299c586b is not actually causing any
> problems; it's just not fully effective at solving the problem.  Is
> that correct?

Yes, correct.

> In other words, is there a rush in trying to get this revert to Linus
> during this cycle as a regression fix?
> 
> I think the answer is no, and we can just let this full patch series
> go in via the vfs branch during the next merge window, but I just
> wanted to make sure.

Exactly, that's my plan as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
