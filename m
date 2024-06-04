Return-Path: <linux-fsdevel+bounces-20954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D44B18FB446
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 15:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DF91C2240F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 13:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B00944E;
	Tue,  4 Jun 2024 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGyYivXi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC60E8F45
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508975; cv=none; b=Xi4VDL/T4NDJKje4braGYH82V44D2HxJW1jSbQaPpJXKMjes+oi7AZXTwx3Gjjm1wPzm2M1g/CdGLMFTciCm5H/lvBMAENyAIf/M/wVi+D28sI/WhFFZQHfSLSGhAppLI7CXFppd9R961nzpKQAfwygTFBnPvNEt/St/wsZstcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508975; c=relaxed/simple;
	bh=F1cDhncZGMxK8M68Vq47VOsnYVAv1CoQbsNBeQqZgWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/ThcA7e0WoQq5i2G28vhCwSJq95sKRLCprgJbml2p4OCkE8Py/OYvtGNWs5tGN1ssOXXRuSs9C0zbXBoENslWM0AZN+w2DBPsiCso6gSmyRUQdGeZr4ZlrFddUj0n/fJGfOa3tLcd2fVXikr7YiraVMC8x7pL1jgXEhLxACKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGyYivXi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a7dc13aabso1331410a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 06:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717508972; x=1718113772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNHBWQtqAxs80AR+fnChywhPY8AcDfAVuR3K/W+iGmY=;
        b=VGyYivXiaWx9tBOCCu+MzgYsqR/Ic0mYB1FR8dr0rDTlywPvM4Ya9ErTtswyeJ0fF7
         rzTXKQ0qswg6JtTuksL/ozGtqcI4cwh6omDnRcn5zhfXutZRtw9Fuh+j9uIODyF8vPPP
         ijsVyiv7HCKYlGqxCL4vcoA5eFvlxBaYnVkWUW4hfcXPG3jhGRymbezVf8L5Yexr6Y1O
         XLHpuEoGHsOxwMyAtKCALwcfAAuFcR/fdapNQcmjJNOdZzPBFFogOuE+cmD9lVVzUix7
         ORHDG8ahBFfEjxFB5T7EfyML3yttWyHBvw5NEINQP/XeormFb5y3GPef7uev2t1WGWC3
         J5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717508972; x=1718113772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNHBWQtqAxs80AR+fnChywhPY8AcDfAVuR3K/W+iGmY=;
        b=hIwjCGxM5C4zmISWkk671Sl/ZpM86rrcJY8V4qZ+4C/HiFgpfsS5aq/MT7H1jTmTto
         hj1eVzsioNQK0pJV+I5PRL1AOH8IhlOXufA7F+aomgT/UeY22sF8AziYIAEI09GaSIZi
         bzzKJ9PyvWe/pha0n6lvkFhG4RvngaVT9Ef28459FZwys7aYNTX9qi35i1i+6SQBK2+1
         U2zr35n58VQXGDn9foijYPOxXKOawPmG9XN+oxfBX8rTlCY0+s61/O9Eyen4kQMffSXT
         3zN4NrlNmCyMp6pkMi4mp1cAwM28HvB7AaKP+SoCiW24MzW2e6Y9BwfAXFCuCG1/+I0z
         IdRg==
X-Forwarded-Encrypted: i=1; AJvYcCV6FQiCknso297ikmVtIunnnVd0HKRu2eMC0xM77oaT2SAes/dax/2Cl0Xo6snim9mguVXMhimxEYo4ny+4UbL/9xzaAsXt6qhljFmMHA==
X-Gm-Message-State: AOJu0YykRjbvWRjlUNqvTM8R0vYDVXfjrZNzvVugYqKBlxO7b8x4qW/r
	8uPIjV0gqZN4ulEt+21rodbvyZ/0DKd4nnihJLnjvGCw5uHsi7o/Z7xcgt4zTnNgPYVAccPznMM
	HLd0Z0Z3RE2YmectG4SC5LC9RxX9hdILiy4s/tw==
X-Google-Smtp-Source: AGHT+IEPA4w/c8joqUfxG7lhAQwDWNOXreL17KYOoj01a6LXlVEnAZsNLeDcT5MlmotgHXXthoATakwbbFRaKXEt9n0=
X-Received: by 2002:a50:cd83:0:b0:57a:79c2:e9d0 with SMTP id
 4fb4d7f45d1cf-57a79c2eb22mr2065760a12.3.1717508971959; Tue, 04 Jun 2024
 06:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHB1NaicRULmaq8ks4JCtc3ay3AQ9mG77jc5t_bNdn3wMwMrMg@mail.gmail.com>
 <CAJfpegsELV80nfYUP0CvbE=c45re184T4_WtUEhhfRGVmpmpcQ@mail.gmail.com>
 <CAHB1NaiddGRxh7UjaXejWsYnJY52dYDvaB2oZpqQXqVocxTm+w@mail.gmail.com> <20240604092757.k5kkc67j3ssnc6um@quack3>
In-Reply-To: <20240604092757.k5kkc67j3ssnc6um@quack3>
From: JunChao Sun <sunjunchao2870@gmail.com>
Date: Tue, 4 Jun 2024 21:49:20 +0800
Message-ID: <CAHB1NahP14FAMj04D-T-bWs7JAn_mXfmXSeKUEkRbALZrLeqAA@mail.gmail.com>
Subject: Re: Is is reasonable to support quota in fuse?
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan Kara <jack@suse.cz> =E4=BA=8E2024=E5=B9=B46=E6=9C=884=E6=97=A5=E5=91=A8=
=E4=BA=8C 17:27=E5=86=99=E9=81=93=EF=BC=9A

>
> On Tue 04-06-24 14:54:01, JunChao Sun wrote:
> > Miklos Szeredi <miklos@szeredi.hu> =E4=BA=8E2024=E5=B9=B46=E6=9C=884=E6=
=97=A5=E5=91=A8=E4=BA=8C 14:40=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Mon, 3 Jun 2024 at 13:37, JunChao Sun <sunjunchao2870@gmail.com> w=
rote:
> > >
> > > > Given these challenges, I would like to inquire about the community=
's
> > > > perspective on implementing quota functionality at the FUSE kernel
> > > > part. Is it feasible to implement quota functionality in the FUSE
> > > > kernel module, allowing users to set quotas for FUSE just as they
> > > > would for ext4 (e.g., using commands like quotaon /mnt/fusefs or
> > > > quotaset /mnt/fusefs)?  Would the community consider accepting patc=
hes
> > > > for this feature?
> > >
> > >
> > > > I would say yes, but I have no experience with quota in any way, so
> > > > cannot help with the details.
> >
> > Thanks for your reply. I'd like try to implement this feature.
>
> Nice idea! But before you go and spend a lot of time trying to implement
> something, I suggest that you write down a design how you imagine all thi=
s
> to work and we can talk about it. Questions like: Do you have particular
> usecases in mind? Where do you plan to perform the accounting /
> enforcement? Where do you want to store quota information? How do you wan=
t
> to recover from unclean shutdowns? Etc...
>
>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

Thanks a lot for your suggestions.

I am reviewing the quota code of ext4 and the fuse code to determine
if the implementation method used in ext4 can be ported to fuse. Based
on my current understanding, the key issue is that ext4 reserves
several inodes for quotas and can manage the disk itself, allowing it
to directly flush quota data to the disk blocks corresponding to the
quota inodes within the kernel. However, fuse does not seem to manage
the disk itself; it sends all read and write requests to user space
for completion. Therefore, it may not be possible to directly flush
the data in the quota inode to the disk in fuse.

I am considering whether it would be feasible to implement the quota
inode in user space in a similar manner. For example, users could
reserve a few regular files that are invisible to actual file system
users to store the contents of quota. When updating the quota, the
user would be notified to flush the quota data to the disk. The
benefit of this approach is that it can directly reuse the quota
metadata format from the kernel, users do not need to redesign
metadata. However, performance might be an issue with this approach.

And if fuse could reserve some disk blocks to save contents of quota
inode, that would be better, but as far as my current understanding
goes, it seems that this is not possible. I haven't finalized the
design yet and still need to look at the code and related documents.

Best regards
--
Junchao Sun <sunjunchao2870@gmail.com>

