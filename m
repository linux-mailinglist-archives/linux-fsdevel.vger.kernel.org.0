Return-Path: <linux-fsdevel+bounces-39341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EB4A12EF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 00:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E5E16134F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 23:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1C81DD525;
	Wed, 15 Jan 2025 23:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8aHguRy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D401DDC00;
	Wed, 15 Jan 2025 23:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736982269; cv=none; b=pmd0ZSI4A9kPOKoGszWtFAlPS8QTmDc1WKj1RN4mmQiIhN/O991fa5Xo0oZ//fckc7/1AeAp9dt0Iz2+Jasw5rGvkLxDCGXj0lb11+ES9RMBk/m4TdUJoR+0fvOYScKsTZrahrKbdklJCUCkhlp+DKlsRSeVghqgxgNnYnyBHFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736982269; c=relaxed/simple;
	bh=28S+AUl8D3nIC+YEzfnoWZjB3/BI6MXQpDs5KkVnv2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fH2QmO7EG/YRlbdbl2vHThxJ9XZZcuijYjuZsshPNeUGaCKfPUDag87tVpGewRGKnXsOfWkUQKR5VMFkqeyUNn6ryv26Opgwg96G4ZgIfCN8zEeA61ey7JJxmhfcm4mfiWrCwFxFnG11e7A/dZHrFCiJjZX2O4SlcUskjoz/4uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8aHguRy; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f42992f608so531064a91.0;
        Wed, 15 Jan 2025 15:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736982266; x=1737587066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlXjhmu0DDd/wOdKu+MNFy7ulTErAkB+k2GStp1vimY=;
        b=b8aHguRykSD6tdaum+NF97Hix8F8d4w/07gfoP6pmWpz4cPNXaI7OI7s5gNNWkqTjd
         ePVF3LPHCL9I30DvNpr8cinLoDn17A2iFS9Bqid28VGHvBO6rfPqRypThHbg0dagREM5
         eYAokBm1EYSB6i3fH8Vn8yfv7cWw2qUV8WYsrwesPU4p5lWsuFuUwPFBzD6iSNPrRUK7
         Lrv0EvWlBljOnQ/TWhwOPpazgmrdZ3MH3dTtbjCKvlGQx4tLNc8ogINlgvHPTIdNzGoU
         y0zjsHAUWT3iZVF1jeVqprbW0ldzXYZH4PtOPUqDdIthqIOMfHAFCWB/dIInTIUcJTjD
         E8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736982266; x=1737587066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlXjhmu0DDd/wOdKu+MNFy7ulTErAkB+k2GStp1vimY=;
        b=iQmCxf9PNRNIo1gQO5ldJ8p7yo9yV9LO3tcCdwXezc3lHK3HsjxKcaT8tsQ248fsfj
         ojvBAqCOT+rYBwuApC9yP3JLURmXTF5bNZd58qp50D+51+U/iCLTa+uyHl2yOvJFP4ge
         g6XMXPv5PbgS2p7kXh3j1urbgTjjAV4GZ8E6Da3u2O6MtueiO8o8Cu6OjSViuauFxxN/
         ZYaDRKguazffqWDoh4Hee/LhvnT3dHHfwG1LCSAhftPpGI/IikBIDQX/p6faxuNwcy5K
         VV3piGLBW+G9SG+LNjE/C6FEWP2owEoRdHluFpODWFjWa1umvEvfkmERZjdxAtBdORGT
         CBmw==
X-Forwarded-Encrypted: i=1; AJvYcCUahVoyrUaT3Y+cGDnqjTeb/XazgNUQtx7ympk95HLy5N3bOzSQpJ2+Fekwd97SOhBTIYGFY7xmfXpFpxRW@vger.kernel.org
X-Gm-Message-State: AOJu0YysiRKBJw6yd7MRysn25m7GmlVDLSPF9qvGo/2uGX85vvITT843
	bU4C8jggp+kUET4uzbkOjxMpsQXrKX/EhYL8qLzX7TYWQzDTjPLg+kSuTHphTBCFFqmcICIzxnF
	tuCwV6i76TOUamTO27a7f0czp/ll/fJmN
X-Gm-Gg: ASbGncv9Kbz/Xgqv4eSVkbHsc1iUy5wZhp675zz20lMNAV0FytGO9+0TFAGesHRZHe5
	8tBH/KerVtKN6r3GwZ/E/9TU8jzSlLtrcwZ0ASQ==
X-Google-Smtp-Source: AGHT+IG6qhoUZOKitarBW+pX9bxJ3ul3yZKEBysA+fsvulAH3bWoAx7pZznOJj2Zc3BxzWLxMd1hMcEjL6SpHLmbuIg=
X-Received: by 2002:a17:90b:2f0e:b0:2f4:49d8:e718 with SMTP id
 98e67ed59e1d1-2f548eac0bfmr45834241a91.9.1736982266401; Wed, 15 Jan 2025
 15:04:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9a168461fc4665edffde6d8606920a34312f8932.camel@ibm.com>
In-Reply-To: <9a168461fc4665edffde6d8606920a34312f8932.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 16 Jan 2025 00:04:15 +0100
X-Gm-Features: AbW1kvbkZe-BZ42_LcDKpvCIa0iOp9_gFIvLbx1ExKothJmm4FjkvDO5_WQU_PY
Message-ID: <CAOi1vP9uiR_7R-sa7-5tBU853uNVo6wPBBHDpEib3CyRvWsqLQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: Introduce CONFIG_CEPH_LIB_DEBUG and CONFIG_CEPH_FS_DEBUG
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 1:41=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> Hello,
>
> There are multiple cases of using BUG_ON() in the main logic of
> CephFS kernel code. For example, ceph_msg_data_cursor_init() is
> one of the example:
>
> void ceph_msg_data_cursor_init(struct ceph_msg_data_cursor *cursor,
>                   struct ceph_msg *msg, size_t length)
> {
>     BUG_ON(!length);
>     BUG_ON(length > msg->data_length);
>     BUG_ON(!msg->num_data_items);
>
> <skipped>
> }
>
> Such approach is good for the case of debugging an issue.
> But it is not user friendly approach because returning
> and processing an error is more preferable than crashing
> the kernel.
>
> This patch introduces a special debug configuration option
> for CephFS subsystems with the goal of error processing
> in the case of release build and kernel crash in the case
> of debug build:
>
> if CONFIG_CEPH_LIB_DEBUG
>         BUG_ON();
> else
>         return <error code>;
> endif
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> ---
>  fs/ceph/Kconfig                | 13 +++++++++++
>  include/linux/ceph/messenger.h |  2 +-
>  net/ceph/Kconfig               | 13 +++++++++++
>  net/ceph/messenger.c           | 16 +++++++++++--
>  net/ceph/messenger_v1.c        | 27 +++++++++++++++-------
>  net/ceph/messenger_v2.c        | 41 +++++++++++++++++++++++++---------
>  6 files changed, 90 insertions(+), 22 deletions(-)
>
> diff --git a/fs/ceph/Kconfig b/fs/ceph/Kconfig
> index 7249d70e1a43..203fb5d1cdd4 100644
> --- a/fs/ceph/Kconfig
> +++ b/fs/ceph/Kconfig
> @@ -50,3 +50,16 @@ config CEPH_FS_SECURITY_LABEL
>
>           If you are not using a security module that requires using
>           extended attributes for file security labels, say N.
> +
> +config CEPH_FS_DEBUG
> +       bool "Ceph client debugging"
> +       depends on CEPH_FS
> +       default n
> +       help
> +         If you say Y here, this option enables additional pre-
> condition
> +         and post-condition checks in functions. Also it could enable
> +         BUG_ON() instead of returning the error code. This option
> could
> +         save more messages in system log and execute additional
> computation.
> +
> +         If you are going to debug the code, then chose Y here.
> +         If unsure, say N.
> diff --git a/include/linux/ceph/messenger.h
> b/include/linux/ceph/messenger.h
> index 1717cc57cdac..acfab9052046 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -532,7 +532,7 @@ u32 ceph_get_global_seq(struct ceph_messenger
> *msgr, u32 gt);
>  void ceph_con_discard_sent(struct ceph_connection *con, u64 ack_seq);
>  void ceph_con_discard_requeued(struct ceph_connection *con, u64
> reconnect_seq);
>
> -void ceph_msg_data_cursor_init(struct ceph_msg_data_cursor *cursor,
> +int ceph_msg_data_cursor_init(struct ceph_msg_data_cursor *cursor,
>                                struct ceph_msg *msg, size_t length);
>  struct page *ceph_msg_data_next(struct ceph_msg_data_cursor *cursor,
>                                 size_t *page_offset, size_t *length);
> diff --git a/net/ceph/Kconfig b/net/ceph/Kconfig
> index c5c4eef3a9ff..4248661669bd 100644
> --- a/net/ceph/Kconfig
> +++ b/net/ceph/Kconfig
> @@ -45,3 +45,16 @@ config CEPH_LIB_USE_DNS_RESOLVER
>           Documentation/networking/dns_resolver.rst
>
>           If unsure, say N.
> +
> +config CEPH_LIB_DEBUG
> +       bool "Ceph core library debugging"
> +       depends on CEPH_LIB
> +       default n
> +       help
> +         If you say Y here, this option enables additional pre-
> condition
> +         and post-condition checks in functions. Also it could enable
> +         BUG_ON() instead of returning the error code. This option
> could
> +         save more messages in system log and execute additional
> computation.
> +
> +         If you are going to debug the code, then chose Y here.
> +         If unsure, say N.
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index d1b5705dc0c6..42db34345572 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1063,18 +1063,30 @@ static void __ceph_msg_data_cursor_init(struct
> ceph_msg_data_cursor *cursor)
>         cursor->need_crc =3D true;
>  }
>
> -void ceph_msg_data_cursor_init(struct ceph_msg_data_cursor *cursor,
> -                              struct ceph_msg *msg, size_t length)
> +int ceph_msg_data_cursor_init(struct ceph_msg_data_cursor *cursor,
> +                             struct ceph_msg *msg, size_t length)
>  {
> +#ifdef CONFIG_CEPH_LIB_DEBUG
>         BUG_ON(!length);
>         BUG_ON(length > msg->data_length);
>         BUG_ON(!msg->num_data_items);
> +#else
> +       if (!length)
> +               return -EINVAL;
> +
> +       if (length > msg->data_length)
> +               return -EINVAL;
> +
> +       if (!msg->num_data_items)
> +               return -EINVAL;
> +#endif /* CONFIG_CEPH_LIB_DEBUG */

Hi Slava,

I don't think this is a good idea.  I'm all for returning errors where
it makes sense and is possible and such cases don't actually need to be
conditioned on a CONFIG option.  Here, this EINVAL error would be
raised very far away from the cause -- potentially seconds later and in
a different thread or even a different kernel module.  It would still
(eventually) hang the client because the messenger wouldn't be able to
make progress for that connection/session.

With this patch in place, in the scenario that you have been chasing
where CephFS apparently asks to read X bytes but sets up a reply
message with a data buffer that is smaller than X bytes, the messenger
would enter a busy loop, endlessly reporting the new error, "faulting",
reestablishing the session, resending the outstanding read request and
attempting to fit the reply into the same (short) reply message.  I'd
argue that an endless loop is worse than an easily identifiable BUG_ON
in one of the kworker threads.

There is no good way to process the new error, at least not with the
current structure of the messenger.  In theory, the read request could
be failed, but that would require wider changes and a bunch of special
case code that would be there just to recover from what could have been
a BUG_ON for an obvious programming error.

Thanks,

                Ilya

