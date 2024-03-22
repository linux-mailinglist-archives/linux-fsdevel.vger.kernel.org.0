Return-Path: <linux-fsdevel+bounces-15089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7EE886ED7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 15:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E821F24295
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 14:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57319481CE;
	Fri, 22 Mar 2024 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8wOLpBD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DB445033
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118629; cv=none; b=ZO+JIJIdwxNySrVzuFCzzQr3ldKyWpZAf/boJcG7hu1eAEzvfIR29HXX16fPLOV7m9uT/5DtqToc9rdwprdzKWAck6TFJpbfyJfrvdFuaIUYC1YZBWTOc6335QIkF4uxHSZxn/1qTEFzJpz87ok0bWNdeDaYU+HyqwABIxSyN9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118629; c=relaxed/simple;
	bh=zP4ojaz1TRNYXZ10g7tnMYLlVkv8t3Oku0yyBwL84c0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E9roGmnNuz+ZrKpcin0ehrfL2OfIhiiUJlLDTExYshS53MqXGZbHm9Ve6IjTNQcdsRiiLnRiw6ZBWijzQLlTcAH6HmMnbvLQgEw7oazh90vPNdY9Df5HOARKCDFal8sJVBUOVv0ZbdnlaXA2nx1Z2E5exNwAOMUdn4HyXr5yv54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C8wOLpBD; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd62fa20fso44600417b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 07:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711118627; x=1711723427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r11gan0bux9CWlThl7OmOfAkmlVcnsFKZdnlUg7ZkdM=;
        b=C8wOLpBDHI0/ha4b+hqC/ZQgELEPSG81Z/gz4B0LY18l/wfqBMzGzovCrBu9+OgHSW
         p9BMPctTGflfpcCkLvyvF9W7zghvkCunZhCIZE/hJBhXikNmao1GgEoUH2pQ3wHOFgLZ
         QlsMs0rYEPfaRzGaojlEh08DCkq8nMlFFkEVog1euY/NMWJK2Ono+pWnGTIIQeQO3Xsm
         W2FHbmqNFODq6NeQkWyHQk6v5Ei9AI3k9BuSLXP5HN379rpf82Cin20cr5WFl3bDk/9Y
         M2VFwttSQuLoRBeRa28+fYA5oXYRpMux04B/6hjVTdyoukXr4FmbDurgVaEM7VCZnvTX
         tzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711118627; x=1711723427;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r11gan0bux9CWlThl7OmOfAkmlVcnsFKZdnlUg7ZkdM=;
        b=AS8nzodvbVNLnhlxanrKYg54UiJo6+RmNA1krcPbCUiPv7T2chlwSv0TkOmY/AYkRc
         9t5TAiKy/qZICscBmaC0G43OXIkfgPBI7hcWQKB5uV+f5p/ES8P5iDXYZEfNf1WV9jYl
         emaCsz8iJGGg0jU2vVEFRel9p8d08uuy+GNj8wVVBkAa/l5F4dzQMERBxkB+VVShbgWz
         /Cqlm6Ve8BkMCJb7OP+C+InprFMO9pwqzTW1XAy1Wfu+/SQOe+WktkMdpgbr1lgB1LsC
         ujMsnJ6jvPz/sBsdcgM7lBRTqNoz5SF9xmI2ZNxtKX0gveF3aggeJrT9wBe1wGoz+vlJ
         /GfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/o2lAGRTJHmTVfgH9YG01IaYWs6RDbdYJYcd0rTuTsy3HqM0Dd74ZroO7ycIVmss8SyNgDYrWxuzpymj4oVdTqgx2PFEyf6uwdt8UkA==
X-Gm-Message-State: AOJu0YwB6fe4Fn+uER4JItfvcgSf5PIlfTINeqCSQRZVdhPDmAxTnMCS
	WcW6SbVyFS1LwvpjZ0EeI4snrWQuiajUWBBldAoDhGLeCt4OfUyCc1bzHKDW1jmhwqCOu+0bt23
	+Qg==
X-Google-Smtp-Source: AGHT+IGLZppWbArfkXBdhvSgEmcTQvFfeoLPhk/b30YHyJF0avO1RLKN77X2gh7WjLmtSVntcYuXPkU5OfU=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:2408:b0:dc6:e20f:80cb with SMTP id
 dr8-20020a056902240800b00dc6e20f80cbmr70099ybb.3.1711118627288; Fri, 22 Mar
 2024 07:43:47 -0700 (PDT)
Date: Fri, 22 Mar 2024 15:43:45 +0100
In-Reply-To: <20240322.iZ1seigie0ia@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309075320.160128-1-gnoack@google.com> <20240309075320.160128-8-gnoack@google.com>
 <20240322.iZ1seigie0ia@digikod.net>
Message-ID: <Zf2ZITn3CXksmIM-@google.com>
Subject: Re: [PATCH v10 7/9] selftests/landlock: Check IOCTL restrictions for
 named UNIX domain sockets
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 08:57:18AM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Sat, Mar 09, 2024 at 07:53:18AM +0000, G=C3=BCnther Noack wrote:
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing=
/selftests/landlock/fs_test.c
> > index d991f44875bc..941e6f9702b7 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c

[...]

> > +/* For named UNIX domain sockets, no IOCTL restrictions apply. */
> > +TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
> > +{

[...]

> > +	/* Sets up a client connection to it */
> > +	cli_un.sun_family =3D AF_UNIX;
> > +	snprintf(cli_un.sun_path, sizeof(cli_un.sun_path), "%s%ld", path,
> > +		 (long)getpid());
>=20
> I don't think it is useful to have a unique sun_path for a named unix
> socket, that's the purpose of naming it right?

Removed, well spotted!  I did not realize that I could omit that.

=E2=80=94G=C3=BCnther

