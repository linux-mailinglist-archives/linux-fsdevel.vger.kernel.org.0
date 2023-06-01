Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FCF71EE6A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 18:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjFAQN5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 12:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjFAQN4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:13:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCBDE4;
        Thu,  1 Jun 2023 09:13:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 43B861FDAE;
        Thu,  1 Jun 2023 16:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685636034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZJvHyX75bsYrg59/xv8goVF/SY5G71ydpRI3Pzi5140=;
        b=PZvMYCMQoEFcCHiewgIaHWYAfeoz0QO179rgcwOwjwsxBWYW33SHzYTryDM5y3yV1ixTph
        umdfykUSKmqOqbf1ixpa7QLeLHr1SrJccO501Zz+AU9Ac1foS50ckQU1ZLD49ZZgKhjsew
        yB7DLoxcS+1UXGNtc8gNF6pmG8vlddg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685636034;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZJvHyX75bsYrg59/xv8goVF/SY5G71ydpRI3Pzi5140=;
        b=U0R/ic9qdjSntJ85EPgaZNvIrEfLVWmdkxYGujNcma/HAtVChmBiwR7uULYLxv9tabZz/v
        WaBEdlTyPuVETvBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 323DB13441;
        Thu,  1 Jun 2023 16:13:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rhIgDMLDeGRlBQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 01 Jun 2023 16:13:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B0704A0754; Thu,  1 Jun 2023 18:13:53 +0200 (CEST)
Date:   Thu, 1 Jun 2023 18:13:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Jan Kara' <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] fs: Establish locking order for unrelated
 directories
Message-ID: <20230601161353.4o6but7hb7i7qfki@quack3>
References: <20230601104525.27897-1-jack@suse.cz>
 <20230601105830.13168-4-jack@suse.cz>
 <20230601-gebracht-gesehen-c779a56b3bf3@brauner>
 <20230601152449.h4ur5zrfqjqygujd@quack3>
 <c5f209a6263b4f039c5eafcafddf90ca@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5f209a6263b4f039c5eafcafddf90ca@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-06-23 15:37:32, David Laight wrote:
> ...
> > > > + * Lock any non-NULL argument. The caller must make sure that if he is passing
> > > > + * in two directories, one is not ancestor of the other
> 
> Not directly relevant to this change but is the 'not an ancestor'
> check actually robust?
> 
> I found a condition in which the kernel 'pwd' code (which follows
> the inode chain) failed to stop at the base of a chroot.
> 
> I suspect that the ancestor check would fail the same way.

Honestly, I'm not sure how this could be the case but I'm not a dcache
expert. d_ancestor() works on dentries and the whole dcache code pretty
much relies on the fact that there always is at most one dentry for any
directory. Also in case we call d_ancestor() from this code, we have the
whole filesystem locked from any other directory moves so the ancestor
relationship of two dirs cannot change (which is different from pwd code
AFAIK). So IMHO no failure is possible in our case.

								Honza

> 
> IIRC the problematic code used unshare() to 'escape' from
> a network natespace.
> If it was inside a chroot (that wasn't on a mount point) there
> ware two copies of the 'chroot /' inode and the match failed.
> 
> I might be able to find the test case.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
