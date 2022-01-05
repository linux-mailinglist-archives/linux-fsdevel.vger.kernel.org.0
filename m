Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A724C485707
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 18:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242138AbiAERDz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 12:03:55 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59796 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242123AbiAERDv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:03:51 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0670D1F37C;
        Wed,  5 Jan 2022 17:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641402230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jNu2mn341ZGkz1uVIEx0qvJ64WIUA3ihYU6sd+dalP4=;
        b=a5mPAC4sor3NED+DLzF1SX/nfY1Edr7PivWLrdq/lHJP12IhSgcKewgofXKxjkPaeY340T
        4xrXOrP4lGpoE2jl+SK/hK6e/dIsis29ZMk6IqTQlqngz/NizMkDFnBi6u9uv8dF0wVLmG
        a+WYr+qet6/IcLBwshKnda+aIGzEM/g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADA4313BF9;
        Wed,  5 Jan 2022 17:03:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TwVkKXXP1WEIGwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 05 Jan 2022 17:03:49 +0000
Date:   Wed, 5 Jan 2022 18:03:48 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v5 13/16] mm: memcontrol: reuse memory cgroup ID for kmem
 ID
Message-ID: <20220105170348.GA21070@blackbody.suse.cz>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-14-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220085649.8196-14-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 20, 2021 at 04:56:46PM +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> There are two idrs being used by memory cgroup, one is for kmem ID,
> another is for memory cgroup ID. The maximum ID of both is 64Ki.
> Both of them can limit the total number of memory cgroups.
> Actually, we can reuse memory cgroup ID for kmem ID to simplify the
> code.

An interesting improvement.

I'm a bit dense -- what's the purpose the MEM_CGROUP_ID_DIFF offset?
Couldn't this deduplication be extended to only use mem_cgroup.id.id
instead of mem_cgroup.kmemcg_id? (With a boolean telling whether kmem
accounting is active.)

Thanks,
Michal
