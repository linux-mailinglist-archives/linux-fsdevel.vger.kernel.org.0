Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA246F9829
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 12:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjEGKMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 06:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjEGKMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 06:12:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A720E3A87;
        Sun,  7 May 2023 03:12:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8EB661F74A;
        Sun,  7 May 2023 10:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683454319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E2IBRhSYCp7770K3WZ9qLNwH/ZcVfrY9C1tieDZlpdg=;
        b=FIbi3vnJWeyisZKQAKPVxxKWxGo2cNOIKsLNgCwvtQ9PD+03S4WGFNTrTeJVW8AyA0ho3C
        4qhOKE4ROa0kpIcILETDzKxA6afhoxlER3gNbyxMQyTTYalxOeW0dQ8rZBj0mnF5I5ObNd
        ZJsiFec8xeevqFYY1Vrw1++ytRBXVaw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B8D8139C3;
        Sun,  7 May 2023 10:11:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vjeYGW95V2R4NAAAMHmgww
        (envelope-from <mhocko@suse.com>); Sun, 07 May 2023 10:11:59 +0000
Date:   Sun, 7 May 2023 12:11:58 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     chengkaitao <chengkaitao@didiglobal.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        corbet@lwn.net, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, brauner@kernel.org,
        muchun.song@linux.dev, viro@zeniv.linux.org.uk,
        zhengqi.arch@bytedance.com, ebiederm@xmission.com,
        Liam.Howlett@oracle.com, chengzhihao1@huawei.com,
        pilgrimtao@gmail.com, haolee.swjtu@gmail.com, yuzhao@google.com,
        willy@infradead.org, vasily.averin@linux.dev, vbabka@suse.cz,
        surenb@google.com, sfr@canb.auug.org.au, mcgrof@kernel.org,
        sujiaxun@uniontech.com, feng.tang@intel.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 0/2] memcontrol: support cgroup level OOM protection
Message-ID: <ZFd5bpfYc3nPEVie@dhcp22.suse.cz>
References: <20230506114948.6862-1-chengkaitao@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506114948.6862-1-chengkaitao@didiglobal.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 06-05-23 19:49:46, chengkaitao wrote:
> Establish a new OOM score algorithm, supports the cgroup level OOM
> protection mechanism. When an global/memcg oom event occurs, we treat
> all processes in the cgroup as a whole, and OOM killers need to select
> the process to kill based on the protection quota of the cgroup

Although your patch 1 briefly touches on some advantages of this
interface there is a lack of actual usecase. Arguing that oom_score_adj
is hard because it needs a parent process is rather weak to be honest.
It is just trivial to create a thin wrapper, use systemd to launch
important services or simply update the value after the fact. Now
oom_score_adj has its own downsides of course (most notably a
granularity and a lack of group protection.

That being said, make sure you describe your usecase more thoroughly.
Please also make sure you describe the intended heuristic of the knob.
It is not really clear from the description how this fits hierarchical
behavior of cgroups. I would be especially interested in the semantics
of non-leaf memcgs protection as they do not have any actual processes
to protect.

Also there have been concerns mentioned in v2 discussion and it would be
really appreciated to summarize how you have dealt with them.

Please also note that many people are going to be slow in responding
this week because of LSFMM conference
(https://events.linuxfoundation.org/lsfmm/)
-- 
Michal Hocko
SUSE Labs
