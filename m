Return-Path: <linux-fsdevel+bounces-31892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDFD99CC96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 16:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5772B23435
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A70A1A0BDB;
	Mon, 14 Oct 2024 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah9OCc3j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33709E571;
	Mon, 14 Oct 2024 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915419; cv=none; b=P6xCFWkBXclKq8kF5BxbARsubalKUjD5+XaJH78yWtQUNxLAQzoe5zSc6elxEDcj80M9eN35kI7SU5AIIQ47EHx4A3Kzir4ZKtqMGXwZoCfpLHEP381pm4m7LBhdWb0c5ZGzEDBhlKDMKQ53LTLXarJeseiiMqILL5x3R+ubY7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915419; c=relaxed/simple;
	bh=90Iz6hvNZU7IBUC+PcJv1z2+26k+1HjcYupMFBXvIsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTzmSVEjTeU0Sfjeid1zbZcNe1jJICS9SNE+47yQ3GHc81fVNt9le2CVGDUJ8qPSo0KJmCJkh9vqerCr/Pe8Cunub8Yuz9edZRHdrR+XCNhdtsf9hs8X4GuuZU9Qhz7wp9yWIL9uZVfYj6OuUORnykj7pys2O/4B/c/y5e2H4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ah9OCc3j; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7afc658810fso400682385a.3;
        Mon, 14 Oct 2024 07:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728915417; x=1729520217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+aZfNdhDbLhcnNI+c0/kje2c/Gjh70Xqm13tBc72L4=;
        b=ah9OCc3jW5WoacW9syeofx9GqkNEdY40XDFtm+KTJzghKnMotPLqAEd/TkIvYqP929
         AJeqq+jDJsN75Qj0WHQxqrxmQTs+h4ux+3Wi4AKtamZOPx+90hvg+zFfoRe33h9o9fJN
         XF+ChOFjStic+tjbpp/WHANLHOCf22uyU0uLwskf9BCxTSNG12yyHDx51ijcL1vpDgFW
         5weLPCb8jaQtxqprgQSv4FgiIQdYaeoS73wbGJeFdaIjB0oMvCyXjY7tqWxMYvF7mHBz
         nZXsLREOjCDua/oBm1ZTSgUJXCqljhoRhzcdzbbzc4WyXqzD43LlasDbhxjCdk9iABWF
         36Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728915417; x=1729520217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+aZfNdhDbLhcnNI+c0/kje2c/Gjh70Xqm13tBc72L4=;
        b=Qwr4i9sMK2o7XjTnTST+7G3GNWjlmXG4sKlmT9P9hLE4UsRgIi7CJAPsJvNGjhpZV1
         tdnBN9LKUCNiE0FJiK9iucuoHoSH2CJmDBzg/h7Qji7mliXQAiZRh3vSdBUYggZK1G58
         BT7y1wvZ+ujlTbKCnu+teciR0G2PwgGb88Y/fDZ8CypPxeKDJ9Rp0zHALwxEl06+VnSp
         lQuHaifHLbW3oojYmTkEl1DOdiwRX118uxzH4VOaCUTHGzZIw+1xPiaXe19rAcpEYyWi
         NAsShutV08g9pnHxOfsJ4OLtOWTAQmed+3j3DZG7OJDcKbPy/vNt86kGdjm+KaUQEJdk
         M4Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWaqZ6b3hORRQ6lpVmARYkMtb6RiBUZcxSCoUEsCiHYr1ORd01PaJHFuBGULKBQCAeOoX7dAm6NVHgBDc6W@vger.kernel.org, AJvYcCX9VlnxE76S3W04pN8BT0QKZuZO1YfYL80QfdiQ9XKA8lMXVCqXj9GHTr0jYlBTvJd4eRWJimOWCAEywKxf8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyX22Q0Fi15H1ul14MV8LutaEd889Xkz3oGNXxjaald+lthA292
	CrL3KzFO7DVKJITuYPTc6702Bg9IglDYuUL5EilSH78ZIq2taHhbP7uugSVM4zY//Lf5kno4b9l
	yzZt5KHkaU85/kDIzjRABW117rJzABRQDmFnMtQ==
X-Google-Smtp-Source: AGHT+IGfZa7EZFKiTIeYSP9jB5fz5bFVwOvmOB0AiskgxlLNbDi3ehEcs8Wx3U3lUGfB6QnxmmQcN/pK4h8n7NbzJwM=
X-Received: by 2002:a05:620a:2904:b0:7a9:bdd4:b4ea with SMTP id
 af79cd13be357-7b11a34308fmr1932990585a.9.1728915416971; Mon, 14 Oct 2024
 07:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014-work-overlayfs-v3-0-32b3fed1286e@kernel.org>
In-Reply-To: <20241014-work-overlayfs-v3-0-32b3fed1286e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 14 Oct 2024 16:16:45 +0200
Message-ID: <CAOQ4uxjYzkxcOXXcxYtjZ2qvvV7cet2jopqDU0iGAAHcG4REXQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] ovl: file descriptors based layer setup
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:41=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Hey,
>
> Currently overlayfs only allows specifying layers through path names.
> This is inconvenient for users such as systemd that want to assemble an
> overlayfs mount purely based on file descriptors.
>
> When porting overlayfs to the new mount api I already mentioned this.
> This enables user to specify both:
>
>      fsconfig(fd_overlay, FSCONFIG_SET_FD, "upperdir+", NULL, fd_upper);
>      fsconfig(fd_overlay, FSCONFIG_SET_FD, "workdir+",  NULL, fd_work);
>      fsconfig(fd_overlay, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower1);
>      fsconfig(fd_overlay, FSCONFIG_SET_FD, "lowerdir+", NULL, fd_lower2);
>
> in addition to:
>
>      fsconfig(fd_overlay, FSCONFIG_SET_STRING, "upperdir+", "/upper",  0)=
;
>      fsconfig(fd_overlay, FSCONFIG_SET_STRING, "workdir+",  "/work",   0)=
;
>      fsconfig(fd_overlay, FSCONFIG_SET_STRING, "lowerdir+", "/lower1", 0)=
;
>      fsconfig(fd_overlay, FSCONFIG_SET_STRING, "lowerdir+", "/lower2", 0)=
;
>
> The selftest contains an example for this.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

For the series:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Let me know if you want me to pick those up through the ovl tree.
I don't expect any merge conflicts with other pending ovl patches.

Thanks,
Amir.

> ---
> Changes in v3:
> - Add documentation into overlayfs.rst.
> - Rename new mount api parsing helper.
> - Change cleanup scope in helper.
> - Link to v2: https://lore.kernel.org/r/20241011-work-overlayfs-v2-0-1b43=
328c5a31@kernel.org
>
> Changes in v2:
> - Alias fd and path based mount options.
> - Link to v1: https://lore.kernel.org/r/20241011-work-overlayfs-v1-0-e342=
43841279@kernel.org
>
> ---
> Christian Brauner (5):
>       fs: add helper to use mount option as path or fd
>       ovl: specify layers via file descriptors
>       Documentation,ovl: document new file descriptor based layers
>       selftests: use shared header
>       selftests: add overlayfs fd mounting selftests
>
>  Documentation/filesystems/overlayfs.rst            |  17 +++
>  fs/fs_parser.c                                     |  20 +++
>  fs/overlayfs/params.c                              | 116 ++++++++++++---=
-
>  include/linux/fs_parser.h                          |   5 +-
>  .../selftests/filesystems/overlayfs/.gitignore     |   1 +
>  .../selftests/filesystems/overlayfs/Makefile       |   2 +-
>  .../selftests/filesystems/overlayfs/dev_in_maps.c  |  27 +---
>  .../filesystems/overlayfs/set_layers_via_fds.c     | 152 +++++++++++++++=
++++++
>  .../selftests/filesystems/overlayfs/wrappers.h     |  47 +++++++
>  9 files changed, 334 insertions(+), 53 deletions(-)
> ---
> base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
> change-id: 20241011-work-overlayfs-dbcfa9223e87
>

