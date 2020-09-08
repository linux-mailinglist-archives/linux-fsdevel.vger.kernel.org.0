Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA98B26128B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 16:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgIHOVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 10:21:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729969AbgIHOPu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 10:15:50 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2522821532;
        Tue,  8 Sep 2020 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599566955;
        bh=zqEJfVUqeIO7gcyXpU/RQrWv768uPLWmdl436rYkjNc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=r9MkgzRhGCgNzfrsZE+kpQFUDyFuFOrz2OR0FWyHBwTO4LxMOkcSNzC3d7+5tPFiJ
         1dy/zgm27I9gPVSxdDLb5x7mtq0x55XpOtkZQkWfXLkyILImR/J06QW8FDa4VegxBc
         G9G5UKPR47OUmugugGbU3Y9WaSyowIwN9Wb6Dh+4=
Message-ID: <b71271c9573032c74eca352fdf4a9db2d2fbec3e.camel@kernel.org>
Subject: Re: [RFC PATCH v2 00/18] ceph+fscrypt: context, filename and
 symlink support
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Date:   Tue, 08 Sep 2020 08:09:14 -0400
In-Reply-To: <20200908055446.GP68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
         <20200908055446.GP68127@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-09-07 at 22:54 -0700, Eric Biggers wrote:
> On Fri, Sep 04, 2020 at 12:05:19PM -0400, Jeff Layton wrote:
> > This is a second posting of the ceph+fscrypt integration work that I've
> > been experimenting with. The main change with this patch is that I've
> > based this on top of Eric's fscrypt-pending set. That necessitated a
> > change to allocate inodes much earlier than we have traditionally, prior
> > to sending an RPC instead of waiting on the reply.
> 
> FWIW, if possible you should create a git tag or branch for your patchset.
> While just the mailed patches work fine for *me* for this particular patchset,
> other people may not be able to figure out what the patchset applies to.
> (In particular, it depends on another patchset:
> https://lkml.kernel.org/r/20200824061712.195654-1-ebiggers@kernel.org)
> 

I've tagged this out as 'ceph-fscrypt-rfc.2' in my kernel.org tree (the
first posting is ceph-fscrypt-rfc.1).

Note that this also is layered on top of David Howell's fscache rework,
and the work I've done to adapt cephfs to that.

> > Note that this just covers the crypto contexts and filenames. I've also
> > added a patch to encrypt symlink contents as well, but it doesn't seem to
> > be working correctly.
> 
> What about symlink encryption isn't working correctly?

What I was seeing is that after unmounting and mounting, the symlink
contents would be gibberish when read by readlink(). I confirmed that
the same crypttext that came out of fscrypt_encrypt_symlink() was being
fed into fscrypt_get_symlink(), but the result from that came back as
gibberish.

I need to do a bit more troubleshooting, but I now wonder if it's due to
the context handling being wrong when dummy encryption is enabled. I'll
have a look at that soon.

Thanks for the review so far!
-- 
Jeff Layton <jlayton@kernel.org>

