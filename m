Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD4E5A4163
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 05:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiH2DNH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 23:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiH2DNF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:13:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4788817A8A;
        Sun, 28 Aug 2022 20:13:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CD0C01FAA4;
        Mon, 29 Aug 2022 03:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661742783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f26RWbmfVsNehc6AfEHFnxY9Zicti3u2CzpcOTKnX1U=;
        b=xqZ1mIDUJQ6aBwLK/HkmkxAAOMUssRnXtGUq841L2g47+DG/9Rs188TWBpanz0z+z6yHxN
        bKU/9CSBG/OadMnjEJr7d5+i8VPPnwzi2szu7lerwzmI7sX7eQO5H+mQVWjHuGG3d3Gck4
        GxmCYeyy90vMER+1BYPh97qTsjdelm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661742783;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f26RWbmfVsNehc6AfEHFnxY9Zicti3u2CzpcOTKnX1U=;
        b=WBGv3CrPPeptqETKZpF89+FgFT7gOLHDpu6tUbgyxGRmEZCQWbiNqdr9WZJEiu44UgDa71
        uiBXSXinPz+Ak+Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75808133A6;
        Mon, 29 Aug 2022 03:13:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AKxIDb0uDGPBIAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 29 Aug 2022 03:13:01 +0000
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
Subject: Re: [PATCH 08/10] NFSD: allow parallel creates from nfsd
In-reply-to: <Ywmfg2vP5tDWdzOY@ZenIV>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>,
 <166147984376.25420.3784384336816172144.stgit@noble.brown>,
 <Ywmfg2vP5tDWdzOY@ZenIV>
Date:   Mon, 29 Aug 2022 13:12:58 +1000
Message-id: <166174277856.27490.5042755038091513802@noble.neil.brown.name>
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
> 
> >  	if (is_create_with_attrs(open))
> >  		nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
> > +	inode = d_inode(path.dentry);
> >  
> > -	inode_lock_nested(inode, I_MUTEX_PARENT);
> > +	child = filename_create_one_len(open->op_fname,
> > +					open->op_fnamelen,
> > +					&path, 0, &wq);
> >  
> > -	child = lookup_one_len(open->op_fname, parent, open->op_fnamelen);
> > -	if (IS_ERR(child)) {
> > -		status = nfserrno(PTR_ERR(child));
> > -		goto out;
> > -	}
> > +	if (IS_ERR(child))
> > +		return nfserrno(PTR_ERR(child));
> 
> Leaks acls, by the look of it?

Yep - I think that fell through a crack when I reordered patches to get
get some clean-ups into nfsd before this repost.

> 
> > +	if (!IS_PAR_UPDATE(fhp->fh_dentry->d_inode) &&
> > +	    inode_trylock_shared(fhp->fh_dentry->d_inode)) {
> > +		/* only have a shared lock */
> > +		inode_unlock_shared(fhp->fh_dentry->d_inode);
> > +		fhp->fh_no_atomic_attr = true;
> > +		fhp->fh_no_wcc = true;
> 
> Er...  Shouldn't that be IS_PAR_UPDATE() && ... ?
> 
Definitely.  Thanks!

NeilBrown
