Return-Path: <linux-fsdevel+bounces-68032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD40C51875
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 11:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AE03BB8D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 09:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E8D2FDC50;
	Wed, 12 Nov 2025 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBleDw50"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E0E2D663B;
	Wed, 12 Nov 2025 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940559; cv=none; b=o/G0ECOtSCllTOlqaUaS+Rlojik4uBr6qkWOtvq6UIuMEIF8ETEp40Mco8jpmnK+hN8mxwJqj2yBtC4NJ31yMDgviW/t/dJuQQBidm/oiPaMXYI7dWrAJZf0EDsgHskBKGBK781ByEVTegeUpjJH7llJXf0IIE83rtrMadydaV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940559; c=relaxed/simple;
	bh=sCz/KdI7yKdeZV5sd5nf35uwO2Z+AByDIOej6Yw2MbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGnnJACiYlAydLTPj4J8UX6ZVfkuA+NmSpI26YZTovF8Q5k3CzGHX1BW2LniPLCBwklvfyeb3aDtOT2jOAyqyXnAOgXEcoUJZVeu7AJJ5mVUsTjvgQoq/Ffs7JRLyBDaBjW2AYjyH+RTiP4awOHJBgU1QFFevGYNzXLFFGugyfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBleDw50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF40C19425;
	Wed, 12 Nov 2025 09:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762940558;
	bh=sCz/KdI7yKdeZV5sd5nf35uwO2Z+AByDIOej6Yw2MbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBleDw50dDNRKiVI1Z2wGSzS2owwso1IIDe6LfKqfClawIOOcFVtgbN0audnqB+v0
	 FrccyMGEEIQgg1EFQHPD+Eiah/HP/6ID/fDKkcS456qJavx9BO71MVWXa2twQorRJJ
	 KkxC0yXuZUV/Hpdot7a4yggHz3538ZLj25th/+ugIUZZPMNesBHL8b0aNphLv4JRiL
	 OtFFEgEut4gbnd/zGdyZujRpA1LTLYJNu+AizFaSzJRYDOylbwqztoPtnPo3F8t/4K
	 jzygTdjb7eTmUo+yY8EiqMhgOJTY9bihh1moF5EBT6l1ccbSJtsvtn9/Dw0R7nncu6
	 oAM15FPsNlQoQ==
Date: Wed, 12 Nov 2025 10:42:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrei Vagin <avagin@google.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs/namespace: correctly handle errors returned by
 grab_requested_mnt_ns
Message-ID: <20251112-gelitten-sanduhr-17a9d8b97ec8@brauner>
References: <20251111062815.2546189-1-avagin@google.com>
 <20251111-umkleiden-umgegangen-c19ef83823c1@brauner>
 <CAEWA0a5ZjWuyFM9b6076GT6yEn0jYZu06C=huPxpqyxWQiM7QA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEWA0a5ZjWuyFM9b6076GT6yEn0jYZu06C=huPxpqyxWQiM7QA@mail.gmail.com>

On Tue, Nov 11, 2025 at 08:20:46AM -0800, Andrei Vagin wrote:
> )
> 
> On Tue, Nov 11, 2025 at 1:13 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Nov 11, 2025 at 06:28:15AM +0000, Andrei Vagin wrote:
> > > grab_requested_mnt_ns was changed to return error codes on failure, but
> > > its callers were not updated to check for error pointers, still checking
> > > only for a NULL return value.
> > >
> > > This commit updates the callers to use IS_ERR() or IS_ERR_OR_NULL() and
> > > PTR_ERR() to correctly check for and propagate errors.
> > >
> > > Fixes: 7b9d14af8777 ("fs: allow mount namespace fd")
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Signed-off-by: Andrei Vagin <avagin@google.com>
> > > ---
> >
> > Thanks. I've folded the following diff into the patch to be more in line
> > with our usual error handling:
> 
> The diff looks good, thanks. I have another question regarding
> 7b9d14af8777 ("fs: allow mount namespace fd"). My understanding is that
> the intention was to allow using mount namespace file descriptors
> (req->spare) for the statmount and listmounts syscalls. If this is
> correct and I haven't missed anything, we need to make one more change:
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 9124465dca556..3250cadde6fc4 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5738,7 +5738,7 @@ static int copy_mnt_id_req(const struct
> mnt_id_req __user *req,
>         ret = copy_struct_from_user(kreq, sizeof(*kreq), req, usize);
>         if (ret)
>                 return ret;
> -       if (kreq->spare != 0)
> +       if (kreq->spare != 0 && kreq->mnt_ns_id != 0)
>                 return -EINVAL;

Yeah, that's right. I'm going to rename the field to mnt_ns_fd as
well... Thanks!

diff --git a/fs/namespace.c b/fs/namespace.c
index 76f6e868f352..2bad25709b2c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5727,7 +5727,7 @@ static int copy_mnt_id_req(const struct mnt_id_req __user *req,
        ret = copy_struct_from_user(kreq, sizeof(*kreq), req, usize);
        if (ret)
                return ret;
-       if (kreq->spare != 0)
+       if (kreq->mnt_ns_fd != 0 && kreq->mnt_ns_id)
                return -EINVAL;
        /* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
        if (kreq->mnt_id <= MNT_UNIQUE_ID_OFFSET)
@@ -5744,15 +5744,12 @@ static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq
 {
        struct mnt_namespace *mnt_ns;

-       if (kreq->mnt_ns_id && kreq->spare)
-               return ERR_PTR(-EINVAL);
-
        if (kreq->mnt_ns_id) {
                mnt_ns = lookup_mnt_ns(kreq->mnt_ns_id);
-       } else if (kreq->spare) {
+       } else if (kreq->mnt_ns_fd) {
                struct ns_common *ns;

-               CLASS(fd, f)(kreq->spare);
+               CLASS(fd, f)(kreq->mnt_ns_fd);
                if (fd_empty(f))
                        return ERR_PTR(-EBADF);

diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 7fa67c2031a5..5d3f8c9e3a62 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -197,7 +197,7 @@ struct statmount {
  */
 struct mnt_id_req {
        __u32 size;
-       __u32 spare;
+       __u32 mnt_ns_fd;
        __u64 mnt_id;
        __u64 param;
        __u64 mnt_ns_id;

