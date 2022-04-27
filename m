Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8152551244B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 23:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbiD0VJP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 17:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237974AbiD0VI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:08:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B825E8E19E
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 14:05:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 73098210EE;
        Wed, 27 Apr 2022 21:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651093523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHdnP9zHAjjyTCl0YD7znZHKYdXKqLdovpDCOJC1JNY=;
        b=caMmlzM1f2dfJsTWyxfq9QzvgUfZ+qfWdYbJKp2UJUF0iukpScw60Z1KJKaUOu1O85MQTA
        I/PN4JXCYTfAzpwgEuvW6EmdHX6PlBHkmm9Y+JJeB9p1TVZdnLano+gvtQoF1VpFAgcSJS
        N8/9lsqLnZEU3DNAM9jJGR4q2yqFtIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651093523;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHdnP9zHAjjyTCl0YD7znZHKYdXKqLdovpDCOJC1JNY=;
        b=K5Y7ZT+YCh9Pq13I9WJuyqLdLYOh0Mb7HL05owNPNk/hCZBJ7qDMmul4YnwfxSvY3K6Uta
        JfTq8runWLIZi7Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A74613A39;
        Wed, 27 Apr 2022 21:05:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5TvqEBOwaWJcEgAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 27 Apr 2022 21:05:23 +0000
Date:   Wed, 27 Apr 2022 23:05:22 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        willy@infradead.org, Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH v7 4/6] gen_init_cpio: fix short read file handling
Message-ID: <20220427230522.216c91c8@suse.de>
In-Reply-To: <20220426134039.4f6f864141577229a01ad8be@linux-foundation.org>
References: <20220404093429.27570-1-ddiss@suse.de>
        <20220404093429.27570-5-ddiss@suse.de>
        <20220426134039.4f6f864141577229a01ad8be@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 26 Apr 2022 13:40:39 -0700, Andrew Morton wrote:

> On Mon,  4 Apr 2022 11:34:28 +0200 David Disseldorp <ddiss@suse.de> wrote:
> 
> > When processing a "file" entry, gen_init_cpio attempts to allocate a
> > buffer large enough to stage the entire contents of the source file.
> > It then attempts to fill the buffer via a single read() call and
> > subsequently writes out the entire buffer length, without checking that
> > read() returned the full length, potentially writing uninitialized
> > buffer memory.  
> 
> That was rather rude of it.
> 
> > Fix this by breaking up file I/O into 64k chunks and only writing the
> > length returned by the prior read() call.  
> 
> Does this change fix any known or reported problems?

This was found via code inspection. I'm not aware of anyone hitting it
in the wild.

Thanks for the feedback, Andrew.

Cheers, David
