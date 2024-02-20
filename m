Return-Path: <linux-fsdevel+bounces-12147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2EE85B85F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 10:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9010286E1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646F160DD3;
	Tue, 20 Feb 2024 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDYiEGut"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D1D5D725;
	Tue, 20 Feb 2024 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423019; cv=none; b=LFvXAlIN1mu/83hwVGBrQzM1CRbmBEfuvx5YMcwfysE5W0teSjYBtya6Ng4Yk9sSE3uAxwy2LT/2uf2mkpD1K2S5z7nPGKpdcDbkSQadVo0WG6g3fUsoLfbAnkH+FErmBNv/nplsPwMvqlxYcCKEdS8Gh41P4+PBIUkGvXsWoow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423019; c=relaxed/simple;
	bh=ndWAmyMkyCe7p03x/9HHbHy76rgNeM5CEFriO4AjFT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDo/yDCGq+7DMl1P0VTmOsUqqyf6QA4udWn+YQbp8z2X8G/fvOyG13yjqLjlASqrCzy3qV15HIgOiCER/v/YMQ+fBqNoh/5PjcEG8kQyTCACnESprq7lOlCdeTU2YLKQreRwma9esmxwILeRiWptaLxU3ivL9wcLBy+dYBUiP4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDYiEGut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED29C43390;
	Tue, 20 Feb 2024 09:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708423019;
	bh=ndWAmyMkyCe7p03x/9HHbHy76rgNeM5CEFriO4AjFT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDYiEGuttiQVberspseQVpB4Jch8Z2ZrWiIOeyuRcCuXGLIRFXR275xuUlcX94Rzs
	 2/dyIVxOvyxpZIPwZdNu23hhgP9dZDWhSjr9qzCf2iQoOehtppGlBXg73XU43rKEh0
	 yoiwQLvMhLXPwFvfwW93oJvFme797H7Hkmvd5C30LUVn74wIU4Nhr0vtFk2QK8+fxj
	 XEUmBXgmsdvLP6hABt/noHrUNTGW3thG6vySSeZFw+ZATCYgTBA50t8VTxWRnmMzuY
	 cu1XWeh8zFpfjxAsFiZUdQUuVJFRE/G2yRBQ38s8jZ2hSZBkW7+/oJUSKq1E1aLIwu
	 VLyL1riVTmHNw==
Date: Tue, 20 Feb 2024 10:56:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, hughd@google.com, 
	akpm@linux-foundation.org, Liam.Howlett@oracle.com, oliver.sang@intel.com, 
	feng.tang@intel.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Subject: Re: [PATCH v2 1/6] libfs: Re-arrange locking in offset_iterate_dir()
Message-ID: <20240220-ortsrand-initialen-43550ee746ed@brauner>
References: <170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net>
 <170820142021.6328.15047865406275957018.stgit@91.116.238.104.host.secureserver.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <170820142021.6328.15047865406275957018.stgit@91.116.238.104.host.secureserver.net>

On Sat, Feb 17, 2024 at 03:23:40PM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Liam and Matthew say that once the RCU read lock is released,
> xa_state is not safe to re-use for the next xas_find() call. But the
> RCU read lock must be released on each loop iteration so that
> dput(), which might_sleep(), can be called safely.

Fwiw, functions like this:

static struct dentry *offset_find_next(struct xa_state *xas)
{
        struct dentry *child, *found = NULL;

        rcu_read_lock();
        child = xas_next_entry(xas, U32_MAX);
        if (!child)
                goto out;
        spin_lock(&child->d_lock);
        if (simple_positive(child))
                found = dget_dlock(child);
        spin_unlock(&child->d_lock);
out:
        rcu_read_unlock();
        return found;
}

should use the new guard feature going forward imho. IOW, in the future such
helpers should be written as:

static struct dentry *offset_find_next(struct xa_state *xas)
{
        struct dentry *child, *found = NULL;

	guard(rcu)();
        child = xas_next_entry(xas, U32_MAX);
        if (!child)
		return NULL;
        spin_lock(&child->d_lock);
        if (simple_positive(child))
                found = dget_dlock(child);
        spin_unlock(&child->d_lock);
        return found;
}

which allows you to eliminate the goto and to have the guarantee that the rcu
lock is released when you return. This also works for other locks btw.

