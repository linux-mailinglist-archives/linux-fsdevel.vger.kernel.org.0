Return-Path: <linux-fsdevel+bounces-70142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0022EC92050
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 13:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18E3F4E07AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 12:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87807328B4F;
	Fri, 28 Nov 2025 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cukbYydp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34143081DE
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764333861; cv=none; b=kSGuAr9nTfuNO+nMB2fX8bf494BU4wRvV6xpjsazenUUvlyD0EgnY2fu/TL0cdDIcitTFvRlkXwMT7s06Hd3dgvhAbZh50RMQHHfusBxjjzuSkDGRzQM6tC8TUsI6Rbhsxx3qiE3hdTXy6VOzNEi5V5uqnS0b1fSzflBA5ItOVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764333861; c=relaxed/simple;
	bh=AxWSmIM34z68sdiGspdnWDo6fwax7UlfjkmOViLYG8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIbVKMJlNrf4tsc7vnigKD27TOZEDLv4UYhfEAWNeX8Sl1GMAySXPCCSuwXy0Bo7LMpacjC2hUTrnfAFViSoN61z/qcZ8JbLEEC6Rgps86wAVsTPs2XIgfcNG3suAyXzwhW1hIbCiGDhZsbxkr9dZQfiDN85ySDHPdUs3D4dtw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cukbYydp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77251C116B1
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 12:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764333860;
	bh=AxWSmIM34z68sdiGspdnWDo6fwax7UlfjkmOViLYG8M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cukbYydpZWi9v5E2NpebGr6XMN/hipsdoYypGGrSFP5lo041JycKD8xb0jEhI5qaW
	 cSArFYGFBpqwut46ednOJ24susq5g/a8bGOHNWuPRf/nR5KoFJCvIzQV4C36JL5Yn8
	 a7yd1zCBWuL+4J345aEBA8UhrH3ifPLKEIAbwoNHD0a3E80LFfTOwz5J8cnfJqR7cg
	 C7i8Rgzljh6LXZmHSh73iku7lBlF+cl5nAgRwwon4vRkq2nXTbUui0rUwb1onSxL0g
	 ANMjtWwU2VmMGn/vf24QUYA2NYg6/Uc4YANB8z8LvhA8UjXKTyy77cTHrSvo1JRpvg
	 WPQoTzKLEUPAA==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso3593119a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 04:44:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUiiAQsLeNEYcpyxDG8WSSAwyf/fld0VE0PFKwXdxknVncXFZ4XRE1YcBgo14KiLph8HHzwTLJsomLN5pZx@vger.kernel.org
X-Gm-Message-State: AOJu0YxXhiUlXfZSWF+07nB7A1oIfAfiU5EkHqvPc6VLcrAZhisNe0mH
	KzY5C1Lcn9IwZGGKXUyZQbzUvfXB0CBZyEIdUhZBjh/KvL0kKAuVwAWwKMZdzsxoOFSX10dB/j5
	x3djjEbnK3mQJLnwGCcplkVjwf0ydXqM=
X-Google-Smtp-Source: AGHT+IGsYgfGbe2BexK70iG15uQb9K+AtA6pZ6o2HgoYDqxVPc06gY56qPtVObOOZzV2UqBX3n7XMhPKnmiHH43AIP8=
X-Received: by 2002:a05:6402:104b:b0:640:e7bc:d3ce with SMTP id
 4fb4d7f45d1cf-645396905a6mr22099925a12.11.1764333859039; Fri, 28 Nov 2025
 04:44:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128095109.686100-2-Yuezhang.Mo@sony.com>
In-Reply-To: <20251128095109.686100-2-Yuezhang.Mo@sony.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 28 Nov 2025 21:44:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-NXwgpRbxer6X0F=7QfmaDR-Ym6OV=pFf+h7dJ4qsAAQ@mail.gmail.com>
X-Gm-Features: AWmQ_blNh_kZo5I2J0jfKA2FHPt3dtHW9aATo-X1LeBAPQgSuKPK_fzpDvHm-Qs
Message-ID: <CAKYAXd-NXwgpRbxer6X0F=7QfmaDR-Ym6OV=pFf+h7dJ4qsAAQ@mail.gmail.com>
Subject: Re: [PATCH] exfat: fix remount failure in different process environments
To: Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc: sj1557.seo@samsung.com, linux-fsdevel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 7:02=E2=80=AFPM Yuezhang Mo <Yuezhang.Mo@sony.com> =
wrote:
>
> The kernel test robot reported that the exFAT remount operation
> failed. The reason for the failure was that the process's umask
> is different betweem mount and remount, causing fs_fmask and
I have directly fixed typo.(between)
> fs_dmask are changed.
>
> Potentially, both gid and uid may also be changed. Therefore, when
> initializing fs_context for remount, inherit these mount options
> from the options used during mount.
>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202511251637.81670f5c-lkp@intel.co=
m
Applied it to #dev.
Thanks!

