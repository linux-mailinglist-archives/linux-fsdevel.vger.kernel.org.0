Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168BA564B7F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jul 2022 04:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiGDCKc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 22:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGDCKb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 22:10:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA42C38A4;
        Sun,  3 Jul 2022 19:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=B3aLPDwjpJnxSQ1KUQ7Dm7BQP0bcShCaxYFa6X+qGJo=; b=egxo7OntdvK3g9mMz9VdtCRrBK
        OoSo906h/yFvw8jetwY86USn9PBdj8w6ud4YshUSHa0rEdchWisfc5NF6Zi3IwWWSrWIc9XYrQJwU
        laaTpmrn+ixfmJTillpCvLq5cfDqJsv9rxnq0jiRq950x74RHmssZjSeoPWSvoLPHb51J7/sK0m3w
        iBkkVqsR90nBAcdLOVY6ewOoLjSasufC8yj0bRvFNs2mT5GRWwnn7cPZo/+/HtOwV3BzVlNio23C0
        XbEv6HoDolzm3dUjYgqcJoK7CemIfyHHTSXCNTbwa/uSEjwYCa7UDr6fTnk7J+w+kAnD7zoI+KkhT
        KfJgx+dw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8BXV-00GsK3-Pr; Mon, 04 Jul 2022 02:10:17 +0000
Date:   Mon, 4 Jul 2022 03:10:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com,
        dhowells@redhat.com, vshankar@redhat.com,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com
Subject: Re: [PATCH 1/2] netfs: release the folio lock and put the folio
 before retrying
Message-ID: <YsJMCZB/ecQQha+/@casper.infradead.org>
References: <20220701022947.10716-1-xiubli@redhat.com>
 <20220701022947.10716-2-xiubli@redhat.com>
 <30a4bd0e19626f5fb30f19f0ae70fba2debb361a.camel@kernel.org>
 <f55d10f8-55f6-f56c-bb41-bce139869c8d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f55d10f8-55f6-f56c-bb41-bce139869c8d@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 04, 2022 at 09:13:44AM +0800, Xiubo Li wrote:
> On 7/1/22 6:38 PM, Jeff Layton wrote:
> > I don't know here... I think it might be better to just expect that when
> > this function returns an error that the folio has already been unlocked.
> > Doing it this way will mean that you will lock and unlock the folio a
> > second time for no reason.
> > 
> > Maybe something like this instead?
> > 
> > diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> > index 42f892c5712e..8ae7b0f4c909 100644
> > --- a/fs/netfs/buffered_read.c
> > +++ b/fs/netfs/buffered_read.c
> > @@ -353,7 +353,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
> >                          trace_netfs_failure(NULL, NULL, ret, netfs_fail_check_write_begin);
> >                          if (ret == -EAGAIN)
> >                                  goto retry;
> > -                       goto error;
> > +                       goto error_unlocked;
> >                  }
> >          }
> > @@ -418,6 +418,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
> >   error:
> >          folio_unlock(folio);
> >          folio_put(folio);
> > +error_unlocked:
> >          _leave(" = %d", ret);
> >          return ret;
> >   }
> 
> Then the "afs" won't work correctly:
> 
> 377 static int afs_check_write_begin(struct file *file, loff_t pos, unsigned
> len,
> 378                                  struct folio *folio, void **_fsdata)
> 379 {
> 380         struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
> 381
> 382         return test_bit(AFS_VNODE_DELETED, &vnode->flags) ? -ESTALE : 0;
> 383 }
> 
> The "afs" does nothing with the folio lock.

It's OK to fix AFS too.
