Return-Path: <linux-fsdevel+bounces-62614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3DBB9B1A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 19:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3354C0C58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 17:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5043D3043B0;
	Wed, 24 Sep 2025 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1aUKMqw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C531C6FF6
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735949; cv=none; b=TfiHPqdDBwzxq57Kt3yv0nlYZCCnpYv+EFELzHZyn/aJUaXVPScpwZa2KhU1Dh/fBvQTfcqkhTJ6Fg5q2yuEa0T4X2BBbAnBhitg7G3O5LvH1/h5dp3zt/XcKqSXkFXXQ4UQnsHNEE06AwySU0QhY7L4ZhrEci4tnSHF/cvx9jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735949; c=relaxed/simple;
	bh=jQs4oTNCc/XJnYiW4A2/lwE3nYRFZTsk7teTmHwjil0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nd6tkHVeTkjiYj8IO3i4JH4gfqSCbTfEUr+Cl3Fc9bRge3d3o3GNklz0r4Vk1SRlbNAQ6SGPn/IG1EOr7Cb1yVxoCiNc8woxMzK1IPzVGs56v01qXkVjb9PNtZf7K40d1B0FAmz48VI1T3tdN8uRKJIqD33b0GdBgKwZllNTgsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1aUKMqw; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4da7a3d0402so689251cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758735947; x=1759340747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXrXQ+GWO/KKTG12KIxhd5u/xeio6mqGVic1Y1gfljI=;
        b=S1aUKMqwvrkwbFdAZy0DhunW4g69GZbBGE1B+zjOrl66reWyp8SVtBnb+I1Vg+8K0T
         Q2h5IbkVdmLn2qxhHnanJEzU1vVIacKSDBMkW2kUx/dtjdaQKFXbaNK7l4cnxwljv5g6
         YBeeRTrEtnxaKgIQgIcx5ZFTcQMJb92qEwX1YSImYj2AOTcPFp4LH4cI+P76XAfeEgeO
         wuGWGbXZfzmOny+3w9mnoXU2ywJKm0HxHUQ36R6rdYJZs0if2ZHpE2uaDQxOHL1oMEFA
         fAi8Cx2Ey89UT0Dic2W69oT54E/To1vz4fGlJLUaXx7wi9D/fFf4XR/uSkIPiypXVO2c
         j/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758735947; x=1759340747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXrXQ+GWO/KKTG12KIxhd5u/xeio6mqGVic1Y1gfljI=;
        b=fotEJT+ZtxjTjaUaVdycTdV76zSlW5mfZ2i2bUz4hr7w73jfNpLZCLybY9U/Q1jMrJ
         hTP/p+c4Q1D3oyEOpD3TQolXnb6ZN3/0a1NwbeUvcr14YZ5LfmpgeOCdnAvOkV21GKCJ
         zOnRfBrhL/wqn8yOWx1GJDrR15gqAt64syEZ5+cbl/nCzTwvhqOdtdNC071hIXKJ78CQ
         R/9bodQsz7OkTLFd+O0miNEvEXxlBOqK8nll0Askof1BgBMFvj9BRD8bx7+6oI5YCKjq
         IFhl+0vGt8TJKYAIL8pArpLyuhLIIOjAvpFTkOHAfEJL8MWQ4v4y9VdOaRI2aa27O7CL
         pIGA==
X-Forwarded-Encrypted: i=1; AJvYcCX93kNT5K9z238eNQCfz5aQW6Ajlvz2jTocOPcXWHtdNtNTcuALYLP5eYD2G7UAzBIyHV36C50iZ4X5R6zl@vger.kernel.org
X-Gm-Message-State: AOJu0YwfaLo7W6ghQPgROZDYlx4AxASEw12FPCyA2nBNoctGDOtuaLb5
	fwvk2+HxerWvOTrsKUuzmFGOAhAiYngtA+dJ5A2N+7VX51hE1nbteeMsTa1zdPnUkQW1m6957jE
	cTqhvw+/t88dwOGR4oGWLXAXU/RF3CBU=
X-Gm-Gg: ASbGncuQCeq+aI94Ce31ghS4rOZXIVR3V+x55PGH8VtoHUnXNLu/AnAgvIE/8Rc0GIq
	p+M7s8UoyOfuCbBu3Gt6AcaX6xcI1y9zTWNYXBqcKFW/gEKRjEgKL3BUo26x8dY1dAIg5zYiO8P
	5tLIhL47+rwZMZugqHSssHJLTOgde1Ei/vqpONA3l8o6TH2ySWuqXOjE5E/TBCIUkR7pqEJyceg
	zn+H02gus8Bm5IlAx8PTwnCg5agbmFiY4BWZOks
X-Google-Smtp-Source: AGHT+IHIoMb+thlI3l24RCbT6wRUHYvUJaCVtftjqfA9V/ihxnjJUQaak72q/a27hLnqWe+K99LYRcj/cpIlmmqWv5A=
X-Received: by 2002:ac8:57c9:0:b0:4cb:9ad0:9978 with SMTP id
 d75a77b69052e-4da5d2577d7mr7875241cf.30.1758735946841; Wed, 24 Sep 2025
 10:45:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924091000.2987157-1-willy@infradead.org> <wuel5bsbfa7t5s6g6hgifgvkhuwpwiapgepq3no3gjftodiojc@savimjoqup56>
In-Reply-To: <wuel5bsbfa7t5s6g6hgifgvkhuwpwiapgepq3no3gjftodiojc@savimjoqup56>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 24 Sep 2025 10:45:35 -0700
X-Gm-Features: AS18NWABbguEvjKMtwKxWrjKRKO2hVdjHc_5Gs0GgKayZNBUtRDf0OQLZXbXQW0
Message-ID: <CAJnrk1YjoB4A_iS-VS1T059yNuVjm2hAAJJfnMAmXgLZwQyf=A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Defer evicting inodes to a workqueue
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 4:35=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 24-09-25 10:09:55, Matthew Wilcox (Oracle) wrote:
> > +++ b/fs/inode.c
> > @@ -883,6 +883,10 @@ void evict_inodes(struct super_block *sb)
>
> Why evict_inodes? I think you want prune_icache_sb() -> inode_lru_isolate=
()?

I think prune_dcache_sb() can lead to inode eviction in reclaim as
well (eg prune_dcache_sb() -> shrink_dentry_list() -> shrink_kill() ->
__dentry_kill() -> dentry_unlink_inode() -> evict()), so maybe this
should also be done there too.


Thanks,
Joanne
>
> >                         spin_unlock(&inode->i_lock);
> >                         continue;
> >                 }
> > +               if (in_reclaim() && (inode->i_state & I_DIRTY_ALL)) {

