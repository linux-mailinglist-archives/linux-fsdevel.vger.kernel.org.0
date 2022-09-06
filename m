Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781465ADEE6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 07:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiIFF3p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 01:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiIFF3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 01:29:41 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC71EE29
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Sep 2022 22:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mXPK6jY7DovOBIiV8RL06xxHnGdeIYXsf2+lRkMW5uc=; b=pkV+wB3KkuaIVtjMmnnVe3mk4z
        jFdVnyUluMp6bxD5+lUhbK9qT0Ow0v4cC0e9FMQPv7JG4ktjrFN2S0dV6iNvsYOdpu21cVZSbIfJJ
        ke4pEJdIX0AfLoCKNQWF1hohdQXWjUiX60oAWBVNcipJSC6J3UJPxVGOd1+VuwYalpWkEfpK7Dxns
        jo5RzSaChqEiezPKP3Qjbm9svnI1epZOudU91eYIDQETlw5Be2G9gpmaz1Fsw/zyuagkifmxleTQR
        zrxI7Fmlu1lgJ/uny/v+h5aZfoQk7iYFWFSYC7jWcxYgG1HaIM5RZ3pHYLS8Y0v5zGfbICE9gwGfm
        cXbvPHTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oVR9M-00CaP3-Fa;
        Tue, 06 Sep 2022 05:29:28 +0000
Date:   Tue, 6 Sep 2022 06:29:28 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Yu-li Lin <yulilin@google.com>,
        chirantan@chromium.org, dgreid@chromium.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        suleiman@chromium.org
Subject: Re: [PATCH 2/2] fuse: Implement O_TMPFILE support
Message-ID: <YxbauDXVcjD7oaiy@ZenIV>
References: <CAJfpegvsCQ+rJv2rSk3mUMsX_N26ardW=MYbHxifO5DU7uSYqA@mail.gmail.com>
 <20220831025704.240962-1-yulilin@google.com>
 <CAJfpegvMGxigBe=3tgwBRKuSS0H1ey=0WhOkgOz5di-LqXH-HQ@mail.gmail.com>
 <CAMW0D+epkBMTEzzJhkX7HeEepCH=yxJ-rytnA+XWQ8ao=CREqw@mail.gmail.com>
 <YxYbCt4/S4r2JHw2@miu.piliscsaba.redhat.com>
 <CAOQ4uxiK-nwpu8eNFByfHgfmEehMD9OEktjNF39ZY2v2NJMBmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiK-nwpu8eNFByfHgfmEehMD9OEktjNF39ZY2v2NJMBmw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 06, 2022 at 07:58:50AM +0300, Amir Goldstein wrote:
> On Mon, Sep 5, 2022 at 7:25 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Wed, Aug 31, 2022 at 02:30:40PM -0700, Yu-li Lin wrote:
> > > Thanks for the reference. IIUC, the consensus is to make it atomic,
> > > although there's no agreement on how it should be done. Does that mean
> > > we should hold off on
> > > this patch until atomic temp files are figured out higher in the stack
> > > or do you have thoughts on how the fuse uapi should look like prior to
> > > the vfs/refactoring decision?
> >
> > Here's a patch refactoring the tmpfile kapi to return an open file instead of a
> > dentry.
> >
> > Comments?
> 
> IDGI. Why did you need to place do_dentry_open() in all the implementations
> and not inside vfs_tmpfile_new()?
> Am I missing something?

	The whole point of that horror is to have open done inside ->tmpfile()
instances...

	Al, very unhappy with proposed interface ;-/
