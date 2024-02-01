Return-Path: <linux-fsdevel+bounces-9792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 236C4844F35
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 03:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F641F29A50
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 02:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C7A376E6;
	Thu,  1 Feb 2024 02:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaR0XplI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D342101D2;
	Thu,  1 Feb 2024 02:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706755207; cv=none; b=us7G+NOJrYNeZtXh6O16+rfIv5mftKrLiUkvMOx/gCEbO80mEOEjCSeXCgy0QI1Sj9wQjIrobbSDgGyk3xExaemfpNg8tfn1QM2mw5VVkv1KXqKYyUkg5/JwS5PaVXjQvKzrabSCndvSFQs7lj+cI1MChuQPWYlkZRWRw5/RgUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706755207; c=relaxed/simple;
	bh=LPpZdySx2W/ZIxGVAEs34b1jtJV9q9VGPAnbd7UvT+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArKic/oKz7z7oAPmAxk77K6sdU335/zWikWkpuRbkuYFEiJX4LDBVpJJwbHS0wOWJrv7F+TTG4PEE3bG6UgknCZHAn+1UbH1OZXtUsiivwm0nPdJs57vGhe7GdbVL2jv1MyIFtT0/FVUxqwVljOLoqhMeuQE7FbhS3qbBphdlRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaR0XplI; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-511234430a4so683559e87.3;
        Wed, 31 Jan 2024 18:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706755203; x=1707360003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXWwSoZre+3koEZnxFdbxmNFgGH19wNuOnkGx1zO/uo=;
        b=VaR0XplIH/0m+a3msiUn/1QKoOKjnoJoLNsI/tYCscCPKiiuQFzSQ6oNfLQAuu+TKf
         ebR99ReLfy8UtoEwAPNpqWcKTQznVeMOAuZ5ctKd7ml2JbY5UJfoIBT7kOE9fKurS1Z3
         2z92KbgADy4WAUVow4KwYh30oJaAm3lYY1c2Aaijwvcrm7Nw7e0/Ngve4MbYnct0tZ3U
         ghv4aDP8dFMWUt4cTP5ou1RLTTqgUgKj+FDgkFYhd3WGnp+8wP/BnIAtJsXisrWMW/7I
         SqDJdi20LClFGhkP5X3ae+RVqNHaK7pRUBs7OigdEDhZv8SjOhDAtMB/uM3NwSvzIhCe
         NhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706755203; x=1707360003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXWwSoZre+3koEZnxFdbxmNFgGH19wNuOnkGx1zO/uo=;
        b=Q6+nG+BwMopuraGEBQWzR/7nHLSJ9ZdbIwe3J4E4D9kRW0y2IcnkNDjE+k/DpHTltb
         D8jLF1jNxI4K824ebvkst+KWWziCSsn44f6PN/wgGhKzEXGsWB6tzLcOt7VWhY5Yg2j+
         h8XeAtaMOF/IuoLqEmpOCuGfX8FyAvU5Lqh3Iv97Bcw0DRSw4VMARN+bnYzaRZW/0pjO
         pcmHy0e36zSlub3gj94N7YlKn1vpF1yvZpbBfLvAy+EBlt9+ZhMlC8AuAI/RCFZJRsMj
         O1Yu02I7o3hvn6+J1lV7G0udC5+i9/872sXctJtwJV/DHw5ffMF1+bE74Ruohw7AtodS
         +A6Q==
X-Gm-Message-State: AOJu0YzZRvdV2aDW4DASJAA+hDbOMbvIJN57gug3Kdd8PR2j/5ewt0bz
	bhkzT85Y90rY/I/Sjx2w5BEwWa9UwI3d0L3rFZKQDF3xmD3HUSkzitMxiNsQvDMqX7ZqZCNhRWY
	oPebrFZ6D5z2HcLfYMtBE5yo5MDk=
X-Google-Smtp-Source: AGHT+IHhiubWEPUZz6obhjsoWIzt66BkqGcoVMY/N2K7pJstetjvqMcWLLVQcprzBQwAdKduriiDI+IglB8rF/dJCRk=
X-Received: by 2002:ac2:4d10:0:b0:510:e05:435a with SMTP id
 r16-20020ac24d10000000b005100e05435amr759072lfi.26.1706755203061; Wed, 31 Jan
 2024 18:40:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131105912.3849767-1-zhaoyang.huang@unisoc.com> <ZbpJqYvkoGM7fvbC@casper.infradead.org>
In-Reply-To: <ZbpJqYvkoGM7fvbC@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 1 Feb 2024 10:39:51 +0800
Message-ID: <CAGWkznGLt-T1S7_BM8-2eLhxVYktYYLmdfMbRKRK88Ami-mEdg@mail.gmail.com>
Subject: Re: [PATCHv6 1/1] block: introduce content activity based ioprio
To: Matthew Wilcox <willy@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Yu Zhao <yuzhao@google.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <niklas.cassel@wdc.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Hannes Reinecke <hare@suse.de>, Linus Walleij <linus.walleij@linaro.org>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:23=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Jan 31, 2024 at 06:59:12PM +0800, zhaoyang.huang wrote:
> > change of v6: replace the macro of bio_add_xxx by submit_bio which
> >               iterating the bio_vec before launching bio to block layer
>
> Still wrong.
I did some research on bio operations in the system and state my
understanding here. I would like to have you review it and give me
more details of the fault. thanks

1. REQ_OP_ZONE_xxx
a. These operations are from driver/block layer/fs where we can keep
driver/block layer using the legacy submit_bio by not including
act_prio.h.
b. most of fs's REQ_OP_ZONE_xxx will be handled by blkdev_zone_mgmt
which is the same as 'a'
c. __submit_zone_reset_cmd within f2fs use no page for REQ_OP_ZONE_RESET

2. other REQ_OP_<none>_READ/WRITE except REQ_OP_ZONE_xxx
These operations all comes from driver and block layer as same as 1.a

3. direct_io
keep fs/direct-io.c and fs/iomap/direct-io.c using legacy submit_bio

4. metadata, dentry
Are these data also file pages?

5. normal REQ_OP_READ/WRITE/SYNC
fs choose to use act based submit_bio by including act_ioprio.h in
corresponding c file

