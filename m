Return-Path: <linux-fsdevel+bounces-9984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67DA846E30
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658001F29E0D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C4C13BEB0;
	Fri,  2 Feb 2024 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="g6iI/Sey"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F0D5B691
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870786; cv=none; b=UAIl1IMh/xhShUIR1D7LbXC0wc2mQX5MWUw/tNT/XbsldkAQc3KqpaH6+CBGg8WdvSieNSL9/PNSeUIxKu4Jpq360muxs9EsM0sGao2+qjg2vDF+4XJupAJG6HXO82k8P1Gi3rcGk7Pth100cC9wgwquWOtE9C4B5DZZYgiMJqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870786; c=relaxed/simple;
	bh=zvp0K9ydN3nMMzMq61aNR+c3kffjeXbJJ0TvhrErc1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLs+M6Kt5E22lIiHhwjOBoMz2SnNaTeZPTn9DXP0MWJJtX1ccEwhOH+3cYjpYBYysSKqEkXHxIDil3laJ+SOHrOfoxdOeykJidnmlAH/DeGhWmf2JKsG8YiwWZc7Wr5XDGA8QnACO0udttRrOqse8c1LM6p2ANL2v8WUUHqNxaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=g6iI/Sey; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a35e9161b8cso270240166b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 02:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706870782; x=1707475582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3kPO1VsO0xl/Hz3gFZBk/t8WtAh4jt1/TJtfk1JPNxw=;
        b=g6iI/SeyswTt7LP2T5GQxtFBNdW02HE3sgFq99mlgK1Uu2YJXZSOuDEHQJUeOlRp+F
         XTb/OBc8YHXbNuaFSmxoQOHUOaDtotXDc5Kyucw+F/dlL/wf03c9Jr2n/fh4F9HNzvxd
         rk7puOGuur9ZlbWLq4ZD7eMVuL1OvF921mOMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706870782; x=1707475582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kPO1VsO0xl/Hz3gFZBk/t8WtAh4jt1/TJtfk1JPNxw=;
        b=XB25CJ28ilhwYkNvfjsAz1NMVYjSfgJKtFPbvV5nS/6nngax6NdCUVFsoQtFY6Nmff
         g6iCi0uF9ukZ/htStr5SUfZVPqCOftMO1Fz5l1c249MSxyqmgL1jb+uJST8aqxtoLfru
         sNfSkhT89nFPES9FSP9ds9xx3rN3XohKWh1yjebnK225EE+u76OtcVeAeH2/rQbSJ/NX
         xQrvrhI2d+Bbv+VhuvXCyMixer7/JrylUxqSxBaFvX22DE6To4/VJ07U4V2iUwxJaUxb
         72mAxxUM9SBJU1jkYD9S/8Om4huDtdD6Fz34riQWazc17C/dlpD/Au8vrxIoPdfJDA0I
         SwCw==
X-Gm-Message-State: AOJu0YyCXDuJngAk/6tNhvQCKCAdN7aunt3Ir7T8hBdKF6HW5fqZMcAz
	TUOrcjZShc4TM1axHi1bCybevy6i/fK49dlqTz1sOqPZN8Qpk1+oSfRRhvsZvWSMlyXB8CDxkh4
	b36D2wGIIOajwW0mK/UQgGMM3wCNZWfMfxIUEzg==
X-Google-Smtp-Source: AGHT+IFR7cDiHqvGndK4aAk7B92jSuGV10s7ALvFXkMAB0xA944wD4b6Z6Pb2dUr/+XV5Ri8TqFJebZRVSVnU5kL+Zg=
X-Received: by 2002:a17:907:1119:b0:a31:34a9:d742 with SMTP id
 qu25-20020a170907111900b00a3134a9d742mr1152228ejb.3.1706870781905; Fri, 02
 Feb 2024 02:46:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2701318.1706863882@warthog.procyon.org.uk> <CAJfpegtOiiBqhFeFBbuaY=TaS2xMafLOES=LHdNx8BhwUz7aCg@mail.gmail.com>
 <2704767.1706869832@warthog.procyon.org.uk>
In-Reply-To: <2704767.1706869832@warthog.procyon.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 2 Feb 2024 11:46:10 +0100
Message-ID: <CAJfpegu6v1fRAyLvFLOPUSAhx5aAGvPGjBWv-TDQjugqjUA_hQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Replacing TASK_(UN)INTERRUPTIBLE with regions
 of uninterruptibility
To: David Howells <dhowells@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org, Matthew Wilcox <willy@infradead.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, dwmw2@infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 11:30, David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > > We have various locks, mutexes, etc., that are taken on entry to
> > > filesystem code, for example, and a bunch of them are taken interruptibly
> > > or killably (or ought to be) - but filesystem code might be called into
> > > from uninterruptible code, such as the memory allocator, fscache, etc..
> >
> > Are you suggesting to make lots more filesystem/vfs/mm sleeps
> > killable?  That would present problems with being called from certain
> > contexts.
>
> No, it wouldn't.  What I'm suggesting is something like:
>
>         overlayfs_mkdir(inode)
>         {
>                 inode_lock(inode);  <---  This could be interruptible

Just making inode_lock() interruptible would break everything.

So I assume this is not what you meant, but that we add error handling
to each and every inode_lock() call?

>                 ...
>                 begin_task_uninterruptible();

Yes, I understand that this is your suggestion.

For overlayfs it doesn't really make sense, but for network fs and
fuse I guess it could be interesting.  I would have thought that
making all fs related sleeping locks interruptible is not something
that would be worth the effort, but maybe you have a very good use
case.

Thanks,
Miklos

