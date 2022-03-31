Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AC84ED74B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 11:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbiCaJvu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 05:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbiCaJvp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:51:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA322028B5;
        Thu, 31 Mar 2022 02:49:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 73487210FC;
        Thu, 31 Mar 2022 09:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648720191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u6+sAd7YfiATOTQjdt06KmdXfLb03Ey01Ml9uR3Qy70=;
        b=rtVvL0bJsq0D7n8ZZ/w9oE5W4D/OtG7q5Lu+HFJXpHzjI2IHjYVbdOOzLCcsMMzpN+mEzO
        DTrWM2NGTEPyfCmrwMI+M+CVZPY7+cWUAeApEZ/egeHeIC0D5m5e3Zc6DWOmLak5T9OVXj
        OLQQGSbcIELXvaP9cPrnd3AK29Rvfww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648720191;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u6+sAd7YfiATOTQjdt06KmdXfLb03Ey01Ml9uR3Qy70=;
        b=BiVGZFZAhSZLwCmNCTwbmXhiiXKNTmxzSjNJjsa+wKyLy9+w0yA6u/GiJChs0xDzhK/K3O
        6TBo6IsnvdE6hoAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4689B132DC;
        Thu, 31 Mar 2022 09:49:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PLrBDz95RWLARQAAMHmgww
        (envelope-from <ddiss@suse.de>); Thu, 31 Mar 2022 09:49:51 +0000
Date:   Thu, 31 Mar 2022 11:49:49 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     "NeilBrown" <neilb@suse.de>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] VFS: filename_create(): fix incorrect intent.
Message-ID: <20220331114949.02fae137@suse.de>
In-Reply-To: <164868118815.25542.13263176689793254608@noble.neil.brown.name>
References: <164842900895.6096.10753358086437966517@noble.neil.brown.name>
        <20220330101408.2bbb47ee@suse.de>
        <164868118815.25542.13263176689793254608@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 31 Mar 2022 09:59:48 +1100, NeilBrown wrote:

> On Wed, 30 Mar 2022, David Disseldorp wrote:
> > Hi Neil,
> > 
> > I gave this a spin and was wondering why xfstests wouldn't start with
> > this change...
> > 
> > On Mon, 28 Mar 2022 11:56:48 +1100, NeilBrown wrote:
> > ...  
> > > 
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 3f1829b3ab5b..3ffb42e56a8e 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -3676,7 +3676,6 @@ static struct dentry *filename_create(int dfd, struct filename *name,
> > >  	int type;
> > >  	int err2;
> > >  	int error;
> > > -	bool is_dir = (lookup_flags & LOOKUP_DIRECTORY);
> > >  
> > >  	/*
> > >  	 * Note that only LOOKUP_REVAL and LOOKUP_DIRECTORY matter here. Any
> > > @@ -3698,9 +3697,11 @@ static struct dentry *filename_create(int dfd, struct filename *name,
> > >  	/* don't fail immediately if it's r/o, at least try to report other errors */
> > >  	err2 = mnt_want_write(path->mnt);
> > >  	/*
> > > -	 * Do the final lookup.
> > > +	 * Do the final lookup.  Request 'create' only if there is no trailing
> > > +	 * '/', or if directory is requested.
> > >  	 */
> > > -	lookup_flags |= LOOKUP_CREATE | LOOKUP_EXCL;
> > > +	if (!last.name[last.len] || (lookup_flags & LOOKUP_DIRECTORY))
> > > +		lookup_flags |= LOOKUP_CREATE | LOOKUP_EXCL;  
> > 
> > This doesn't look right, as any LOOKUP_DIRECTORY flag gets dropped via
> > the prior "lookup_flags &= LOOKUP_REVAL;".  
> 
> Arg.. thanks for testing - I clearly should have tested more broadly.
> 
> I could leave the "is_dir" variable there I guess.
> Or maybe the masking statement should be 
>     lookup_flags &= LOOKUP_REVAL | LOOKUP_DIRECTORY;
> as that is a better match for the comment.

Modifying "lookup_flags" results in changed filename_parentat() and
__lookup_hash() parameters, which isn't an intended consequence IIUC. I
think retaining "is_dir" would make sense.

Cheers, David
