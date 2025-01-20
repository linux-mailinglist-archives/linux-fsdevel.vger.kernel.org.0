Return-Path: <linux-fsdevel+bounces-39666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5F0A16BD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 12:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 485607A1807
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 11:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1121DED7B;
	Mon, 20 Jan 2025 11:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofYdasKZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1F2770C
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 11:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737373838; cv=none; b=PK9tQj468wCXvgg/0VYIpzbM59gwdVdIAPuvHB1Ss4lKKIWWBUnUUsht7/59K1u4ezLkNKJXcQdM7h0dGdmaDYEeHI6y3tSX/+f4UjuvcSvPVxaQj4l3Cqknjnx68CvRZ8tLbpnEbWLzWEZQolDFboMQWICwga5ahmBMMP5RKug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737373838; c=relaxed/simple;
	bh=kR1s/AsKJyYcXIzu5DBiBtLPPb34X4BZk5ZTMzwHdLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WK0J7yW++yAffZ3EAjI1JXT6Y/AsASUm1JccVX4L0KTQO54EL2gsowhIOZ0rhPomq3/F7KmmwEdnMAcOjxverV9wIbuywD26ljpUQSsijxsU/nQ5tyKxFd9ETi+pI+N7HBTj3f8JTtRUOE0Fyp0AZHTKlhVBId132aLly4xvlmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofYdasKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397EAC4CEE0
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 11:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737373838;
	bh=kR1s/AsKJyYcXIzu5DBiBtLPPb34X4BZk5ZTMzwHdLA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ofYdasKZfyoWtd9JkPzAR1U+5RjMVxUFuW0GuzeepFqX6EVPB+2dvRR+ldlWhWmth
	 wYvqa1R3XWRVZPzqT36V6c+wm0tIgkCDpWQgdwjDa2RH5hh23uetvRPqXZfMtbhGGj
	 m7ZNK2mXYk4zqMkqKM0U4AnHu8IQdcra9xTAljk5k+UhElDloqhVy/DEkxd7qNKz6k
	 ID4IGraBZD9a+QXBv00l8WyhFABltHVZBV7k1zG1rIofD6B/RMlNWSAgSwtyQMMVJi
	 ymgS82853s1ECQ/moRT1ghvs6XUEbO1Q6IeN8aSbYJFOF6YbDXWP1uWwgTDapfJDWH
	 /3XO9kShqQ7Lw==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-721d213e2aeso1229352a34.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 03:50:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8owuVhr8QYofwOmgUT4zIofTF/bQJVUz9S/WYr2Cuz9pKPjGYbWzzLSaK2tgQRrTiMSHpi1zuSfrnyvLm@vger.kernel.org
X-Gm-Message-State: AOJu0YzgJzDcguKtBYpJHU2GNuAgIc15SWXWUAMVt3X3eZrsQ+TUUAFU
	8/W5jWALHpFXLVuOBa5w8T8WcbCJ9Gvrhlu9i2p2DisVcc67th6SXnd4UziPiKSxrTZeof2DbVk
	Lzds7oXQoDvlh24t5ySacbo0LMGE=
X-Google-Smtp-Source: AGHT+IFA9rhKlIWOfj1b/iCalyvuheKbND2CrOi0KkPahIICpeksx7cEuqN//WRGJgYA9SX48nPYBphCf/xRI6oH1us=
X-Received: by 2002:a05:6830:6087:b0:723:28c2:aa84 with SMTP id
 46e09a7af769-7249da89f3bmr8620439a34.13.1737373837424; Mon, 20 Jan 2025
 03:50:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB6316C98ED4C7811402F3F0F3811B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB6316C98ED4C7811402F3F0F3811B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 20 Jan 2025 20:50:26 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_SrXagOhzcKUFLqL8SjHjp5YVTdc0y10R76Q4cDda==w@mail.gmail.com>
X-Gm-Features: AbW1kvb38Qh7Hna_6RVGvnzCdAUW0gVuuOFXqn2RL33OPGu99QqAWKnQSoDa1rc
Message-ID: <CAKYAXd_SrXagOhzcKUFLqL8SjHjp5YVTdc0y10R76Q4cDda==w@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: fix just enough dentries but allocate a new
 cluster to dir
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 5:16=E2=80=AFPM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> This commit fixes the condition for allocating cluster to parent
> directory to avoid allocating new cluster to parent directory when
> there are just enough empty directory entries at the end of the
> parent directory.
>
> Fixes: af02c72d0b62 ("exfat: convert exfat_find_empty_entry() to use dent=
ry cache")
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Applied it #dev.
Thanks!

