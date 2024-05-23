Return-Path: <linux-fsdevel+bounces-20045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191B88CD131
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 13:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E471C21A83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 11:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAA81474BD;
	Thu, 23 May 2024 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmFt4Ohj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA431474AE
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716463526; cv=none; b=Uw1K6pi5uQps9xuXjUyFRIO5zaTNKf7ZhaKejDuFX2D+tj1boA7eeSE18fc9RKpddw+XxOEPj6SgyfmywWPaiI8RZuzOunPJxkgTzeyHVyf/13EPfLimf8g3dBW4I9S7WvvjxQB0hf025eJVz2ZOltt6unFX21Z5PcqGRxxxLaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716463526; c=relaxed/simple;
	bh=wt5PN/qtjJ2rzw45d1w/1vKkEDgQP106dMP5qeGQdII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFwLfU4ZuEbJGvr6i2A25K9elJboBSaCtIOZCE417jCxvfPfqU7qBD2C8O2MDAY2aixO0VxL4RIhEIUNG28wI/bYw/XPKkj3K/5R+Ql640a3uTJbOgYNIdxQXVAoAzVisuVjpOfTEAGOoHgt8cplcZ3hH2iZa+GYhw8hVzkkdC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmFt4Ohj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716463523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6zBDO7+ZsvNadbNCW894YSxB3AuxDzS9c+VkJhtMr+U=;
	b=NmFt4OhjbZQOE+WyIUQ0P/SWRjF8hm4sncGptRl2w6qXFXD4Sx75mafGZx3HnLqnq5j7ms
	nzkWmP73Ru6GQq5aCDEjeGCwCYq4mVjIwI8a6c73U22eSfi6BlSNuRFK2Miz9FXHFcm6/5
	7kSyBFkBq42YroyVt9fULEW2y0cwLCk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-gbJh6pVKOUO2in3WmnBaVQ-1; Thu, 23 May 2024 07:25:22 -0400
X-MC-Unique: gbJh6pVKOUO2in3WmnBaVQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-420eed123a2so25715525e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 04:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716463521; x=1717068321;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6zBDO7+ZsvNadbNCW894YSxB3AuxDzS9c+VkJhtMr+U=;
        b=nTjys5B7mmi6OSZuViLhJX0QwX9bzNpcEHcWZDAFLN6Scb+OjCPzL0SFiH4ROxh58u
         j+kUPdMxH/7OKMJcElAgZhmLCc6s0oOwMqyhI518CWlz7JMUBsWbxNhNSs3s15Vrf5Tv
         0oCqBmfHt6XxNZiKE1xVHQfx8z2uhn7owrMToaARU3M4bv+XGdRAdvDTrq4sc2MasDts
         EDXJU6DP7r40D6pnLXZqAFkDHxcsRFUazv4ql4rSRdWzkv2Ju4192apoQW/ETIWEyAX5
         8bO1v2xVr/p7j9BKjjos3zYYscdPdv4aKyl0NZrceWWw0FgoAQDRxWyUoCrFJrAdc0aQ
         ySVA==
X-Forwarded-Encrypted: i=1; AJvYcCXuJY+E4ytlafNxT3u35Xd92CwqfHOgZ8yhRCU/KlwK+dYnVGK9dlgOHnvHWnQOXJDETJ+xfWqg62gyiDTU8frZpm/837NA8juU21m+kw==
X-Gm-Message-State: AOJu0YwSkkda2R9t0ym81KuzCkTv1Un3ZXSZjrzRrE/WgHyQeY1sQmG6
	0YN0vQ4bGT84KKcaPrTfZ4UVKjfAcjyQ4gUsx+pHrHuJWghY774d8gyVsC+ifp9f+WBXzXjgL5r
	On7XUTttMJUs8TBmdGdDAxtVWY5vJHBZIxIGZXU4C0heE+GFKCyn1iptwgqGtdlOZ8LHjbw==
X-Received: by 2002:a05:600c:1c95:b0:41f:e87b:45c2 with SMTP id 5b1f17b1804b1-420fd225b5amr45149055e9.0.1716463520561;
        Thu, 23 May 2024 04:25:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFf/0WS7wUZcK2TlJzARg3ViRqgIdeYsEi8F/byytPfMSORAmrYwNtxoWRNoW6XrfebxrVYQ==
X-Received: by 2002:a05:600c:1c95:b0:41f:e87b:45c2 with SMTP id 5b1f17b1804b1-420fd225b5amr45148895e9.0.1716463520080;
        Thu, 23 May 2024 04:25:20 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc0asm36726213f8f.1.2024.05.23.04.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 04:25:19 -0700 (PDT)
Date: Thu, 23 May 2024 13:25:18 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eric Biggers <ebiggers@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2 2/4] fs: add FS_IOC_FSSETXATTRAT and
 FS_IOC_FSGETXATTRAT
Message-ID: <upfj7ycpdowfsss5nslt4objo4el6xv3chwj2psmvycjjrpnrb@ide7wa5bzvib>
References: <20240520164624.665269-2-aalbersh@redhat.com>
 <20240520164624.665269-4-aalbersh@redhat.com>
 <CAOQ4uxikMjmAkXwGk3d9897622JfkeE8LXaT9PBrtTiR5y3=Rg@mail.gmail.com>
 <z6ctkxtwhwioc5a5kzisjxffkde6xpchstrr3zlflh4bsz4mpd@5z2s2d7lbje5>
 <CAOQ4uxjaLbrmSDk_a_M6YDT5tQoHO=dXTDsHVOSYcMxeQnpP1w@mail.gmail.com>
 <3b7opex4hgm3ed6v24m7k4oagp2gnsjms45yq223u2nnrbvicx@bgoqeylzxelj>
 <20240522162853.GW25518@frogsfrogsfrogs>
 <20240522163856.GA1789@sol.localdomain>
 <CAOQ4uxjkHyRvV1VVAa+Agdgb8TOHJv1QOJvNbgmG-PY=G1L+DQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjkHyRvV1VVAa+Agdgb8TOHJv1QOJvNbgmG-PY=G1L+DQ@mail.gmail.com>

On 2024-05-22 22:03:55, Amir Goldstein wrote:
> On Wed, May 22, 2024 at 7:38 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Wed, May 22, 2024 at 09:28:53AM -0700, Darrick J. Wong wrote:
> > >
> > > Do the other *at() syscalls prohibit dfd + path pointing to a different
> > > filesystem?  It seems odd to have this restriction that the rest don't,
> > > but perhaps documenting this in the ioctl_xfs_fsgetxattrat manpage is ok.
> >
> > No, but they are arbitrary syscalls so they can do that.  ioctls traditionally
> > operate on the specific filesystem of the fd.
> 
> To emphasize the absurdity
> think opening /dev/random and doing ioctl to set projid on some xfs file.
> It is ridiculous.
> 
> >
> > It feels like these should be syscalls, not ioctls.
> >
> 
> I bet whatever name you choose for syscalls it is going to be too
> close lexicographically to [gs]etxattrat(2) [1]. It is really crowded
> in the area of getattr/getfattr/fgetxattr/getxattr/getfileattr/getfsxattr...
> I think I would vote for [gs]etfsxattrat(2) following the uapi struct fsxattr.
> I guess we have officially spiralled.
> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/linux-fsdevel/20240426162042.191916-1-cgoettsche@seltendoof.de/
> 

Thanks for the link, will convert to syscalls in next version.

-- 
- Andrey


