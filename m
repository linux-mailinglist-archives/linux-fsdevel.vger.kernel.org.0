Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E3E648259
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Dec 2022 13:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiLIM1T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Dec 2022 07:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIM1S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Dec 2022 07:27:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4094219C;
        Fri,  9 Dec 2022 04:27:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2642D1FDD3;
        Fri,  9 Dec 2022 12:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670588836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SceSQ4zWov1ruMmU/Cx4LOSHMhOduLnCnMnnkM+gdgY=;
        b=Y/jTuZgZkRwDo3u6JvpxWmxiCzQ7i4pV50tHTktLt3Lv9PdTcSOmis4LHFLFclwTIcdd0f
        kPaux3bQGkvZRGxRDTM/8fMPG716dlC2ra5uhmQXUryrL9B93z2EHqhu0OH/x35juMIVqe
        83doSlhUIabdsyiPq/nkMFbIId+D7rA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F01A0138E0;
        Fri,  9 Dec 2022 12:27:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5mIYOqMpk2NkTQAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 09 Dec 2022 12:27:15 +0000
Date:   Fri, 9 Dec 2022 13:27:15 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     =?utf-8?B?56iL5Z6y5rab?= Chengkaitao Cheng 
        <chengkaitao@didiglobal.com>
Cc:     chengkaitao <pilgrimtao@gmail.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
        "haolee.swjtu@gmail.com" <haolee.swjtu@gmail.com>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vasily.averin@linux.dev" <vasily.averin@linux.dev>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "surenb@google.com" <surenb@google.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "sujiaxun@uniontech.com" <sujiaxun@uniontech.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm: memcontrol: protect the memory in cgroup from
 being oom killed
Message-ID: <Y5Mpo+X/rtr2D8Jr@dhcp22.suse.cz>
References: <Y5HzfLB7lu4+BOu1@dhcp22.suse.cz>
 <114DF8F0-3E68-4F2B-8E35-0943EC2F51AE@didiglobal.com>
 <Y5LxAbOB2AYp42hi@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5LxAbOB2AYp42hi@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 09-12-22 09:25:38, Michal Hocko wrote:
> On Fri 09-12-22 05:07:15, 程垲涛 Chengkaitao Cheng wrote:
[...]
> > Here is a simple example. In a docker container, users can divide all processes 
> > into two categories (important and normal), and put them in different cgroups. 
> > One cgroup's oom.protect is set to "max", the other is set to "0". In this way, 
> > important processes in the container can be protected.
> 
> That is effectivelly oom_score_adj = OOM_SCORE_ADJ_MIN - 1 to all

Sorry that should have been OOM_SCORE_ADJ_MIN + 1

-- 
Michal Hocko
SUSE Labs
