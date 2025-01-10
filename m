Return-Path: <linux-fsdevel+bounces-38843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC56CA08C20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54BDF18871CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 09:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD78B20ADC3;
	Fri, 10 Jan 2025 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhkW9Dyg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66422209F25
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501527; cv=none; b=bUid5EGo7UrX2pLVgGtUGdM6rG5rjCwAAfkz276zk2ysyQzk1gJyPcnryZ2f9CCaTrxYPu4Hfa/0G+GefAj3G+kjlYLseGman1GDEy0gAfxnwOIdvSzA5jpUBrv7ACB+gstiPpFOYznufqahWWhgkqUIEKhv1vZe+QhChe7AUHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501527; c=relaxed/simple;
	bh=s7lXcWSuC53cbPlSpv4SsrIkxu9qpkm5LNwjrK5FKJw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bhXKc+bsQF+FtTQ3TpEnFWFY+gvzdbviYGiCS1FBAmXivK7Tk3B+xXCqSTwRkxATCBQLhsjssI6RKuAshjSz1HOYk0ju5WL1Ke/LzPBVOgTWbLvaW1tXn4uPvOh61pS/F+Qs/Za47DowJUWmhDVBnCN2wFg6Vd0V9f2NaRv42aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhkW9Dyg; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5401e6efffcso1972367e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 01:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736501523; x=1737106323; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AaVs7X5Lipr7QFdHudRACJcYYuqjWU6ZjJtgUE9iHyU=;
        b=QhkW9Dyg6Vy8KDdJckGEnNKg/QEwDBBYuiMsPOJnGDJ14qHhDXfz6pM5pyR2YWSKyi
         rbNsbgcs4+E+tkJFutK4B1CZC+14tbi0Jvvci21gxZlLfoqqkdypZSncXIPIv1gW88Vo
         HyRXslqE34CMtcIkGdfDHArV8stdmunFh0QeVGxWX0WKtcv67Rs2HdvGyE6ZfWM/mTML
         yHIeVpaq4mZn5Da8w6/hHP09Xen74pd/tg8bXmUf4fFVURDBHvjD4n0jpsaRc3rXx/P9
         gj//+8lG7tg1B44n3u0Gc652gg7wsZsgt16uQqNodnS9vTdZg0wMSDJo+GQqeWT8v0Z2
         X7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736501523; x=1737106323;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AaVs7X5Lipr7QFdHudRACJcYYuqjWU6ZjJtgUE9iHyU=;
        b=IggdclQGGTEnHGKshJDElOlsCmA4E7Lr7JDI3T2o0pJpjo9bWq6ZIFtJJJ1pZkd8Lr
         JK0DZ4j27v7GKa7RvFSqzN7IisIjZGEOjVXPgK1Z1+FXPhaREXXRltWmYn0RYdjgQ+LP
         ORzhngDQfxVy4FLKXrPBED1B9lXvGOXlDfyd5I2FkG80zKq4BkC0+t81fE4eYKJNj/UP
         nO2u8dWFwfF8S62yAxJABijKAsx0JYIhqek3fTdqdAB8f5i3yqTaIZhIubLCQn1krHtE
         1WuDQsxnWYv7Stqf6FwcbfzVwtWBN4y61exzpgyPer6SytVxRzozAxCLVNP0s7rFIlVB
         vfYA==
X-Gm-Message-State: AOJu0YzdRh6A5LNXsIziiVeCVqvzFWXv5/FM3SnNEF7KxQXhJaXBeoQp
	voNNthHvBXgBhTPwTr9L3ILvmuQT4miNd/TlQsLRxIrST5nD2aPVpNmIquru2qoAGrp3I1Ag8y6
	0vfTxpWSInoMTg6wtApPq9zYFIz3RUuIyVtzmnw==
X-Gm-Gg: ASbGncuT3IXn9THaZ/GFR5MsYlipJ4brsOmshf4ibFk2YvkraWwOWajnKpw5wDJCzSu
	D1JnfVHSvG+X4NKfNZODiOLRMwRXky0ioLsbjv5U=
X-Google-Smtp-Source: AGHT+IFSdG382byzHXQHND3MNFZf5aebpLw2fhq2ZpK4rD7VcqDHjAydfEtE6Fd90HRtMsitvYPjJFudeQLWfb9W4bI=
X-Received: by 2002:a05:6512:b05:b0:540:2549:b6da with SMTP id
 2adb3069b0e04-542845d65b5mr3407318e87.23.1736501523003; Fri, 10 Jan 2025
 01:32:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Fri, 10 Jan 2025 17:31:50 +0800
X-Gm-Features: AbW1kvYqXfm5Foy3rgh3mzofaXWgxZ5W7Lqi_rTANp2dCMyO6nAC5qJUSrslnkg
Message-ID: <CAHB1NahYr5vyu74oPTp_+W2X8mOzP9GYZ8QkMtgk4xTKLwzzHA@mail.gmail.com>
Subject: Inquiry regarding FUSE filesystem behavior with mount bind in docker
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Respected Maintainers,

I hope this email finds you well.

Recently, one of our customers encountered the following issue:
A directory from a FUSE filesystem(a local union fs) on the host
machine was shared inside a Docker container using mount bind. After
updating the FUSE filesystem (by killing the existing FUSE process,
replacing the binary, and starting a new FUSE process), any operation
on the shared directory inside the Docker container failed with the
error 'Transport endpoint is not connected'. The only solution in this
case was to restart the container.

Upon further reproduction and debugging, I found that the issue arises
due to the check in fuse_get_req() where the condition if
(!fc->connected) causes an ENOTCONN error code to be returned. I
understand this behavior, and it is reasonable in principle. However,
I still want to ask: is there a way to avoid this error?

I believe there are two aspects to this issue:

1. Handling the mount bind of a directory when the FUSE process is
killed and restarted.
2. The behavior related to the mount namespace within Docker.

Currently, I=E2=80=99ve implemented a rather hacky solution to address this
issue by re-associating the old mount bind points with the new dentry
of the updated FUSE filesystem. Specifically, the steps I followed
are:

1. During the initial mount bind, I record the path of the shared
directory in struct mountpoint.
2. After mounting the new FUSE filesystem, I traverse all struct mount
instances which were linked to staled super_block on  the host using
an ioctl command. I then locate the new dentry for the shared
directory using the recorded mnt_mp->path, and update the
corresponding mnt.mnt_sb and mnt.mnt_root accordingly.
3. During unmount, ensure that the old mnt_sb and mnt_root are also
released properly.

I am aware that this approach is very hacky and likely prone to bugs.
However, it appears to work for now, and I've been testing the above
case for 2 days, no issues have been reported yet.

My questions are as follows:

Is this issue something that is worth addressing upstream? If so, I
would be happy to work on it and submit patches to the mainline
kernel.
If not, are there alternative ways to avoid this problem in a more
stable and reliable manner?
IMO, solving this issue further demonstrates the flexibility and high
availability of user-space file systems.

Any feedback or guidance would be highly appreciated. I look forward
to hearing your thoughts.

Thank you for your time and support.


Best regards,
--=20
Julian Sun <sunjunchao2870@gmail.com>

