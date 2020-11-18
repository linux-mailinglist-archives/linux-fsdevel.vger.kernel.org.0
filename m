Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A8A2B845B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 20:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgKRTF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 14:05:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:60866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgKRTF5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:05:57 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9639220B1F;
        Wed, 18 Nov 2020 19:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605726357;
        bh=czhwXJzBR4zdRxRmpiz6/CDV6S0jGgxbOLv7GLXvEi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UjOF4cr4HY06mtasTjDvTwJSyxBGG8YJAp+6mdTN+4xE8fSYavbczWX1lWh//WqVo
         rVQRLoTh1cbSKnB2SOlxbd17YT9Ed1+EP0inyaWja+lnpiyWvsNYG7igsxzyw9MeTg
         vYcQGBsopsYIMipvK1Y5rj7tjY+R+FNEWIA1tzVo=
Date:   Wed, 18 Nov 2020 11:05:54 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v3 3/3] f2fs: Handle casefolding with Encryption
Message-ID: <X7Vwkgb8tqJh+mOr@sol.localdomain>
References: <20201118064245.265117-1-drosen@google.com>
 <20201118064245.265117-4-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118064245.265117-4-drosen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 06:42:45AM +0000, Daniel Rosenberg wrote:
> Expand f2fs's casefolding support to include encrypted directories.  To
> index casefolded+encrypted directories, we use the SipHash of the
> casefolded name, keyed by a key derived from the directory's fscrypt
> master key.  This ensures that the dirhash doesn't leak information
> about the plaintext filenames.
> 
> Encryption keys are unavailable during roll-forward recovery, so we
> can't compute the dirhash when recovering a new dentry in an encrypted +
> casefolded directory.  To avoid having to force a checkpoint when a new
> file is fsync'ed, store the dirhash on-disk appended to i_name.
> 
> This patch incorporates work by Eric Biggers <ebiggers@google.com>
> and Jaegeuk Kim <jaegeuk@kernel.org>.
> 
> Co-developed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Looks good.  If it's needed (some may claim it's not needed because I have a
Co-developed-by), you can add:

	Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
