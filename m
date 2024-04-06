Return-Path: <linux-fsdevel+bounces-16258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B815D89A91F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 07:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512AA1F21423
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 05:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABA3200B7;
	Sat,  6 Apr 2024 05:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+DbQkh3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B511419479;
	Sat,  6 Apr 2024 05:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712381118; cv=none; b=o4PR8wj3fO7mbsrvVL9yOrKifIhVRVZt4U4QOk8OyY4lRNQ/PviN/RSWq13UgSKMT9ZSBtfzVHJArcftzFVy8ShmRwy7cyAuHyMicVCk/ysN4pUqObnSGZVTvoJvDbevSSQX/H2+FgsxODHSZkGPXqQemCo/LZ9xEM6LzLTGkew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712381118; c=relaxed/simple;
	bh=hzp9HyvmOrTYDuK28GX1kEwaWQcEGAXzI+4hiBrNFOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3s4ELD6e+6UE8Cwc6yYYf8HvxtjHbkkYCkaDyuS3VrR9rJnEH4VO/0VwAQIKkih2AOIchEVLhun+wDKqwVRqoYDIsi+a8k+MZSLxjPNeOaQO491E2hr2aFJsHWYpxlFcA7zWnhRQT9Zhq8S63B3oXy3QGxBAnfcgpfzzcKVxt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+DbQkh3; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6994bcf7e80so3632886d6.0;
        Fri, 05 Apr 2024 22:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712381115; x=1712985915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhLN9cN2qzUox6TTfuotLrtT0I8++ymvJQ3nzVbMdnM=;
        b=A+DbQkh3IxdiZfEyml0zSCichn4aRAHsp0NtJHiLuaJMoboKuf4hCwtU4GReTX3H4I
         0QeRV/bOtCV61tBUA0w+SToSvjVDXhLLQRcEBQkd05sO7q/S0d3XsJ1Kd8rx+9bQySzO
         g7rEtJAPctevLovsbf2UtE1TkCAynuy0hCSxkbkRMhP3tnRbkuLyo5TWJQLcxNnFnD+E
         1ytfrEXw/YBqpu5lAWYw9mEYFT/thVUrSHLfib1fpdtDvYTbJ9DbN6ZSMmkOjxet6QjG
         IG36LOes86iRBrdYXv6H8w/VV4tGAOganXBkasD5N5yv+4JHlB3bkiX77AiaAG2k0WKc
         qQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712381115; x=1712985915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhLN9cN2qzUox6TTfuotLrtT0I8++ymvJQ3nzVbMdnM=;
        b=GLFRT8LkLDlgb2QlS23wXBw+qrd7qDTovxvG6r7dS9xSwjvb8aAkUxvR2jEw4iKca6
         UYY3+WSFKN8C3vSOKOsDUIBRXvi2WxuVN+BZRvrf/seS47nLK/FiMn9kkgDj5HU8YuNp
         MLVt5N2C4ET947xFY/exL5PgcgbECTUXnRM2GEIilqa53uT9fTGQAUm3/E4hF9VugGqg
         eIwiQl4AooVWLm43h3iVwheH1hUHLdu99akH5XbZgusgInHbxg7t/owGoxi6qPszYIHa
         JjhimYsrbKjZNEWgQ/u1Sqe6k5I4Bcm3NdaWhUdkZ/dx+VGaRPSBvMRKuPSkhqxOR2+T
         K1Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUVPHfGq9cobp3PLkcYDYDlFLUny4xRr4YfA5pY1dDzbGjO+mrH51L+ypnKpSwN8n3rDEibS4VGwv8j+9l8dtUazbeIMPHEOPOxZcV+mdICg5BWBOvqLX+U/sGnowUu6nrq/LcTTXUsfbReOg==
X-Gm-Message-State: AOJu0YxiZ7Qbkd11siyCrE02dsVwZhcz6hPJ2uRiICKRGkc1lsyqWqd/
	CwkxLKG9iHT39TZioGygvvPvuh/2IlG14ERPU6OcY0HrtVrr78Yd3OBpgr3N6clElZHJlcfbzCH
	/ZZrwnR2CexZ00CEJrIlNHHAtZu8=
X-Google-Smtp-Source: AGHT+IH1+ArLrVcGFURcXfjQBrXzpPFw6/exLPQmegpwxSjV6Ia72nupr6Uwd72ymyhJWddkm+TzzzNT+uWR2j12gGc=
X-Received: by 2002:a05:6214:5007:b0:699:29e0:10b4 with SMTP id
 jo7-20020a056214500700b0069929e010b4mr6541922qvb.13.1712381115642; Fri, 05
 Apr 2024 22:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000098f75506153551a1@google.com> <0000000000002f2066061539e54b@google.com>
 <CAOQ4uxiS5X19OT2MTo_LnLAx2VL9oA1zBSpbuiWMNy_AyGLDrg@mail.gmail.com>
 <20240404081122.GQ538574@ZenIV> <20240404082110.GR538574@ZenIV>
 <CAOQ4uximHfK78KFabJA3Hf4R0En6-GfJ3eF96Lzmc94PGuGayA@mail.gmail.com> <20240406040923.GX538574@ZenIV>
In-Reply-To: <20240406040923.GX538574@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 6 Apr 2024 08:25:03 +0300
Message-ID: <CAOQ4uxikd7HY3gfvLLJp4VRMEhV0NPOExN+UYQ8dDG=p=f-MRQ@mail.gmail.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
To: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>
Cc: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>, 
	gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	valesini@yandex-team.ru, Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 7:09=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Thu, Apr 04, 2024 at 12:33:40PM +0300, Amir Goldstein wrote:
>
> > We do not (anymore) lock ovl inode in ovl_llseek(), see:
> > b1f9d3858f72 ovl: use ovl_inode_lock in ovl_llseek()
> > but ovl inode is held in operations (e.g. ovl_rename)
> > which trigger copy up and call vfs_llseek() on the lower file.
>
> OK, but why do we bother with ovl_inode_lock() there?
> Note that serialization on struct file level is provided
> on syscall level - see call of fdget_pos() in there.
> IOW, which object are you protecting?  If it's struct file
> passed your way, you should already have the serialization.
> If it's underlying file on disk, that's up to vfs_llseek().

You're right.

> Exclusion with copyup by a different operation?

Nah, don't see how this is relevant to file->f_pos.

>
> I'm not saying it's wrong - it's just that the thing is
> tricky enough, so some clarification might be a good idea.

I think I just used inode_lock() in
9e46b840c705 ("ovl: support stacked SEEK_HOLE/SEEK_DATA")
as a common coding pattern in overlayfs when protecting the
"master" copy of overlay inode attributes, but it was not needed
for file->f_pos.

Miklos, please ack that I am not missing anything and that
ovl_inode_lock() is indeed redundant in ovl_llseek().

Anyway, this lock is not part of the lockdep issue that started this thread=
.

Thanks,
Amir.

