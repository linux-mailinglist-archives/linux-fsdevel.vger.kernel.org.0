Return-Path: <linux-fsdevel+bounces-20115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 370BA8CE66F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 15:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FE31F240BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB0612C469;
	Fri, 24 May 2024 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UekWVpFU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0CF8624B;
	Fri, 24 May 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716558916; cv=none; b=EwI5dShjQIiCnMYjfom8pNwDz3UG0CuSMUPJpbAkAyIjN5T6dK+yBs/psv+iEicHMyEFxkZ5ovRi7T1cDqwUkQ9K++ztNft3wvrheh4jIbctlLjuHo7E7Ruah4DL9mpj3UEWGlUPJz15tqI+jEv7qqBN6LFF37ZN3siYefjeSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716558916; c=relaxed/simple;
	bh=0qKlbT0Sn7O74uZtM5dWU/MMQ2oUn8jK5z/BM5idXoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEIhSxRu2fIUoJEbjD9Y38B6Hyxx26zzpOIKLDHKoVt9osvh5ialp8BtD7bP/UKf/FeL3aoyCUotOrK7P4z2yh9GOLXl/Gp3N5tc6y3wsRUcqldgJaeSb3q7mFr1Srjb1m+jRUq6HciWJKsoByNxMbOHkEm8NdY7ZckCXJQkBt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UekWVpFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCADC2BBFC;
	Fri, 24 May 2024 13:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716558915;
	bh=0qKlbT0Sn7O74uZtM5dWU/MMQ2oUn8jK5z/BM5idXoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UekWVpFUw3upX1JQ1MZv9Onlexv40qPeMFBZnwqf83OSThzcSZNNldlCTtINstVMf
	 F/Jr5xkWyAtA/slMrsm9dFRe0zL5zsmi4Y9ZVuohSudfBa7nzp/gK6pm9Q+4R6EP8o
	 U1k94vuHk/wWnAEPyYZ2sOeUVjJcrToUqHmWSH6S/bKADQIj9Cd8G7ncZ/7F+aIVW2
	 EapRj0dUu2nQbNk0lnUz0z3J9TPVPOO6Oyp/LiBgDQoQwA3+9sEnzs3MdHSx/d/cIX
	 Qq4BYgkPdsQf8mTSGmJ+YbbNK9NdsWDdvT8BKCV6Afe6bPlM/OVcEDvOkx+4BfMvYJ
	 Yy4FSS6Sp2YTw==
Date: Fri, 24 May 2024 15:55:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Eric Sandeen <sandeen@redhat.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: ignore auto and noauto options if given
Message-ID: <20240524-glasfaser-gerede-fdff887f8ae2@brauner>
References: <20240522083851.37668-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240522083851.37668-1-wsa+renesas@sang-engineering.com>

On Wed, May 22, 2024 at 10:38:51AM +0200, Wolfram Sang wrote:
> The 'noauto' and 'auto' options were missed when migrating to the new
> mount API. As a result, users with these in their fstab mount options
> are now unable to mount debugfs filesystems, as they'll receive an
> "Unknown parameter" error.
> 
> This restores the old behaviour of ignoring noauto and auto if they're
> given.
> 
> Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> With current top-of-tree, debugfs remained empty on my boards triggering
> the message "debugfs: Unknown parameter 'auto'". I applied a similar fix
> which CIFS got and largely reused the commit message from 19d51588125f
> ("cifs: ignore auto and noauto options if given").
> 
> Given the comment in debugfs_parse_param(), I am not sure if this patch
> is a complete fix or if there are more options to be ignored. This patch
> makes it work for me(tm), however.
> 
> From my light research, tracefs (which was converted to new mount API
> together with debugfs) doesn't need the same fixing. But I am not
> super-sure about that.

Afaict, the "auto" option has either never existent or it was removed before
the new mount api conversion time ago for debugfs. In any case, the root of the
issue is that we used to ignore unknown mount options in the old mount api so
you could pass anything that you would've wanted in there:

/*
 * We might like to report bad mount options here;
 * but traditionally debugfs has ignored all mount options
 */

So there's two ways to fix this:

(1) We continue ignoring mount options completely when they're coming
    from the new mount api.
(2) We continue ignoring mount options toto caelo.

The advantage of (1) is that we gain the liberty to report errors to
users on unknown mount options in the future but it will break on
mount(8) from util-linux that relies on the new mount api by default. So
I think what we need is (2) so something like:

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index dc51df0b118d..713b6f76e75d 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -107,8 +107,16 @@ static int debugfs_parse_param(struct fs_context *fc, struct fs_parameter *param
        int opt;

        opt = fs_parse(fc, debugfs_param_specs, param, &result);
-       if (opt < 0)
+       if (opt < 0) {
+               /*
+                * We might like to report bad mount options here; but
+                * traditionally debugfs has ignored all mount options
+                */
+               if (opt == -ENOPARAM)
+                       return 0;
+
                return opt;
+       }

        switch (opt) {
        case Opt_uid:


Does that fix it for you?

