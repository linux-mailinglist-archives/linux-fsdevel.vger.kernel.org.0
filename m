Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8340444ECF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 19:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbhKLS7T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 13:59:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229892AbhKLS7T (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 13:59:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F195A60F93;
        Fri, 12 Nov 2021 18:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636743388;
        bh=D1rXtDqoJhaQG2E/xRhBx3f6tZ2CC1AU4VZeakU4NHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z8YcLZD6kjgh7/4hm30vXdlHY9oApUE+tnDU+KggGsZd7BC71Nlfiwl7vMC95vghW
         +rEhxKgVJAdy+4P4NLBzc5no3CXGj90Uf6/U5hm+Zau84epTA7pqMtY3PFiFNFECiW
         t5rIhktfsToMAXf0fYa7enbx0kOpWWKKbmd4sJQtGhe3bb458MODcsXugAuizWljXf
         ykmKhwrLlc2gXbCjsRe3uPplWLfvi0ou0UqWYqZXAbGhXFeNu9TcWAA8dafCcs/QB+
         5hUBSy+7UKgH0rsIw4sGt65Rw8FivQNDCeywxsBhyAT0/5cidw0qASeLiWaXoug2Jr
         ZFIzfJKamp1Ew==
Date:   Fri, 12 Nov 2021 10:56:26 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     tytso@mit.edu, corbet@lwn.net, viro@zeniv.linux.org.uk,
        hughd@google.com, akpm@linux-foundation.org,
        linux-fscrypt@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 4/5] shmem: Avoid segfault in
 shmem_read_mapping_page_gfp()
Message-ID: <YY642nxarVElvKUS@gmail.com>
References: <20211112124411.1948809-1-roberto.sassu@huawei.com>
 <20211112124411.1948809-5-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112124411.1948809-5-roberto.sassu@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 12, 2021 at 01:44:10PM +0100, Roberto Sassu wrote:
> Check the hwpoison page flag only if the page is valid in
> shmem_read_mapping_page_gfp(). The PageHWPoison() macro tries to access
> the page flags and cannot work on an error pointer.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

This looks like a recent regression from the commit:

	commit b9d02f1bdd98f38e6e5ecacc9786a8f58f3f8b2c
	Author: Yang Shi <shy828301@gmail.com>
	Date:   Fri Nov 5 13:41:10 2021 -0700

	    mm: shmem: don't truncate page if memory failure happens

Can you please send this fix out as a standalone patch, to the right people and
including the appropriate "Fixes" tag?

- Eric
