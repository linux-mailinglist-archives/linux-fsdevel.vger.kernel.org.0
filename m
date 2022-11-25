Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF088638308
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 05:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiKYEJ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 23:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKYEJ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 23:09:26 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6692C21E01;
        Thu, 24 Nov 2022 20:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dhcCjaJ57IsbkqSUTzblE3Oegbl0RdETkw+TxczXs2o=; b=DCfYm8tP3312DF88DmAxxJkMHK
        OPNDqWf+GWrd7eM6AiDwT5jVSQrgxVs//5FMqENYi8QqpoRy34Qjtu0Cea4NMTohQNykElKKlk667
        LbodGSP0owEIB7D5tBEHZoFwoiFlHGCFxBGzuJ+WYwNJjNEvWaVoPwZWmAyq+qI/iG/UU7zxlfN0u
        sq44/Ivv8twQDYsYak2ylZ9+Wx1zVZvNOfvY20hnCa0+KPjoMicOfJzyxDDbTHx9CC/BGxvlVIxIr
        clV7jsaxmrD1QtfIUIjJq1WNKmjg4u0lXVJRBbZZRe9Hu483FzPqBWAR4vAF+do05PW/qR0bFNQU0
        ChfJ7fAA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oyQ1h-006aTm-1R;
        Fri, 25 Nov 2022 04:09:21 +0000
Date:   Fri, 25 Nov 2022 04:09:21 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Pierre Labastie <pierre.labastie@neuf.fr>,
        linux-unionfs@vger.kernel.org
Subject: Re: [regression, bisected] Bug 216738 - Adding O_APPEND to O_RDWR
 with fcntl(fd, F_SETFL) does not work on overlayfs
Message-ID: <Y4A/8VsEidcUchG2@ZenIV>
References: <2505800d-8625-dab0-576a-3a0221954ba3@leemhuis.info>
 <Y3+jz5CVA9S+h2+b@ZenIV>
 <CAJfpeguqCrEbvv4d4jdOnczQ9VOf4u9sSghvnDOWvUb84fv6OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguqCrEbvv4d4jdOnczQ9VOf4u9sSghvnDOWvUb84fv6OQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 24, 2022 at 09:33:54PM +0100, Miklos Szeredi wrote:
> > I could pick it in vfs.git #fixes, or Miklos could put it through his tree.
> > Miklos, which way would you prefer that to go?
> 
> I'll pick this into #overlayfs-next, as a PR for this cycle is needed anyway.

OK...  FWIW, I wonder if exposing setfl() would and using it instead of
open-coding would be a good idea - these two are very close to each other...
