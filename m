Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BC772BD14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 11:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjFLJvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 05:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjFLJuu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:50:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C375B423E
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 02:35:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 611546128E
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 09:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E831C4339B;
        Mon, 12 Jun 2023 09:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686562516;
        bh=CZsu52LmuruUJYAVDXYqBPHBpFykNLj71HB4tOKOLlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGv1ffNTbO7Eoh8DBrNI9RWDzDY4RiUPrrQdJC2eob8r6H4uN08RxXCymGXyYrdST
         ljwA612wnzTsB1+sp5xuM7/HEcW0zwp6QCoz8R9BTKTfqCisXUYiKioZaFz082dk+M
         aJLujVjnclN77vkVGp+jRsZ2PkTpbvogVnAjx4n9/vGM59kCTiJd9dFw7mJ9y6dd6x
         JpsLohgtF6q4V0cGYh8t4XWj/tEZ/cjapl7Ts+KNvrN96kNA4X7TZyZCRGfPjZ7iJo
         yVM/nYqyR6jZhFZnutZR4X+6/RtY08J1fFW3q+Rxd/6+F1HTQwsXTC0lofox5FL7i9
         ui7trDWuNjM6g==
Date:   Mon, 12 Jun 2023 11:35:12 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: move fsnotify_open() hook into do_dentry_open()
Message-ID: <20230612-aufzuarbeiten-geklebt-5af9b817f764@brauner>
References: <20230611122429.1499617-1-amir73il@gmail.com>
 <20230612085431.ycbzjj7wk6qij3qf@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230612085431.ycbzjj7wk6qij3qf@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 10:54:31AM +0200, Jan Kara wrote:
> On Sun 11-06-23 15:24:29, Amir Goldstein wrote:
> > fsnotify_open() hook is called only from high level system calls
> > context and not called for the very many helpers to open files.
> > 
> > This may makes sense for many of the special file open cases, but it is
> > inconsistent with fsnotify_close() hook that is called for every last
> > fput() of on a file object with FMODE_OPENED.
> > 
> > As a result, it is possible to observe ACCESS, MODIFY and CLOSE events
> > without ever observing an OPEN event.
> > 
> > Fix this inconsistency by replacing all the fsnotify_open() hooks with
> > a single hook inside do_dentry_open().
> > 
> > If there are special cases that would like to opt-out of the possible
> > overhead of fsnotify() call in fsnotify_open(), they would probably also
> > want to avoid the overhead of fsnotify() call in the rest of the fsnotify
> > hooks, so they should be opening that file with the __FMODE_NONOTIFY flag.
> > 
> > However, in the majority of those cases, the s_fsnotify_connectors
> > optimization in fsnotify_parent() would be sufficient to avoid the
> > overhead of fsnotify() call anyway.
> > 
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> 
> Thanks! The cleanup looks nice so I've applied it with the typo fixup from
> Christian. I have a slight worry this might break something subtle
> somewhere but after searching for a while I didn't find anything and the
> machine boots and ltp tests pass so it's worth a try :)

Yep, I agree. If we can reduce cluttering multiple places with
fsnotify_open() and instead move it to a central location it's a
maintenance win in the long term.
