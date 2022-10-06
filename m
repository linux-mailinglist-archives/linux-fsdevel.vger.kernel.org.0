Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0C15F6845
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 15:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiJFNfm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 09:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiJFNfl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:35:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EA1AA368;
        Thu,  6 Oct 2022 06:35:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2058AB82088;
        Thu,  6 Oct 2022 13:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FAAC433D6;
        Thu,  6 Oct 2022 13:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665063337;
        bh=ViEMSxsUJ1UqhVTBkNbIrBa+2wTdALFNnTrC+KQewGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TUgb/GA2SQMKPpzOBD9MIGZAs8APeWu1miAVoPNA9tWjfXEajwncdViE+LSWhtrzV
         yzV7ayaDEPdKsr20+qITIO8w7SeP33J0FvYNeulgi6kgTzxBpF7/Qs6QvvlqJC0Kd+
         AkRH+t42Ev0Uv5hsHckAbw1V/YsJXoBIvMvUm91AZbYDwvuP/Papk2ZnIevuB+4X0h
         czn1pdoFhiIMuJ+r9EcSVrshJ9Wssw0tE94qVU6q6AKl4p6D2cx2mm4EniMjwMoJQR
         WmQxhxR9uavsRS/NNQc6kQHSLbjYGQ0ALWg7Y4j75W7SaX69N1Z/feQso/WN1a4ke/
         svokE9UY7trMQ==
Date:   Thu, 6 Oct 2022 15:35:32 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] attr: use consistent sgid stripping checks
Message-ID: <20221006133532.umwp6gzsh3wujwng@wittgenstein>
References: <20221005151433.898175-1-brauner@kernel.org>
 <20221005151433.898175-2-brauner@kernel.org>
 <CAJfpegss=79W+BXpOH_n7ZOtci1O0njHHxZMnb8ULJBStkq7mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegss=79W+BXpOH_n7ZOtci1O0njHHxZMnb8ULJBStkq7mg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:03:23PM +0200, Miklos Szeredi wrote:
> On Wed, 5 Oct 2022 at 17:14, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Currently setgid stripping in file_remove_privs()'s should_remove_suid()
> > helper is inconsistent with other parts of the vfs. Specifically, it only
> > raises ATTR_KILL_SGID if the inode is S_ISGID and S_IXGRP but not if the
> > inode isn't in the caller's groups and the caller isn't privileged over the
> > inode although we require this already in setattr_prepare() and
> > setattr_copy() and so all filesystem implement this requirement implicitly
> > because they have to use setattr_{prepare,copy}() anyway.
> 
> Could the actual code (not just the logic) be shared between
> should_remove_sgid() and setattr_copy()?
> 
> Maybe add another helper, or reformulate should_remove_sgid() so that
> it can be used for both purposes.

Yeah, thanks for pointing that out. I'm actually working on that.
