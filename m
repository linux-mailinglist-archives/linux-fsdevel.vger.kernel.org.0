Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 694D5148F30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 21:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404265AbgAXUOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 15:14:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387535AbgAXUOF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 15:14:05 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F8CF2071E;
        Fri, 24 Jan 2020 20:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579896844;
        bh=BXwKT7PuUAxXdQBtcYCaPasA/6uX1OMir4E6yh0LA3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1ag7/2DSoxG5KYU0EMVWB64o75K0btoF+qRMCO5k9cTMqUywqJBdCg/sUprpKIHv/
         9MepeQSjc6pe8xJdw8+LoNAgcQY5x8NUgXg6RHWOLoXD7dmmnthVG6ewye8WF1rbAv
         53XYtcyTT0ewAW3ULL2QSG0sBV/ytCRp6aZzLJeA=
Date:   Fri, 24 Jan 2020 12:14:02 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org
Cc:     Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v5 4/6] ubifs: don't trigger assertion on invalid no-key
 filename
Message-ID: <20200124201317.GC41762@gmail.com>
References: <20200120223201.241390-1-ebiggers@kernel.org>
 <20200120223201.241390-5-ebiggers@kernel.org>
 <20200122003014.GA180824@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122003014.GA180824@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 21, 2020 at 04:30:15PM -0800, Eric Biggers wrote:
> On Mon, Jan 20, 2020 at 02:31:59PM -0800, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > If userspace provides an invalid fscrypt no-key filename which encodes a
> > hash value with any of the UBIFS node type bits set (i.e. the high 3
> > bits), gracefully report ENOENT rather than triggering ubifs_assert().
> > 
> > Test case with kvm-xfstests shell:
> > 
> >     . fs/ubifs/config
> >     . ~/xfstests/common/encrypt
> >     dev=$(__blkdev_to_ubi_volume /dev/vdc)
> >     ubiupdatevol $dev -t
> >     mount $dev /mnt -t ubifs
> >     mkdir /mnt/edir
> >     xfs_io -c set_encpolicy /mnt/edir
> >     rm /mnt/edir/_,,,,,DAAAAAAAAAAAAAAAAAAAAAAAAAA
> > 
> > With the bug, the following assertion fails on the 'rm' command:
> > 
> >     [   19.066048] UBIFS error (ubi0:0 pid 379): ubifs_assert_failed: UBIFS assert failed: !(hash & ~UBIFS_S_KEY_HASH_MASK), in fs/ubifs/key.h:170
> > 
> > Fixes: f4f61d2cc6d8 ("ubifs: Implement encrypted filenames")
> > Cc: <stable@vger.kernel.org> # v4.10+
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Richard, can you review the two UBIFS patches in this series, and if you're okay
> with them, provide Acked-by's so that we can take them through the fscrypt tree?
> They don't conflict with anything currently in the UBIFS tree.
> 

Richard, any objection to us taking these patches through the fscrypt tree?

- Eric
