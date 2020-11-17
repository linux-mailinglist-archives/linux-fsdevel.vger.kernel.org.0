Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976372B6D7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 19:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgKQSgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 13:36:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgKQSgJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:36:09 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA74F223C7;
        Tue, 17 Nov 2020 18:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605638168;
        bh=XFTKnyksOQF5hI0TvFTXOnV3KR3hpWlZi6TBqSIlN+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TDkYXN8CuXva+9OJ9b39gOkV0069pK+fKDahpqGUjsGcqRpFilPNA9fKO0pC028pt
         IoJRLdqRMCA9DRRLjwr7kUg0oPUfUKs6w/Tw2vuqqcgbZTDTUEyH/IIqd8BM2F1iwh
         QjPFKNx/xoX0SEq3VPRzU472078pyjJ1hcwl1m/U=
Date:   Tue, 17 Nov 2020 10:36:06 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     kernel-team@android.com, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [f2fs-dev] [PATCH v2 1/3] libfs: Add generic function for
 setting dentry_ops
Message-ID: <X7QYFm3QIYBhdI7V@sol.localdomain>
References: <20201117040315.28548-1-drosen@google.com>
 <20201117040315.28548-2-drosen@google.com>
 <X7QTkSyiMojM6T10@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X7QTkSyiMojM6T10@sol.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 10:16:49AM -0800, Eric Biggers wrote:
> 
> Here's a suggestion which I think explains it a lot better.  It's still possible
> I'm misunderstanding something, though, so please check it carefully:
> 
> /**
>  * generic_set_encrypted_ci_d_ops - helper for setting d_ops for given dentry
>  * @dentry:	dentry to set ops on
>  *
>  * Casefolded directories need d_hash and d_compare set, so that the dentries
>  * contained in them are handled case-insensitively.  Note that these operations
>  * are needed on the parent directory rather than on the dentries in it, and the
>  * casefolding flag can be enabled on an empty directory later but the
>  * dentry_operations can't be changed later.  As a result, if the filesystem has
>  * casefolding support enabled at all, we have to give all dentries the
>  * casefolding operations even if their inode doesn't have the casefolding flag
>  * currently (and thus the casefolding ops would be no-ops for now).
>  *
>  * Encryption works differently in that the only dentry operation it needs is
>  * d_revalidate, which it only needs on dentries that have the no-key name flag.
>  * The no-key flag can't be set "later", so we don't have to worry about that.
>  *
>  * Finally, to maximize compatibility with overlayfs (which isn't compatible
>  * with certain dentry operations) and to avoid taking an unnecessary
>  * performance hit, we use custom dentry_operations for each possible
>  * combination rather always installing all operations.
>  */

Last line in my suggestion has a typo: "rather" => "rather than".

- Eric
