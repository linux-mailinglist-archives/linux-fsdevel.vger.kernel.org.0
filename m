Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AD95C01CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 17:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiIUPjz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 11:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiIUPjZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:39:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CDD82748
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 08:36:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F866B80AEC
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 15:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02C1C433C1;
        Wed, 21 Sep 2022 15:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663774588;
        bh=dnmJS3+d7FnDQ3XQZohcNq4MsUekzIkcWPem/2K5lwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oseShktPA3l2OlxzlO8NcGgx+FfF/3R8GPYHbfZ7r2s+tTYt7fB/I6tNmhl3MRj06
         KYTd7tmdr1iYdZ0C3lCA9UQeqLC+8QkMxT95KFIPpAyOeIAgcsI1oxbq63iNf9kqyA
         kXeqJ6pFETFjBjYfwog8s4ENoUJCtnD89tFlmH1AEst2XR0NrC/JnQmOGcIcC/QYNH
         rvV8oFBIj2mOKgrCD8AwRw3Q2OzjFIrHiZXjG1eTRzFkhnCY8EIJfNVTb2lJZ/hCkZ
         mxCCNReTf+m+/Zz86Mz9FsoavKXii/bJHFVhYFPGrKrdxJD76/+NYQ8envJooRqtqN
         IOkXWEErRup5Q==
Date:   Wed, 21 Sep 2022 17:36:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [PATCH v3 8/9] vfs: open inside ->tmpfile()
Message-ID: <20220921153622.3mhqs23mqanl3xdt@wittgenstein>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
 <20220920193632.2215598-9-mszeredi@redhat.com>
 <20220921090820.woijqimkphaf3qll@wittgenstein>
 <CAJfpegt8ZX88EbDqPci5ZOBDkrT-bZt=T+XWarw0=zpCAxkLwQ@mail.gmail.com>
 <20220921150750.grruzm3copwproyu@wittgenstein>
 <CAJfpegtZwMUGQ+J+STD9V9rxjX=vCKD-YBtLgWpe+GAf75ffkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegtZwMUGQ+J+STD9V9rxjX=vCKD-YBtLgWpe+GAf75ffkw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 05:27:18PM +0200, Miklos Szeredi wrote:
> On Wed, 21 Sept 2022 at 17:08, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Wed, Sep 21, 2022 at 04:58:38PM +0200, Miklos Szeredi wrote:
> 
> > > file_dentry() is basically a hack for overlayfs's "fake path" thing.
> > > It should only be used where strictly necessary.  At one point it
> > > would be good to look again at cleaning this mess up.
> >
> > Yeah, that's what I was getting at. The file_dentry() helper would
> > ideally just be as simple as file_inode() and then we'd have
> > file_dentry_real() for the stacking filesystem scenarios.
> 
> Sure.  But that again belongs to a separate discussion, imo.

Separate patchset for sure.
