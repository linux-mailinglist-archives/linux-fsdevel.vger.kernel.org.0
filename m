Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D710649D212
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 19:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244296AbiAZSwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 13:52:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45242 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiAZSwO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:52:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB8826158E;
        Wed, 26 Jan 2022 18:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C70C340E3;
        Wed, 26 Jan 2022 18:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643223133;
        bh=bq+ubs72mt1p96IPmqJ3At3GXgXmm5/hMhOnaLGNUVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e6JnpaevJYs+1WgEA+FdJwdbrFxH729NqMr8XGf2BOKVJXUN6JrfNcHjfC42/KVUA
         75ISQzrtAPIWBGGWEWk8J9DF5Qz2tIuXs2HdY3eu7/4HszJydbZBCbze+tI5cYGfLG
         Dt4lfSOD5FpasFG9adQW18DE5WhXer3QWF8YWLQwluxiq6yPKzJA9jJSWFROKQMKE/
         nYvq/LDV0UBNLdPQBGt04O/CfRpK0fvPJY8o3/OrOzh2uJJSqbWl77PagDFhSAfXJf
         YkZm325a2LEeqnUq3SkTR2tNu0AqZo0Xg3t5QIl1IB+RzJCnMSU05rDeNCyTnz1m0t
         JRxd90/eOedRQ==
Date:   Wed, 26 Jan 2022 10:52:11 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, jlayton@kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: fscrypt and potential issues from file sparseness
Message-ID: <YfGYW7DGecySgYOH@sol.localdomain>
References: <124549.1643201054@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <124549.1643201054@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On Wed, Jan 26, 2022 at 12:44:14PM +0000, David Howells wrote:
> Hi,
> 
> I'm looking at doing content encryption in the network filesystem support
> library.  It occurs to me that if the filesystem can record sparsity in the
> file, then a couple of issues may arise if we wish to use that to record
> zeroed source blocks (ie. the unencrypted blocks).  It further occurs to me
> that this may occur in extent-based filesystems such as ext4 that support
> fscrypt and also do extent optimisation.
> 
> The issues are:
> 
>  (1) Recording source blocks that are all zeroes by not storing them and
>      leaving a hole in a content is a minor security hole as someone looking
>      at the file can derive information about the contents from that.  This
>      probably wouldn't affect most files, but it might affect database files.

This is working as intended; it's a known trade-off between security and
usability that is documented in Documentation/filesystems/fscrypt.rst.  eCryptfs
worked differently, and that caused lots of problems because things that would
be fast on normal filesystems were instead extremely slow.

> 
>  (2) If the filesystem stores a hole for a *source* block of zeroes (not an
>      encrypted block), then it has the same problems as cachefiles:
> 
>      (a) A block of zeroes written to disk (ie. an actually encrypted block)
>      is very, very unlikely to represent a source block of zeroes, but the
>      optimiser can punch it out to reduce an extent and recover disk space,
>      thereby leaving a hole.
> 
>      (b) The optimiser could also *insert* blocks of zeroes to bridge an
>      extent, thereby erasing a hole - but the zeroes would be very unlikely to
>      decrypt back to a source block of zeroes.
> 
>      If either event occurs, data corruption will ensue.
> 
>      To evade this one, we have to do one of the following:
> 
> 	1. Don't use sparsity to record source blocks of zeroes
> 	2. Disable extent optimisations of these sorts
> 	3. Keep a separate map of the content
> 
> Now, I don't know if fscrypt does this.  It's hard to tell.
> 

Changing an all-zeroes region to a hole (or vice versa) in an encrypted file is
impossible without the key, so yes that sort of thing needs to be disabled, e.g.
based on whether the inode has the encrypt flag set or not.

As far as I know, neither e2fsprogs nor f2fs-tools implement this sort of
optimization.  e2fsck supports optimizing how the extents are represented on
disk, but it doesn't mess with the actual data blocks.

- Eric
