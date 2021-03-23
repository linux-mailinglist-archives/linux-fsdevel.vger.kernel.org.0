Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F0E3469AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 21:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhCWUQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 16:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbhCWUQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:16:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3BBC061574;
        Tue, 23 Mar 2021 13:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=KBGGAbtQx5bJl1bepUiUvamzxwg3INvrVstI/LqAhE0=; b=Chs+SKa1t/9u5XyOgH99T3K+t6
        1zbggaXTvMSHzTawMPMHFjFQyk2e9bI9KWdrzX5I2oa8KDwjzlyMYegYpOSWarqI+0G4YCX5n26NW
        Nz9nO9tPFfgDA1Yk/RWKzwHi4fM1dj0buGCcolBN1QPe8HWRCUDNVTjDw+LL3YWfXN4Be8qTgiyDe
        oc6LCfzd6f5PswOxQjntIi0/DFFchAdrtxv6DFAEd59uaIFIJorPpk35wOfPvFjFK601+2P9ZWJ9/
        tg9qR73R2DGUvoG6ekvC4T0tRjIiyHcfChXm6eyxPARNURyFnS1kUD04n52MO/VfPmG3Ql/ctRIKr
        vo/TnCiA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOnR4-00AVBR-4A; Tue, 23 Mar 2021 20:15:36 +0000
Date:   Tue, 23 Mar 2021 20:15:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        krisman@collabora.com, smcv@collabora.com, kernel@collabora.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Rosenberg <drosen@google.com>
Subject: Re: [RFC PATCH 1/4] Revert "libfs: unexport generic_ci_d_compare()
 and generic_ci_d_hash()"
Message-ID: <20210323201530.GL1719932@casper.infradead.org>
References: <20210323195941.69720-1-andrealmeid@collabora.com>
 <20210323195941.69720-2-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210323195941.69720-2-andrealmeid@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 04:59:38PM -0300, André Almeida wrote:
> This reverts commit 794c43f716845e2d48ce195ed5c4179a4e05ce5f.
> 
> For implementing casefolding support at tmpfs, it needs to set dentry
> operations at superblock level, given that tmpfs has no support for
> fscrypt and we don't need to set operations on a per-dentry basis.
> Revert this commit so we can access those exported function from tmpfs
> code.

But tmpfs / shmem are Kconfig bools, not tristate.  They can't be built
as modules, so there's no need to export the symbols.

> +#ifdef CONFIG_UNICODE
> +extern int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str);
> +extern int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
> +				const char *str, const struct qstr *name);
> +#endif

There's no need for the ifdef (it only causes unnecessary rebuilds) and
the 'extern' keyword is also unwelcome.
