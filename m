Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596A4269A11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 02:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgIOAEY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 20:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgIOAEY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:04:24 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09C1F208DB;
        Tue, 15 Sep 2020 00:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600128264;
        bh=qfRUjs9naBSrfqPpZUZcgR5jyoydYcO/N4OmsE69C88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZLBjsJmnMPR6muLbc8iYaOwLknXPmoqjwxEK+UJG+IchUeA7SUhe5zcXbGUdu45f5
         ZO7ty0DgrkgSQghzOEoP0bLp/52UospU4Ab5MVOmzxcaHY8A0VB4WD3OAWG7FL8nRb
         CDKq297sjPN7K2AOUJCIilsViCXOTwW488w8PN78=
Date:   Mon, 14 Sep 2020 17:04:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Daniel Rosenberg <drosen@google.com>
Subject: Re: [RFC PATCH v3 03/16] fscrypt: export fscrypt_d_revalidate
Message-ID: <20200915000422.GC899@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
 <20200914191707.380444-4-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914191707.380444-4-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:16:54PM -0400, Jeff Layton wrote:
> ceph already has its own d_revalidate op so we can't rely on fscrypt
> using that directly. Export this symbol so filesystems can call it
> from their own d_revalidate op.

IMO, a slightly clearer explanation would be:

	Since ceph already uses its own dentry_operations, it can't use
	fscrypt_d_ops.  Instead, export fscrypt_d_revalidate() so that
	ceph_d_revalidate() can call it.

Also, it turns out that ext4 and f2fs will need this too.  You could add
to the commit message:

	This change is also needed by ext4 and f2fs to add support for
	directories that are both encrypted and casefolded, since similarly the
	current "fscrypt_d_ops" approach is too inflexible for that.  See
	https://lore.kernel.org/r/20200307023611.204708-6-drosen@google.com and
	https://lore.kernel.org/r/20200307023611.204708-8-drosen@google.com.

FYI, I might take this patch for 5.10 to get it out of the way, since
now two patchsets are depending on it.

- Eric
