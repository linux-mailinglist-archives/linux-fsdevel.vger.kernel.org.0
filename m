Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5F74E5926
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 20:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344277AbiCWTba (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 15:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344271AbiCWTba (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:31:30 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C0A89CC4;
        Wed, 23 Mar 2022 12:29:59 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id D23745EE6; Wed, 23 Mar 2022 15:29:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D23745EE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1648063798;
        bh=JqlmM1NJloLOZMtErdOCWTM4BMqIYjuNg8gf8rNh+10=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=XiuE3MK+ad95PtbIPK3tcNgV2ZFIBA/1OobGjqdSpjWTURZVlzhQ5UzmFAB6l+BQv
         9sSK1ci0gHcdFjVQyOjO454C6k6EgKsR255d2OBlzQ7IlOE7bA++zZNjOUhN49/hV5
         nbRqZ/PRFcmEYls4Zyh9I3nNlgSifXY4XSoujKec=
Date:   Wed, 23 Mar 2022 15:29:58 -0400
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dharmendra Singh <dsingh@ddn.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
Message-ID: <20220323192958.GA18275@fieldses.org>
References: <20220322192712.709170-1-mszeredi@redhat.com>
 <YjrJWf+XMnWVd6K0@kroah.com>
 <d0e2573a-7736-bb3e-9f6a-5fa25e6d31a2@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0e2573a-7736-bb3e-9f6a-5fa25e6d31a2@ddn.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 11:26:11AM +0100, Bernd Schubert wrote:
> Add in network file systems. Demonstrating that this is useful
> locally and with micro benchmarks - yeah, helps a bit to make it
> locally faster. But the real case is when thousands of clients are
> handled by a few network servers. Even reducing wire latency for a
> single client would make a difference here.
> 
> There is a bit of chicken-egg problem - it is a bit of work to add
> to file systems like NFS (or others that are not the kernel), but
> the work won't be made there before there is no syscall for it. To
> demonstrate it on NFS one also needs a an official protocol change
> first.

I wouldn't assume that.  NFSv4 already supports compound rpc operations,
so you can do OPEN+READ+CLOSE in a single round trip.  The client's
never done that, but there are pynfs tests that can testify to the fact
that our server supports it.

It's not something anyone's used much outside of artificial tests, so
there may well turn out be issues, but the protocol's definitely
sufficient to prototype this at least.

I'm not volunteering, but it doesn't seem too difficult in theory if
someone's interested.

--b.

> And then applications also need to support that new syscall
> first.
> I had a hard time explaining weather physicist back in 2009 that it
> is not a good idea to have millions of 512B files on  Lustre. With
> recent AI workload this gets even worse.
> 
> This is the same issue in fact with the fuse patches we are creating
> (https://lwn.net/Articles/888877/). Miklos asked for benchmark
> numbers - we can only demonstrate slight effects locally, but out
> goal is in fact to reduce network latencies and server load.
> 
> - Bernd
