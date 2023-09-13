Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E30979EFBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 19:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjIMRDN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 13:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjIMRDL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:03:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F035DC;
        Wed, 13 Sep 2023 10:03:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 18E90218DF;
        Wed, 13 Sep 2023 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694624586;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jc9cGHAR1BPs1t7lfB6YE1RvgCVnkTfxA/oir8xg+MU=;
        b=u1nN8jfBWhhToATucmM4uHyNMkKQcHsHL+NJi2s0JHCbTLMC0jXsyqA80+KqS9mdA7XKwW
        8I+TEVy1L4SvhKxYrQiAK/sjv51oZTqCfVz4AURvFwJyETx6+Smi+1cDU9q/kzYukdhPpj
        HFLkcchVWRHATLrF/xS07SzTHf6cYtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694624586;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jc9cGHAR1BPs1t7lfB6YE1RvgCVnkTfxA/oir8xg+MU=;
        b=F52LLlC6VovCvdbPKk/Kqej87VJU5Cqe0h/J2orpRNKsxZ/yXfRPAqJlMqsKE1eMUsDjiY
        778EV4OsIfOEQBAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B70713582;
        Wed, 13 Sep 2023 17:03:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ITUhJUnrAWXbLgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Sep 2023 17:03:05 +0000
Date:   Wed, 13 Sep 2023 19:03:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 38/45] fs: super: dynamically allocate the s_shrink
Message-ID: <20230913170303.GT20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
 <20230911094444.68966-39-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911094444.68966-39-zhengqi.arch@bytedance.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 11, 2023 at 05:44:37PM +0800, Qi Zheng wrote:
> In preparation for implementing lockless slab shrink, use new APIs to
> dynamically allocate the s_shrink, so that it can be freed asynchronously
> via RCU. Then it doesn't need to wait for RCU read-side critical section
> when releasing the struct super_block.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> CC: Chris Mason <clm@fb.com>
> CC: Josef Bacik <josef@toxicpanda.com>
> CC: David Sterba <dsterba@suse.com>

Acked-by: David Sterba <dsterba@suse.com>
