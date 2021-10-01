Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D942041F4D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 20:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355699AbhJASSe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 14:18:34 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48506 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhJASSe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 14:18:34 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 4FC621F42460
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     tytso@mit.edu, viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 0/2] Handle a soft hang and the inconsistent name issue
Organization: Collabora
References: <cover.1632909358.git.shreeya.patel@collabora.com>
Date:   Fri, 01 Oct 2021 14:16:45 -0400
In-Reply-To: <cover.1632909358.git.shreeya.patel@collabora.com> (Shreeya
        Patel's message of "Wed, 29 Sep 2021 16:23:37 +0530")
Message-ID: <87ee94625u.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shreeya Patel <shreeya.patel@collabora.com> writes:

> When d_add_ci is called from the fs layer, we face a soft hang which is
> caused by the deadlock in d_alloc_parallel. First patch in the series
> tries to resolve it by doing a case-exact match instead of the
> case-inexact match done by d_same_name function.

Hi Shreeya,

I understand what you are trying to solve here, but this could use some
clarification.

There is no such deadlock in the upstream code base, since d_add_ci is
never called by a file system with a d_compare hook that causes the
issue.  Patch 02/02 will be the first to include such path, to address
the /proc/self/cwd leakage, therefore, Patch 01/02 is done in
preparation of that patch.  That needs to be clearly stated here.

Originally, the 'native', per-directory case-insensitive implementation
merged in ext4/f2fs stores the case of the first lookup on the dcache,
regardless of the disk exact file name case.  This is intended as an
internal implementation detail, that shouldn't be leaked to
userspace. Whenever the kernel returns a name to userspace it should be
the exact name, as written on disk.  But, on /proc/self/cwd, the
internal name is leaked to userspace.  The goal of the series is
*solely* to fix the leakage of this implementation detail to userspace.

I think the solution is in the right direction, but I see some
issues on the implementation I'm discussing inline.

> The second patch resolves the inconsistent name that is exposed by
>/proc/self/cwd in case of a case-insensitive filesystem.
>/proc/self/cwd uses the dentry name stored in dcache. Since the dcache
>is populated only on the first lookup, with the string used in that
>lookup, cwd will have an unexpected case, depending on how the data was
>first looked-up in a case-insesitive filesystem.
>
>
> Shreeya Patel (2):
>   fs: dcache: Handle case-exact lookup in d_alloc_parallel
>   fs: ext4: Fix the inconsistent name exposed by /proc/self/cwd
>
>  fs/dcache.c     | 20 ++++++++++++++++++--
>  fs/ext4/namei.c | 13 +++++++++++++
>  2 files changed, 31 insertions(+), 2 deletions(-)

-- 
Gabriel Krisman Bertazi
