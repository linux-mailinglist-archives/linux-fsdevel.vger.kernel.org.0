Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEBE42E3DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 23:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbhJNV4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 17:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbhJNV4v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:56:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E82CC061570;
        Thu, 14 Oct 2021 14:54:46 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 869B11F44F68;
        Thu, 14 Oct 2021 22:54:44 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 2/2] fs: ext4: Fix the inconsistent name exposed by
 /proc/self/cwd
Organization: Collabora
References: <cover.1632909358.git.shreeya.patel@collabora.com>
        <8402d1c99877a4fcb152de71005fa9cfb25d86a8.1632909358.git.shreeya.patel@collabora.com>
        <YVdWW0uyRqYWSgVP@mit.edu> <8735pk5zml.fsf@collabora.com>
        <YVe0HS8HM48LDUDS@mit.edu>
Date:   Thu, 14 Oct 2021 18:54:31 -0300
In-Reply-To: <YVe0HS8HM48LDUDS@mit.edu> (Theodore Ts'o's message of "Fri, 1
        Oct 2021 21:21:33 -0400")
Message-ID: <8735p3gtm0.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Fri, Oct 01, 2021 at 03:11:30PM -0400, Gabriel Krisman Bertazi wrote:
>> 
>> The dcache name is exposed in more places, like /proc/mounts.  We have a
>> bug reported against flatpak where its initialization code bind mounts a
>> directory that was previously touched with a different case combination,
>> and then checks /proc/mounts in a case-sensitive way to see if the mount
>> succeeded.  This code now regresses on CI directories because the name
>> it asked to bind mount is not found in /proc/mounts.
>
> Ah, thanks for the context.  That makes sense.
>
>> I think the more reasonable approach is to save the disk exact name on
>> the dcache, because that is the only version that doesn't change based
>> on who won the race for the first lookup.
>
> What about the alternative of storing the casefolded name?  The
> advantage of using the casefolded name is that we can always casefold
> the name, where as in the case of a negative dentry, there is no disk
> exact name to use (since by definition there is no on-disk name).

That would work.  The casefolded version is always predictable (since
unicode is stable) and even though is not as easily available as the
disk name function (getdents), it solves the issue.

It would also allow us to use utf8_strncasecmp_folded in the d_compare
hook, which is nice.

Do you have an implementation suggestion to solve the dcache issue
pointed by Viro?

-- 
Gabriel Krisman Bertazi
