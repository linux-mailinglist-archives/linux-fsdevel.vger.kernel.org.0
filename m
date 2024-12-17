Return-Path: <linux-fsdevel+bounces-37649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0753F9F5154
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 17:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEAEF1882473
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 16:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7224E1F758D;
	Tue, 17 Dec 2024 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bF78MDLf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD55142E77
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453874; cv=none; b=Ag4f/88ct/SwX7ITNM328/PjeZPjZY8eYeFhHBjJIE55M0BAzYpgSZaeOa3BotH2o12litGAQOiRhBVGZcpdraQVWmVNEA01oNHVGF57ZwdtYByXiFKh69M/B18P0s9ivKH5eDTtA4NXsk8IUBz35CjzMl4MAO7JF0h0DSmR+5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453874; c=relaxed/simple;
	bh=IddbzDZ5HWjh54mxeeaNAxq+2x7hRqa/vsPy99xpzJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsRe9fSnfRH9+ndiZU/vevjWJ6c+8IpbvKqZRIyzQDk8HJPpsRToKzwF3hg5GDfSZUt04KNLbOJHq3xUmkS45dTUHa6A7P2O+UMBhcV/R4Ip4RydeRTGIk4TM9hkZxy07qFNZdrE06BbYlm7/cf/ZsL/WChwFDXr571GfHUSNWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bF78MDLf; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e46c6547266so2843162276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 08:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734453872; x=1735058672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2RqZ1iTuiwe0w1Bq33bMFV9IQegQcbvuONqKrlBbjo=;
        b=bF78MDLfSbxA5wMJtBKdDDLy90Z0PpC5W4LX9Y6mgvw/mEE5mqCMPNhO1lULrT1IAi
         v8AkdgOtPFko9HOoG8rXNdYiONd+5SR7WqI57KROLC088cazPOV3IvYl4vPB2q0dYZpA
         Y35WWrmxIR+7yrumUnmJYNjase+32G9AEa4zsLlGdDETmGDEAX2SPfdMPTC4VaofrqNL
         hZeiWVFtEi4x/r5xlhmqiWVMlOSPI5pu8W4xqLx+mDC6iX8nSM8hn7p2Xuq4rR3TRV4B
         /dlMyFl8I6pfeEeJiDbAzcaRKfSjfSKx0QH4/+J7HkztgCwe9CnJQo3omlSWM5VGq4FT
         xCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734453872; x=1735058672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2RqZ1iTuiwe0w1Bq33bMFV9IQegQcbvuONqKrlBbjo=;
        b=t0XoYWmpj5zsFXyMc2OsIZCjUvyFaweobBRUHXTq8vfswq8zmgCHR64RLLLrBs/poK
         wwSYGAY8bChNXzdBv62rDFWvjsFNsmlMF5fh9vnbvemZKq+vqmeOjISqkV/+bo4CLuGp
         DyEA0j9xcJ/ZReBtC4MFliltIVM05BhY7hebexXZj61NQfyaCCVAf+3kI6VIma+9Nl0/
         zzqq4mSLKeJe6PybHqMDxGcbrffdZEnLNWTse7H8RTAPvMQTvIobNmkyy0GDNgOZvJ+F
         AOiR9EZVSKCMpTwsV1FOLsO8HW6U4V43gY0zS1e3ZC4ErOpgq7VILsF+/t6ZsInnVGc+
         gdOA==
X-Gm-Message-State: AOJu0YwoWmTF8zUZXm7CmaJQN4ZvEq2HCzmheRCtYP89CCULhGX0c6fc
	0oJExBR5g+v/2DAOxXJK5rzKonw2S5J4euFQEWVHfqN982MLN4aXULx3hYwDaYcKgJZcT3gSU2p
	MKOvJeRvkpuj+Sx8RnTRazKj5Euqqslju29X9
X-Gm-Gg: ASbGncsurU7mwEE+lmHwpKAnEDkscJrJQmvMmX1Sg3J9OnxeSa2BKZDcEN046l0bh4T
	OAmtyKp81LZi64b13q586EMi6OQAmFkmfVfMP
X-Google-Smtp-Source: AGHT+IHzqcrxGq0lg+OZOnITp7xku/OCQjSoNpcPMUQryKBaUP5W83erdFqKWvmsUKKSg0Lo+y4IN41xlRpasiS2KwE=
X-Received: by 2002:a05:6902:160b:b0:e38:7d0d:d7df with SMTP id
 3f1490d57ef6-e5300052ff3mr4121093276.50.1734453872299; Tue, 17 Dec 2024
 08:44:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216234308.1326841-1-song@kernel.org> <CAHC9VhSu4gJYWgHqvt7a_C_rr3yaubDdvxtHdw0=3wPdP+QbbA@mail.gmail.com>
 <CAPhsuW4e8xcmZj_qrONSsC8SDrtNaqjeFgPRo=NE9MDiApQkvw@mail.gmail.com>
In-Reply-To: <CAPhsuW4e8xcmZj_qrONSsC8SDrtNaqjeFgPRo=NE9MDiApQkvw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Dec 2024 11:44:21 -0500
Message-ID: <CAHC9VhQgS1n5RJxFmVxohng9UL_Wi6x_0MOaPAeiFTFsUxZd0A@mail.gmail.com>
Subject: Re: [RFC] lsm: fs: Use i_callback to free i_security in RCU callback
To: Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	willy@infradead.org, corbet@lwn.net, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, brauner@kernel.org, jack@suse.cz, cem@kernel.org, 
	djwong@kernel.org, jmorris@namei.org, serge@hallyn.com, fdmanana@suse.com, 
	johannes.thumshirn@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 8:24=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Mon, Dec 16, 2024 at 4:22=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Mon, Dec 16, 2024 at 6:43=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > >
> > > inode->i_security needes to be freed from RCU callback. A rcu_head wa=
s
> > > added to i_security to call the RCU callback. However, since struct i=
node
> > > already has i_rcu, the extra rcu_head is wasteful. Specifically, when=
 any
> > > LSM uses i_security, a rcu_head (two pointers) is allocated for each
> > > inode.
> > >
> > > Add security_inode_free_rcu() to i_callback to free i_security so tha=
t
> > > a rcu_head is saved for each inode. Special care are needed for file
> > > systems that provide a destroy_inode() callback, but not a free_inode=
()
> > > callback. Specifically, the following logic are added to handle such
> > > cases:
> > >
> > >  - XFS recycles inode after destroy_inode. The inodes are freed from
> > >    recycle logic. Let xfs_inode_free_callback() and xfs_inode_alloc()
> > >    call security_inode_free_rcu() before freeing the inode.
> > >  - Let pipe free inode from a RCU callback.
> > >  - Let btrfs-test free inode from a RCU callback.
> >
> > If I recall correctly, historically the vfs devs have pushed back on
> > filesystem specific changes such as this, requiring LSM hooks to
> > operate at the VFS layer unless there was absolutely no other choice.
> >
> > From a LSM perspective I'm also a little concerned that this approach
> > is too reliant on individual filesystems doing the right thing with
> > respect to LSM hooks which I worry will result in some ugly bugs in
> > the future.
>
> Totally agree with the concerns. However, given the savings is quite
> significant (saving two pointers per inode), I think the it may justify
> the extra effort to maintain the logic. Note that, some LSMs are
> enabled in most systems and cannot be easily disabled, so I am
> assuming most systems will see the savings.

I suggest trying to find a solution that is not as fragile in the face
of cross subsystem changes and ideally also limits the number of times
the LSM calls must be made in individual filesystems.

--=20
paul-moore.com

