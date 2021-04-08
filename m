Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E403589FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 18:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhDHQpw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 12:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhDHQpv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:45:51 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F186EC061760;
        Thu,  8 Apr 2021 09:45:39 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUXmj-003kcY-LV; Thu, 08 Apr 2021 16:45:37 +0000
Date:   Thu, 8 Apr 2021 16:45:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, jolsa@kernel.org, hannes@cmpxchg.org,
        yhs@fb.com
Subject: Re: [RFC bpf-next 1/1] bpf: Introduce iter_pagecache
Message-ID: <YG8zMV59hSzpCHSn@zeniv-ca.linux.org.uk>
References: <cover.1617831474.git.dxu@dxuuu.xyz>
 <22bededbd502e0df45326a54b3056941de65a101.1617831474.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22bededbd502e0df45326a54b3056941de65a101.1617831474.git.dxu@dxuuu.xyz>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 02:46:11PM -0700, Daniel Xu wrote:

> +static void fini_seq_pagecache(void *priv_data)
> +{
> +	struct bpf_iter_seq_pagecache_info *info = priv_data;
> +	struct radix_tree_iter iter;
> +	struct super_block *sb;
> +	void **slot;
> +
> +	radix_tree_for_each_slot(slot, &info->superblocks, &iter, 0) {
> +		sb = (struct super_block *)iter.index;
> +		atomic_dec(&sb->s_active);
> +		radix_tree_delete(&info->superblocks, iter.index);
> +	}

... and if in the meanwhile all other contributors to ->s_active have
gone away, that will result in...?

IOW, NAK.  The objects you are playing with have non-trivial lifecycle
and poking into the guts of data structures without bothering to
understand it is not a good idea.

Rule of the thumb: if your code ends up using fields that are otherwise
handled by a small part of codebase, the odds are that you need to be
bloody careful.  In particular, ->ns_lock has 3 users - all in
fs/namespace.c.  ->list/->mnt_list: all users in fs/namespace.c and
fs/pnode.c.  ->s_active: majority in fs/super.c, with several outliers
in filesystems and safety of those is not trivial.

Any time you see that kind of pattern, you are risking to reprise
a scene from The Modern Times - the one with Charlie taking a trip
through the guts of machinery.
