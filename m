Return-Path: <linux-fsdevel+bounces-32123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DBF9A0D6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 16:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB61BB24AE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 14:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2270120E012;
	Wed, 16 Oct 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJeMUGMS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836102141A1;
	Wed, 16 Oct 2024 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090384; cv=none; b=bQ+bm4vSHPN1104NIHcJUMV5Vf6CfxqylBrGIwHYL5m4m0Y97eAYsRn4OJUY5P84q2IDrVAaat47FSJhDOJa4nsaO6Dz+9XTnvKtcEf1ScSqtPbsJrORiFfuNKxcJ3jlXNuNdDUh9htaxixrGX0HC3ckFwtnSN2tezeFqm4m4kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090384; c=relaxed/simple;
	bh=vipUYaVNF/6jEiyj4XoyWQ08zskOkWfRYKrVvfRCPcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVF7TYaZTlfhD/uPCF2JFqRE6z+H8WBofv3Gt9BcFH98wS7luArCsrGF6nyWHZAy/NK80O/qYX4KX2Mhx/oI9CIhB2O6vL7jSxMjOrolfoJG02wWfnEzTjFrHSne+GLlfnvldO0cQzckOtSuLtAQ61lU7RxXNwBeK9BoGX3hfes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJeMUGMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B55DC4CECF;
	Wed, 16 Oct 2024 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729090384;
	bh=vipUYaVNF/6jEiyj4XoyWQ08zskOkWfRYKrVvfRCPcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IJeMUGMShZWxdMURyBFv8HKLnUD7jQ+Pp1DkoIVvyGgoJRPe0zEVMNfd7rVLgawxD
	 HFJk+jfsNtzx9cshvrh2Q7k7kJ3WuoII+Ca+LW3Rl94J/FZFhCuKpTllqGAOj5k9wR
	 m/EQ8qBgprLE2MVNdot6aji15GuNg2OJ79DynrZgW7YAODFJn/MeQ/6+dBde4qS63t
	 PDTOEkQx5eQZtVLn72cjTFZJ2VqzPloEy9xqe2AmbEEyFyQN92cpQ2gCsysddvKPcU
	 BiAb9jsTiMIthwk9xqN0aH5z9oDkGbznig0akI2Bdvhy4/3X/gmXpUFUIp75Kqnx11
	 yUeaG++eAroDA==
Date: Wed, 16 Oct 2024 16:52:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>, 
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, anupnewsmail@gmail.com, alessandrozanni.dev@gmail.com, 
	syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs: Fix uninitialized value issue in from_kuid
Message-ID: <20241016-einpacken-ebnen-bcd0924480e1@brauner>
References: <20241016123723.171588-1-alessandro.zanni87@gmail.com>
 <20241016132339.cq5qnklyblfxw4xl@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241016132339.cq5qnklyblfxw4xl@quack3>

On Wed, Oct 16, 2024 at 03:23:39PM +0200, Jan Kara wrote:
> On Wed 16-10-24 14:37:19, Alessandro Zanni wrote:
> > Fix uninitialized value issue in from_kuid by initializing the newattrs
> > structure in do_truncate() method.
> 
> Thanks for the fix. It would be helpful to provide a bit more information
> in the changelog so that one doesn't have to open the referenced syzbot
> report to understand the problem. In this case I'd write something like:
> 
> ocfs2_setattr() uses attr->ia_uid in a trace point even though ATTR_UID
> isn't set. Initialize all fields of newattrs to avoid uninitialized
> variable use.
> 
> But see below as I don't think this is really the right fix.

Agreed.

> 
> > Fixes: uninit-value in from_kuid reported here
> >  https://syzkaller.appspot.com/bug?extid=6c55f725d1bdc8c52058
> 
> Fixes tag should reference some preexisting commit this patch is fixing. As
> such this tag is not really applicable here. Keeping the syzbot reference
> in Reported-by and Closes (or possibly change that to References) is good
> enough.
> 
> > Reported-by: syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=6c55f725d1bdc8c52058
> > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > ---
> >  fs/open.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/open.c b/fs/open.c
> > index acaeb3e25c88..57c298b1db2c 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -40,7 +40,7 @@ int do_truncate(struct mnt_idmap *idmap, struct dentry *dentry,
> >  		loff_t length, unsigned int time_attrs, struct file *filp)
> >  {
> >  	int ret;
> > -	struct iattr newattrs;
> > +	struct iattr newattrs = {0};
> 
> We usually perform such initialization as:
> 	struct iattr newattrs = {};
> 
> That being said there are many more places calling notify_change() and none
> of them is doing the initialization so this patch only fixes that one
> particular syzbot reproducer but doesn't really deal with the problem.
> Looking at the bigger picture I think the right solution really is to fix
> ocfs2_setattr() to not touch attr->ia_uid when ATTR_UID isn't set and
> similarly for attr->ia_gid and ATTR_GID.

Yes, that's what we did for similar bugs.

