Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8CA57E93A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 23:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiGVVyB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 17:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiGVVyA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:54:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6AA2980A
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jul 2022 14:53:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E499D1FE74;
        Fri, 22 Jul 2022 21:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658526837;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J6ZDM2qb1aYzALMnUlVXWZHDE+sGeTzAp3o+boojF6M=;
        b=O4Pu/8NvjwjlH2G9KzXT5APhClNFeO9mc6MtKFxkwMM628ZXE22QWpvVgkPRcgn8p5SZzA
        hidbaKFZrCZN0s5ERmcYXDURR8g+3CjDTvfpPLGPlNXRGcKcQbieG3JPKDyUBIIGwxBChj
        KNcYdEzU3F9+1FI/1WeMJhWcHBooGs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658526837;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J6ZDM2qb1aYzALMnUlVXWZHDE+sGeTzAp3o+boojF6M=;
        b=WX7SEeIGBIkY920Nh4zCgu0LDE1mZLZeNff7fu5yCXurQ0xYzLHBuE8AMXkQrq1t2Bs3lq
        mZDqtQMGtuaqcCCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5F3F13AB3;
        Fri, 22 Jul 2022 21:53:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9mKEL3Uc22J8EgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 22 Jul 2022 21:53:57 +0000
Date:   Fri, 22 Jul 2022 23:49:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH v2] affs: use memcpy_to_zero and remove replace
 kmap_atomic()
Message-ID: <20220722214902.GX13489@suse.cz>
Reply-To: dsterba@suse.cz
References: <20220712222744.24783-1-dsterba@suse.com>
 <20220721185024.5789-1-dsterba@suse.com>
 <YtnOKvyjvYwFcFQ1@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtnOKvyjvYwFcFQ1@iweiny-desk3>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 21, 2022 at 03:07:38PM -0700, Ira Weiny wrote:
> On Thu, Jul 21, 2022 at 08:50:24PM +0200, David Sterba wrote:
> > The use of kmap() is being deprecated in favor of kmap_local_page()
> > where it is feasible. For kmap around a memcpy there's a convenience
> > helper memcpy_to_page, use it.
> > 
> > CC: Ira Weiny <ira.weiny@intel.com>
> 
> Typo in the subject: s/memcpy_to_page/memcpy_to_zero
> 
> Other than that.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Thanks, fixed.
