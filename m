Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC8A770215
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjHDNne (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjHDNnc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:43:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D769CC;
        Fri,  4 Aug 2023 06:43:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AEAF6202F;
        Fri,  4 Aug 2023 13:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3648C433C8;
        Fri,  4 Aug 2023 13:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691156610;
        bh=kbI6uhsKaWV3wJ5jBexDIv4wahQYe+iY2KZ8KvjLd9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GLO4E4/Niv1mv6bDyeWgczh41Iqlr39LpdYBsDSPtPGA27oOoWoNPZkbmKTtR1Kzk
         13OXMwVrtjv/MGGCcAyVCJ3uN5A/WeLfgiMXA8ZgUkBFjG+65DEFlarwKFgJzFxWMF
         BdoKwj5YPEmVXgEB/MuAu3Hh67i1zn96lAuIPjqTloYht5cPC/FnBDWkD0LaIlO5Y4
         0eumFU7Uhgvgb2fv3AZSx7ZbTDH7VsaHF5yp5Osdq3hiKn09DaQ6yQNutHrSZt+xKd
         EoEVARJUAcH1LjyuYxhafmM3l42pWA1A6b6zerJmSHqCva+655e578MHzlRLbzFq2f
         sN3z/jwc+S+eg==
Date:   Fri, 4 Aug 2023 15:43:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] file: always lock position
Message-ID: <20230804-turnverein-misswirtschaft-ef07a4d7bbec@brauner>
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
 <20230724-pyjama-papier-9e4cdf5359cb@brauner>
 <CAHk-=wj2XZqex6kzz7SbdVHwP9fFoOvHSzHj--0KuxyrVO+3-w@mail.gmail.com>
 <20230803095311.ijpvhx3fyrbkasul@f>
 <CAHk-=whQ51+rKrnUYeuw3EgJMv2RJrwd7UO9qCgOkUdJzcirWw@mail.gmail.com>
 <20230803-libellen-klebrig-0a9e19dfa7dd@brauner>
 <CAHk-=wi97khTatMKCvJD4tBkf6rMKTP=fLQDnok7MGEEewSz9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi97khTatMKCvJD4tBkf6rMKTP=fLQDnok7MGEEewSz9g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 03, 2023 at 11:35:53AM -0700, Linus Torvalds wrote:
> On Thu, 3 Aug 2023 at 11:03, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Only thing that's missing is exclusion with seek on directories
> > as that's the heinous part.
> 
> Bah. I forgot about lseek entirely, because for some completely stupid
> reason I just thought "Oh, that will always get the lock".
> 
> So I guess we'd just have to do that "unconditional fdget_dir()" thing
> in the header file after all, and make llseek() and ksys_lseek() use
> it.
> 
> Bah. And then we'd still have to worry about any filesystem that
> allows 'read()' and 'write()' on the directory - which can also update
> f_pos.
> 
> And yes, those exist. See at least 'adfs_dir_ops', and
> 'ceph_dir_fops'. They may be broken, but people actually did do things
> like that historically, maybe there's a reason adfs and ceph allow it.
> 
> End result: we can forget about fdget_dir(). We'd need to split
> FMODE_ATOMIC_POS into two instead.
> 
> I don't think we have any free flags, but I didn't check. The ugly

We do. Christoph freed up 3 last cycle. I think I mentioned it in one my
prs. (And btw, we should probably try to get rid of a few more.)

> thing to do is to just special-case S_ISDIR. Not lovely, but whatever.
> 
> So something like this instead? It's a smaller diff anyway, and it
> gets the crazy afds/ceph cases right too.

If you really care about this we can do it. But if we can live with just
unconditionally locking then I think we're better off. As I said, I've
explicitly had requested the lkp performance ci that (I think Intel?)
runs for us to be run on this with a focus on single threaded
performance and so far there was nothing that wasn't noise.
