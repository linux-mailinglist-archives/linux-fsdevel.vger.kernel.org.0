Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56AFBF0D8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 05:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbfKFEFW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 23:05:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:43388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfKFEFW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 23:05:22 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 146A820717;
        Wed,  6 Nov 2019 04:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573013121;
        bh=Z0GxY95oJxO9ZLq8oaOmmcb0jIbpBQJAL5XisXjvaEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UyEdLZm6RSRKo2uOnglC4+TurPB07Qt0Yie+qg069GiVrVlXNuPHZpNdCMdqunXXU
         578Ib5wQ8lOqzDmUFMycgh3jvuHOYBSid4q5TnN+bbA4yivNJX9C48fHKvKoZ5tK+E
         3BIlG4gNPpY7fJ5x6AkHqEZs4OxdQm+Sw+vpLKCI=
Date:   Tue, 5 Nov 2019 20:05:19 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2 1/3] fscrypt: add support for IV_INO_LBLK_64 policies
Message-ID: <20191106040519.GA705@sol.localdomain>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20191024215438.138489-1-ebiggers@kernel.org>
 <20191024215438.138489-2-ebiggers@kernel.org>
 <20191106033544.GG26959@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106033544.GG26959@mit.edu>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 05, 2019 at 10:35:44PM -0500, Theodore Y. Ts'o wrote:
> On Thu, Oct 24, 2019 at 02:54:36PM -0700, Eric Biggers wrote:
> > @@ -83,6 +118,10 @@ bool fscrypt_supported_policy(const union fscrypt_policy *policy_u,
> >  			return false;
> >  		}
> >  
> > +		if ((policy->flags & FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) &&
> > +		    !supported_iv_ino_lblk_64_policy(policy, inode))
> > +			return false;
> > +
> >  		if (memchr_inv(policy->__reserved, 0,
> >  			       sizeof(policy->__reserved))) {
> >  			fscrypt_warn(inode,
> 
> fscrypt_supported_policy is getting more and more complicated, and
> supported_iv_ino_lblk_64_policy calls a fs-supplied callback function,
> etc.  And we need to use this every single time we need to set up an
> inode.  Granted that compared to the crypto, even if it is ICE, it's
> probably small beer --- but perhaps we should think about caching some
> of what fscrypt_supported_policy does on a per-file system basis at
> some point?

I don't think this will make any difference given everything else that needs to
be done to set up a file's key.  Also, anything extra we spend here will be far
less than the amount of time we save with IV_INO_LBLK_64 policies by not having
to do the key derivation and tfm allocation for every file.

Christoph suggested replacing ->has_stable_inodes() and
->get_ino_and_lblk_bits() with a new SB_* flag like SB_IV_INO_LBLK_64_SUPPORT.
But I don't like that that would result in worse error messages and would "leak"
a specific fscrypt policy flag into filesystems rather than having the
filesystems declare their properties.

If we really wanted to optimize fscrypt_get_encryption_info(), I think we
probably shouldn't try to microoptimize fscrypt_supported_policy(), but rather
take advantage of the fact that fscrypt_has_permitted_context() already ran.
E.g., we could cache the xattr, or skip both the keyring lookup and
fscrypt_supported_policy() by grabbing them from the parent directory.

- Eric
