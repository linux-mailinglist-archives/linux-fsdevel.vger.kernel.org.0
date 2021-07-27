Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771CA3D704E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 09:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbhG0HVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 03:21:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235558AbhG0HVF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:21:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C934E60238;
        Tue, 27 Jul 2021 07:21:02 +0000 (UTC)
Date:   Tue, 27 Jul 2021 09:21:00 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/10] memcg: enable accounting for mnt_cache entries
Message-ID: <20210727072100.4a3o6tcw7v5ot2lr@wittgenstein>
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
 <cover.1627362057.git.vvs@virtuozzo.com>
 <045db11f-4a45-7c9b-2664-5b32c2b44943@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <045db11f-4a45-7c9b-2664-5b32c2b44943@virtuozzo.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 08:33:12AM +0300, Vasily Averin wrote:
> The kernel allocates ~400 bytes of 'strcut mount' for any new mount.
> Creating a new mount namespace clones most of the parent mounts,
> and this can be repeated many times. Additionally, each mount allocates
> up to PATH_MAX=4096 bytes for mnt->mnt_devname.
> 
> It makes sense to account for these allocations to restrict the host's
> memory consumption from inside the memcg-limited container.
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---

Looks good. Thank you!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

I wonder how much this increases reported memory consumption when you
boot full system containers that run systemd and a bunch of systemd
services that each use a separate mount namespace.
