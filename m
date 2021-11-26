Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DF845F255
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 17:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345428AbhKZQsW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 11:48:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48962 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378460AbhKZQqR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:46:17 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 35BF2212BD;
        Fri, 26 Nov 2021 16:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637944982;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fmBvewAO8mTwkpsCQPRg1igFqC3ChA+p22fO+6l0PPE=;
        b=duP48ZS+TCtwDH5L3z96anN30Oj70SYnxUhMPpbW0T+VPm2AK9ka0IinIUYu4ChfXpdKbC
        f8IZsiB/L6/FeYO6+PYfTkSHYauXm9UeZ38hJdrXNeh6Ytwwj+9m3vgjITH9z3+KnQjhfZ
        mcVJZSYeP1JTGBXhWoCDf1bK7AXg9Fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637944982;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fmBvewAO8mTwkpsCQPRg1igFqC3ChA+p22fO+6l0PPE=;
        b=5s4aCH6YWzWhJOA2vKNRBndbY/L0bi8pskC/m8XiVaQCVBtnxm4NkcJIiKwt62/cSHm1PZ
        4WKq5pkxWBb7fjDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 15FC4A3B81;
        Fri, 26 Nov 2021 16:43:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F01A3DA735; Fri, 26 Nov 2021 17:42:52 +0100 (CET)
Date:   Fri, 26 Nov 2021 17:42:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: Avoid live-lock in search_ioctl() on hardware
 with sub-page faults
Message-ID: <20211126164252.GB28560@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-btrfs@vger.kernel.org
References: <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124192024.2408218-4-catalin.marinas@arm.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 24, 2021 at 07:20:24PM +0000, Catalin Marinas wrote:
> Commit a48b73eca4ce ("btrfs: fix potential deadlock in the search
> ioctl") addressed a lockdep warning by pre-faulting the user pages and
> attempting the copy_to_user_nofault() in an infinite loop. On
> architectures like arm64 with MTE, an access may fault within a page at
> a location different from what fault_in_writeable() probed. Since the
> sk_offset is rewound to the previous struct btrfs_ioctl_search_header
> boundary, there is no guaranteed forward progress and search_ioctl() may
> live-lock.
> 
> Use fault_in_exact_writeable() instead which probes the entire user
> buffer for faults at sub-page granularity.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: David Sterba <dsterba@suse.com>
