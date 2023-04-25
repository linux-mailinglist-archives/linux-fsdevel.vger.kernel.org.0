Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67C36EE4F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 17:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbjDYPss (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 11:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjDYPsr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:48:47 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D704499;
        Tue, 25 Apr 2023 08:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nhq8YjcSkErGMNBvHsXUdP0g2LgRuD18+BaCmW56ZIY=; b=BG+HMS4+1On7xiFyRHmfX65zAz
        NZFLAaF9/lh58JtcuA6/xfpV0mxiQHL4G8sKDnC/Siie8h2lCrx2Dh0WkTOC61W67ABaUuPnQPCzE
        LuWehfxqRe688BzWlsNnGbIXleSs9pg4fYuRmWG+Da2rjJemV5AIvLFRVP6Ub+7TZhEFm4UmVjO3Q
        0Vjf1gxt5cfHQbzoTQsUJXP2XQFcdLp2qOXfyv/uSXGgrGbHVVvgWDevFhxz1IMbMefckr2/xEyPi
        sJ1Qysd7yWDR91ZRVJyYyfKFCmcde5JTitX7YQtT5BKCxKFutEgoto2BGxwoMqxWuD6wET0P81+Ya
        A1ctZSfQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1prKuJ-00CSGJ-1f;
        Tue, 25 Apr 2023 15:48:43 +0000
Date:   Tue, 25 Apr 2023 16:48:43 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pidfd updates
Message-ID: <20230425154843.GR3390869@ZenIV>
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
 <20230425060427.GP3390869@ZenIV>
 <20230425-sturheit-jungautor-97d92d7861e2@brauner>
 <20230425135429.GQ3390869@ZenIV>
 <20230425-mulmig-wandschmuck-75699afb1ecc@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425-mulmig-wandschmuck-75699afb1ecc@brauner>
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

On Tue, Apr 25, 2023 at 04:36:27PM +0200, Christian Brauner wrote:
> On Tue, Apr 25, 2023 at 02:54:29PM +0100, Al Viro wrote:
> > On Tue, Apr 25, 2023 at 02:34:15PM +0200, Christian Brauner wrote:
> > 
> > > It is rife with misunderstandings just looking at what we did in
> > > kernel/fork.c earlier:
> > > 
> > > 	retval = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
> > >         [...]
> > >         pidfile = anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
> > >                                      O_RDWR | O_CLOEXEC);
> > > 
> > > seeing where both get_unused_fd_flags() and both *_getfile() take flag
> > > arguments. Sure, for us this is pretty straightforward since we've seen
> > > that code a million times. For others it's confusing why there's two
> > > flag arguments. Sure, we could use one flags argument but it still be
> > > weird to look at.
> > 
> > First of all, get_unused_fd_flags() doesn't give a damn about O_RDWR and
> > anon_inode_getfile() - about O_CLOEXEC.  Duplicating the expression in
> > places like that is cargo-culting.
> 
> I distinctly remember us having that conversation about how to do this
> nicely back then and fwiw this is your patch... ;)
> 6fd2fe494b17 ("copy_process(): don't use ksys_close() on cleanups")

Should've followed with "no need to pass nonsense flags to get_unused_fd_flags()
and anon_inode_getfile()"...

> So sure, that was my point: people are confused why there's two flag
> arguments and what exactly has to go into them and just copy-paste
> whatever other users already have.

> There's definitely one where people allocate a file descriptor early on
> and then sometimes maybe way later allocate a struct file and install
> it. And that's where exposing and using get_unused_fd_flags() and
> fd_install() is great and works fine.

FWIW, there's something I toyed with a while ago - a primitive along the
lines of
fd_set_file(fd, file)
{
	if (IS_ERR(file)) {
		put_unused_fd(fd);
		return ERR_PTR(file);
	}
	fd_install(fd, file);
	return fd;
}

That simplifies quite a few places, collapsing failure exit handling.
Not sure how many can be massaged into that form, though...
