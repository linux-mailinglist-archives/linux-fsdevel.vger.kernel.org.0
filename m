Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B30C780BC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 14:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376881AbjHRM1k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 08:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376883AbjHRM1O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:27:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68443AA3;
        Fri, 18 Aug 2023 05:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/fc1MNvza03TLgwrERiKQBFJ3dxq+IUaLj1LYjuDaIc=; b=DMqXhxh5Ff7Y11+xVEYNDecdue
        9DMw8JAjvnoiBamjTJmoZ6M44HjVSob5wjKco7RvmWGacseHphD4TiN3tNtnVdo5NzIkRz8dMkOv3
        ddRY7hWlsK1eERVrRCA0hgIpM/UrCpzf7yRzdi/UduIdNLUQl5x4aVwaCusoEp2AMSLtWMZh6AGcz
        1fJ8TOEf7W2RlUc65+hz+TzaqsLT9AYmGxCmz0FSc3ydYASudX2Q/FniUcmF/6258cGe+fMLvrung
        gok1uQkGBuLvxxZ9QpqiXMsRMzZ4pyfqoRmLR1GK98Fbh5j3/m+OAE9A51RwuY6JqY18p2K95FnmJ
        JADbbchw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qWyZ9-009PXu-J7; Fri, 18 Aug 2023 12:26:59 +0000
Date:   Fri, 18 Aug 2023 13:26:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'David Howells' <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@list.de>,
        Christian Brauner <christian@brauner.io>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in
 memcpy_from_iter_mc()
Message-ID: <ZN9jkweGABK5LSNU@casper.infradead.org>
References: <CAHk-=wg8G7teERgR7ExNUjHj0yx3dNRopjefnN3zOWWvYADXCw@mail.gmail.com>
 <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com>
 <20230816120741.534415-1-dhowells@redhat.com>
 <20230816120741.534415-3-dhowells@redhat.com>
 <608853.1692190847@warthog.procyon.org.uk>
 <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com>
 <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com>
 <665724.1692218114@warthog.procyon.org.uk>
 <1748360.1692358952@warthog.procyon.org.uk>
 <b9c32d9669174dbbbb8e944146814a98@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9c32d9669174dbbbb8e944146814a98@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 18, 2023 at 12:16:23PM +0000, David Laight wrote:
> > > +	ITER_IOVEC = 1,
> > > +	ITER_UBUF = 2,
> > > +	ITER_KVEC = 4,
> > > +	ITER_BVEC = 8,
> > > +	ITER_XARRAY = 16,
> > > +	ITER_DISCARD = 32,
> 
> IIRC Linus had type:6 - that doesn't leave any headroom
> for additional types (even though they shouldn't proliferate).

I have proposed an ITER_KBUF in the past (it is to KVEC as UBUF is
to IOVEC).  I didn't care enough to keep pushing it, but it's clearly
a common idiom.

