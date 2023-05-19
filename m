Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90EA70957C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 12:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjESK5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 06:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjESK5C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 06:57:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA5C113;
        Fri, 19 May 2023 03:57:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10C4465679;
        Fri, 19 May 2023 10:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F8AC433D2;
        Fri, 19 May 2023 10:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684493820;
        bh=Ny8DZAy5gKR3s60MDtiOGy1mFcI6FdFw0aMN+pXWUOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MAdZDpKPl0mTxDUvAb4tg3zBCnn+EcVd1JzAARb/qLdKqXRiYiVd7ZGphiEBGzWKu
         0ga90+cCzAsqpY7s6I+BtX3Ri8deJ/2dtkrxN9cNbnsA1uLd/kZZYESX9L2KGO9YqO
         HeOLzeKrwK3xNMkl0DeMF8x7Z6wvtsdpV+GxOv+suHCYV7fWdgchnbfjf2AV39UHO6
         oHaDDup4rCm6e4/OAOjbCY/PKGD3c+weVXnN8TSE7h5AApC2K7NrwCUbwi7apF0qs9
         UvFcAxNxUUKUHy0mLlH+kI39is6G66mfHngg+eYPuCBCBMyGZNZp+770WtEW3cNuCL
         pFWO02tA3/CaA==
Date:   Fri, 19 May 2023 12:56:55 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: A pass-through support for NFSv4 style ACL
Message-ID: <20230519-allzu-aufmerksam-c3098b5ecf0d@brauner>
References: <20230516124655.82283-1-jlayton@kernel.org>
 <20230516-notorisch-geblickt-6b591fbd77c1@brauner>
 <TYXPR01MB18549D3A5B0BE777D7F6B284D9799@TYXPR01MB1854.jpnprd01.prod.outlook.com>
 <cc4317d9cb8f10aa0b3750bdb6db8b4e77ff26f8.camel@kernel.org>
 <20230517-herstellen-zitat-21eeccd36558@brauner>
 <20230517123914.GA4578@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517123914.GA4578@mit.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 08:39:14AM -0400, Theodore Ts'o wrote:
> On Wed, May 17, 2023 at 09:42:59AM +0200, Christian Brauner wrote:
> > 
> > I have no idea about the original flame war that ended RichACLs in
> > additition to having no clear clue what RichACLs are supposed to
> > achieve. My current knowledge extends to "Christoph didn't like them".
> 
> As to what RichACL's are supposed to achieve....

Interesting, thanks for all the details!

> 
> Windows/NFSv4 -style ACL's are very different from POSIX semantics, in
> a gazillion ways.  For example, if you set a top-level acl, it will
> automatically affect all of the ACL's in the subhierarcy.  This is
> trivially easy in Windows given that apparently ACL's are evaluated by
> path every time you try to operate on a file (or at least, that's how
> it works effectively; having not taken a look at Windows source code,
> I can't vouch for how it is actually implemented.)  This is, of
> course, a performance disaster and doesn't work all that well for
> Linux where we can do things like like fchdir() and use O_PATH file
> descriptors and *at() system calls.  Moreover, Windows doesn't have
> things like the mode parameter to open(2) and mkdir(2) system calls.
> 
> As a result, RichACL's are quite a bit more complicated than Posix
> ACL's or the Windows-style ACL's from which they were derived because
> they have to compromise between the Windows authorization model and
> the Posix/Linux authorization model while being expressive enough
> to mostly emulate Windows-style ACL's.  For example, instead of
> implementing Windows-style "automatic inheritance", setrichacl(1) will
> do the moral equivalent of chmod -R, and then add a lot of hair in the
> form of "file_inherit, dir_inherit, no_propagate, and inherit_only"
> flags to each ACL entry, which are all there to try to mostly (but not
> completely) handle make Windows-style and Linux/POSIX acl's work
> within the same file system.  There's a lot more detail of the hair
> documented here[1].
> 
> [1] https://www.systutorials.com/docs/linux/man/7-richacl/
> 
> I'll note most of this complexity is only necessary if you want to
> have local file access to the file system work with similar semantics
> as what would get exported via NFSv4.  If you didn't, you could just
> store the Windows-style ACL in an xattr and just let it be set via the
> remote file system, and return it when the remote file system queries
> it.  The problem comes when you want to have "RichACLs" actually
> influence the local Linux permissions check.

Yeah, I'm already scared enough.
