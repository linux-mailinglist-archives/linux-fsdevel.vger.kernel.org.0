Return-Path: <linux-fsdevel+bounces-68434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2F9C5C187
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 09:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 628903478C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 08:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D722FCC1E;
	Fri, 14 Nov 2025 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4p19VLv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FE62D2490;
	Fri, 14 Nov 2025 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763110403; cv=none; b=AaGmFqM+DDGZgg7IGt0GEjLTNv9dXnXYMnoDMTTQ9bSJ04f0g0zbZyS0cxEV2g7TvIoGGwHN+OjMGKCGx8sg+MklS4tALSagzPkX1U8B6n+1EkLRgE3+WnqTL2ZS7rN5rCrnPOqrkvwWUzVAYwArZvYE2yiDYyyX7xIKuuhV0Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763110403; c=relaxed/simple;
	bh=WZMktV4ff0LBQ2EF6H6Xc4F2TRjMpOcovsF/7DfFT/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwDougopnQvy/gYnz6yHbNbs38WSChsEkukJNJMCMoVNJqHhTS/TN4a1VVR6govabQ6skHqSKweVEkbwRXd55f/1029tpZS0YP2nF8DZod9PAQB4eHjhXMeY/ojc4DWyxxqZCTf3mdQzuJI9DXfHE9UBZ/Vvrceo2O/SMh9X+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4p19VLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6371FC19421;
	Fri, 14 Nov 2025 08:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763110403;
	bh=WZMktV4ff0LBQ2EF6H6Xc4F2TRjMpOcovsF/7DfFT/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4p19VLvphgHlJwyh2qYOsPfUrHzT5fuSBcHJshQR348uS7tf0ER/QlB199RlBYJe
	 THQJiKrrmaUbIoZKl4yf2kbYfY3UtfY6kjKLd4ZXZOdmSpIS0BMQveq5vYAdR3menv
	 FkLoajW6EOs3rVWwz7ibYK08UcsGorrvT8fcCQujGk0TBGTiq7+MMb5ELZi3NeAh35
	 SIBzsmVO8/+GHYdkOTAmEV+404bLNChTVjyWuemizuZXpliu+/1u9JAmZTGqrnvK2h
	 vHMRbA9UpZcFFoiWpChMHZGeKBgT1NbL5pVlc9J5lQAitScMCwOJp9cUtwwO0DiLKa
	 00YTahhEdd98Q==
Date: Fri, 14 Nov 2025 09:53:19 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 03/42] ovl: port ovl_create_or_link() to cred guard
Message-ID: <20251114-tyrannisieren-esstisch-9a596bcdeb7c@brauner>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
 <20251113-work-ovl-cred-guard-v3-3-b35ec983efc1@kernel.org>
 <CAJfpegtLkj_+W_rZxoMQ3zO_ZYrcKstWHPaRd6BmD4j80+SCdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegtLkj_+W_rZxoMQ3zO_ZYrcKstWHPaRd6BmD4j80+SCdA@mail.gmail.com>

On Fri, Nov 14, 2025 at 08:09:35AM +0100, Miklos Szeredi wrote:
> On Thu, 13 Nov 2025 at 22:32, Christian Brauner <brauner@kernel.org> wrote:
> 
> > @@ -641,23 +640,17 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
> >                          * create a new inode, so just use the ovl mounter's
> >                          * fs{u,g}id.
> >                          */
> > -               new_cred = ovl_setup_cred_for_create(dentry, inode, attr->mode,
> > -                                                    old_cred);
> > -               err = PTR_ERR(new_cred);
> > -               if (IS_ERR(new_cred)) {
> > -                       new_cred = NULL;
> > -                       goto out_revert_creds;
> > -               }
> > +                       new_cred = ovl_setup_cred_for_create(dentry, inode, attr->mode, old_cred);
> > +                       if (IS_ERR(new_cred))
> > +                               return PTR_ERR(new_cred);
> 
> put_cred() doesn't handle IS_ERR() pointers, AFAICS.

The function doesn't but the cleanup macro (as is customary) does:
DEFINE_FREE(put_cred, struct cred *, if (!IS_ERR_OR_NULL(_T)) put_cred(_T))

