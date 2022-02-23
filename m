Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCC14C129A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 13:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240411AbiBWMSM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 07:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237095AbiBWMSM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:18:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B7D9E57D;
        Wed, 23 Feb 2022 04:17:44 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AF7AD212B8;
        Wed, 23 Feb 2022 12:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645618663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z25zmfa1BH9FbZAkPcAjAOIvBZxhio/HEtOcbGxkK2s=;
        b=iBLlmwQKBfdGXCAAeg3wvlnrV4J7/udoMQQsDdu2Cee3a60Gai9m9bpGPUSAITEkoMaU8s
        1//GkQuJVdkXZW2F3rLTgCANQjuKMwtQWqcfgugd/zWATYwJ3OL5tTae/rSTpI2MgrUQn2
        85bOgy9hMuJpJjjUpIHA/9zHbWWnRZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645618663;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z25zmfa1BH9FbZAkPcAjAOIvBZxhio/HEtOcbGxkK2s=;
        b=XIUgtLKy3brznIghNde4scldLLjKyFNVYfgKgSPS1OgKLfn3fJyCKSDJsMuABr1N7A2HJi
        gggIq5wSLuuz1jCw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A0D3BA3B83;
        Wed, 23 Feb 2022 12:17:43 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E6B50A0605; Wed, 23 Feb 2022 13:17:37 +0100 (CET)
Date:   Wed, 23 Feb 2022 13:17:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>,
        Edward Shishkin <edward.shishkin@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: get rid of AOP_FLAG_CONT_EXPAND flag
Message-ID: <20220223121737.bsyoih6rt63pev54@quack3.lan>
References: <fbc744c9-e22f-138c-2da3-f76c3edfcc3d@gmail.com>
 <20220220232219.1235-1-edward.shishkin@gmail.com>
 <20220222102727.2sqf4wfdtjaxrqat@quack3.lan>
 <YhTnSwmHVRe5AzJQ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhTnSwmHVRe5AzJQ@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 22-02-22 13:38:19, Matthew Wilcox wrote:
> On Tue, Feb 22, 2022 at 11:27:27AM +0100, Jan Kara wrote:
> > On Mon 21-02-22 00:22:19, Edward Shishkin wrote:
> > > Signed-off-by: Edward Shishkin <edward.shishkin@gmail.com>
> > > ---
> > >  fs/reiserfs/inode.c | 16 +++++-----------
> > >  1 file changed, 5 insertions(+), 11 deletions(-)
> > 
> > Thanks! I have queued this patch into my tree.
> 
> I added the following commit message to it for my tree:
> 
> Author: Edward Shishkin <edward.shishkin@gmail.com>
> Date:   Mon Feb 21 00:22:19 2022 +0100
> 
>     reiserfs: Stop using AOP_FLAG_CONT_EXPAND flag
> 
>     We can simplify write_begin() and write_end() by handling the
>     cont_expand case in reiserfs_setattr().
> 
>     Signed-off-by: Edward Shishkin <edward.shishkin@gmail.com>
>     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Yeah, I have written some changelog as well :) Something like:

    reiserfs: get rid of AOP_FLAG_CONT_EXPAND flag
    
    Remove usage of AOP_FLAG_CONT_EXPAND flag. Reiserfs is the only user of
    it and it is easy to avoid.
    
    Link: https://lore.kernel.org/r/20220220232219.1235-1-edward.shishkin@gmail.com
    Signed-off-by: Edward Shishkin <edward.shishkin@gmail.com>
    Signed-off-by: Jan Kara <jack@suse.cz>

> I don't object if it goes via your tree; I doubt I'll get the AOP_FLAG
> removal finished in time for the next merge window.

OK, I'll keep it in my tree then and push it to Linus for the merge window.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
