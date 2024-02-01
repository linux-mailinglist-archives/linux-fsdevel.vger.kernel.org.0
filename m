Return-Path: <linux-fsdevel+bounces-9904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 522FA845D98
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E231C267F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D60468C;
	Thu,  1 Feb 2024 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgY3T2Td"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0674F1FDB
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806015; cv=none; b=NAd5PiUGVsLLA2WByjel1sWTQlDzZskthrPgk2YUMD2LlGjPgBj6sR8uov056G0HVUonnm6docBYfb42q7HJpHhI26PEGQS/Gxy5jq6o+HrCBerhv0ypHDj2h6i0U6Y4MRY2TejDx6w9AZJxm1krlYIqXQgnfWXeH03qsois28c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806015; c=relaxed/simple;
	bh=VpRZoKZNX4nHqFqpOcbZO948o0DHKiW63SZjzY/SxOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5xGLKUBGYckuJQwjaNwaYtkbhlXmUF8ID2hk7DPQMJA7s2cTUIo/97tdsZHUtuTbjLXReGP5n+zgNQETZFaQITzAeP7hDOuZZ/5Ivw7u62oq9TR6dLJw/JPhSlKNO30Drd/9Ixy1Pq/n2TK+8wNF3TVg0kqGMMWu6pHV8G8Kng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgY3T2Td; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68c35bf7523so5609676d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 08:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706806013; x=1707410813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpRZoKZNX4nHqFqpOcbZO948o0DHKiW63SZjzY/SxOg=;
        b=TgY3T2TdG9YafeH/05NCmv6Uv7N0WiisAOcgO+mU8lFBZJvn+tSk16Yx9PPRcUZPYA
         D/ojYrJ0To4Uc7EziMeJFGoLZPgwa6rQq6LT/B20wGh2jIjade20LlJCOWwvHA0Nj9zM
         xk3Rj6J1IswFzkKpz5DRP+gHT1CYwOoTWiPvwZeNPNeW6OQQp20+YKPpNoms+gU1kgA2
         kD5vAaAYoIxDEJg7cjFp3SKTd8OYb6NAgLiMsOXzK8xZTZRnH4A9qpSzuPijNZ6hc7z+
         QQIqYlbcMqgwGnW9KkO5BwpFbkB+B651BwgjTVLZP86uTqP3njUJ5tAQBoxo3knHo061
         HzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706806013; x=1707410813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpRZoKZNX4nHqFqpOcbZO948o0DHKiW63SZjzY/SxOg=;
        b=iVmcTqVFO8H0mUxlM839ryO0xvQhx72UosreHnWk6NXqPnAyJaPcJQ9idie9CqYNQA
         AKKoe7F+o/Gk3IMZOm4lki5Ya82lIMie5KvGdY1Avu9OuJOwxrfBsZCYV9ARwZbFHHzw
         +ZRQjDlKn9LilKFNiSj4Pve1Xz+ojjKPZhgXRmhA+lwdSeacra8DdICRV4fnUg2BXLdC
         34pw88h+qC2RJYI1ft+Fm1bEo9Bqu4H9WooRqnHL4v3fIpI/987TrGFxeq09anp7Mgir
         NHYfl4gxkLqFMMVUHmfGqH9C9yV1hxgLXaq6kslDxSP4tpWSeAcV9LoXNe2iAO/Y6KP3
         ncAA==
X-Gm-Message-State: AOJu0YxQAtrmE5fwi+sn3PW2/Yc+ceeX5wTdvCVJdK7YzzPAbLsvExxV
	YhqpJ4RXeLvImU2nwcbw9x8ICSBszc+MCdfE5MG7gf6PTF11CQrDF1cuGsRCrfQX/lWZvpQfTUz
	Fxdx7LLSAxX5CNsc8kMY0emXVeqY=
X-Google-Smtp-Source: AGHT+IFKZ4Hm7QFkBOenQSycvzMDjrcBp7SVJN9p1dBrW3i1XEVgVzq2SaD7/hsk888Mqnf1Lwo0pBupi+73GDvp1oU=
X-Received: by 2002:ad4:5aa4:0:b0:68c:6a65:895f with SMTP id
 u4-20020ad45aa4000000b0068c6a65895fmr6438346qvg.10.1706806012813; Thu, 01 Feb
 2024 08:46:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <20240131230827.207552-5-bschubert@ddn.com>
 <CAJfpeguF0ENfGJHYH5Q5o4gMZu96jjB4Ax4Q2+78DEP3jBrxCQ@mail.gmail.com>
 <CAOQ4uxgv67njK9CvbUfdqF8WV_cFzrnaHdPB6-qiQuKNEDvvwA@mail.gmail.com>
 <CAJfpegupKaeLX_-G-DqR0afC1JsT21Akm6TeMK9Ugi6MBh3fMA@mail.gmail.com>
 <CAOQ4uxiXEc-p7JY03RH2hJg7d+R1EtwGdBowTkOuaT9Ps_On8Q@mail.gmail.com> <CAJfpegs4hQg93Dariy5hz4bsxiFKoRuLsB5aRO4S6iiu6_DAKw@mail.gmail.com>
In-Reply-To: <CAJfpegs4hQg93Dariy5hz4bsxiFKoRuLsB5aRO4S6iiu6_DAKw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Feb 2024 18:46:41 +0200
Message-ID: <CAOQ4uxhNS81=Fry+K6dF45ab==Y4ijpWUkUmvpf2E1hJrkzC3w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] fuse: prepare for failing open response
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, dsingh@ddn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 12:51=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 1 Feb 2024 at 11:41, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > I was considering splitting fuse_finish_open() to the first part that
> > can fail and the "finally" part that deals with attributes, but seeing
> > that this entire chunk of atomic_o_trunc code in fuse_finish_open()
> > is never relevant to atomic_open(), I'd rather just move it out
> > into fuse_open_common() which has loads of other code related to
> > atomic_o_trunc anyway?
>
> Yep.

FWIW, I pushed some cleanups to:

https://github.com/amir73il/linux/commits/fuse_io_mode-wip/

* e71b0c0356c8 - (github/fuse_io_mode-wip) fuse: introduce inode io modes
* 081ddd63a9ff - fuse: prepare for failing open response
* 437b84a47a8a - fuse: allocate ff->release_args only if release is needed
* e2df18f9a3d6 - fuse: factor out helper fuse_truncate_update_attr()

e2df18f9a3d6 is the O_TRUNC change discussed above.
437b84a47a8a gets rid of the isdir argument to fuse_file_put(), so this
one liner that you disliked is gone.

I will see if I can also get the opendir separation cleanup done.

Thanks,
Amir.

