Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE35F75FD75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 19:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjGXRXK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 13:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjGXRXK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CADA98;
        Mon, 24 Jul 2023 10:23:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAE09612BB;
        Mon, 24 Jul 2023 17:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDE4C433C8;
        Mon, 24 Jul 2023 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690219388;
        bh=PHUCwK+xGWEwTqiXLN8XM4Fi947K/7A6EbMvDLkq7/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p8PJsABFgH6TqkMrE6N8QWfuoZ0eUzCT/7+nN/er0L0zcQo7xrDhYyV2FRMdKkTWd
         tvJ3K98wzlx6fUQcoTDkc2NOkA52JUSzeG6YCkA3kiNFaz+0TeJ0RWp4zEDYukA/pG
         jPogPW2gHUA8+loX5oJQwSHpeuwIbIXxziuwzCQIYA3+n98PEtnVFZJl5QUU+Xnc6p
         8V4nfXuuQYln/BO7RpRMzwI2kH4bq7+oMqjSCBxOiBVO46bnjnn81V/TtXxf8oQVDz
         ChjloofNwJd1L8F19zW+Gf0PsZwNWghfgPc35m7pHMrr0H+uo5heAcE5smHyGPd+wf
         w7FFVEYlyIXAA==
Date:   Mon, 24 Jul 2023 19:23:03 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] file: always lock position
Message-ID: <20230724-gebessert-wortwahl-195daecce8f0@brauner>
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-scheren-absegnen-8c807c760ba1@brauner>
 <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whwUTsixPwyBiuA25F2mAzARTU_-BijfmJ3MzkKLOYDmA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 09:36:28AM -0700, Linus Torvalds wrote:
> On Mon, 24 Jul 2023 at 09:19, Christian Brauner <brauner@kernel.org> wrote:
> >
> > SCM_RIGHTS which have existed since 2.1 or sm allow you to do the same
> > thing just cooperatively. If you receive a bunch of fds from another
> > task including sockets and so on they refer to the same struct file.
> 
> Yes, but it has special synchronization rules, eg big comment in
> commit cbcf01128d0a ("af_unix: fix garbage collect vs MSG_PEEK").
> 
> There are magic rules with "total_refs == inflight_refs", and that
> total_refs thing is very much the file count, ie
> 
>                 total_refs = file_count(u->sk.sk_socket->file);
> 
> where we had some nasty bugs with files coming back to life.

It's a bit of a shame that this isn't documented anywhere as that's
pretty sensitive stuff and it seems a high bar to assume that everyone
has that historical knowledge. :/ So we should definitely document this
in Documentation/ going forward.

This means pidfd_getfd() needs the same treatment as MSG_PEEK for sockets.
