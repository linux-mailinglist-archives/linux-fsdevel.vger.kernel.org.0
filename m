Return-Path: <linux-fsdevel+bounces-35096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B859D1059
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 13:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC4DEB21491
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 12:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0C11990B7;
	Mon, 18 Nov 2024 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2GSgfRx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181D7190470
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731931694; cv=none; b=qPc5pWvnvksRdCiN9m6nzXsVN9But7511KKGMmIJwGJ+IrZrzj0mA7lbPvD00P0r/mswX3YF7CbEcy3+65QxnQiEzAEEEdZvW0BQ4f4+mUjEJP2KgLuQ2rSs4SvlrFNtrldK1ivJp2iuqqu8Zo9qQeCZkZa6Pfs9sltE9tRlZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731931694; c=relaxed/simple;
	bh=71lS8hQ0kTzOSToCRJa1KXGzs+V+TTJEgfptPNMf+pM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjtGFuIIo8h5DkGLZhC6LhQBe6joEGoWtzoGBCWIoaHI9tQrdVzguWXPIigQazwKdlrYt4+f5AFfSOCDQYNlrq/puQH6c7nE4pcUEG8ltKR+QI+kfhOwIyVEKU+UlQQTpEwOn8dpNtAGzsxdQ/JQuLX72SArcr3Y19mooz6t4SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2GSgfRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26C7C4CED0
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 12:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731931693;
	bh=71lS8hQ0kTzOSToCRJa1KXGzs+V+TTJEgfptPNMf+pM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r2GSgfRx73m8dG/RYxRFRBOH7G96R4oz+IQDIvdl0S5cOiNA5hVpBmbPPKqX0TWiK
	 Gfo73vKMC7W6RFV8cqIKW+DErhl/3m0krhOnxMFKWqdEU3PxP+AZ8W+nWkMIZmIwsd
	 grWrLEi30/PEB4OJveP/oOXo6oYqIGj6mnhGIHvGWEPB9zbn8OdMsLdKCQ1ScdGfxl
	 lLfdEVLRW+rrzOXOFSzwJxKqIOwQOKZiTP7nUIO9e2fkc74BMsz8uE8/7/y7uKDgA1
	 P4zm9lR20bisRZKgDSyUJRGTSjr7D2ZYURMEe31TiNwIMIpEyP5l3NY/LuDqB+e9p/
	 /kYP1B7xdAZHQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-295d27f9fc9so1000767fac.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 04:08:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWmWWEz8fTEbFeOtAeE9YIjCemeOCPGSQbXFykxQeQ/njAwmV7VU+A/HBHoXpd9SfKmVE6GU+RrO5UoO4R1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk6edeYyneUVgu4SSgnLIEggpB1zoq5ERBbg+A+kspXK04MIpS
	sv9iJK/siBxeQOKuAeZKszhIWJI18Apokdwdc0v8jRJszZo64IbRGrQGx5oeAZJ745Q1PED4HsY
	cF1UG1iOyCfusy3u5gx9q4Z2DCz8=
X-Google-Smtp-Source: AGHT+IEtmkGeZKpbNT8KqoeYqpWihttibUnHkl0C8oBp8L0Q8S3yiO1/gt5Wbi3s4U+37PhiV4Y3uuy56UoqZfmH9i4=
X-Received: by 2002:a05:6870:a105:b0:278:8fe:6293 with SMTP id
 586e51a60fabf-2962dcd3385mr8925446fac.1.1731931692763; Mon, 18 Nov 2024
 04:08:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB6316B385B7AE35C20C574B4481272@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB6316B385B7AE35C20C574B4481272@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 18 Nov 2024 21:08:01 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-JAe0g8ASrPyy_yYgQHXHkoQmSPcgdQHinQRqgm1hh_A@mail.gmail.com>
Message-ID: <CAKYAXd-JAe0g8ASrPyy_yYgQHXHkoQmSPcgdQHinQRqgm1hh_A@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] exfat: reduce FAT chain traversal
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 11:01=E2=80=AFAM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> This patch set is designed to reduce FAT traversal, it includes the
> patch to implement this feature as well as the patches to optimize and
> clean up the code to facilitate the implementation of this feature.
>
> Changes for v3:
>   - [2/7] add this new patch.
>   - [3/7] use macro instead of function.
>
> Changes for v2:
>   - [6/6] add inline descriptions for 'dir' and 'entry' in
>     'struct exfat_dir_entry' and 'struct exfat_inode_info'.
>
> Yuezhang Mo (7):
>   exfat: remove unnecessary read entry in __exfat_rename()
>   exfat: rename argument name for exfat_move_file and exfat_rename_file
>   exfat: add exfat_get_dentry_set_by_ei() helper
>   exfat: move exfat_chain_set() out of __exfat_resolve_path()
>   exfat: remove argument 'p_dir' from exfat_add_entry()
>   exfat: code cleanup for exfat_readdir()
>   exfat: reduce FAT chain traversal
Applied them to #dev.
Thanks!

>
>  fs/exfat/dir.c      |  29 ++------
>  fs/exfat/exfat_fs.h |   6 ++
>  fs/exfat/inode.c    |   2 +-
>  fs/exfat/namei.c    | 173 +++++++++++++++++++-------------------------
>  4 files changed, 86 insertions(+), 124 deletions(-)
>
> --
> 2.43.0
>

