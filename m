Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB655C00BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 17:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiIUPIF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 11:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiIUPIE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:08:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2747754D
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 08:08:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11EC2B82509
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 15:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7135C433D6;
        Wed, 21 Sep 2022 15:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663772880;
        bh=g6qJp0RW67KdIQdwo9pb4hUX+aXyZQEqiebt0VzSv9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VdPyup6Ww6sryRy3y9HmQqnF3m+IDuwCBIkB7Km0sgC1wL967Nc3MYOD6EBt/KT5w
         hGODZEiUcjXYhZn+vN4/UUiI9J13P+7mYCNodv+d7AHg9T0Gqrr2y3Cz17XfYJUFGs
         iVG1C+NQCibm5Od5tj7af3jpN/AlCjJG/x6Bhiw9KlW1HBgJmO14JymedRVnIIHpCn
         UFceB2UgxgEf/4LiVAqcCysumDt2m+JMd+DQxCV2Fg/A+k5BROauHFdeH4bqDicYHf
         BzZKqK5xdy1yuMt98MQHgrurdychPH3TxLkv8rYHBbApfaScD+lbURJCZKnB6omSOp
         v458DfBydrFkg==
Date:   Wed, 21 Sep 2022 17:07:50 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v3 8/9] vfs: open inside ->tmpfile()
Message-ID: <20220921150750.grruzm3copwproyu@wittgenstein>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
 <20220920193632.2215598-9-mszeredi@redhat.com>
 <20220921090820.woijqimkphaf3qll@wittgenstein>
 <CAJfpegt8ZX88EbDqPci5ZOBDkrT-bZt=T+XWarw0=zpCAxkLwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegt8ZX88EbDqPci5ZOBDkrT-bZt=T+XWarw0=zpCAxkLwQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 04:58:38PM +0200, Miklos Szeredi wrote:
> On Wed, 21 Sept 2022 at 11:08, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Sep 20, 2022 at 09:36:31PM +0200, Miklos Szeredi wrote:
> > > This is in preparation for adding tmpfile support to fuse, which requires
> > > that the tmpfile creation and opening are done as a single operation.
> > >
> > > Replace the 'struct dentry *' argument of i_op->tmpfile with
> > > 'struct file *'.
> > >
> > > Call finish_open_simple() as the last thing in ->tmpfile() instances (may
> > > be omitted in the error case).
> > >
> > > Change d_tmpfile() argument to 'struct file *' as well to make callers more
> > > readable.
> > >
> > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > ---
> >
> > Seems fine to me. Fwiw, it feels like all the file->f_path.dentry derefs
> > could be wrapped in a helper similar to file_inode(). I know we have
> > file_dentry() but that calls d_real() so not sure if that'll be correct
> > for all updated callers,
> 
> I don't think file_dentry() should be used for this.
> 
> file_dentry() is basically a hack for overlayfs's "fake path" thing.
> It should only be used where strictly necessary.  At one point it
> would be good to look again at cleaning this mess up.

Yeah, that's what I was getting at. The file_dentry() helper would
ideally just be as simple as file_inode() and then we'd have
file_dentry_real() for the stacking filesystem scenarios.
