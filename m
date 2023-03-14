Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4FE6B8C75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 09:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjCNIFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 04:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjCNIF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:05:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CEE80936;
        Tue, 14 Mar 2023 01:05:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 269001FE20;
        Tue, 14 Mar 2023 08:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678781114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TqIJDRVcUYmUlbVn0Al2s2TH5Ea7U61xcXfPnxRC8bk=;
        b=JuuPkRge9DaAsKPAnSsr3J3o2B1c45g4WDsJTAypBCaOTG/+k2YtwugJotj+5umoepDq5L
        TuUVPHm4eFg+d2esuhVpCZd6V3STHgLDJx9hJDyNjPYs0q2y13F3+6WIXihGzreIdcwUbu
        lO+u7taEJcnju7keWQH7NrYiQQWglyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678781114;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TqIJDRVcUYmUlbVn0Al2s2TH5Ea7U61xcXfPnxRC8bk=;
        b=lFATKKuMWsr+cewxUEmgvU2RGt38Txqkod0y1aDc5gwWv25hEcpjSi72g6lfcJ97SCxl5W
        v+xphcCSgLf76gAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E80C113A26;
        Tue, 14 Mar 2023 08:05:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PMfcN7kqEGSmNQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 14 Mar 2023 08:05:13 +0000
Message-ID: <4b9fc9c6-b48c-198f-5f80-811a44737e5f@suse.cz>
Date:   Tue, 14 Mar 2023 09:05:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: [LSF/MM/BPF TOPIC] SLOB+SLAB allocators removal and future SLUB
 improvements
To:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        bpf@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Language: en-US
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As you're probably aware, my plan is to get rid of SLOB and SLAB, leaving
only SLUB going forward. The removal of SLOB seems to be going well, there
were no objections to the deprecation and I've posted v1 of the removal
itself [1] so it could be in -next soon.

The immediate benefit of that is that we can allow kfree() (and kfree_rcu())
to free objects from kmem_cache_alloc() - something that IIRC at least xfs
people wanted in the past, and SLOB was incompatible with that.

For SLAB removal I haven't yet heard any objections (but also didn't
deprecate it yet) but if there are any users due to particular workloads
doing better with SLAB than SLUB, we can discuss why those would regress and
what can be done about that in SLUB.

Once we have just one slab allocator in the kernel, we can take a closer
look at what the users are missing from it that forces them to create own
allocators (e.g. BPF), and could be considered to be added as a generic
implementation to SLUB.

Thanks,
Vlastimil

[1] https://lore.kernel.org/all/20230310103210.22372-1-vbabka@suse.cz/
