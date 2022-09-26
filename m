Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EF55E9C23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 10:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiIZIfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 04:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbiIZIfr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:35:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F9E3AE54;
        Mon, 26 Sep 2022 01:35:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00415B819A1;
        Mon, 26 Sep 2022 08:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBDFC433C1;
        Mon, 26 Sep 2022 08:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664181337;
        bh=jAiFKY9REf+j70Ep4ugBF7W0LbNMBPRZhQNPjPecT+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W+ThhAKQMlzEUH3XYhSizjJQc94UWA//zJHPyT3WLTHachXfxGQsD1lXRbBmRYryi
         fVlVHxPCKafNm0MMw7Lx9VT0LUZX6z/+776SHilpIZqXx9ROc88sEDeBKk8MpBeVW2
         2H2IUFLLiD7wzhI2BZ7+iEWFAxzmhQuJJeGDznWCJTOsOX8xFoDwgx8Rbx48aLclYe
         e2WkfGjhgFQMsPNfCKkxRAF6jrt0P+zlniDrrE5B4k5VDgL1zEIOBH6tPxiny7S2ij
         ZfU6KPan7NM84vdkr7Zg5m2va8H08QwiZbUXRNSNxQXRl88+OqkSftBftgkfCkwwd2
         CFbFHyLjPhJOA==
Date:   Mon, 26 Sep 2022 10:35:31 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Steve French <smfrench@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-cifs@vger.kernel.org
Subject: Re: [PATCH 04/29] cifs: implement get acl method
Message-ID: <20220926083531.kh3swhh4lsst4jrp@wittgenstein>
References: <20220922151728.1557914-1-brauner@kernel.org>
 <20220922151728.1557914-5-brauner@kernel.org>
 <CAH2r5mvkSW1FY2tP87mKGrOMkoN8tbOP9r=xJ4XnVbkcrE9guA@mail.gmail.com>
 <20220923083810.ff7jfaszl7qhoutd@wittgenstein>
 <CAH2r5mt2Em03zN+HgL0=YZ335PLyJoBf5z3H2_Mn7y3rF=xS=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH2r5mt2Em03zN+HgL0=YZ335PLyJoBf5z3H2_Mn7y3rF=xS=A@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 25, 2022 at 05:53:03PM -0500, Steve French wrote:
> On Fri, Sep 23, 2022 at 3:38 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, Sep 22, 2022 at 10:52:43PM -0500, Steve French wrote:
> > > Looks like the SMB1 Protocol operations for get/set posix ACL were
> > > removed in the companion patch (in SMB3, POSIX ACLs have to be handled
> >
> > Sorry, what companion patch? Is a patch in this series or are you
> > referring to something else?
> 
> I found it - the patch order was confusing (I saw patches 4 and 27,
> but patch 5 was
> missed).  The functions I was asking about were deleted in patch 27 in
> your series but readded in patch 5 which I had missed.

Ok, so we should be good.

> 
> On the more general topic of POSIX ACLs:
> - Note that they are supported for SMB1 (to some servers, including Samba)
> - But ... almost all servers (including modern ones, not just ancient
> SMB1 servers) support "RichACLs" (remember that RichACLs  were
> originally based on SMB/NTFS ACLs and include deny ACEs so cover use
> cases that primitive POSIX ACLs can't handle) but for cifs.ko we have
> to map the local UID to a global unique ID for each ACE (ie id to SID
> translation).  I am interested in the topic for how it is recommended
> to map "POSIX ACLs" to "RichACLs."  I am also interested in making

I think this calls for a session during next years LSFMM but it's a bit
out of scope for this refactoring. :) But we should keep this discussion
in mind!
