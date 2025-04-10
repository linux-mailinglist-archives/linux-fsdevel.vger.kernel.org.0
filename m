Return-Path: <linux-fsdevel+bounces-46222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7C8A84B9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 19:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 487747A12AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 17:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC87A2046AF;
	Thu, 10 Apr 2025 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Igoq8XiO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DF920C038
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744307312; cv=none; b=urAjYQlxSRyLi/1E74aMoa0IukLkDJGsYcZqe7kCmIyg9qA0mTik/8uZ0oBEVlIN50clVeTRnUHXrbpgHKEDlokAjoMQOc8fpw/SbSkqpdP8ShWQpV5GSmCQanvf1IIhh5oQU05VelhxnxXtG7Dlcu8IX0c1n4XvktCO+5d1J5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744307312; c=relaxed/simple;
	bh=9kFVBt0xmNJ1O3N7xNDOXpsY2sp5HC0wOX9IKhNyfoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4aviw//RqT387wFk8LZDpd4dyFPK/nlrd5svo1SVNtnU2fOVYL/+qhnKdF5VEkU24ZF3kJzsG0mWUMMo669PPNJpJh4dS4upULzP4U5DxZ6Q76G11nqjh9lB37TjTt1LcXjxyyf7jtP4j4Z8+yy/shJZ6+rP9nMnCO8VTvQXkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Igoq8XiO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744307309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqvPNxA7jww3BXXOwYN/gaN85wuxZPgfj7tUlo1Pygo=;
	b=Igoq8XiOR2jq/FzPAumA9aWR2qErCcMAyz6s3JlB9EEI4xDcCXXp9FEdmEi/q0ByLxeCJ9
	ugiRj3jejH0O45K8chmG0RU1PgDuCS6jq0OUWLSShyW2GQVerQADXPh9B7ZVd094OxVD4N
	mMvEApChBM5BEhJlUHv+cNdLWwbPjvk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680--ywlhW3GNhm-I-gWSVqymw-1; Thu, 10 Apr 2025 13:48:27 -0400
X-MC-Unique: -ywlhW3GNhm-I-gWSVqymw-1
X-Mimecast-MFC-AGG-ID: -ywlhW3GNhm-I-gWSVqymw_1744307307
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff69646218so1467350a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 10:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744307307; x=1744912107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqvPNxA7jww3BXXOwYN/gaN85wuxZPgfj7tUlo1Pygo=;
        b=jq70zyylPEPcUDo+O92QeymfSiypG3OM9sZjW0QlF6p5BB+mpGKp0kJr/K2uSUDBkX
         qCSpd1Sz6lHaCVFsD9VedRomT7inE1VZFQA8fza1YPegYQBVo5V/m2a3qh2OJ28FiV7P
         Evqc9+3azo1razZ20jmAKEcLvKZUiGVaTdslnjCWnjR++Lj2sMWGaTWO5E4g8Gm+5GmV
         73k9WeFHP+fGC4UNJTLcp3oW7kghDfcCVLqUzcLmYOtnXu6fhFgO/VXmFPY8UE3kTur3
         c9rAQhKgfZ6G2xEgAwfp39Pzts6D5x3tm1zdvlIP6za++mGqOCkz/G0CPoh3ZD7R3QY5
         UFpg==
X-Forwarded-Encrypted: i=1; AJvYcCUYDKOhdHmRdTmRvmaN2oVhIgteQH6F/B4YEm7yZ28s+/nZosPGYvwI6VtW18xtVmXxZC77jKLzpx4xaRln@vger.kernel.org
X-Gm-Message-State: AOJu0YwK2/6W1vc1feK5KynLuqITl5RHb/u6MnQopKae3iddGc/m51s4
	HFwui+YzeGXVhmTAKFxOlpeibyPB762aw5t0maYDUT87CnSrdH/5RVUdbG6k/JRTg7YDw0FWy3G
	rUp7+FlikR/F/f2o1W/LVso3fATLHa0wdax2Cl0GOVmMqoz8jG7curhWRVdejqSohA6wbdA2MtZ
	uXgFzKn1ARKo5mfiuKTaeo+B6kI2sIw6YDr/makA==
X-Gm-Gg: ASbGnct45OIsyNeRsRG711W/2C0PlVSgSB0dtCWVqDNCOqMPjTg5QQo3VSYdKSYX8FA
	2bBk8fNX6I5IAenUugGCeTp0BAXmOrFOCKlyGjVf/6cd8ecfVLfemn4ytPxj36DGl5jM=
X-Received: by 2002:a17:902:dac9:b0:224:1579:5e91 with SMTP id d9443c01a7336-22b42c5ac2amr51880055ad.47.1744307306735;
        Thu, 10 Apr 2025 10:48:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUo1DbI1h9w9OLlDnjq5RZSX9CGytc55kczInpUMCnGZepk9T1FYX3YU4pw1A+DuQV82ASCx1d3eK2A6PEVwk=
X-Received: by 2002:a17:902:dac9:b0:224:1579:5e91 with SMTP id
 d9443c01a7336-22b42c5ac2amr51879845ad.47.1744307306483; Thu, 10 Apr 2025
 10:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407182104.716631-1-agruenba@redhat.com> <20250407182104.716631-3-agruenba@redhat.com>
 <Z_eGvBHssVtGKpty@infradead.org>
In-Reply-To: <Z_eGvBHssVtGKpty@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 10 Apr 2025 19:48:14 +0200
X-Gm-Features: ATxdqUF2qSG62wdzI_CXx71qpQw7c7dGZziC1q7bbQkSEqifIFryfqrjJnWzITo
Message-ID: <CAHc6FU6NHxG-Tn+5tn2zy3QJFVruOM6tG7DsDi1sF+vDw4Xr_g@mail.gmail.com>
Subject: Re: [RFC 2/2] writeback: Fix false warning in inode_to_wb()
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Rafael Aquini <aquini@redhat.com>, 
	gfs2@lists.linux.dev, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 10:52=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
> On Mon, Apr 07, 2025 at 08:21:02PM +0200, Andreas Gruenbacher wrote:
> > -static inline struct bdi_writeback *inode_to_wb(const struct inode *in=
ode)
> > +static inline struct bdi_writeback *inode_to_wb(struct inode *inode)
> >  {
> >  #ifdef CONFIG_LOCKDEP
> >       WARN_ON_ONCE(debug_locks &&
> > +                  inode_cgwb_enabled(inode) &&
> >                    (!lockdep_is_held(&inode->i_lock) &&
> >                     !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock=
) &&
> >                     !lockdep_is_held(&inode->i_wb->list_lock)));
> > --
>
> This means that even on cgroup aware file systems we now only get
> the locking validation if cgroups are actually enabled for the file
> system instance and thus hugely reducing coverage, which is rather
> unfortunate.

Right. Is checking for (inode->i_sb->s_iflags & SB_I_CGROUPWB) instead okay=
?

Thanks,
Andreas


