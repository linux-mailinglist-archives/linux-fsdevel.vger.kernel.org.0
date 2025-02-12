Return-Path: <linux-fsdevel+bounces-41599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 586B7A32820
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 15:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6417118840A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 14:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F6C20F072;
	Wed, 12 Feb 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYtXpyc7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCABE20F065
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369504; cv=none; b=PgRzaIuZ/u6mYpojuO47bg36cBKVVa560xVLbQOYftyR5c56dNmkmWGkDZBEXDAq1zSwcmrxuvsZIpsUaw4/fl2hekvxdbj8JqzfhC4hQ7j7gcZJH85/sHl06CdUZg8XOzazZ7K3JjqQ9YF8KU+rYGnKMRB5OJw8WustZcav/CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369504; c=relaxed/simple;
	bh=CHR7bx3j6YnOnMVScIR4W2WNRCTT80y2fE/Ou9ofHWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xv4D3UX1D1vv3O29wwPmuuBvA4XHiDqGH0NVxxe/Eg/Nuj3aOUXuL+TndAHaaSiY3x122U+b17HRPCVB/v/IEevy6xM3CVps5UJiRj7JdZ6uO0EMhUIuCdcIuA8OyY+QCY7bJnwfX8K9OqAGjhuWpyZBPdM8//VCpx+rWOpUavU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYtXpyc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24516C4CEE7
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 14:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739369503;
	bh=CHR7bx3j6YnOnMVScIR4W2WNRCTT80y2fE/Ou9ofHWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sYtXpyc7g/KHHH1PKnFlbDTBpEX+kTmYSkzH7GjO+tjcsDJSyDQ2h1AEdgwpVEYeM
	 d4I4ypKNRslPJqxC86ULAOP5Nq2uLYtTWqwCpDGF+Szqs8xnT5UL1/61qKNF1kpbgv
	 iVyp1Kt4u6IKQjDvVdueDxTwqWLoGRspmMdI20z5/X5fECDaSrvBqKlXcx9Xdtyib2
	 mOHMXXlAcSf1jN3HMLY2lxh7PG+Ir7IzUG5MiPyktLa4S48hCZ9K0qcH9ui4Sdv/lP
	 ZlA4puvBjqSIj0FwNEWF7M5rzt9oiBwt9kaHa6CgqPyplbCXbGBo1kZEGfAZt3I8Ox
	 jdoPf3mC4HwSA==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-726ef4cba96so448956a34.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 06:11:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqJpnE0VtacCS+mYHyUOSthTCB6Er9KXJgneC83XTfy2PUC+61R3+ajc3COQ5jILm2zuS1lWcUDiUGyJKg@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz98ycBjKYOlRmfVXtQ9qqgFrfvAx6G0W8/VoP8dmwTMHGoe0J
	Ys885sjJpoiKrHmNq2p6qzHiMazfWhzt4K9TowZDCozPaJ3szCz/TXXEN2x3bWBXfns3M8Tcn+D
	BjrNYUacU8bjqM7w9RrybTNgvlwk=
X-Google-Smtp-Source: AGHT+IFeDh3QTxUIhujpBf37He6ZCtQqw4YpnSd6ssFeh9oL2HXdfOO5m55BMZviEEAwjG2HVr0L3gAdobpjmqxW+Es=
X-Received: by 2002:a05:6871:6a5:b0:2b8:3d1c:772 with SMTP id
 586e51a60fabf-2b8d646fb7fmr2160321fac.5.1739369502459; Wed, 12 Feb 2025
 06:11:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bug-219746-228826@https.bugzilla.kernel.org/> <bug-219746-228826-lg3LNttcRh@https.bugzilla.kernel.org/>
 <194cd33028e.d4f0541717222.3605915477419792562@maxgrass.eu>
 <PUZPR04MB631698672680CB6AC1529C0F81F62@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <7d880675-4aba-4081-84af-1cbacaef17ab@sandeen.net> <PUZPR04MB6316C15A42D10DFEC3F2F46181FC2@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB6316C15A42D10DFEC3F2F46181FC2@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 12 Feb 2025 23:11:31 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_mq6Gs_qk8uwCrb+5xVXvMzP36+ckCLrx4RqA4fPATFQ@mail.gmail.com>
X-Gm-Features: AWEUYZnPjiP8Pt40CQ_p09L98vz5-nUfupDFJsqLxc_LiJPV6t1q_lA8rC1bots
Message-ID: <CAKYAXd_mq6Gs_qk8uwCrb+5xVXvMzP36+ckCLrx4RqA4fPATFQ@mail.gmail.com>
Subject: Re: [PATCH] exfat: short-circuit zero-byte writes in exfat_file_write_iter
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: Eric Sandeen <sandeen@sandeen.net>, Noah <kernel-org-10@maxgrass.eu>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, sj1557seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 3:37=E2=80=AFPM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> Please add the "Fixes" tag.
>
> Fixes: 11a347fb6cef ("exfat: change to get file size from DataLength")
I have directly added and applied it to #dev.
Thanks!

