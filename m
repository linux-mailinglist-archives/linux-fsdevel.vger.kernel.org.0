Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E88A6EE37D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 15:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjDYNyf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 09:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjDYNyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:54:33 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F33184;
        Tue, 25 Apr 2023 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k/Lcc5ci35ckXUfmlZrOfLVKgK878IfthEo5BY6xFvk=; b=EQEr/Df6JpKgE0uP3lklAk80ZF
        WFyX1V7Si10GgiUI/RIp1G11KKASXSuPY9zbRV0HPdQFJxlfxBOjxKyayrgleD8gxfEiq0dKH8byu
        C0GEwSGGmCNLa6AxjUi4TZCnY2kMzUh1w8L+nYiSgIrusExp8fVgHg09+5ils+LOWxf64ZhrTBwqs
        4RaTUU88PjZ/YHCuKR+h/QB5bDw3jrl7tzPdDYODxS7dvrlkASCire73Uc2rPzGdOubBfkuT6foMx
        nVbWv5Lb7x3w8q+AYAzDwCUuWcn1JfHXNimAPEMFTEApJpocO3kKYhYqBrotTi5VGkSVTLfb7I0Tt
        O8tYgNMA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1prJ7l-00CQhy-1I;
        Tue, 25 Apr 2023 13:54:29 +0000
Date:   Tue, 25 Apr 2023 14:54:29 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pidfd updates
Message-ID: <20230425135429.GQ3390869@ZenIV>
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
 <20230425060427.GP3390869@ZenIV>
 <20230425-sturheit-jungautor-97d92d7861e2@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425-sturheit-jungautor-97d92d7861e2@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 25, 2023 at 02:34:15PM +0200, Christian Brauner wrote:

> It is rife with misunderstandings just looking at what we did in
> kernel/fork.c earlier:
> 
> 	retval = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
>         [...]
>         pidfile = anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
>                                      O_RDWR | O_CLOEXEC);
> 
> seeing where both get_unused_fd_flags() and both *_getfile() take flag
> arguments. Sure, for us this is pretty straightforward since we've seen
> that code a million times. For others it's confusing why there's two
> flag arguments. Sure, we could use one flags argument but it still be
> weird to look at.

First of all, get_unused_fd_flags() doesn't give a damn about O_RDWR and
anon_inode_getfile() - about O_CLOEXEC.  Duplicating the expression in
places like that is cargo-culting.
 
> But with this api we also force all users to remember that they need to
> cleanup the fd and the file - but definitely one - depending on where
> they fail.
> 
> But conceptually the fd and the file belong together. After all it's the
> file we're about to make that reserved fd refer to.

Why?  The common pattern is
	* reserve the descriptor
	* do some work that might fail
	* get struct file set up (which also might fail)
	* do more work (possibly including copyout, etc.)
	* install file into descriptor table

We want to reserve the descriptor early, since it's about the easiest
thing to undo.  Why bother doing it next to file setup?  That can be
pretty deep in call chain and doing it that way comes with headache
about passing the damn thing around.  And cleanup rules with your
variant end up being more complicated.

Keep the manipulations of descriptor table as close to the surface
as possible.  The real work is with file references; descriptors
belong in userland and passing them around kernel-side is asking
for headache.
