Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F5070DC01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 14:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjEWMJV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 08:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236349AbjEWMJU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 08:09:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4943118;
        Tue, 23 May 2023 05:09:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 605EB6117C;
        Tue, 23 May 2023 12:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E9DC433D2;
        Tue, 23 May 2023 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684843758;
        bh=3HvMiLwSxwQEG8Ntmcawz72NdT2pUbel5Q8Sk7Zjzik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJ2qIB74oDOP+PUdnYONaOPP2l2LQGFy/WVyW1zNXHabrGks7kUzGD+Oh8zH3hO8w
         FD7fwqyB58gRA9260iNFdDIkIX60E6tFGmX+7enMxHmTSGvRrutzOkNcD2Y14/cSfJ
         1FluobWOkijaPdBgyxPv1hUEpLPCkTDdjxLsKjfd9XevhkcRd1xN+fxjPqLTJnqPg3
         bXmdRyvpwgOTeoPgCoR+0hJF5gRv5Lb0OsuG1lxUN7B4Zyn6ymo3qlRDNUjugjWito
         /x3quZKgWRZQBbpi4ClKR3b8Ey5XZwYT+usTx63Bqcbmdh1kj5xdD2OL/hM9fpuww3
         VtqMoRCM6ysWQ==
Date:   Tue, 23 May 2023 14:09:12 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <dchinner@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Jiri Wiesner <jwiesner@suse.de>
Subject: Re: [RFC PATCH 0/3] Rework locking when rendering mountinfo cgroup
 paths
Message-ID: <20230523-salamander-gemeldet-b549ea345cf8@brauner>
References: <20230502133847.14570-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230502133847.14570-1-mkoutny@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 02, 2023 at 03:38:44PM +0200, Michal Koutný wrote:
> Idea for these modification came up when css_set_lock seemed unneeded in
> cgroup_show_path.
> It's a delicate change, so the deciding factor was when cgroup_show_path popped
> up also in some profiles of frequent mountinfo readers.
> The idea is to trade the exclusive css_set_lock for the shared
> namespace_sem when rendering cgroup paths. Details are described more in

I have no issue with the cgroup specific part of relying on
namespace_sem but kernel/cgroup/ has no business of being aware of
namespace semaphore in any way. Leave a comment to clarify what you're
doing but we're not going to sprinkle namespace_sem references - even if
only for the sake of lockdep - into other subsystems.
