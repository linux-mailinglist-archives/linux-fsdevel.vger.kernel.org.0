Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E632B269BD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 04:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgIOCNh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 22:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgIOCNg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 22:13:36 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C838720678;
        Tue, 15 Sep 2020 02:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600136015;
        bh=PT45RPaOLGWOL8F6GJRhsMvmzvAXjKMef+PBoi1VEbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jpZjLrVo4UfZPHNUZwUHkPd4KOFvicd6owUm9te0YEuKy4IXgEZuKT6OJo7pA5hsx
         L77nnvpdYVBwsEK54obpgANf7cYqiUgeqTnNV5RQuVM7LS61J8Rl11NCru9WJO8Dvn
         Etr4+7DwBR7aGgDOyyEZkTBpszWegTIRvOUeC+GU=
Date:   Mon, 14 Sep 2020 19:13:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v3 00/16] ceph+fscrypt: context, filename and symlink
 support
Message-ID: <20200915021334.GN899@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914191707.380444-1-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:16:51PM -0400, Jeff Layton wrote:
> This is the third posting of the ceph+fscrypt integration work. This
> just covers context handling, filename and symlink support.
> 
> The main changes since the last set are mainly to address Eric's review
> comments. Hopefully this will be much closer to mergeable. Some highlights:
> 
> 1/ rebase onto Eric's fscrypt-file-creation-v2 tag
> 
> 2/ fscrypt_context_for_new_inode now takes a void * to hold the context
> 
> 3/ make fscrypt_fname_disk_to_usr designate whether the returned name
>    is a nokey name. This is necessary to close a potential race in
>    readdir support
> 
> 4/ fscrypt_base64_encode/decode remain in fs/crypto (not moved into lib/)
> 
> 5/ test_dummy_encryption handling is moved into a separate patch, and
>    several bugs fixed that resulted in context not being set up
>    properly.
> 
> 6/ symlink handling now works
> 
> Content encryption is the next step, but I want to get the fscache
> rework done first. It would be nice if we were able to store encrypted
> files in the cache, for instance.
> 
> This set has been tagged as "ceph-fscrypt-rfc.3" in my tree here:
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
> 
> Note that this is still quite preliminary, but my goal is to get a set
> merged for v5.11.

A few comments that didn't fit anywhere else:

I'm looking forward to contents encryption, as that's the most important part.

Is there any possibility that the fscrypt xfstests can be run on ceph?
See: https://www.kernel.org/doc/html/latest/filesystems/fscrypt.html#tests

In fs/ceph/Kconfig, CEPH_FS needs:

	select FS_ENCRYPTION_ALGS if FS_ENCRYPTION

There are compile errors when !CONFIG_FS_ENCRYPTION.

- Eric
