Return-Path: <linux-fsdevel+bounces-26344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD06A957E74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 08:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E651F24FC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 06:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2467816C696;
	Tue, 20 Aug 2024 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUXlBEqP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E484918E375
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724136015; cv=none; b=Q9m8GozWlTyZiWsc88ZLgKaPEJsabkfC6Hu3k/5a/NoPI8zYoZv+lv/h0hQRn+FGUDEnWCOOhxNZW4RZL3ZJdNy/tlyfhHJZ8wiBwIhpeLSaN9xxbAfX8ls7X3E+WXe6zCyhDdYPcUdm1yunaQ9xK6k5/uzxTf1JglbnGQfx6l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724136015; c=relaxed/simple;
	bh=kP8n14qwZP/guqRmk5n6M3hDQvDSOh8PKZWRKCjEAWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzgJVIIaTqWu3BTWdZERzGavcxtbWUM42MV01zcVRCZykhCAD5laeSNg7hUNgVe6IrAtojNEJeFExw19BZbdNAgcj74M5H+nVcwTaZ0CzJz3gQDB/adJ9u8Zyux6eHC1dfchSGUhj9xGFXLmR4uV7fMzhQs3DOsc11m1/2RzgFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUXlBEqP; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1d3e93cceso583938185a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 23:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724136012; x=1724740812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tF1ri6syvhfZOujy5H9/jH+tQf0oDs3nQaoeCM2BCPc=;
        b=AUXlBEqP3ExZqUBo8gN2xxur6LT/CWAAfFieU7g6FtcGCBpjd0Ae8lIV7+ua7XKwsi
         7N/x3iZMIlBdLKoS9CDFfHB2fqnO+1OL2Y1FNoqNcqnxVAA/r0lzEykOQKbEoD3UfD/2
         3A8znZz3yi0U9cPxHmtQQKbDncZnI5J/6crgWdkhEL5BHP9lTV1z3Ay256gYAUrCr3Gt
         ABQMmxkTLGp8NgsnuVGSG7V99sFJfzCvvCRGFr5S9kWYTtTLsWRSO6YLEfyOwBBxasdw
         qN2siz1ElRXB8IvCAdxV4YGKrmhllZ2LD+z/k3S4hSS98uYjRoVD1S7wYyxcm7CLn6eQ
         SVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724136012; x=1724740812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tF1ri6syvhfZOujy5H9/jH+tQf0oDs3nQaoeCM2BCPc=;
        b=k+mrQZPF6xPooVXsG2RCjlg7iPsm+M6Ee7dWOCtCKFdiyTo5RHuybP0IdJbxd+XTn7
         DzzR1dGHnfVaHES9JvmjOB7LH8Wjo7CT43XGUXVl3Uso2RMtRluCa4lvZxTHdfiVtMEz
         qqtAedzLCMbFhM2NKljDUEqDOzVU1uw2hIerptzdsUUVPvFWrbYsvXF4n4XexI7m2E9+
         3FXIQSEAhjxXSz6IRpli45qzecfbfvacsdHIfcb0gECnBp242pWCLtwUDVdRDBnm24Hw
         16f/bXLqWHrR2REppmHQ5uDtyzFPG8wneBSkWuO9Thlqi1V9u4WbG8bcAfARkl02wwSD
         zHxA==
X-Forwarded-Encrypted: i=1; AJvYcCUJgs3eJV/Kl9U/7FVec3apTV3AiczeBCJuSNTzrvlQVaNeQMHsT60jSuwlZ5iw9oFz+aMS0smI8gUi5bys@vger.kernel.org
X-Gm-Message-State: AOJu0YzMsCSa/GWW30LvA4MO8Nx6JQ0/p+vWA8K/FinTPxUglCDmXeJQ
	+JEvzAQiVBF1JFaaWc4ntMFShvzurRWgN5pS4djxgEO+6jzz90yciTfaEG0MmE7BsmBFnHNTY0N
	cENVULJtefqp+3AYzbYZG6EuPIMA=
X-Google-Smtp-Source: AGHT+IH2NxGaT39Hmf7CzIQS6YAbvB7OHnfL8S6jCFmfuaC9MItLQZfp7SM7V66wSlD8OtNj92AmNkqFxFcm7rx1Kr0=
X-Received: by 2002:a0c:c791:0:b0:6bf:97e1:ed65 with SMTP id
 6a1803df08f44-6bfa8a796acmr26288826d6.23.1724136012594; Mon, 19 Aug 2024
 23:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813232241.2369855-1-joannelkoong@gmail.com> <20240813232241.2369855-3-joannelkoong@gmail.com>
In-Reply-To: <20240813232241.2369855-3-joannelkoong@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 20 Aug 2024 14:39:34 +0800
Message-ID: <CALOAHbDt6QiUt4mzMx2DS=16u5dx1tnPBqO2kT4gh_9gBgoq1A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, kernel-team@meta.com, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 7:24=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Introduce two new sysctls, "default_request_timeout" and
> "max_request_timeout". These control timeouts on replies by the
> server to kernel-issued fuse requests.
>
> "default_request_timeout" sets a timeout if no timeout is specified by
> the fuse server on mount. 0 (default) indicates no timeout should be enfo=
rced.
>
> "max_request_timeout" sets a maximum timeout for fuse requests. If the
> fuse server attempts to set a timeout greater than max_request_timeout,
> the system will default to max_request_timeout. Similarly, if the max
> default timeout is greater than the max request timeout, the system will
> default to the max request timeout. 0 (default) indicates no timeout shou=
ld
> be enforced.
>
> $ sysctl -a | grep fuse
> fs.fuse.default_request_timeout =3D 0
> fs.fuse.max_request_timeout =3D 0
>
> $ echo 0x100000000 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument
>
> $ echo 0xFFFFFFFF | sudo tee /proc/sys/fs/fuse/default_request_timeout
> 0xFFFFFFFF
>
> $ sysctl -a | grep fuse
> fs.fuse.default_request_timeout =3D 4294967295
> fs.fuse.max_request_timeout =3D 0
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  Documentation/admin-guide/sysctl/fs.rst | 17 ++++++++++
>  fs/fuse/Makefile                        |  2 +-
>  fs/fuse/fuse_i.h                        | 16 ++++++++++
>  fs/fuse/inode.c                         | 19 ++++++++++-
>  fs/fuse/sysctl.c                        | 42 +++++++++++++++++++++++++
>  5 files changed, 94 insertions(+), 2 deletions(-)
>  create mode 100644 fs/fuse/sysctl.c
>
> diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admi=
n-guide/sysctl/fs.rst
> index 47499a1742bd..44fd495f69b4 100644
> --- a/Documentation/admin-guide/sysctl/fs.rst
> +++ b/Documentation/admin-guide/sysctl/fs.rst
> @@ -332,3 +332,20 @@ Each "watch" costs roughly 90 bytes on a 32-bit kern=
el, and roughly 160 bytes
>  on a 64-bit one.
>  The current default value for ``max_user_watches`` is 4% of the
>  available low memory, divided by the "watch" cost in bytes.
> +
> +5. /proc/sys/fs/fuse - Configuration options for FUSE filesystems
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This directory contains the following configuration options for FUSE
> +filesystems:
> +
> +``/proc/sys/fs/fuse/default_request_timeout`` is a read/write file for
> +setting/getting the default timeout (in seconds) for a fuse server to
> +reply to a kernel-issued request in the event where the server did not
> +specify a timeout at mount. 0 indicates no timeout.

While testing on my servers, I observed that the timeout value appears
to be doubled. For instance, if I set the timeout to 10 seconds, the
"Timer expired" message occurs after 20 seconds.

Is this an expected behavior, or is the doubling unavoidable? I'm okay
with it as long as we have a functioning timeout. However, I recommend
documenting this behavior to avoid any potential confusion for users.

--
Regards
Yafang

