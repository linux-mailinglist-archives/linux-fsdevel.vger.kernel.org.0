Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342E23997D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 04:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFCCEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 22:04:09 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45187 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229541AbhFCCEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 22:04:07 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15322DFx016671
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Jun 2021 22:02:13 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 01DBC15C3CAF; Wed,  2 Jun 2021 22:02:12 -0400 (EDT)
Date:   Wed, 2 Jun 2021 22:02:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH] ext4: Fix no-key deletion for encrypt+casefold
Message-ID: <YLg4JOlrNCRJhY6s@mit.edu>
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
> 
> Fixes: 471fbbea7ff7 ("ext4: handle casefolding with encryption")
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Applied, thanks.

					- Ted
