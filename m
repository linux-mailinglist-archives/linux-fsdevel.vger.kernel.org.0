Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88657B1731
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 11:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjI1JWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 05:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjI1JWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:22:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD6F1FE9;
        Thu, 28 Sep 2023 02:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=/LbGuJS6p8ohAFxyUvYH7JE8uergoje10e9hBkx1drM=; b=FiJsRqJBMchqjwD4JGykDKK8Wr
        TFIgSWtM+AqF2kjFV3aHNcGwx5mUY4vl/nLmcPZvW9n472XQNhpEML524OSjbNZIxLgDTCADZJOKh
        hdUYnHZvtOY7Cz0AI8UYneHj9mayCZwlOoDSMFRa/C8nClo9DWFaRJ4s1AjjLj+kh3NaGUrhCTfhb
        BjD3bVXryUf+57o7ckyOzkmOWgzTgvZVh63iiO6aLGbxSEp1PqzpDcrKMCKtsDXQ8xsuvYxCWmC8L
        iuio9M0LPZYfTF/Ww/WPFVQsN4sxecHeOPimeRCa/RH0YyGpE83SDNRtjY+pnTPc+gEGUUyaIQTGi
        VznkQPMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qlnDd-001f5z-Cx; Thu, 28 Sep 2023 09:22:01 +0000
Date:   Thu, 28 Sep 2023 10:22:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>
Subject: Re: [PATCH] ovl: punt write aio completion to workqueue
Message-ID: <ZRVFuReyZGbIXOBM@casper.infradead.org>
References: <20230928064636.487317-1-amir73il@gmail.com>
 <fb6c8786-5308-412e-9d87-dac6fd35aa32@kernel.dk>
 <CAOQ4uxjC6qif-MZqkLUsd0RixD0xVHVuGDT=7HCX0kcY1okv2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjC6qif-MZqkLUsd0RixD0xVHVuGDT=7HCX0kcY1okv2A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 28, 2023 at 12:15:00PM +0300, Amir Goldstein wrote:
> On Thu, Sep 28, 2023 at 10:08 AM Jens Axboe <axboe@kernel.dk> wrote:
> > On 9/28/23 12:46 AM, Amir Goldstein wrote:
> > >               ret = -ENOMEM;
> > >               aio_req = kmem_cache_zalloc(ovl_aio_request_cachep, GFP_KERNEL);
> > >               if (!aio_req)
> >
> > Unrelated to this patch, but is this safe? You're allocating an aio_req
> > from within the ->write_iter() handler, yet it's GFP_KERNEL? Seems like
> > that should at least be GFP_NOFS, no?
> 
> I could be wrong, but since overlayfs does not have any page cache
> of its own, I don't think memory reclaim poses a risk.

Use the scoped APIs, people!  GFP_NOFS needs to die.  If your filesystem
cannot tolerate being reentered, call memalloc_nofs_save() / restore()
when it can tolerate being reentered.

> > That aside, punting to a workqueue is a very heavy handed solution to
> > the problem. Maybe it's the only one you have, didn't look too closely
> > at it, but it's definitely not going to increase your performance...
> 
> I bet it won't... but I need to worry about correctness.
> 
> What I would like to know, and that is something that I tried
> to ask you in the Link: discussion, but perhaps I wasn't clear -
> Are there any IOCB flags that the completion caller may set,
> that will hint the submitter that completion is not from interrupt
> context and that punting to workqueue is not needed?

I'd really like page cache write completions to not be handled in
the interrupt handler.  Then we could make the i_pages lock not an
interrupt-disabling lock any more.  I think that'd best be handled in a
workqueue too, but maybe there's a better solution nowadays.
