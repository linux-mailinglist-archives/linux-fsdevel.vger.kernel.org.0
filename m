Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0B544ED1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 20:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbhKLTRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 14:17:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235265AbhKLTRy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 14:17:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47A9D60F0F;
        Fri, 12 Nov 2021 19:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636744503;
        bh=he4nr5Zv1gj4KhLHrTt/kC3kiKokVah8k8LJvlxoIRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kU7HDMriA9hhIsiB0T9A9b+mcLYld4tLHPl2C9DwU/nD5vae/RmDMSCpv66q/G12y
         ul4lU4/LmdD7OddSFchAgI52Gdy+L5UEVLSyPkRsRJTfc10OfKuo1f0epLGQXN0R+G
         1cNa3K/AYNOUf6lxyLOjGjffTKvVcg9jTuujT143VcQJA5lGVagdXrTD4pcol0UJRo
         ABdgqB72Q3O0pGUykGDPmqps8j1ZTYn3yxmOlvY92/cnPrhfBZJcrpDF0ULz3tzxCH
         mbxf7Mhw6JH7anfDf9YyYoIZD9LWVO0W0oRixyXXg2LDm7VNLtFk4wpLdl65HazcxA
         0YmnomMJh2zow==
Date:   Fri, 12 Nov 2021 11:15:01 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     tytso@mit.edu, corbet@lwn.net, viro@zeniv.linux.org.uk,
        hughd@google.com, akpm@linux-foundation.org,
        linux-fscrypt@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/5] fsverity: Revalidate built-in signatures at
 file open
Message-ID: <YY69NaucW+0t474Q@gmail.com>
References: <20211112124411.1948809-1-roberto.sassu@huawei.com>
 <20211112124411.1948809-3-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112124411.1948809-3-roberto.sassu@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 12, 2021 at 01:44:08PM +0100, Roberto Sassu wrote:
> Fsverity signatures are validated only upon request by the user by setting
> the requirement through procfs or sysctl.
> 
> However, signatures are validated only when the fsverity-related
> initialization is performed on the file. If the initialization happened
> while the signature requirement was disabled, the signature is not
> validated again.

I'm not sure this really matters.  If someone has started using a verity file
before the require_signatures sysctl was set, then there is already a race
condition; this patch doesn't fix that.  Don't you need to set the
require_signatures sysctl early enough anyway?

- Eric
