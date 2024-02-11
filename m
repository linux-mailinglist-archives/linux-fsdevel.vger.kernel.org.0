Return-Path: <linux-fsdevel+bounces-11062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFE1850854
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 10:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BFCEB21807
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 09:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262A45917C;
	Sun, 11 Feb 2024 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4A4yBvs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB355915F
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Feb 2024 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707644148; cv=none; b=D99oDlKzjBmTwnxo31uDUe/S+xRY3Ic1ogxH3eAtYA4cjMMojhShW4u3we+kMoLw6iJlTXmLfwzY562Fs8uo0qzd6OPL9RFD3ukS//9Jd0N2xxt7arM6T9oKdjDHup96iC6fvbVWt2zmw21G5PhICTWjTq2VHvX7mRJ88SraWHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707644148; c=relaxed/simple;
	bh=TH4wZS24qpSRB2owdnOAq4iTMgyZlVFrxUPzmwbgadQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3qrQ3GpQYZC9TFKRh2k/8rSbnx8uv5TYDwRsL4MyzirUA4DqPXYtju2DeWlhbarzWn9qkR3SksCZQEZ5JmCYTp29vdeo3vZ95MTLChzJyEr7+ROoqt33uEUo7y5FoaZmIAFo7Xv0WFA+2wCA8KioxIeQ4alqJ4bfA0RevAne8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r4A4yBvs; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5115f93fe57so7779e87.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Feb 2024 01:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707644145; x=1708248945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH4wZS24qpSRB2owdnOAq4iTMgyZlVFrxUPzmwbgadQ=;
        b=r4A4yBvsjLYgXqrUYk1g7+Hha9nknbmYFOOeXcOLFRvu6pS3mogduSNZrTOx180v3k
         +CBxzg5z0g72d/44Paf7+pkxBsWSxBoTSNTpcDDbMV4/hwiU6TkwnZMpTrueyki8l2/Y
         24tAV8zVFYRvhRkQmG2ZJpZDgAE9+MqhgwnQxex/awC8es1xGI5PEqLQeZVzIP2ZGt1e
         DGuaMMqcmnKrDl9Jn3G9cFa7+4G6R6ikmf/R6aQ6siv32eHTTb20w6NaQmDMAoBmQXmi
         6ixjUo/J9URQ/JtWis+tLl8OtME5CUGvWDAG5QH1HGBxMc5EgRAUWmK28pWWWhEu9C98
         hOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707644145; x=1708248945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TH4wZS24qpSRB2owdnOAq4iTMgyZlVFrxUPzmwbgadQ=;
        b=ux3qiUHr0scyV/glW95QTidcMmfHdFLaoh0bCdKR//gpMZgiZny5B6fKsuaqrnNbYy
         PpcfJcrcTAP7+UFKxq4+rtLBoHwSZA9pEbCyaKvvNVF/2lIwUqBh5TnBDHjM/k1E0ZM4
         M0EF5hwqOtitX2/FOuRBKkzScviCrcFYmzYHGkUP1gvHJKN0nW3t47suiZkTu+A/YNMa
         XtIln5H59VOmkCqO8EVrfbz8seVE2DejAiXJfrmULA7VJmaQa1WV+cg8CCBp00Y0j3z6
         b3eLixlCbBs0p0dKDlkDoG7PVOTmsdy3WyJRhuwNoq4G+uazx4NfhdO1sIDBM/u76fOl
         Vi+A==
X-Gm-Message-State: AOJu0Yy0V2xWu1BifUo5tedO0XSqsjsPgk5hfJeTMW7/XU5llyPQYVNG
	SiXR5ulH2bgHPPgj4IkacXqDZ4XSW+ngklBEZFsNGaCUjGQKglfA14dVGB7ne3iblKF+yNAr5SO
	XykuqHLh6hVsZh9Tlo1bbKEjq174U2o8LEGG+
X-Google-Smtp-Source: AGHT+IH6GSO5X0Nc2TMuWJvjnMysLYSOkmwizWQnAr5k97RFt+AZfM1Nt+KJVr8tFK+KmAahy67pV89IjCQH61jhG4E=
X-Received: by 2002:ac2:5e8e:0:b0:511:7373:3ca8 with SMTP id
 b14-20020ac25e8e000000b0051173733ca8mr54923lfq.3.1707644144566; Sun, 11 Feb
 2024 01:35:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209211528.51234-1-jdamato@fastly.com> <20240209211528.51234-2-jdamato@fastly.com>
In-Reply-To: <20240209211528.51234-2-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 11 Feb 2024 10:35:31 +0100
Message-ID: <CANn89i+fBA1EQJdcgiwatcX4bdW0DXCEoHQC7ps-TboCt-p5hQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/4] eventpoll: support busy poll per epoll instance
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org, 
	brauner@kernel.org, davem@davemloft.net, alexander.duyck@gmail.com, 
	sridhar.samudrala@intel.com, kuba@kernel.org, willemdebruijn.kernel@gmail.com, 
	weiwan@google.com, David.Laight@aculab.com, arnd@arndb.de, sdf@google.com, 
	amritha.nambiar@intel.com, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 10:15=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Allow busy polling on a per-epoll context basis. The per-epoll context
> usec timeout value is preferred, but the pre-existing system wide sysctl
> value is still supported if it specified.
>
> busy_poll_usecs is a u32, but in a follow up patch the ioctl provided to
> the user only allows setting a value from 0 to S32_MAX.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Acked-by: Stanislav Fomichev <sdf@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

