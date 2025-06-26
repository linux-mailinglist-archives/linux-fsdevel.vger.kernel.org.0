Return-Path: <linux-fsdevel+bounces-53095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73711AE9FE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 16:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA6317B46FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 14:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFF22E7F1A;
	Thu, 26 Jun 2025 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB2dRBTJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4352E718A;
	Thu, 26 Jun 2025 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946883; cv=none; b=h2WTSb+bCmt4hlHgxom/xzhqD8bf+X1WfU2K7c6an8eALHmFXnxpI8ZB4SUAGDcO5xNU2cfSbhkd0kHAJ5vo/J3GYYLPYtVH1LTwBVC+qfXp0r0Io0CxF33pKQR7Q9mRz2g+mnu9lfMIFOSZesBoQZjItwiZElIVSVUXSZKb9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946883; c=relaxed/simple;
	bh=W9tHbxHnKeRQE5geeibzijql5KBQit7N4QCOc9dhrsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtA+rsiQCVoGFQSA2sh//KEpVr587oQBrGglAIUhglMhkUda67Ah6fj0R/Kz5kTrDZt8JehWSsyl1wiq57W5y/KpigR7mKuPt2Jfpo4DZ7m85hCO3fXye5zcBJYiVWzbY8wSjA/lGIPlFky4wYenRzDM3q7RiQITrvlC2N/UHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XB2dRBTJ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6facacf521eso11084106d6.3;
        Thu, 26 Jun 2025 07:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750946881; x=1751551681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AFJAJWMJoLX2aT06uj/U15KdrwYtiZtVOwqSV/4SzY=;
        b=XB2dRBTJ+ygUGFOj7los26+P0cji2fWIPiNCpQY3mh/lVJrpDOHDIXSj8Mg5X4ueLx
         fob76pCmDQn2SdB/wBOy2hsnDLoBmd9MxwsMjXW1BgdDv5KwwvCZl+MtMsbkapOJcEdz
         3e0DA/Wnwj4wy8S096vVW9PVGp/COsvCXF3YYzkGNBfod0Iij4uPrNI+YoUlZagz+udY
         D8IopIOfVSUpXnGA7iVa2Opuw6zGkcIVCpSq0IC4G1HvJIh9sQ/FZH1Z1n0A6dNc4O7+
         NLbEtVlAYmtu0E9DN0m9ATecRxpJmb+aG+vz1f7Rhm48kf2CWzPzATQwnTD04KOXk6fG
         1fBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750946881; x=1751551681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AFJAJWMJoLX2aT06uj/U15KdrwYtiZtVOwqSV/4SzY=;
        b=nzLEOwd33isGqHadQfsdUyq6xELNHjQs5hP6wry0nwco4FJ4+Z90FMGT5cFuUSmKSC
         p61+LkWNsmf0udHGvEcs8J57lg2jY1tM4EgZvOFnNWR32bHrk8NjuewDTo8t6Wxst8Ov
         AGCnyx0CjuWN1tNwNweaIwYeC9ccAPBz2bzBV/TRYVbaOEIhhFVfUrrI3kX0lyPi5kT6
         /WJ5YLb4mjrIKSkHZYjcFwKBYvVMcKRKVrl55i/K4joiZeu5IrAgvBcmiFFToYb/MBqG
         JAiQOU5eeG0ET7NUwdK9eHspvNEg0D3s786VZzpUT733q0xiUe4rvlznyIGy4svgR+hv
         hoxw==
X-Forwarded-Encrypted: i=1; AJvYcCU0GU2mpS/bxbTZ9vHMsCu5XJVSJNAaoNNY2X8tYtSnLrOkWmEJ1ga9Qoy3+hNlH7UH1BLFxDiKgm/Z7qto@vger.kernel.org, AJvYcCWL+utsJ+rCdNBCgIqiC11dmTAxGUhPLaLOP3XBVywHoOlRMENAaEpL8BHrZiMDXZkBbWAkPkLDyz8k@vger.kernel.org, AJvYcCXx+AMy9KRZJrxOLkMsIYnxKv11VzWj0k6GbsoFo1YFW/AzH70E/QYm/vLRJQsy3c1d+N/AO0EWuaa0HhwbIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh06X0QtPpswWY2wxI9dsaMPbkux9B8NyFlbD9rddyYntMGp0F
	LqxlnAOpB/ANU+AJvT/0fLBH7tE5FNoP/NwtKp9wLJ80SkLmJDS3iYZIM0QlvTRbhpl0fpcaH11
	efrCxfbZmgwwtLjqTUQfoxu5lXc+pW+w=
X-Gm-Gg: ASbGncvjB4FwYJDJPUkIGfpZ81ZA1q4sCqdvG/pqzbciu8z02MkminKKTfwR8kRbFj1
	PG+Kk5vzmNiqzaaQUDtRcei112uH2w3zFEhD+L55P8SB+WXFO8FDIFI/7jc2JYuibfnukr66Kja
	LP2jZMnBw++PVPW0r5BnYXftIJiquw/tvKVw24q8HNlVCItVVzBx7hrplCramwrBWkm+sdOlMk0
	If8sA==
X-Google-Smtp-Source: AGHT+IFuTBd/k6VUgHv/Tqnp8nePZb+/XSJ00N/ywtLL9ZMOQqvkiEoIBt16EJ8iSVWekrkdSUFODlbllPETtxHu3oE=
X-Received: by 2002:a05:6214:5bc2:b0:6f8:f1a5:e6a4 with SMTP id
 6a1803df08f44-6fd5efac2c6mr119139766d6.22.1750946881068; Thu, 26 Jun 2025
 07:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1576470.1750941177@warthog.procyon.org.uk> <dd1b01babe2b5023e9e26c56a2f2b458@manguebit.org>
In-Reply-To: <dd1b01babe2b5023e9e26c56a2f2b458@manguebit.org>
From: Steve French <smfrench@gmail.com>
Date: Thu, 26 Jun 2025 09:07:49 -0500
X-Gm-Features: Ac12FXyyhbfNlNMpQYe9aZUeZ4JpjPV4v5OkXG2uBhjAE4kIr6iaVInUeAOolnI
Message-ID: <CAH2r5mus-f5y+p16hkaYZWA=fCAiMGT1vpMawbVCZ2EC0K5Pxg@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix i_size updating
To: Paulo Alcantara <pc@manguebit.org>
Cc: David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

added to for-next pending testing

On Thu, Jun 26, 2025 at 8:39=E2=80=AFAM Paulo Alcantara <pc@manguebit.org> =
wrote:
>
> David Howells <dhowells@redhat.com> writes:
>
> > Fix the updating of i_size, particularly in regard to the completion of=
 DIO
> > writes and especially async DIO writes by using a lock.
> >
> > The bug is triggered occasionally by the generic/207 xfstest as it chuc=
ks a
> > bunch of AIO DIO writes at the filesystem and then checks that fstat()
> > returns a reasonable st_size as each completes.
> >
> > The problem is that netfs is trying to do "if new_size > inode->i_size,
> > update inode->i_size" sort of thing but without a lock around it.
> >
> > This can be seen with cifs, but shouldn't be seen with kafs because kaf=
s
> > serialises modification ops on the client whereas cifs sends the reques=
ts
> > to the server as they're generated and lets the server order them.
> >
> > Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Steve French <sfrench@samba.org>
> > cc: Paulo Alcantara <pc@manguebit.org>
> > cc: linux-cifs@vger.kernel.org
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> >  fs/netfs/buffered_write.c |    2 ++
> >  fs/netfs/direct_write.c   |    8 ++++++--
> >  2 files changed, 8 insertions(+), 2 deletions(-)
>
> Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
>


--=20
Thanks,

Steve

