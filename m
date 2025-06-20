Return-Path: <linux-fsdevel+bounces-52367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA23AE2464
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 23:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AFC21BC245D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 21:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175E523BCE3;
	Fri, 20 Jun 2025 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1tra5fA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67672224898;
	Fri, 20 Jun 2025 21:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750456770; cv=none; b=uXsR869PLnPIBWfMSyT8ekrU8Mt+6lA3hvktaVJ2166izlqF5lw2WVdwmNHxSfDJt3fF79msdJQmNLSQnVm5V+blh5tdtbA9AW0te1GeHsWOD9fZdJEmLvp5lRgNNG2TwHwmRjGwyl+WwUm3YzRHXDJjOdURdNajBK0P3N0m48w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750456770; c=relaxed/simple;
	bh=63te8wwcuOZegBXprmXeQJ2OOPB2Fa+R7wapMpKOn44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXe6Rpuy+G/vnRrYIH39JXNeRSj+S/CZFwS1ZyJzFYuOKSDqUpF7PimSLooqAt9ZjWwyOeG1wyitctdUeWpqlRHlvVetwBtIaGFqAiJKe3g6JxytWQxL8msr/sIweo6pFGec2Ufmy59lsCD7vptiKixWuc1jxpwJ1yTN++q+ous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1tra5fA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0802BC4CEF2;
	Fri, 20 Jun 2025 21:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750456770;
	bh=63te8wwcuOZegBXprmXeQJ2OOPB2Fa+R7wapMpKOn44=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O1tra5fA5OpmS2CF8mrWsYLyZJUoMg+5Ly9hiRBQHQtmj7TAeSv3pQzPPqNQgHf3H
	 xVuwl0k6m560FMkJb0uCoL0/fZK1FQaVfhWt6O6P9aRUF5wy17xcW61a25K7YK6o2T
	 d3zLV92yMLgfpycoU4G2s3JhVCRfvxApsdaEldCW+pdYzSmoXE32fHxtzuliqXm924
	 bVSea4Dv5RF9blS75r/FU/nVWkpBhFQ8nCdskdWp4xSKnwWEn7o6xzzHCQSTXtMxy2
	 i6SSlGhdlvXpkLwQQs0qXAhfixUJSwI6WTgpdlmLt15u8kK2gUYPgQnsYzWnXGxY8A
	 u+EM7P+I2G8dw==
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a440a72584so24363571cf.2;
        Fri, 20 Jun 2025 14:59:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXTMlvw4Cj2iiF3zQ2hxymL/pjbOea+PAFUUbIcSXVHFcI+U6zxls5a3ylHq46PPdN0jIjGptFl4bGXLaQKezZVqMlKGfX@vger.kernel.org, AJvYcCWnP9K7sU/ZodDAXlQKelVtFohhOHR2++67SmnB6xfvyn9dr5XnH8k7c+7rinOpkrLKX5fyvGcEmmtlPcGi@vger.kernel.org, AJvYcCX6anLRY3DEDPf6iqFdkgk1sURgpQGp1z+XkekfmfaqwvSF5wSmyG3YZKI6KemrzHLUxeDtWsi/HMLzs6Py@vger.kernel.org
X-Gm-Message-State: AOJu0YzVCCHevgHSMpMYxuvgyDWiPcic0utuXieLplXPScl2K1juyDfk
	RsAcz39EaNll8d0CZu5O8gAyZ75/7SS79ur6fuhy7/46KaCJQzBdlKZuQ2b5vdaNa47s4hWqg/y
	DvkkAC4CoqiEd+bMKET7jOzOtfa59CwQ=
X-Google-Smtp-Source: AGHT+IFD3WvtlrgNG6kq+U9U7yxkF7/+ufoV54N6pbVQsB7ri9hvP39fSdWH0gFoWV+S6HvLUhxN1D9ZuXCtLuuijd4=
X-Received: by 2002:ac8:5894:0:b0:477:c04:b512 with SMTP id
 d75a77b69052e-4a77a24bc5fmr74015541cf.16.1750456769124; Fri, 20 Jun 2025
 14:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617061116.3681325-1-song@kernel.org>
In-Reply-To: <20250617061116.3681325-1-song@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 20 Jun 2025 14:59:17 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5uu8cOYJWJ3Gne+ixpiWVAby1hZOnUgsXcFASEhV4Xhg@mail.gmail.com>
X-Gm-Features: AX0GCFtB5WpXbtgDqonU-KBN5EWY8ZPLkipOykAU_GhR2BYEI5Zkrc7jPl_KFTM
Message-ID: <CAPhsuW5uu8cOYJWJ3Gne+ixpiWVAby1hZOnUgsXcFASEhV4Xhg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
To: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	brauner@kernel.org, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com, m@maowtm.org, 
	neil@brown.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian, Micka=C3=ABl, and folks,

Could you please share your comments on this version? Does this
look sane?

Thanks,
Song

On Mon, Jun 16, 2025 at 11:11=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> In security use cases, it is common to apply rules to VFS subtrees.
> However, filtering files in a subtree is not straightforward [1].
>
> One solution to this problem is to start from a path and walk up the VFS
> tree (towards the root). Among in-tree LSMs, Landlock uses this solution.
>

[...]

