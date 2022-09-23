Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9475E756A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 10:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiIWIHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 04:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiIWIHU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:07:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B64911D627
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 01:07:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 823BBCE12C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 08:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2272C433D6;
        Fri, 23 Sep 2022 08:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663920436;
        bh=r2UzhTbM3DjXxzAAxCXY9uiYFuTpfKwUWk/Ny3XH1gM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eSM2MxDHRAPQl+kMNNmeTOZjAqGYApy6kSZjMmECXet5ZRRcdD8BGQXLb/QaBqHqp
         JQlQOQsv0AKxKMgXQEH3qw6mMdS81cizsuGyeiZippkSUkkaP4nGWTy18zzk7XLScc
         XNB5/nGuJHJ/il2kmtD5VEOogTDe/bkJGatH5sab0jOZIGWz7h9Lky+uwOk3EOXQkj
         HuIN9aVhFWZGxdXOhzIGJZnA0yLKW7YYhlE6mhVi2Og0XabxIm6S5WEtNkY9+lypwp
         6zvzQOYjL7OVUhP4o3ZTWS+dYChQeG53k+3Mt9NRO+5SDPM3ZoFmFOkbq6L63qVWPe
         aMj1+QEkCVMQQ==
Date:   Fri, 23 Sep 2022 10:07:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 03/29] fs: add new get acl method
Message-ID: <20220923080707.b2sejmu5ydbrnywp@wittgenstein>
References: <20220922151728.1557914-1-brauner@kernel.org>
 <20220922151728.1557914-4-brauner@kernel.org>
 <20220923064602.GC16489@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220923064602.GC16489@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 23, 2022 at 08:46:02AM +0200, Christoph Hellwig wrote:
> The new method looks good to me, but the patch structuring here
> where we add just the method without caller, than a bunch of
> instances and only then use them seems odd to me.  Isn't there
> some better way to make sure that the newly wire up instances
> actually get used from the start?

The problem is that we have stacking filesystems and once we switch the
vfs over then both stacking filesystems themselves as well as all
filesystems they're stackable upon need to be already converted to the
new posix acl api.

So we can't just switch the vfs or just the stacking filesystems we need
them to switch together after conversion has finished.

(And we do have more stacking fses then we often think. Yhe famous one
is obivously overlayfs but there's ecryptfs and now also ksmbd,
technically cachefiles and I'm probably forgetting a few others. Most of
these luckily don't mess with posix acls.)

I don't think other ways will necessarily give us anything nicer. At
least I haven't come up with a better way.
