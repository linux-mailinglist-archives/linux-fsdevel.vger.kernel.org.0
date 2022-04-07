Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D208B4F7D98
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 13:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbiDGLLY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 07:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiDGLLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:11:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56F1183BD;
        Thu,  7 Apr 2022 04:09:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5DCE721117;
        Thu,  7 Apr 2022 11:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649329760;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=98548563aIgFxuTbEGhuFrrjF0oRxSf7O8rE+4waoDU=;
        b=g4l9K/uvaXiqTrh3Weo9re3njIkaiqWsHhVzlu2BUyNo8+Kh97Oe45WKq1IDepkLQ+TCXq
        DWZCwJ6llV/96zFlTJlkAQsQx4ls9hq9WD2RvRBSCuqRBeaTM2glq5AusAaLjUIyrHa8sw
        Gci42F79V2a/ZAc58R5BDeZFhJPA1GM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649329760;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=98548563aIgFxuTbEGhuFrrjF0oRxSf7O8rE+4waoDU=;
        b=LI5tM34lmFPs2XvK0D3ZAkCwGn99zxxeFnUMWJtRtT3TH/8rccyWZ9R4XYqXWwEnLrQoGV
        +Yxxp19aOb7tPGDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 47FA2A3B88;
        Thu,  7 Apr 2022 11:09:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 314E5DA80E; Thu,  7 Apr 2022 13:05:18 +0200 (CEST)
Date:   Thu, 7 Apr 2022 13:05:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Will Deacon <will@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] btrfs: Avoid live-lock in search_ioctl() on
 hardware with sub-page faults
Message-ID: <20220407110518.GE15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Will Deacon <will@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220406180922.1522433-1-catalin.marinas@arm.com>
 <20220406180922.1522433-4-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406180922.1522433-4-catalin.marinas@arm.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 06, 2022 at 07:09:22PM +0100, Catalin Marinas wrote:
> Commit a48b73eca4ce ("btrfs: fix potential deadlock in the search
> ioctl") addressed a lockdep warning by pre-faulting the user pages and
> attempting the copy_to_user_nofault() in an infinite loop. On
> architectures like arm64 with MTE, an access may fault within a page at
> a location different from what fault_in_writeable() probed. Since the
> sk_offset is rewound to the previous struct btrfs_ioctl_search_header
> boundary, there is no guaranteed forward progress and search_ioctl() may
> live-lock.
> 
> Use fault_in_subpage_writeable() instead of fault_in_writeable() to
> ensure the permission is checked at the right granularity (smaller than
> PAGE_SIZE).
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Fixes: a48b73eca4ce ("btrfs: fix potential deadlock in the search ioctl")
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: David Sterba <dsterba@suse.com>
