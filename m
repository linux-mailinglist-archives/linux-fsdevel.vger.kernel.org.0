Return-Path: <linux-fsdevel+bounces-29548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597C397AB8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 08:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB211C2169A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 06:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CCA8248C;
	Tue, 17 Sep 2024 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL9E3wGR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8077F481D1;
	Tue, 17 Sep 2024 06:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726555250; cv=none; b=Wz8ZUj8s/Ca5YCv/2wGSg967WErdFhX3i+5l7krtR5C8V/YFaBq4BwN7CFLqCfGrhv2v9w+NWWeDF4kTK+wcsyOH4l5siEpi44Iup/LTdIDgF8gKSSXEGrItoceOw/UO10WrU637uXldxqW405W2Cw3ko49AfPbRmnCiDf2g8z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726555250; c=relaxed/simple;
	bh=lrRaZzQx1PUicFEWsjf8xF11xneR/10BGrYs/hZuJDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjLc/pSQQMi/o2IpJi+PoHSbOPyNtbpm6TW5KAA/K+/MvUQ/TsKQe84WTG2aoiZF3RU9UptZu54ZAb9oU/2XmlKGPFiZ0/B7aAjhSTw8O/XnUZ11ImYGzJOmHalevbdM4QOEV5VAG+GCCAroMloFQye94gZPR7sQvyyr+7AxR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL9E3wGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDB8C4CEC6;
	Tue, 17 Sep 2024 06:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726555250;
	bh=lrRaZzQx1PUicFEWsjf8xF11xneR/10BGrYs/hZuJDw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eL9E3wGR3s740rRRgQAIKqMJsQpfySfDPBugUFjGUBco4W8N98ycr6Nzy3abi1TUN
	 gCwz7tZigpL57f/qO5QpbF141bjEBpI4K7oW6A9y7aKTRD0l/okJFNFa3/maLYgHL8
	 KOXf+BoTtixH7IJQVO4eXbBv2hpjWy+4u0Wuoe8z1zy3KWLruLSJLgu6vrR8PuNNmG
	 hjzHOxkz5b63V9/ZIWN2hDbOm7FZERT8uk8KOmEQ1YF0fTF2AFhhSXCMT626gfgQGL
	 7f0ylJ2XjlR0pmRpOC6/N8R0nfVsUDps54BjqUvCWjf/q9XxAG/VHJtvMldhPXPyGL
	 jPsBZLE3NVJGg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-277fdd7d509so2480715fac.0;
        Mon, 16 Sep 2024 23:40:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcMWpzTENUWi+P+H+08s54ycaqkaYOzY2kDxlkPPZVpr0i2aR5dc0E564vRQsFBMsz88pt9FQmiGAfoFq8@vger.kernel.org, AJvYcCWvGRQ/3RVzqUFi7++ev7zpUTjmRg55y7mT5eU0DLejcmdIFpZWhC/UXQm5YPP7N1jPG4QBPhQbVGCvB2JM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5T7BZPO5preJqgs/7Y5lg3aXurrTVIwqj6SJxDKLStYnT+Fl6
	99K9LpGsVattU4ZTrkahwrlzAS7oXEoTC6HtMztppKj5SjCpu3MZ2zaJo8vxSyY6mASGYZwXtuG
	4pb8Fg3CNweE4UVM99a71tJhPjIc=
X-Google-Smtp-Source: AGHT+IEH5yh6G5/4yB8JWXRjt1BvX3OfqdnjeZiwq+2OqqzdvIG1brElBn/avrLnH+0tOKQ7+ihdR6UQ4V0r3ESq/zs=
X-Received: by 2002:a05:6870:c081:b0:278:15b:8ee0 with SMTP id
 586e51a60fabf-27c3e8e9821mr9627294fac.7.1726555249717; Mon, 16 Sep 2024
 23:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916230506.232137-1-danielyangkang@gmail.com>
In-Reply-To: <20240916230506.232137-1-danielyangkang@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 17 Sep 2024 15:40:38 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-__5jnU3znV5qR1SVNaogqAbR-eQW2V_+LsbeVWRb50A@mail.gmail.com>
Message-ID: <CAKYAXd-__5jnU3znV5qR1SVNaogqAbR-eQW2V_+LsbeVWRb50A@mail.gmail.com>
Subject: Re: [PATCH v3] fs/exfat: resolve memory leak from exfat_create_upcase_table()
To: Daniel Yang <danielyangkang@gmail.com>
Cc: viro@zeniv.linux.org.uk, Sungjong Seo <sj1557.seo@samsung.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+e1c69cadec0f1a078e3d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 8:05=E2=80=AFAM Daniel Yang <danielyangkang@gmail.c=
om> wrote:
>
>     If exfat_load_upcase_table reaches end and returns -EINVAL,
>     allocated memory doesn't get freed and while
>     exfat_load_default_upcase_table allocates more memory, leading to a
>     memory leak.
>
>     Here's link to syzkaller crash report illustrating this issue:
>     https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D1406c2019800=
00
>
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> Reported-by: syzbot+e1c69cadec0f1a078e3d@syzkaller.appspotmail.com
> ---
> V2 -> V3: free(NULL) is no-op, removed if() check
> V1 -> V2: Moved the mem free to create_upcase_table
Applied it to #dev now.
Thanks for your work!

