Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6D1470BF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 21:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343966AbhLJUoA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 15:44:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45988 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242871AbhLJUn7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:43:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BD9FB829BC;
        Fri, 10 Dec 2021 20:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53399C00446;
        Fri, 10 Dec 2021 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639168821;
        bh=a1uB11ct1PrYoRS1zLYEvS0YrxfIzoCk80JJLJDrVbA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=snZf/D2FORjZTYUAQBfuxrPy5zrd5ouAlyiXlgg3dqy+CO1PPyraonGMTeN8j/La7
         CFp7nFvkKyXCpWR1M9GUd5uoXEQO6sOJdplkNR0b3Gd66MowzsciSZ0sEmc27Fgtu7
         t6Pa8dF6qpqPu0a4BHuut02noRBDb0FKC/B+yLv9imhS/4SzIaWmpR+CVBQpoUzNu0
         ieN7ft2B8A2tQsTwkj5Ik96nqbP47o2wYvABGVh8PY01+DsUdkvLCU4+sa8S3Eizm2
         7b12Prk1ZantzelZuoYB/yGHSmWCnuI/O+6lwGN3TRN+EthFNP7h6QEnSkTEolVMRy
         VdPLmkkhusLPw==
Message-ID: <8c90912c5fd01a713688b1d2523ffe47df747513.camel@kernel.org>
Subject: Re: [PATCH 05/36] fscrypt: uninline and export fscrypt_require_key
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 10 Dec 2021 15:40:20 -0500
In-Reply-To: <YbOuhUalMBuTGAGI@sol.localdomain>
References: <20211209153647.58953-1-jlayton@kernel.org>
         <20211209153647.58953-6-jlayton@kernel.org>
         <YbOuhUalMBuTGAGI@sol.localdomain>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-12-10 at 11:46 -0800, Eric Biggers wrote:
> On Thu, Dec 09, 2021 at 10:36:16AM -0500, Jeff Layton wrote:
> > ceph_atomic_open needs to be able to call this.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/crypto/fscrypt_private.h | 26 --------------------------
> >  fs/crypto/keysetup.c        | 27 +++++++++++++++++++++++++++
> >  include/linux/fscrypt.h     |  5 +++++
> >  3 files changed, 32 insertions(+), 26 deletions(-)
> 
> What is the use case for this, more precisely?  I've been trying to keep
> filesystems using helper functions like fscrypt_prepare_*() and
> fscrypt_file_open() rather than setting up encryption keys directly, which is a
> bit too low-level to be doing outside of fs/crypto/.
> 
> Perhaps fscrypt_file_open() is what you're looking for here?

That doesn't really help because we don't have the inode for the file
yet at the point where we need the key.

atomic_open basically does a lookup+open. You give it a directory inode
and a dentry, and it issues an open request by filename. If it gets back
ENOENT then we know that the thing is a negative dentry.

In the lookup path, I used __fscrypt_prepare_readdir. This situation is
a bit similar so I might be able to use that instead. OTOH, that doesn't
fail when you don't have the key, and if you don't, there's not a lot of
point in going any further here.
-- 
Jeff Layton <jlayton@kernel.org>
