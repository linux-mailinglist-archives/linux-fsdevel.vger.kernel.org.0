Return-Path: <linux-fsdevel+bounces-4037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2347FBC96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 15:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481CE282477
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 14:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB845B216;
	Tue, 28 Nov 2023 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grnybKhE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6375ABB0;
	Tue, 28 Nov 2023 14:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6699EC433CA;
	Tue, 28 Nov 2023 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701181189;
	bh=8ajioNJSIiEHiX4GCTg+Gw12QS+3ZPXGmlmY0t7+FfE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=grnybKhEPIVczjN2qVvT7MlpD3sBcyS4vuozE0Qo/sPnRMKsVtdEL7GRq1zifxX9P
	 wBEoBtWuslDjXeBgr+tpxmPfTpk7QB1XTU2AuHLGdp7Yw6k6QG0p4cjzSCb0e2S7yB
	 PsKwGsBf0zMq/7NG6xoo6QEpcpENveQqaGz74hUvUOuKXoC1wPScgB/oFVkOlJQyOI
	 PzmLdNUB3DC8KcfthaSVy3e1aayzISgl/laWL0OpCF3B7uycXinxoETge72YscC+Qw
	 NID8Cf8TM6khsUDO/FEIlBC2gjH7cnzPZ3TsAt923MltGC7H53TrbI5w0KqKtSA9dz
	 wbhVjNRFMaJ4Q==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2c876e44157so67823961fa.2;
        Tue, 28 Nov 2023 06:19:49 -0800 (PST)
X-Gm-Message-State: AOJu0Yxe9nlP/YXC0W/V5zXbIYiADjxRbZwfQoCllAY3c3AMzl5LH0Am
	hM2IHa4DM9fZjfrbnchfgCBLeup0ZqEfnb1SVAw=
X-Google-Smtp-Source: AGHT+IEuF1AK6ax2QR9Zic8F0Fz2+XjLrZxFO+nxs8N2t+fmpVcV0T3eR++s6Mkt/JQMtB9Jby7xh2t7hGHvFSHK3Fs=
X-Received: by 2002:a05:651c:1548:b0:2c9:9a1f:2957 with SMTP id
 y8-20020a05651c154800b002c99a1f2957mr7666369ljp.53.1701181187635; Tue, 28 Nov
 2023 06:19:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123233936.3079687-1-song@kernel.org> <20231123233936.3079687-2-song@kernel.org>
 <20231124-heilung-wohnumfeld-6b7797c4d41a@brauner> <CAPhsuW7BFzsBv48xgbY4-2xhG1-GazBuQq_pnaUrJqY1q_H27w@mail.gmail.com>
 <20231127-auffiel-wutentbrannt-7b8b3efb09e4@brauner> <CAPhsuW4qP=VYhQ8BTOA3WFhu2LW+cjQ0YtdAVcj-kY_3r4yjnA@mail.gmail.com>
 <20231128-hermachen-westen-74b7951e8e38@brauner>
In-Reply-To: <20231128-hermachen-westen-74b7951e8e38@brauner>
From: Song Liu <song@kernel.org>
Date: Tue, 28 Nov 2023 06:19:35 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6R-1ZjToupiDtRWjxpcdTA0dw0Sk7zDi9+5AUciTJ6LA@mail.gmail.com>
Message-ID: <CAPhsuW6R-1ZjToupiDtRWjxpcdTA0dw0Sk7zDi9+5AUciTJ6LA@mail.gmail.com>
Subject: Re: [PATCH v13 bpf-next 1/6] bpf: Add kfunc bpf_get_file_xattr
To: Christian Brauner <brauner@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, ebiggers@kernel.org, andrii@kernel.org, 
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, casey@schaufler-ca.com, 
	amir73il@gmail.com, kpsingh@kernel.org, roberto.sassu@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Tue, Nov 28, 2023 at 1:13=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, Nov 27, 2023 at 10:05:23AM -0800, Song Liu wrote:
[...]
> >
> > Overall, we can technically add xattr_permission() check here. But I
> > don't think that's the right check for the LSM use case.
> >
> > Does this make sense? Did I miss or misunderstand something?
>
> If the helper is only callable from an LSM context then this should be
> fine.

If everything looks good, would you please give an official Acked-by or
Reviewed-by?

Thanks,
Song

