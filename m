Return-Path: <linux-fsdevel+bounces-54007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFA9AF9F4F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 11:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82C116A70D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 09:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D8624468D;
	Sat,  5 Jul 2025 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfEmnsp2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785591DE3BB
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Jul 2025 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751706868; cv=none; b=lDh2ydHUEqOEXWPT9pQFjbj9/9dsBnSj5XNWYO8aGQgRpMwZSkTLM8HNeNoNIYZ5t3JKR7db29Vvq0xDYdMsEpfpixc0G7bS8QXdpFBzAhZj94B1ks6WXBUd9cEcoPJGVNsrAy3FQJwjIiI3f2xJ96hqxMzxsaqV49srtGQ7Geg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751706868; c=relaxed/simple;
	bh=OqYdIh2yZLPA2MxwMzFZucs4ZLazyOrC6WW0nTkaZ5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOaxp9ud50bvuqeZxvQI9+gGeqghylVkFVhL1XWz6yyRhBcjmhjEovOVw+nYHLzV/dLKKoo85PcfpmhSOaedLj+TwK1f2+/9H12n9HzKEBreFkyBIE1cPty9MFCuJrl8HJTayqaALfHewGz/GqWD6fJCXCePgIDVY1fxVxCnGSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfEmnsp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E88C4CEE7
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Jul 2025 09:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751706867;
	bh=OqYdIh2yZLPA2MxwMzFZucs4ZLazyOrC6WW0nTkaZ5Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QfEmnsp2j6iRvxWwgQu52N0SjpTW8KugRLwO3CRWyest5uCQUBu/8BFsBqtAIo427
	 0NgplrlboxEPyb/LC6Kf00ZCAF6Yc/dhcjAoHFjedYmxZ6CKa73j43gCVK+3ywGpnh
	 H1SkNkL3HvbKZZ5eaZO8nJqSqhbv0CSFRPPtKcQlGSYg/iVHe9K5n0lpABci2ntfkx
	 63DOSNVq85DKCCbGfHQvCKwuEEiwWBTZtp03VDwlK0WTM3sZs44pckLcnbAfExZX7h
	 hGmDRzoiM+q+2gm6HrLP4b+lKswgfNa6+mYXW/y2tBIkV5uLVyV2rElt60K4bdk6UR
	 wK4pphih57tjQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ade76b8356cso303168466b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Jul 2025 02:14:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVx3Rnc9FLUCCJ3vDkxjTa7851PeW9hdv1Qj986+1CpZq6am9Cu0bF79ywl9/3i1PeNITGpNx/7wXZsXXJH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw05prZt0rA94q34UkLKSKYv2tE8HaPYl9inZ8+a9nLcLYW+yPI
	TZFVnlxoTm554TCmjJE7N/BM+SHd0VNzKugqXstHwnIIIt7Exf4Bcm9SAi/T5LCueRto8bOOvD/
	T3p70qufED1hbiTB1qqXYRPx2DZf8TbU=
X-Google-Smtp-Source: AGHT+IHsqkbPMuG+uoyITr6kCBUreiaehIR1b4qjMlZOck7j1isrqqohUGwHqzcElX5QXgGmYS1buSOID/06HAS72wY=
X-Received: by 2002:a17:907:7fa3:b0:ae0:ac28:ec21 with SMTP id
 a640c23a62f3a-ae3fbcb2fa8mr530536166b.13.1751706866499; Sat, 05 Jul 2025
 02:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB631624E25B584B075A7B7E23814DA@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB631624E25B584B075A7B7E23814DA@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 5 Jul 2025 18:14:14 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8OUtfbJ-Gq3AyppBHdjpVu3niYQ4baeaTuFqPXp4QsYg@mail.gmail.com>
X-Gm-Features: Ac12FXw_CLHH1PL64xazVa0KQ-POC8adIzLfh6GDbnJFgYozx6_6xUOvIyrrfH0
Message-ID: <CAKYAXd8OUtfbJ-Gq3AyppBHdjpVu3niYQ4baeaTuFqPXp4QsYg@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: add cluster chain loop check for dir
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 5, 2025 at 5:24=E2=80=AFPM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> An infinite loop may occur if the following conditions occur due to
> file system corruption.
>
> (1) Condition for exfat_count_dir_entries() to loop infinitely.
>     - The cluster chain includes a loop.
>     - There is no UNUSED entry in the cluster chain.
>
> (2) Condition for exfat_create_upcase_table() to loop infinitely.
>     - The cluster chain of the root directory includes a loop.
>     - There are no UNUSED entry and up-case table entry in the cluster
>       chain of the root directory.
>
> (3) Condition for exfat_load_bitmap() to loop infinitely.
>     - The cluster chain of the root directory includes a loop.
>     - There are no UNUSED entry and bitmap entry in the cluster chain
>       of the root directory.
>
> (4) Condition for exfat_find_dir_entry() to loop infinitely.
>     - The cluster chain includes a loop.
>     - The unused directory entries were exhausted by some operation.
>
> (5) Condition for exfat_check_dir_empty() to loop infinitely.
>     - The cluster chain includes a loop.
>     - The unused directory entries were exhausted by some operation.
>     - All files and sub-directories under the directory are deleted.
>
> This commit adds checks to break the above infinite loop.
>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Applied it to #dev.
Thanks!

