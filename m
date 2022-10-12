Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279535FC89C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 17:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJLPoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Oct 2022 11:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJLPoJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:44:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5261E0732
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 08:44:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8418921E47;
        Wed, 12 Oct 2022 15:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665589447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dCc1+6QRQoHlwNjBV520gGNDku02W4QfTL+SUiZoaIo=;
        b=XPNEu5W3TXeD1llgS9nG23BT8wUfcmol5v9qob7OH5sYc1CTMnuZupQgVoOGzZu1GU09oJ
        hEXh1b1RYeB1vmuve2+rQ9jOa1A4XfXi024xPMhcaIHCCR8rNbyBWvhQFoUgOorUUbj2m/
        PWqonWL0C77h3AThTGiLyVtZsLrYxNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665589447;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dCc1+6QRQoHlwNjBV520gGNDku02W4QfTL+SUiZoaIo=;
        b=SEdxZiC0fsqVkpdGbYGwLP2lXHk96ZaQd1YTnFQTT8nYHeUyz3lVU1bNb4/hPE9A5fhrxc
        Ve7frZdgK5CBhNAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E7B613ACD;
        Wed, 12 Oct 2022 15:44:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 97hWB8fgRmPESgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 12 Oct 2022 15:44:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A9D57A06F3; Wed, 12 Oct 2022 17:44:02 +0200 (CEST)
Date:   Wed, 12 Oct 2022 17:44:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: thoughts about fanotify and HSM
Message-ID: <20221012154402.h5al3junehejsv24@quack3>
References: <CAOQ4uxgyWEvsTATzimYxuKNkdVA5OcfzQOc1he5=r-t=GX-z6g@mail.gmail.com>
 <20220914103006.daa6nkqzehxppdf5@quack3>
 <CAOQ4uxh6C=jMftsFQD3s1u7D_niRDmBaxKTymboJQGTmPD6bXQ@mail.gmail.com>
 <CAOQ4uxjHu4k2-sdM1qtnFPvKRHv-OFWo0cYDZbvjv0sd9bXGZQ@mail.gmail.com>
 <20220922104823.z6465rfro7ataw2i@quack3>
 <CAOQ4uxj_xr4WvHNneeswZO2GEtEGgabc6r-91YR-1P+gPHPhdA@mail.gmail.com>
 <20220926152735.fgvx37rppdfhuokz@quack3>
 <CAOQ4uxgU4q1Pj2-9q7DZGZiw1EPZKXbc_Cp=H_Tu5_sxD6-twA@mail.gmail.com>
 <20220929100145.wruxmbwapjn6dapy@quack3>
 <CAOQ4uxjAn50Z03SysRT0v8AVmtvDHpFUMG6_TYCCX_L9zBD+fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjAn50Z03SysRT0v8AVmtvDHpFUMG6_TYCCX_L9zBD+fg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!

On Fri 07-10-22 16:58:21, Amir Goldstein wrote:
> > > The other use case of automatic inode marks I was thinking about,
> > > which are even more relevant for $SUBJECT is this:
> > > When instantiating a dentry with an inode that has xattr
> > > "security.fanotify.mask" (a.k.a. persistent inode mark), an inode
> > > mark could be auto created and attached to a group with a special sb
> > > mark (we can limit a single special mark per sb).
> > > This could be implemented similar to get_acl(), where i_fsnotify_mask
> > > is always initialized with a special value (i.e. FS_UNINITIALIZED)
> > > which is set to either 0 or non-zero if "security.fanotify.mask" exists.
> > >
> > > The details of how such an API would look like are very unclear to me,
> > > so I will try to focus on the recursive auto inode mark idea.
> >
> > Yeah, although initializing fanotify marks based on xattrs does not look
> > completely crazy I can see a lot of open questions there so I think
> > automatic inode mark idea has more chances for success at this point :).
> 
> I realized that there is one sort of "persistent mark" who raises
> less questions - one that only has an ignore mask.
> 
> ignore masks can have a "static" namespace that is not bound to any
> specific group, but rather a set of groups that join this namespace.
> 
> I played with this idea and wrote some patches:
> https://github.com/amir73il/linux/commits/fan_xattr_ignore_mask

I have glanced over the patches. In general the idea looks OK to me but I
have some concerns:

1) Technically, it may be challenging to call into filesystem xattr
handling code on first event generated by the inode - that may generate
some unexpected lock recursion for some filesystems and some events which
trigger the initialization...

2) What if you set the xattr while the group is already listening to
events? Currently the change will get ignored, won't it? But I guess this
could be handled by clearing the "cached" flag when the xattr is set.

3) What if multiple applications want to use the persistent mark
functionality? I think we need some way to associate a particular
fanotify group with a particular subset of fanotify xattrs so that
coexistence of multiple applications is possible...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
