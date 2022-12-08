Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DB36469BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Dec 2022 08:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiLHHdQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Dec 2022 02:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiLHHdK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Dec 2022 02:33:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E68125C56;
        Wed,  7 Dec 2022 23:33:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D305620717;
        Thu,  8 Dec 2022 07:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670484787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JXDfWNY3Qbfl8rtTtlddtnpeaKhAduAL7p+BYr8IZ2k=;
        b=nDYXvrFzHssNJikFT/o1HPTD29lvSXSarooGqRFa9kKWHGxdsciSmZFTpedjC7WMaWFBAN
        3NkUZ+LYtt1ZA3o52N+KGeToMqt34WShBl8hgNMKmGxggv5/v4inFygp7VUzQs8Nwgr4HB
        sOfiPaSwz3k+ByjhpMiDeFZADJ63wqo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA243138E0;
        Thu,  8 Dec 2022 07:33:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FLl/KTOTkWOuDQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 08 Dec 2022 07:33:07 +0000
Date:   Thu, 8 Dec 2022 08:33:07 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     chengkaitao <pilgrimtao@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        corbet@lwn.net, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        chengkaitao@didiglobal.com, viro@zeniv.linux.org.uk,
        zhengqi.arch@bytedance.com, ebiederm@xmission.com,
        Liam.Howlett@oracle.com, chengzhihao1@huawei.com,
        haolee.swjtu@gmail.com, yuzhao@google.com, willy@infradead.org,
        vasily.averin@linux.dev, vbabka@suse.cz, surenb@google.com,
        sfr@canb.auug.org.au, mcgrof@kernel.org, sujiaxun@uniontech.com,
        feng.tang@intel.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: memcontrol: protect the memory in cgroup from
 being oom killed
Message-ID: <Y5GTM5HLhGrx9zFO@dhcp22.suse.cz>
References: <20221208034644.3077-1-chengkaitao@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208034644.3077-1-chengkaitao@didiglobal.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 08-12-22 11:46:44, chengkaitao wrote:
> From: chengkaitao <pilgrimtao@gmail.com>
> 
> We created a new interface <memory.oom.protect> for memory, If there is
> the OOM killer under parent memory cgroup, and the memory usage of a
> child cgroup is within its effective oom.protect boundary, the cgroup's
> tasks won't be OOM killed unless there is no unprotected tasks in other
> children cgroups. It draws on the logic of <memory.min/low> in the
> inheritance relationship.
> 
> It has the following advantages,
> 1. We have the ability to protect more important processes, when there
> is a memcg's OOM killer. The oom.protect only takes effect local memcg,
> and does not affect the OOM killer of the host.
> 2. Historically, we can often use oom_score_adj to control a group of
> processes, It requires that all processes in the cgroup must have a
> common parent processes, we have to set the common parent process's
> oom_score_adj, before it forks all children processes. So that it is
> very difficult to apply it in other situations. Now oom.protect has no
> such restrictions, we can protect a cgroup of processes more easily. The
> cgroup can keep some memory, even if the OOM killer has to be called.
> 
> Signed-off-by: chengkaitao <pilgrimtao@gmail.com>
> ---
> v2: Modify the formula of the process request memcg protection quota.

The new formula doesn't really address concerns expressed previously.
Please read my feedback carefully again and follow up with questions if
something is not clear.
-- 
Michal Hocko
SUSE Labs
