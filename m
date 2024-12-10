Return-Path: <linux-fsdevel+bounces-36951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCE49EB45D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 16:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EE928373B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 15:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981DD1AF0A2;
	Tue, 10 Dec 2024 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="L4JUgIN1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92F823DE87
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843460; cv=none; b=QyshV/7J7UojIJTJ0ee26j/V02TOhKcw893KsWKVdiuaRb3Qk654GexhKR6D/RWbbObMVA2rMTQz40a6nmxwnsppfM8Ncz6KNy4asczA0LKK+2MK/OZsRZz5kvLML5k50Z5jmn2QEKyas86v6Fhmo17TVQ7wd/mN635EKiVsOu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843460; c=relaxed/simple;
	bh=adZbk0rGRQ8DFNeSap/WRGULmCFCAP9r52FnqvtPElI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jokan2KR40jxZNNO9zIl/ZwonfSisZWkAE9gnxfw0TrxQd4Md0QeYQzF+LvMyDCJkMFeDuIUrutcgvO2ZA+2PNxeMK2hkjjmQ8ZhcubvwYNPiVcVdNOWX/QgTETn/2AI4+gXCH88FDOUuPOXqm2RThNZQlfm+06N8Sk79GejsJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=L4JUgIN1; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46753228bfbso21830511cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 07:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1733843456; x=1734448256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6nrxfbvsRI9VAOZkaqouKzIYl2kdm+8t5h5yr9SXLU=;
        b=L4JUgIN1Vw2yKYCN86X5MZaQ1FEsHtc+9ZpxtbBupXIANJufXwsFnXJjNj2vjCLvH8
         IQXb+DNO94WSFdyPCbaBI0VCSIUxMpS9aGSwp0IxGdQdzE7DDpjcvYK7zy03X6old4CW
         /Xao2in1sKWf/vYJ9TzLytk1laue0sSWMGZMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733843456; x=1734448256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6nrxfbvsRI9VAOZkaqouKzIYl2kdm+8t5h5yr9SXLU=;
        b=d3O0M8cL1de6dkyk0I6kWBcgrx3oTG2IAo+mg2WMLLT60rbvmmwg99MKMgvicbdghE
         XPIPR62PmqqZQm08l0LFXzwnE23I/scx+XXg21+7XNg6RyautjscANGLf56eXo3EGyii
         qiG9IIaoYi5KcWxZ/Cg5jAFXrJii4xECy0QrOGJegyty6vohZHItP0ygRKcAtUCqjtHq
         pz+SqpBz/HlaxcvyCplhysjJbROHQ0ZU3vqtqWZse2WNKw04VXwut8lsAb+ybUzFWV4Z
         niYcWdJg8QhXpfzFgxsDU0DXyvRKssmVdMStP6/Sb8gnzNJ94eLDd4O3OI6XJNrcBX1e
         irpw==
X-Forwarded-Encrypted: i=1; AJvYcCWtbOuqzbVtYfJIN/x9DLPd15lYFJCc0XjGUuF9PyMyY7+qovO4Iwr2ONLWDmBieEbHnM03fCkyKkP6/GBq@vger.kernel.org
X-Gm-Message-State: AOJu0YyLxgdn+Du0TH9dzQ1bCPBVufn/37nA3g6/AdBIKkO00VS+2cT2
	A2khl7l0D3ATGEyePiItYjRpNL+9FBFuihXSYNLJfNLlnf8sy8neaqHrZbFJlTaOC2Bob6UhuVZ
	AFKxiWZmffWDLV0aqwwbda5V11zpioTKsFJuZ3w==
X-Gm-Gg: ASbGncudhsqju5tVSaykKM19B7Vn23oC2qNFpinJklYj8XC8Av86iVj4ArsjpeTUWQ/
	GB0MOAvsdPoBWhMCeoC2JOmrhv4dnbsNLTaI=
X-Google-Smtp-Source: AGHT+IHgi/94bVI1jzQeI1+OtLUlt5D0alijcZOBu9T0SxGXIHQVc1nvFeiBvLr/4xepOrIoXVHGDXbSKSYq09NxvVY=
X-Received: by 2002:ac8:7c43:0:b0:467:4b94:cfaf with SMTP id
 d75a77b69052e-46772097dd5mr73374871cf.51.1733843456354; Tue, 10 Dec 2024
 07:10:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206151154.60538-1-mszeredi@redhat.com> <20241206-aneinander-riefen-a9cc5e26d6ac@brauner>
 <20241207-weihnachten-hackordnung-258e3b795512@brauner>
In-Reply-To: <20241207-weihnachten-hackordnung-258e3b795512@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 10 Dec 2024 16:10:45 +0100
Message-ID: <CAJfpegsFV6CNC0OKeiOYnTZ+MjE2Xiyd0yJaMwvUBHfmfvWz4w@mail.gmail.com>
Subject: Re: [PATCH v2] fanotify: notify on mount attach and detach
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Dec 2024 at 22:17, Christian Brauner <brauner@kernel.org> wrote:

> I took another look at f{a,s}notify. There's no copy_to_user() happening
> when adding events via fsnotify(). It happens when the caller retrieves
> events via read() from the relevant notify file descriptor. We should
> still move calls to notify_mounts() out of the namespace semaphore
> whenever we can though.

Doesn't work.  After unlocking namespace_sem deref of mnt->prev_ns
might lead to UAF.

Anyway, I don't think this is an issue, especially with the downgrade
to read that you added.

Thanks,
Miklos

