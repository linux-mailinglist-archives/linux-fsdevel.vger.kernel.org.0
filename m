Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965C05A3490
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Aug 2022 06:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243634AbiH0Ehn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 00:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244615AbiH0Ehf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 00:37:35 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BDBABD7B;
        Fri, 26 Aug 2022 21:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7F7KoR+pbWAeq4uRGTd/CTEkLm1sJHbvegiLLMNLvrg=; b=NMafFJ4At9KjtQl77wABCL/Itc
        CbLmc3DlTJMGgsA7yjMRoK6FOPoarly+OecKKVBA00SSRN1+4c7/4gdBFkJ2Mm2wm7BQ8TB4scQ2v
        DjWzsIIVUzyag+C9YD3w7dot6FMqkeEKfCST0oDRos84cloypWY+/DRyjNl1fRyoKbSiHb3QA5qmJ
        pA30cmUbkYgwZc9u4iF9wMPYIsHJFhkwvViWADFYhN6BQtFWf6D8jt9JHfX5a7Duwde/NRYxsT246
        QLVrGu4lRWpswV/jB0IQvVy3e2VWToJB2g9sLDeGVMp5PXw0L4dfxprtnzIYwlXMMliIPQlVyCMq+
        bziC4f8w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oRnZT-008sPn-6J;
        Sat, 27 Aug 2022 04:37:23 +0000
Date:   Sat, 27 Aug 2022 05:37:23 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/10] NFSD: allow parallel creates from nfsd
Message-ID: <Ywmfg2vP5tDWdzOY@ZenIV>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
 <166147984376.25420.3784384336816172144.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166147984376.25420.3784384336816172144.stgit@noble.brown>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 26, 2022 at 12:10:43PM +1000, NeilBrown wrote:

>  	if (is_create_with_attrs(open))
>  		nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
> +	inode = d_inode(path.dentry);
>  
> -	inode_lock_nested(inode, I_MUTEX_PARENT);
> +	child = filename_create_one_len(open->op_fname,
> +					open->op_fnamelen,
> +					&path, 0, &wq);
>  
> -	child = lookup_one_len(open->op_fname, parent, open->op_fnamelen);
> -	if (IS_ERR(child)) {
> -		status = nfserrno(PTR_ERR(child));
> -		goto out;
> -	}
> +	if (IS_ERR(child))
> +		return nfserrno(PTR_ERR(child));

Leaks acls, by the look of it?

> +	if (!IS_PAR_UPDATE(fhp->fh_dentry->d_inode) &&
> +	    inode_trylock_shared(fhp->fh_dentry->d_inode)) {
> +		/* only have a shared lock */
> +		inode_unlock_shared(fhp->fh_dentry->d_inode);
> +		fhp->fh_no_atomic_attr = true;
> +		fhp->fh_no_wcc = true;

Er...  Shouldn't that be IS_PAR_UPDATE() && ... ?
