Return-Path: <linux-fsdevel+bounces-15808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F59893200
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 16:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411601F21A17
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 14:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412F76A03F;
	Sun, 31 Mar 2024 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8w4kR7C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA301E88C
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Mar 2024 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711896213; cv=none; b=hD3jfMBDwn2KqG12Q9tWQ0w/Stski/ChXd0wUkwM3F8c+R0SO+gqMieFeTzMApoh9z5/mC0NJHZP3CaduS+Xkpyw2KVnBWj5apmXMYCRsUKa7nk1vOOti8jMnbVFANntT4SJijKY0vhXudXf8PHx20Rr1w69IMNnFkbo7GLuSNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711896213; c=relaxed/simple;
	bh=9E2dzwCG5JmMRallZfO8ZLKlIjiyoKdTfjIljgg+8ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAJc7pvoVoHPRk7I2Yy5xKcHdUVlvoPkYwm8cSeEk8Agx8AsyO0dYxcgYSKf3uSOAX8ynA/yGAlLJ57KBtUUg+SDQJN84y/OpOqYL7yczz7CuT1iodLhmFsKeWxtUX0eDJi4jAlDdXjUwLefEJdDitF7zB032c+qHKASHCXRKGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8w4kR7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E154C433C7
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Mar 2024 14:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711896213;
	bh=9E2dzwCG5JmMRallZfO8ZLKlIjiyoKdTfjIljgg+8ww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i8w4kR7CGe33cnjeGf6FJ4vtzKRrZoFyGPQ9dFlELHDx6obY2M+5VrwL88JQpDfe9
	 AKcdZblpKcZohPl45yPz3TOMBT5s8ByujpWRJnD1Lh92TLVa0LLmTF2z+0pCt2UDPT
	 j7kcuXYY/H3hL7gBLcLEZcEPMDzLFtLvdi6TpuHfIJzNo/+9VWmmQgMaVzbqLpTFxH
	 WmmyEZxacX5asjqX2hiXzQsS4F8t6xkQLmshOBO9idiwKHu4h6PFleTFDGQ/0B0q7T
	 RoT+rXNf//4uj4agjFjZVdkFJSu/PuK0014zuOQBIOQlm/NIX0MSmvLAPNTfzNN4g6
	 f5PMxhsckAyxg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2297d0d6013so2122075fac.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Mar 2024 07:43:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV31H69ji3tB8JnGAaeL2nDNB5hxLy2FMkl/qIiTLYNpByNoCPzy6SMs0Vv/Agv+qQXy9O0Sn8tmTmYoMlfKjm67sKJpVxLXsyYTzIczA==
X-Gm-Message-State: AOJu0Yza6nn4spIilNOXVu2z1YVRJbV2NfG9DTVR+AFYllXZ/aeyJIIS
	NC9UYeqGlhpbtw4JBarQ2XNZts9JPdDdJTqTi6tLUl/AhdPyHzdK6XA+6YP0U8NuOiWZVyq1hq6
	XamnyizzBIuo6z11iTyqp+DNGgfE=
X-Google-Smtp-Source: AGHT+IHHrtick/R9XlZEjyZ243PJzBA7GsuH9MgOeQGLIuFJqaNYeAjJyeTKHE7U3AIQe9wh/bbg7C1elfGRhYovgqw=
X-Received: by 2002:a05:6871:3422:b0:229:e38e:cd8 with SMTP id
 nh34-20020a056871342200b00229e38e0cd8mr6442532oac.26.1711896212361; Sun, 31
 Mar 2024 07:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB6316DBBB2B99C8BA141EF48781342@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB6316DBBB2B99C8BA141EF48781342@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 31 Mar 2024 23:43:21 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-o59dqEoe6dZEcjoeDSuuaAcL9+OxhUHqGf5a-Oxm5NA@mail.gmail.com>
Message-ID: <CAKYAXd-o59dqEoe6dZEcjoeDSuuaAcL9+OxhUHqGf5a-Oxm5NA@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: fix timing of synchronizing bitmap and inode
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Andy.Wu@sony.com" <Andy.Wu@sony.com>, 
	"Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 3=EC=9B=94 27=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 6:04, Y=
uezhang.Mo@sony.com <Yuezhang.Mo@sony.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> Commit(f55c096f62f1 exfat: do not zero the extended part) changed
> the timing of synchronizing bitmap and inode in exfat_cont_expand().
> The change caused xfstests generic/013 to fail if 'dirsync' or 'sync'
> is enabled. So this commit restores the timing.
>
> Fixes: f55c096f62f1 ("exfat: do not zero the extended part")
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Applied it to #dev. Thanks for your patch!

