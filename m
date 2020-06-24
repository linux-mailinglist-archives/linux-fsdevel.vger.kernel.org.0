Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CA0206BC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 07:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388983AbgFXFfC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 01:35:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388470AbgFXFfB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:35:01 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E7FA2072E;
        Wed, 24 Jun 2020 05:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592976900;
        bh=Uvdb15+FwGUGLj2jhaGU6/DgaIrNmpWsV+ez1RtkBmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aH7ky+hF/Jg1QGfBvwiqKCHIP0MpTE4LW78vI6dhtosOeYKEh+oTVtkYpAvkWt0iL
         ShgtMzLXPriGly+wa1+m9TELZOjEkpmRhniqkY7PbvwGbJ75CBOxbWj/lDddErBOg3
         6QVCfLlt6ajSXNSYRvGVdcGxxdHPpG/B6o059JkA=
Date:   Tue, 23 Jun 2020 22:34:58 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v9 0/4] Prepare for upcoming Casefolding/Encryption
 patches
Message-ID: <20200624053458.GD844@sol.localdomain>
References: <20200624043341.33364-1-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624043341.33364-1-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 23, 2020 at 09:33:37PM -0700, Daniel Rosenberg wrote:
> This lays the ground work for enabling casefolding and encryption at the
> same time for ext4 and f2fs. A future set of patches will enable that
> functionality. These unify the highly similar dentry_operations that ext4
> and f2fs both use for casefolding.

I think this undersells this patchset a bit.  This patchset makes ext4 and f2fs
share the casefolded ->d_compare() and ->d_hash() implementations, which
eliminates duplicated code.  That's a good thing regardless of whether we're
going to add encrypt+casefold support or not.

It also changes the casefolded ->d_hash() implementation to not have to allocate
memory (with GFP_ATOMIC, no less), which was a big problem with the old
implementation as it's unreliable and inefficient.

So yes, this prepares for supporting encrypt+casefold.  But these changes make
sense on their own too as an improvement of the casefold feature.  Except for
the one line of code in needs_casefold() that is specific to encrypt+casefold;
maybe that should be left out for now.

(Side note: I think you could drop linux-doc and linux-mtd from Cc, as this
patchset isn't really relevant to those mailing lists.)

- Eric
