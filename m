Return-Path: <linux-fsdevel+bounces-58089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C70EDB292F9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 14:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7F882071C6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 12:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F81D12CDA5;
	Sun, 17 Aug 2025 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFeEgVT2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82801C01;
	Sun, 17 Aug 2025 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755433829; cv=none; b=m9taIMA43zwVPuhT//qhFyb09ENL4r6p3QxMUwsSh80xgTQ8iLrUPvV9t7rMeSEK8msAJT6nuplSFWHgc9pKzocClJZjtQ850t76oPyaN/jOkRtIR4eDQrGG+sQd4jvcHjvYkMF1CzErUxzTmwUtJAOOFhFQNwJWDlny2tP4F1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755433829; c=relaxed/simple;
	bh=n6h59NH3SE3Bpcy49gkT81sJR8Z01RR4cptlo9072iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGJeSGLN/0YdkyJTHVHg5YrVJH8j1VjS1+e5THlEC5JRNMQpfB/1lSIeSEmC4nr0bnvAL+dVnuHXJkWpzWh6on9VtTUTXKLsZcpzICLwafSArXzMb88k4jksmkA9Ry7qyMCmC5NcOpy+DduaHHHhs36QuXnRUw40AQK9EbZkcjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFeEgVT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38657C4CEEB;
	Sun, 17 Aug 2025 12:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755433829;
	bh=n6h59NH3SE3Bpcy49gkT81sJR8Z01RR4cptlo9072iY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gFeEgVT21YQCcwfj477GmziSJIANrnxbw1rdmHOYlXq88LpAebHzSPglPW44IK6qK
	 Oj2GuMMGxmWj/pIA7PUFaWugom9hW8YRscIAF4Dfb/oNyhoIbLd6muykEizJUYyl9Q
	 OMxYWoAR4zyUALI35ukfMGQT1tfy+Fe5yQaAah/d3yWIyut6XfYjUbiexZ/HCk92RZ
	 1LF284znX+KNte+KmAAVR1DmOkW/aRfu5nFVM9RbE5gUk1h4W6gyl8XHMJS9SuC69e
	 n+7P7zYBpCnoXkK6TjAwwcI9DqtKAJ33EyaC9RN7sPttUb8BJ+Duxg/e2yhSKbYvbF
	 PznwFkulWr9jA==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so4408605a12.0;
        Sun, 17 Aug 2025 05:30:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNlq88NqDDwCrU5HP+OMjL33RL+0tEDWVp/VvNxJ9CCBs+ykKGvOneKDFA3yq4MJx7cc6FjGWWeZ9qBdRO@vger.kernel.org, AJvYcCXWxGMXfbj3d1SfUjJmKALaJKUpGq9eZMR6cb1+T71YbTB1j9oicxbqrVT1zdeNeBQoxk0qdq8L4Aphr0dH@vger.kernel.org
X-Gm-Message-State: AOJu0YxsEPCBNRnJaDEzSYnsugk/bcu9kfN8H1EU2wUqlm7TdeSAlFPs
	qtDysm+hjUgFTJoQI9+BGxC6yXKnbscOxADiUvlAEZWyQE7JLcBqIJBT+7gfawmmNGuD2o/TbYy
	brYQwZ5qB/4R7xJpxaKEWNcqMDhcT6wI=
X-Google-Smtp-Source: AGHT+IGC3JoqRM65wcAB348IBohu4qk1K11KOoBv4QVegr1rfy20AWEveM4JIYzEUe4lTTZsmJdEf+piC6S9XdDL3Pc=
X-Received: by 2002:a05:6402:5cd:b0:618:40f0:89b7 with SMTP id
 4fb4d7f45d1cf-618b0563ddbmr7544594a12.34.1755433827843; Sun, 17 Aug 2025
 05:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250817003046.313497-1-ethan.ferguson@zetier.com>
In-Reply-To: <20250817003046.313497-1-ethan.ferguson@zetier.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 17 Aug 2025 21:30:15 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-B85ufo-h7bBMFZO9SKBeaQ6t1fvWGVEUd_RLGEEK5BA@mail.gmail.com>
X-Gm-Features: Ac12FXzAbFIJDevUiokY8nYsGTi6DSa8SEudyxuDwsd4vdt7d2FcffEtlupDNmA
Message-ID: <CAKYAXd-B85ufo-h7bBMFZO9SKBeaQ6t1fvWGVEUd_RLGEEK5BA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
To: Ethan Ferguson <ethan.ferguson@zetier.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2025 at 9:31=E2=80=AFAM Ethan Ferguson
<ethan.ferguson@zetier.com> wrote:
>
> Add support for reading / writing to the exfat volume label from the
> FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls.
>
> Implemented in similar ways to other fs drivers, namely btrfs and ext4,
> where the ioctls are performed on file inodes.
We can load and store a volume label using tune.exfat in exfatprogs.
Is there any usage that requires this, even though there are utils
that can do it?

Thanks.
>
> v2:
> Fix endianness conversion as reported by kernel test robot
> v1:
> Link: https://lore.kernel.org/all/20250815171056.103751-1-ethan.ferguson@=
zetier.com/
>
> Ethan Ferguson (1):
>   exfat: Add support for FS_IOC_{GET,SET}FSLABEL
>   exfat: Fix endian conversion
>
>  fs/exfat/exfat_fs.h  |  2 +
>  fs/exfat/exfat_raw.h |  6 +++
>  fs/exfat/file.c      | 56 +++++++++++++++++++++++++
>  fs/exfat/super.c     | 99 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 163 insertions(+)
>
> --
> 2.50.1
>

