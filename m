Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB4A545024
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 17:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241615AbiFIPHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 11:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237275AbiFIPHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:07:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CB82823ED;
        Thu,  9 Jun 2022 08:07:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 94DBF1FE1A;
        Thu,  9 Jun 2022 15:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654787225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ijNQJtk6i4bS4QWxJisxGyfX37F5AKbQDFufqaSXZY=;
        b=r0GH8a8OMYz9qCxwYnlpQdqJcDdzr81y+7Q96zHtHvv7mOhAiBSBx5z5skJYQuheM9fyrP
        OhwVH796ac6EGIP82Wqxy84XKU2xF2Fw406nnsVzRyzdtn3sZ8tyeYubU4helxrxefY3Ms
        g4pszhJLgKRiq4sTvLytSaOCon18h8E=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4A85F2C141;
        Thu,  9 Jun 2022 15:07:05 +0000 (UTC)
Date:   Thu, 9 Jun 2022 17:07:04 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, alexander.deucher@amd.com, daniel@ffwll.ch,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        hughd@google.com, andrey.grodzovsky@amd.com
Subject: Re: [PATCH 03/13] mm: shmem: provide oom badness for shmem files
Message-ID: <YqIMmK18mb/+s5de@dhcp22.suse.cz>
References: <20220531100007.174649-1-christian.koenig@amd.com>
 <20220531100007.174649-4-christian.koenig@amd.com>
 <YqG67sox6L64E6wV@dhcp22.suse.cz>
 <77b99722-fc13-e5c5-c9be-7d4f3830859c@amd.com>
 <YqHuH5brYFQUfW8l@dhcp22.suse.cz>
 <26d3e1c7-d73c-cc95-54ef-58b2c9055f0c@gmail.com>
 <YqIB0bavUeU8Abwl@dhcp22.suse.cz>
 <d4a19481-7a9f-19bf-c270-d89baa0970fc@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4a19481-7a9f-19bf-c270-d89baa0970fc@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 09-06-22 16:29:46, Christian König wrote:
[...]
> Is that a show stopper? How should we address this?

This is a hard problem to deal with and I am not sure this simple
solution is really a good fit. Not only because of the memcg side of
things. I have my doubts that sparse files handling is ok as well.

I do realize this is a long term problem and there is a demand for some
solution at least. I am not sure how to deal with shared resources
myself. The best approximation I can come up with is to limit the scope
of the damage into a memcg context. One idea I was playing with (but
never convinced myself it is really a worth) is to allow a new mode of
the oom victim selection for the global oom event. It would be an opt in
and the victim would be selected from the biggest leaf memcg (or kill
the whole memcg if it has group_oom configured.

That would address at least some of the accounting issue because charges
are better tracked than per process memory consumption. It is a crude
and ugly hack and it doesn't solve the underlying problem as shared
resources are not guaranteed to be freed when processes die but maybe it
would be just slightly better than the existing scheme which is clearly
lacking behind existing userspace.
-- 
Michal Hocko
SUSE Labs
