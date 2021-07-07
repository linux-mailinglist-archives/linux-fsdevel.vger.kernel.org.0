Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A223BE6D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 13:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhGGLGP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 07:06:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54432 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhGGLGP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 07:06:15 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A624220A9;
        Wed,  7 Jul 2021 11:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625655814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BgwYsC6ZoaxZL4BZ5yOzWNI4AOSUP3oyE9DclzfFN0E=;
        b=s7GlYmyY7GpGckJrnHxNjzV/1A82IqWHbFQpY3fRU3TsVv8kYjD7Uvv7f9KtjjtCgm9bvl
        MODop/1i+cwvBLzxZecn/nb4MBd2Z1lchOjj+0lhS19tC7tLXOyil5c2SEYozn5Ndn47gK
        GZTiW2bWuCkhiefTMzHEObOoFaRE//s=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E7F4E13998;
        Wed,  7 Jul 2021 11:03:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ogBCNQWK5WDYXgAAGKfGzw
        (envelope-from <nborisov@suse.com>); Wed, 07 Jul 2021 11:03:33 +0000
Subject: Re: [PATCH v2 5/8] fs: add a filemap_fdatawrite_wbc helper
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, linux-fsdevel@vger.kernel.org
References: <cover.1624974951.git.josef@toxicpanda.com>
 <b57a146e13e5e08ecffce68fa8a71cf1e36081c8.1624974951.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <5425d3ef-ef71-626b-17f9-b6b5bac27815@suse.com>
Date:   Wed, 7 Jul 2021 14:03:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b57a146e13e5e08ecffce68fa8a71cf1e36081c8.1624974951.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 29.06.21 г. 16:59, Josef Bacik wrote:
> Btrfs sometimes needs to flush dirty pages on a bunch of dirty inodes in
> order to reclaim metadata reservations.  Unfortunately most helpers in
> this area are too smart for us
> 
> 1) The normal filemap_fdata* helpers only take range and sync modes, and
>    don't give any indication of how much was written, so we can only
>    flush full inodes, which isn't what we want in most cases.
> 2) The normal writeback path requires us to have the s_umount sem held,
>    but we can't unconditionally take it in this path because we could
>    deadlock.
> 3) The normal writeback path also skips inodes with I_SYNC set if we
>    write with WB_SYNC_NONE.  This isn't the behavior we want under heavy
>    ENOSPC pressure, we want to actually make sure the pages are under
>    writeback before returning, and if another thread is in the middle of
>    writing the file we may return before they're under writeback and
>    miss our ordered extents and not properly wait for completion.
> 4) sync_inode() uses the normal writeback path and has the same problem
>    as #3.
> 
> What we really want is to call do_writepages() with our wbc.  This way
> we can make sure that writeback is actually started on the pages, and we
> can control how many pages are written as a whole as we write many
> inodes using the same wbc.  Accomplish this with a new helper that does
> just that so we can use it for our ENOSPC flushing infrastructure.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
