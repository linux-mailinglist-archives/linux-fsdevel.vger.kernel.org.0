Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382DA49B52B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 14:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577207AbiAYNcG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 08:32:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42296 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348654AbiAYN3t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:29:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 683C2614A1;
        Tue, 25 Jan 2022 13:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86B9C340E0;
        Tue, 25 Jan 2022 13:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643117386;
        bh=G9+jbEdgn6dqtJ1KUO5cKlCRbG9bB4kcC0JiROCSfAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lq5JRw21XJ3ellYkVHi+Euv3EhrSWzaQYKcF67rTLnyD8zzt/TJGIryT63bMGcqRR
         2mezgv1hSW4XOH7d8OKnSnTlKgPLj4A8H6D7J2g8XKxb9gugPI1XYgYH10By0XAFCe
         dYjNuV37OZGBRAamlDYhnlTKuVyCJIkwhfio9UE8FlQN/itN9Gnh+e/uGshha2IfHm
         2tyRviIUI+qkS4Q3U5/h1X0o6fQcFPws5clh4PzE0ZyM6hYXQngQxdO2oyBtvUtoPs
         yVxp5P2t0howyqjtECf03Nbou74Xo8xIBFCgC2oso+j/JdaJouZLxkpe33iZDrTP4O
         Ij4CkRTHiD7xw==
Date:   Tue, 25 Jan 2022 14:29:42 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: Pre-allocate superblock in sget_fc() if !test
Message-ID: <20220125132942.o7rnqwvqx5w6ifz4@wittgenstein>
References: <20220124161006.141323-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124161006.141323-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 24, 2022 at 11:10:06AM -0500, Waiman Long wrote:
> When the test function is not defined in sget_fc(), we always need
> to allocate a new superblock. So there is no point in acquiring the
> sb_lock twice in this case. Optimize the !test case by pre-allocating
> the superblock first before acquring the lock.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  fs/super.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/super.c b/fs/super.c
> index a6405d44d4ca..6601267f6fe0 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -520,6 +520,8 @@ struct super_block *sget_fc(struct fs_context *fc,
>  	struct user_namespace *user_ns = fc->global ? &init_user_ns : fc->user_ns;
>  	int err;
>  
> +	if (!test)
> +		goto prealloc;

I mean, now its another goto in there that adds to the confusion.
sget_fc() could _probably_ benefit if it were split into
__sget_test_fc() and __sget_independent_fc() with both ending up being
called from sget_fc() dending on whether or not test is NULL ofc.

This way the test and non-test cases would stop being mangled together
possibly making the logic easier to follow. Would probably also require
to move the common initialization part into a helper callable from both
__sget_independent_fc() and __sget_test_fc() sm like idk:

static struct super_block *__finish_init_super(........)
{
	s->s_fs_info = fc->s_fs_info;
	err = set(s, fc);
	if (err) {
		s->s_fs_info = NULL;
		spin_unlock(&sb_lock);
		destroy_unused_super(s);
		return ERR_PTR(err);
	}
	fc->s_fs_info = NULL;
	s->s_type = fc->fs_type;
	s->s_iflags |= fc->s_iflags;
	strlcpy(s->s_id, s->s_type->name, sizeof(s->s_id));
	list_add_tail(&s->s_list, &super_blocks);
	hlist_add_head(&s->s_instances, &s->s_type->fs_supers);
	spin_unlock(&sb_lock);
	get_filesystem(s->s_type);
	register_shrinker_prepared(&s->s_shrink);
	return s;
}
