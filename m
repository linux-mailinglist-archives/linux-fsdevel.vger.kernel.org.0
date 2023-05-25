Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D78710924
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 11:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbjEYJo5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 05:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjEYJoq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 05:44:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07145A9;
        Thu, 25 May 2023 02:44:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 718451FDC2;
        Thu, 25 May 2023 09:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685007882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p5KDT5n7B93Vi9xs1xIjnqiETEkQKRSr647A/1d/+S4=;
        b=qiJeZaxCmaCdG74Skn1lpuA6uFRaLGsNJHxg0eldi3Y2EpQNfYmllo9h9HCULHAETWghYX
        357bUematuJ7lIKzFL/69ANbP87eT3gX9rxFOtQZQhWJJYAv0cZjPVNX1ntpD8yX3OGeY+
        jXKtvH5nCV4ZxyTwyjlGtkQk8mUFAbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685007882;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p5KDT5n7B93Vi9xs1xIjnqiETEkQKRSr647A/1d/+S4=;
        b=zNCa3NEXa5yV+ot1qtkCNy+wRqMbXs+HPIuoqh3YrRzBfoVpGcdCVwdB5n7tnulR+XxqLa
        eztLvHoz8/AuJNCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6013C134B2;
        Thu, 25 May 2023 09:44:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KrBtFwoub2QYZAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 25 May 2023 09:44:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EEDE2A075C; Thu, 25 May 2023 11:44:41 +0200 (CEST)
Date:   Thu, 25 May 2023 11:44:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Amir Goldstein <amir73il@gmail.com>,
        'David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: Locking for RENAME_EXCHANGE
Message-ID: <20230525094441.wozlaigewzqemdm2@quack3>
References: <20230524163504.lugqgz2ibe5vdom2@quack3>
 <CAJfpegu8W9R9G8n+4n3U5Ba_bKpM1o_5_2dfTOoeGDAOFcyF1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu8W9R9G8n+4n3U5Ba_bKpM1o_5_2dfTOoeGDAOFcyF1g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 24-05-23 21:33:07, Miklos Szeredi wrote:
> On Wed, 24 May 2023 at 18:35, Jan Kara <jack@suse.cz> wrote:
> >
> > Hello!
> >
> > This is again about the problem with directory renames I've already
> > reported in [1]. To quickly sum it up some filesystems (so far we know at
> > least about xfs, ext4, udf, reiserfs) need to lock the directory when it is
> > being renamed into another directory. This is because we need to update the
> > parent pointer in the directory in that case and if that races with other
> > operation on the directory, bad things can happen.
> >
> > So far we've done the locking in the filesystem code but recently Darrick
> > pointed out [2] that we've missed the RENAME_EXCHANGE case in our ext4 fix.
> > That one is particularly nasty because RENAME_EXCHANGE can arbitrarily mix
> > regular files and directories. Couple nasty arising cases:
> >
> > 1) We need to additionally lock two exchanged directories. Suppose a
> > situation like:
> >
> > mkdir P; mkdir P/A; mkdir P/B; touch P/B/F
> >
> > CPU1                                            CPU2
> > renameat2("P/A", "P/B", RENAME_EXCHANGE);       renameat2("P/B/F", "P/A", 0);
> 
> Not sure I get it.
> 
> CPU1 locks P then A then B
> CPU2 locks P then B then A
> 
> Both start with P and after that ordering between A and B doesn't
> matter as long as the topology stays the same, which is guaranteed.
> 
> Or did you mean renameat2("P/B/F", "P/A/F", 0);?
> 
> This indeed looks deadlocky.

Right, that is what I meant. Sorry for confusion.

> > Both operations need to lock A and B directories which are unrelated in the
> > tree. This means we must establish stable lock ordering on directory locks
> > even for the case when they are not in ancestor relationship.
> >
> > 2) We may need to lock a directory and a non-directory and they can be in
> > parent-child relationship when hardlinks are involved:
> >
> > mkdir A; mkdir B; touch A/F; ln A/F B/F
> > renameat2("A/F", "B");
> >
> > And this is really nasty because we don't have a way to find out whether
> > "A/F" and "B" are in any relationship - in particular whether B happens to
> > be another parent of A/F or not.
> >
> > What I've decided to do is to make sure we always lock directory first in
> > this mixed case and that *should* avoid all the deadlocks but I'm spelling
> > this out here just in case people can think of some even more wicked case
> > before I'll send patches.
> 
> Locking directories first has always been the case, described in
> detail in Documentation/filesystems/directory-locking.rst
> 
> > Also I wanted to ask (Miklos in particular as RENAME_EXCHANGE author): Why
> > do we lock non-directories in RENAME_EXCHANGE case? If we didn't have to do
> > that things would be somewhat simpler...
> 
> I can't say I remember anything, but digging into
> lock_two_nondirectories() this comes up quickly:
> 
>   6cedba8962f4 ("vfs: take i_mutex on renamed file")
> 
> So apparently NFS is relying on i_mutex to prevent delegations from
> being broken without its knowledge.  Might be that is't NFS only, and
> then the RENAME_EXCHANGE case doesn't need it (NFS doesn't support
> RENAME_EXCHANGE), but I can't say for sure.
> 
> Also Al seems to have had some thoughts on this in d42b386834ee
> ("update D/f/directory-locking")

Thanks for the references. I've now updated the document
Documentation/filesystems/directory-locking.rst and I'm now more convinced
the scheme is correct. It is also kind of neat there are less special cases
:).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
