Return-Path: <linux-fsdevel+bounces-57488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C0AB22126
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 10:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF5F1B6397F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 08:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9B12E9756;
	Tue, 12 Aug 2025 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="n3vQfNmH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9822E283D
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987277; cv=none; b=M+OJHDo9CV2SfLhRhXz+3PltCnUw+fa7uLT+fmq3gvxD0pO9oliLwC9ahJaItTQJvi2GZqVwo3t9GLpC0Uqto9m5gfl6g3gXNUjMStIEQ34Os2yxLGJig07NV4kLTYoGT/scuNdE6ILLB0bpUhM2YMjTvI5YpEpdWGqcie/7IbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987277; c=relaxed/simple;
	bh=p84/JH6ujUXADoU7F1v/k7vE0fdq1DxNOncd6ZeLHYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F45B5zU9hj92YR6CnIu7bNor7hUHtBGm9OcqQfjemd6IqWB/cyVhqarff0WFp1uTZpWGUEaBXTTm8jECq3jb6gfJ1f6KU/+IVKJWTg6GfhrhxogHLslf/lWSIR4fexo9n5CPv7dQqYxG1ep9pZKUpUlu7B+wNznycNbjUlfkUG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=n3vQfNmH; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b08c56d838so71132311cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 01:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1754987273; x=1755592073; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1iYAnIreCDHpg5Mzl3mEVvIUTo7Ej1EmgvdEUIQ6TiQ=;
        b=n3vQfNmHMM0tCkc6R6l33lrLuCfAR4aO8fVFW1N+f5XmyFOXTG+yb3Ce0Pswpm7kSD
         6Y+dqFr+5Dur1dICcTT7tVnBmIXDfuuVC3TVxGRrgFjOlz2EDlKHlUOHUpovNvNssVNh
         XUHtklv21qGXbqcT8P2jNz3aXh2W0Jz+geNaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987273; x=1755592073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1iYAnIreCDHpg5Mzl3mEVvIUTo7Ej1EmgvdEUIQ6TiQ=;
        b=cr2mrZrLL0VS0l+44ccLkTiRrgsrJHPlQy1V7P+34gda21bLELypL0LHNju//fLFnn
         QjhRxYcSQ8CnWBcshNVL7ibXlLqeGKPKd14EEMP/+ZOhaAeqWASnWvb4BsD7s8uqQzUM
         sOwTuJjBC1uOLPHTrq7jMj1Lz3qWyKc8P8NVpBffcvVJ1+nHbRIiAs1u8fLJp099WYbS
         TiSDpmnDy/+7Yr6kL84EgTXW8zTmLrhz7zMyzrxRJwdB0AkAdg3XyrVaiIF3ymBI0Sm2
         f4v/9AHQeyCn04uPYtyb5Ebtv8JSA3/wC53si6yhsxicxcAhHAMlfwO+Fm7oVLLueED0
         MUuw==
X-Forwarded-Encrypted: i=1; AJvYcCVjhzn5rgg8rnrxsPWCz7gao0ynKq/SuNXF3eQnV7kCQ1KF8X7kBDqIbjd0OR5kgqUo8QertF2uu33FnRLZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyYzqOdqjzNLZEtgw200QT1HGBizrlR8A3vxZ+QcBcxZ9KTQ9bl
	GWqbnv7pxCwINSBrnphNEcSO5sioR5UfESHP0HyDW0GFP5wLOy53ID9SLl9xFxn27dPrwBzxrUS
	4ObmYU7BlZnBJs7HW5IUG+Y12vs2lrEgatZVli3wN+A==
X-Gm-Gg: ASbGncsexIBoi0clxp2SogF+UUpwo58eSEBmd3MBfcKzaDzT98SqhqdnAsYUehpETdO
	wWuylzLHMZ98eI8faucONG/yAqiAGYzH28AiA6t+RvJAHt5+eGkwfl0nukxI9BsnODgiqyrG9DQ
	RdOg2w/lWyKC0IoQ+yZ1Y1Co6yGYaYymK7ZmG0fESBU/gti7g+Vt7xIDyyukzCJsSbq4lXXr5em
	0dv
X-Google-Smtp-Source: AGHT+IHhKn6FMwffxsQP6b/eSz87NPzoagmw4rkRbgqDATPA0jZycxCJi4NLu12p8z01OSGS/kQfqc7JlneEYVLOihU=
X-Received: by 2002:ac8:7f16:0:b0:4b0:77c1:1042 with SMTP id
 d75a77b69052e-4b0ec87e630mr38876421cf.0.1754987272938; Tue, 12 Aug 2025
 01:27:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807175015.515192-1-joannelkoong@gmail.com>
In-Reply-To: <20250807175015.515192-1-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Aug 2025 10:27:41 +0200
X-Gm-Features: Ac12FXwonsREqvftcM-jFbI4rom0I55iJ_RI2IafmdmNYIdw_YfNyT8eLKTLP9Y
Message-ID: <CAJfpeguCOxeVX88_zPd1hqziB_C+tmfuDhZP5qO2nKmnb-dTUA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: keep inode->i_blkbits constant
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Aug 2025 at 19:51, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> With fuse now using iomap for writeback handling, inode blkbits changes
> are problematic because iomap relies on inode->i_blkbits for its
> internal bitmap logic. Currently we change inode->i_blkbits in fuse to
> match the attr->blksize value passed in by the server.
>
> This commit keeps inode->i_blkbits constant in fuse. Any attr->blksize
> values passed in by the server will not update inode->i_blkbits. The
> client-side behavior for stat is unaffected, stat will still reflect the
> blocksize passed in by the server.

Not quite.  You also need to save ilog2(attr->blksize) in
fi->orig_i_blkbits and restore it after calling generic_fillattr() in
fuse_update_get_attr() just like it's done for i_mode and i_ino.

Thanks,
Miklos

