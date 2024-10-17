Return-Path: <linux-fsdevel+bounces-32180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8711E9A1E31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 11:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC819B25214
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 09:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5FF1D90B9;
	Thu, 17 Oct 2024 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUxzaAst"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F341D90B3;
	Thu, 17 Oct 2024 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729156944; cv=none; b=QdSkdQ0WDk1BEmbRanqXh4W+E//SCpOxeKqGTEo9+2mbX2H3GNPMNCQ6vxzkS3DI2lKXaMjbaiFoj5M+xwZFv4pL9iEyB/MuVYH+jWFF7ANM9mWNXyfMeGZvjvPhYkpuLCc/BmlzYxbniA9vEe3wy5rvnh7FfdrEYDAior3Rq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729156944; c=relaxed/simple;
	bh=CN06saoFKqKB6Crb6I16l85p58Y17qwmEPiyHVZNYoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3fGGqoiVvBU6WBUFyUvhbmxU9g/USKCxGrLNlwBabBuQpEsAWQ3uvFaThObaEBQNYUF9QKzDXsJckos28FsINhXZ945ZqB2UndXJYwX4Tt9/N3NiaNEGlBFQVaqKQ+0wSnJ38DKp8arulHAyMVBi2IJUFtJFtGwvqe5cEuIlhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUxzaAst; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99cc265e0aso86827866b.3;
        Thu, 17 Oct 2024 02:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729156940; x=1729761740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nAT6RJq/yPaSxzHZ3YIzZ+XtgUy1bRU5UGVeVzamu3w=;
        b=IUxzaAstHXmPTgSJH4J/IDljVmvo3G4yBE2ypOpuC1LC0KOGa8FRa+XUUsxEYWBQg1
         0NbTTN9MhqNAOKcRJmKjlEWcLkL4yjSOEnjogZ/Gy2Aq4xaYnGG4MYcagjTSvf7CXe6+
         fWbs+TMKoMHjgbk6vr00jfIWm6tSAj6TaLz8plEIh1tbTK7pDowPpPQgwmASBSreztu3
         YUyw/UXx+qyQUkeNiYxCExj33BLza3Y9BNtf7YK/ripWH9NjtnibD9vkbtn+YgKzfLfz
         zPbbNYgnJrusAMGL6TH02nxvo3s6HYzSz6fDgn/JYmvxp28JN7P9OrzH7okWE7lQdSOG
         Iq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729156940; x=1729761740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAT6RJq/yPaSxzHZ3YIzZ+XtgUy1bRU5UGVeVzamu3w=;
        b=bumqcE+rdnPzi3t47YI+XMpXQJE6Uiq5+bR7ri6AzPLmafoQTfeGDR7m7xv581IOLw
         2/zhqpmrWWjtkxeARZNfe/826Y38VexVCwcy49Wfjx3xR9q7K8KR2ygSl4NSP2A1uPVW
         G6JDdsv39qaMavvwZRS04rJ3dup0ImMUb0o1K6Ht9xtewzyp7mIB/MraCJQH7oojAx42
         jNzEyiDBR6Tgn7TyLr02+rhULV3ojmWshWYQqDYYQjHJ8ClWApw7MROv8NnYQFsJxl4l
         +QQPas3dSfPDKl6T2j1c+Ty+yMO4o0y41G4kDwOf+906u2KuZiuWHPwR1IlFpPPLmKya
         9Ttg==
X-Forwarded-Encrypted: i=1; AJvYcCVHe07ESqT3ONOcwpTN6prr2X1wtsdcBCkLS/JarfDv5DSGjJok0Tx8dCvp5h+Y4xez2j2ZwhRm2WORJ03F@vger.kernel.org, AJvYcCVjq7xrCVvOxw5s7GmCgn8DpZhMbkD9uU/8RNwFt0pFtjIiguRL0TacZGDAgaIF3B9GvVQ2eA9egREf2v1N@vger.kernel.org
X-Gm-Message-State: AOJu0YzUmL5oRwn7ac0GlvyOp8IrxdBaumQsVCZcrK3Li0cGnuIrDunl
	Efkt/V6Fm48E+cKC6BsJjxS+F2m7oYhp+vx8BJfos8yLhpdKYgms
X-Google-Smtp-Source: AGHT+IGzQxuyYZgtz+JfjykDxU3L53vMA6Xeo/7a4aeoAWtojmDVo7fDrnzjawPs11j2GbnFh6SwoQ==
X-Received: by 2002:a17:907:9446:b0:a9a:26a1:1963 with SMTP id a640c23a62f3a-a9a34c833admr621930566b.7.1729156939356;
        Thu, 17 Oct 2024 02:22:19 -0700 (PDT)
Received: from localhost (net-2-44-97-22.cust.vodafonedsl.it. [2.44.97.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2973faffsm270005266b.48.2024.10.17.02.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:22:18 -0700 (PDT)
Date: Thu, 17 Oct 2024 11:22:17 +0200
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	anupnewsmail@gmail.com, alessandrozanni.dev@gmail.com, 
	syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs: Fix uninitialized value issue in from_kuid
Message-ID: <5lnqirv3cia7cqnjfjp4ypjlpppkx6do5ds5yexzxrtkoct5bm@zjdp32invihk>
References: <20241016123723.171588-1-alessandro.zanni87@gmail.com>
 <20241016132339.cq5qnklyblfxw4xl@quack3>
 <20241016-einpacken-ebnen-bcd0924480e1@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-einpacken-ebnen-bcd0924480e1@brauner>

On 24/10/16 04:52, Christian Brauner wrote:
> On Wed, Oct 16, 2024 at 03:23:39PM +0200, Jan Kara wrote:
> > On Wed 16-10-24 14:37:19, Alessandro Zanni wrote:
> > > Fix uninitialized value issue in from_kuid by initializing the newattrs
> > > structure in do_truncate() method.
> > 
> > Thanks for the fix. It would be helpful to provide a bit more information
> > in the changelog so that one doesn't have to open the referenced syzbot
> > report to understand the problem. In this case I'd write something like:
> > 
> > ocfs2_setattr() uses attr->ia_uid in a trace point even though ATTR_UID
> > isn't set. Initialize all fields of newattrs to avoid uninitialized
> > variable use.
> > 
> > But see below as I don't think this is really the right fix.
> 
> Agreed.

Ok.
 
> > 
> > > Fixes: uninit-value in from_kuid reported here
> > >  https://syzkaller.appspot.com/bug?extid=6c55f725d1bdc8c52058
> > 
> > Fixes tag should reference some preexisting commit this patch is fixing. As
> > such this tag is not really applicable here. Keeping the syzbot reference
> > in Reported-by and Closes (or possibly change that to References) is good
> > enough.

Ok.
 
> > > Reported-by: syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=6c55f725d1bdc8c52058
> > > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > > ---
> > >  fs/open.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/open.c b/fs/open.c
> > > index acaeb3e25c88..57c298b1db2c 100644
> > > --- a/fs/open.c
> > > +++ b/fs/open.c
> > > @@ -40,7 +40,7 @@ int do_truncate(struct mnt_idmap *idmap, struct dentry *dentry,
> > >  		loff_t length, unsigned int time_attrs, struct file *filp)
> > >  {
> > >  	int ret;
> > > -	struct iattr newattrs;
> > > +	struct iattr newattrs = {0};
> > 
> > We usually perform such initialization as:
> > 	struct iattr newattrs = {};
> > 
> > That being said there are many more places calling notify_change() and none
> > of them is doing the initialization so this patch only fixes that one
> > particular syzbot reproducer but doesn't really deal with the problem.
> > Looking at the bigger picture I think the right solution really is to fix
> > ocfs2_setattr() to not touch attr->ia_uid when ATTR_UID isn't set and
> > similarly for attr->ia_gid and ATTR_GID.
> 
> Yes, that's what we did for similar bugs.

Thanks for the valuable comments.

I digged more into the code. I think the two possible fixes are: 
i) return 0 from ocfs2_setattr() if ATTR_UID/ATTR_GID are not set
ii) enter in trace_ocfs2_setattr() only if ATTR_UID/ATTR_GID are set

What do you think?

Thanks,
Alessandro

