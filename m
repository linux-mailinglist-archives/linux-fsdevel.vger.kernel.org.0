Return-Path: <linux-fsdevel+bounces-31643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E517999598
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 01:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8BF11F249BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 23:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8241CF5EA;
	Thu, 10 Oct 2024 23:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GR85n/ct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CC114D6F9
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 23:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728601723; cv=none; b=WWa9e/9Q41utuRQm/zz7Z2pxDBirA77sMNAETkwQiSrzSiMAhadr31MQCtRi5dh9rs8Ze3I7W1cBIjKEd9RaU1GzO2IAJdl2kB0xiHqeeIhyoXNCvYzT3MEGPULgtf2FPJXgLDyJUcj5DJZrY0IG8KJ5cywhx9VaT2yEH44e0gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728601723; c=relaxed/simple;
	bh=RmdbxciR+xksrW2eFmFkGKP+cptgXYPl/V1TwNumNT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dznDsicuATsLfgUzqUJLzehW3/XR7NUBQM6fYaK/1oT8J50ZHk0jRQaTg6capFjO7jzH7ddzYmnVILFgcvgkiv7d84uPXaZ9lhNLGDpf2WZDFADMGMf1oQ6CTUclRDbj84E/85EsvgoGYrdvnBSWGF6Et8bcFdaTsfPKzyMQvPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GR85n/ct; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460464090d5so8780941cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 16:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728601719; x=1729206519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lkuo0KRbOjUvhKzFth+kN2jDKW8qOngx+uKRHcICdIU=;
        b=GR85n/ct15Sdnq0Rxz4XlhHzUIvuDebeMPy2fix0WZWwfWpIJ50O3aXtzILw/i4Fo1
         wJo0o3PnIVJO/gBHURidCRDWgXl14yFsfHIUHymSyr+ln0He1s9aSaIkE9TbFt2twA7G
         Iz0lGdCni8QCWLiLEak7QzhLQl+UVJLI2dLvP33gupX3WETr+87tZALG7FJEnlvRJ5Xb
         sgDgJzBjx5BZ5XFiWBxoTAo5BloRjKrxwoGF2RacJoWc8XpKOe5ifXuZzz28KTSJlRah
         bXagsrcQhDNPmY7TzalcWGF5SQdStxFLOywjbXQucNKyepKZ0I/GjjsDP++SusxNivaq
         LDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728601719; x=1729206519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lkuo0KRbOjUvhKzFth+kN2jDKW8qOngx+uKRHcICdIU=;
        b=TRsV9xltiitW651n5AFPkhLmUE22l4pLSmtxSDSG6T3vGGWhu04PPyFl8ro6/gG3FD
         C5z1IALApK3x8XLGVUWaYe534H8amj4wazTcfAjHABN9+p7mDkH0vubfAi2ka/t6Fx+r
         dH7w3u6HaBNKvQK9a4tAjgY+fq6jWLdzii6INBhmVzrqfa0XrWcJQzyeClAskSuHkPkR
         laivW5YaNn7bU10j+pGr7ehjY7lj2lAS3JNbxArzFtikdCB8WP4rVPGKzIVc0eM94BXz
         FYZ+5sghpK/7FDzXSFmcPr6w5aT1mEiZDdog8uu6ih8zxwpdZUuVal6uqpH+MyPkTf8L
         k4zQ==
X-Gm-Message-State: AOJu0YzAUlf7/hoMr3wxz+CLoIFVe/bbIJ288jSxsFhQP0mtFNTDkw6i
	8GH4qu7Yl+MMzHu+QR/Ltj1MZB49FJDrC2HqkCK4J7j2V1WlKVL08vs875EOyqPxrvcK9d8B1Ae
	/mE8/CPaJvcdats2Q0X1Iu8A5n/A=
X-Google-Smtp-Source: AGHT+IE1FHu/X5jtPHPQ3UZRrdWK5tab5V5v1rkXEDRPy6nNES8oFC/xwrv2x757ope1xsrlVmPXV1AWEp1sEDtr+D4=
X-Received: by 2002:a05:622a:13ce:b0:455:b3d2:fce0 with SMTP id
 d75a77b69052e-4604bbf35famr12410341cf.32.1728601719589; Thu, 10 Oct 2024
 16:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007184258.2837492-1-joannelkoong@gmail.com>
 <20241007184258.2837492-3-joannelkoong@gmail.com> <CAJfpegs9A7iBbZpPMF-WuR48Ho_=z_ZWfjrLQG2ob0k6NbcaUg@mail.gmail.com>
 <CAJnrk1b7bfAWWq_pFP=4XH3ddc_9GtAM2mE7EgWnx2Od+UUUjQ@mail.gmail.com> <CAJfpeguB9zgc5zFtsf6t4WYuLntQ5w8y9P3qP3oNFjohA7VCMA@mail.gmail.com>
In-Reply-To: <CAJfpeguB9zgc5zFtsf6t4WYuLntQ5w8y9P3qP3oNFjohA7VCMA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 10 Oct 2024 16:08:28 -0700
Message-ID: <CAJnrk1ZbkgfmQSGFLFVAn6d_KQr7EgGNf7R=7JYwBNhmuw6+pg@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] fuse: add optional kernel-enforced timeout for requests
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:21=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 10 Oct 2024 at 02:45, Joanne Koong <joannelkoong@gmail.com> wrote=
:
> > I think it's fine for these edge cases to slip through since most of
> > them will be caught eventually by the subsequent timeout handler runs,
> > but I was more worried about the increased lock contention while
> > iterating through all hashes of the fpq->processing list. But I think
> > for that we could just increase the timeout frequency to run less
> > frequently (eg once every 5 minutes instead of once every minute)
>
> Yeah, edge cases shouldn't matter.  I think even 1/s frequency
> wouldn't be too bad, this is just a quick scan of a (hopefully) not
> too long list.
>
> BTW, the cumulative lock contention would be exactly the same with the
> separate timeout list, I wouldn't worry too much about it.
>
> > Alternatively, I also still like the idea of something looser with
> > just periodically (according to whatever specified timeout) checking
> > if any requests are being serviced at all when fc->num-waiting is
> > non-zero. However, this would only protect against fully deadlocked
> > servers and miss malicious ones or half-deadlocked ones (eg
> > multithreaded fuse servers where only some threads are deadlocked).
>
> I don't have a preference.  Whichever is simpler to implement.
>

Sounds great, thanks for the feedback. I'll submit v8 with these new
changes of reusing the existing lists.


Thanks,
Joanne

> Thanks,
> Miklos

