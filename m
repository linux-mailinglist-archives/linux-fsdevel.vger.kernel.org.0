Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1DF1E0879
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 18:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbfJVQPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 12:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbfJVQPI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:15:08 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FF7820B7C;
        Tue, 22 Oct 2019 16:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571760907;
        bh=jm5gtMdP07KkfSKxsAaLk29QiN6xgSCjIxXzWNwp05Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tw1A3NnYtI/hR1ki4FEWB3YJEGkTwWqRbzz5wAUUuaaqe5I2DkOH6rOIRlPiV6mBp
         8hg+XebiRYNX6glDUPm6qws0Blwt6JXLIz3oSFDdtyOpuwQKfmhQR2xaabA+/vIXu4
         kqEc9MyvQw505uyQ1NTTQjFrmJWMR83hZMwcQRlY=
Date:   Tue, 22 Oct 2019 09:15:06 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Dave Chinner <david@fromorbit.com>, linux-fscrypt@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/3] fscrypt: add support for inline-encryption-optimized
 policies
Message-ID: <20191022161504.GA229362@gmail.com>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, linux-fscrypt@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20191021230355.23136-1-ebiggers@kernel.org>
 <20191021230355.23136-2-ebiggers@kernel.org>
 <20191022052712.GA2083@dread.disaster.area>
 <20191022060004.GA333751@sol.localdomain>
 <20191022133001.GA23268@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022133001.GA23268@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 22, 2019 at 09:30:01AM -0400, Theodore Y. Ts'o wrote:
> > An alternative which would work nicely on ext4 and xfs (if xfs supported
> > fscrypt) would be to pass the physical block number as the DUN.  However, that
> > wouldn't work at all on f2fs because f2fs moves data blocks around.  And since
> > most people who want to use this are using f2fs, f2fs support is essential.
> 
> And that is something fscrypt supports already, so if people really
> did want to use 64-bit logical block numbers, they could do that, at
> the cost of giving up the ability to shrink the file system (which XFS
> doesn't support anyway....)

I was talking about the physical block number (offset from the start of the
filesystem -- ext4_fsblk_t on ext4), not the file logical block number (offset
in the file data -- ext4_lblk_t on ext4).  fscrypt doesn't currently support
using the physical block number.

- Eric
