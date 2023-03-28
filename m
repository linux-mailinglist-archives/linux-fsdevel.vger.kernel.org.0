Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5C16CC7E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 18:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjC1Q21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 12:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjC1Q2Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:28:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B57DCDE5
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 09:28:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C0FD6219CF;
        Tue, 28 Mar 2023 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680020901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=glRWKttHyaif3Tia9UrJ1ZD1++zoH7ejygPsJmWo4d4=;
        b=LPlAN7P2uIWMgLwg9r6zUkNGLsk2dckGJ1bnEYYrE+NjPo5eRwv4RYtsU6bTKXYKB+yH8f
        V2tmh9lXJxLj6l5Q/ln4pKAO3yRGm39zi+FhUv5G/cMBOJJZPsWXV8WzY/jeM+hFWbFc6v
        Fo9l90V1cdqmNFYSXizsQfNo7rsmIL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680020901;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=glRWKttHyaif3Tia9UrJ1ZD1++zoH7ejygPsJmWo4d4=;
        b=5T5jIDSLku2md3VhIgIaKIINvKwPxGl9KX554aQsTeJ0ua5FXq5VsrpSkrhONZMUqdTWLl
        GDnFgxnqyGFs4gAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8FC71390B;
        Tue, 28 Mar 2023 16:28:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jg+iKKUVI2S5PAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 28 Mar 2023 16:28:21 +0000
Message-ID: <115288f8-bd28-f01f-dd91-63015dcc635d@suse.cz>
Date:   Tue, 28 Mar 2023 18:28:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [LSF/MM/BPF TOPIC] Memory profiling using code tagging
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
References: <CAJuCfpHJX8zeQY6t5rrKps6GxbadRZBE+Pzk21wHfqZC8PFVCA@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpHJX8zeQY6t5rrKps6GxbadRZBE+Pzk21wHfqZC8PFVCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/22/23 20:31, Suren Baghdasaryan wrote:
> We would like to continue the discussion about code tagging use for
> memory allocation profiling. The code tagging framework [1] and its
> applications were posted as an RFC [2] and discussed at LPC 2022. It
> has many applications proposed in the RFC but we would like to focus
> on its application for memory profiling. It can be used as a
> low-overhead solution to track memory leaks, rank memory consumers by
> the amount of memory they use, identify memory allocation hot paths
> and possible other use cases.
> Kent Overstreet and I worked on simplifying the solution, minimizing
> the overhead and implementing features requested during RFC review.

IIRC one large objection was the use of page_ext, I don't recall if you
found another solution to that?

> Kent Overstreet, Michal Hocko, Johannes Weiner, Matthew Wilcox, Andrew
> Morton, David Hildenbrand, Vlastimil Babka, Roman Gushchin would be
> good participants.
> 
> [1] https://lwn.net/Articles/906660/
> [2] https://lore.kernel.org/all/20220830214919.53220-1-surenb@google.com/
> 

