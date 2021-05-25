Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DCC3907AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 19:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhEYRa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 13:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232246AbhEYRa5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 13:30:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18B1E61404;
        Tue, 25 May 2021 17:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621963767;
        bh=F8vf1n1Dtzgp3rnX9vk5TZwA3ysgxGjZZo3YJRJTqZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oh2Ojt7F5onIP/3sUR2rPQ7sKlePzY1Skcm6Yd46chWDvuuKEWj01TFYsfJpKL6wm
         EZL36hw3h0CXYdDs0+1z3RItguYYAVYZlJdi5tpEF4r0mUThdtb3HuAbkVcTew72Go
         zi86sXOU7/T9WdOSstRNnjhdAF/MOPaQhEZjD3toOgN1PyDK7GZM8xDa/+BiNMGVdL
         r90BdNGsPf9yk+F7wpMIZdpcj30gftyOOBokV7Dl5AdAJ84HU6XA8ooO+CtCAzZv+D
         3WBENHjO2uvZC9uXiLMCzXqAdogq0Oe3ouohYNn7eMbLB5t9e+qtTgdr5uTJu4dtKM
         dXmvbLKwfr2bg==
Date:   Tue, 25 May 2021 10:29:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH] ext4: Fix no-key deletion for encrypt+casefold
Message-ID: <YK0z9US1ek615F8Z@sol.localdomain>
References: <20210522004132.2142563-1-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522004132.2142563-1-drosen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 22, 2021 at 12:41:32AM +0000, Daniel Rosenberg wrote:
> commit 471fbbea7ff7 ("ext4: handle casefolding with encryption") is
> missing a few checks for the encryption key which are needed to
> support deleting enrypted casefolded files when the key is not
> present.
> 
> Note from ebiggers:
> (These checks for the encryption key are still racy since they happen
> too late, but apparently they worked well enough...)
> 
> This bug made it impossible to delete encrypted+casefolded directories
> without the encryption key, due to errors like:
> 
>     W         : EXT4-fs warning (device vdc): __ext4fs_dirhash:270: inode #49202: comm Binder:378_4: Siphash requires key
> 
> Repro steps in kvm-xfstests test appliance:
>       mkfs.ext4 -F -E encoding=utf8 -O encrypt /dev/vdc
>       mount /vdc
>       mkdir /vdc/dir
>       chattr +F /vdc/dir
>       keyid=$(head -c 64 /dev/zero | xfs_io -c add_enckey /vdc | awk '{print $NF}')
>       xfs_io -c "set_encpolicy $keyid" /vdc/dir
>       for i in `seq 1 100`; do
>           mkdir /vdc/dir/$i
>       done
>       xfs_io -c "rm_enckey $keyid" /vdc
>       rm -rf /vdc/dir # fails with the bug

Looks fine, but can you please turn this reproducer into an xfstest?

I'm also wondering if you've done any investigation into fixing ext4 to handle
filenames properly like f2fs does, so that the above-mentioned race condition is
eliminated.  In particular, we should decide whether the user-supplied filename
is a no-key name, and whether it needs casefolding or not, just once -- rather
than separately for each directory entry compared in ext4_match().

- Eric
