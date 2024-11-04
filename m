Return-Path: <linux-fsdevel+bounces-33626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CE89BBAA7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 17:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6AE81C22868
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 16:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717531C4A07;
	Mon,  4 Nov 2024 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0rYMgms"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762AB1369B6;
	Mon,  4 Nov 2024 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739305; cv=none; b=iDwSmD2/HQYTsjX+Hky3OXhrC+G8tqZ9E1IQuU8u5ZDFS9XbGir1+vJkVch29lNp4Lya3YATi6VlkkxVdynsCjgVvMNcpUaOQpZq3nU1e/hCwcOdmftm6jVudeshiAslCGApFb00ol2dRsa06Ir1c2wpe2ame4xT8PnHzs5JDR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739305; c=relaxed/simple;
	bh=Q418ja8tsDXOC77mCOfPiqTbO2OPtGirjJ5OAUF3zK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kxui2FFzp3Y/gRnaILcFJ5TXmkO2P2cf+fuokPLjgBIWaxe3xfOVU7HDbLTlEV7i25Y4wzHYdLZckUBcnvYNQrDVC8qlAp3HpQ1SLTmmM+8E3vtIFnocGr/tydW2l7J8pYMG98wRQzx+juR8S4/JvnPC0y7Elgt9+Z3uxjbILds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0rYMgms; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e2e2baf1087so4088118276.2;
        Mon, 04 Nov 2024 08:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730739303; x=1731344103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5XUR73A1EB/lY4KCXHBgQkAI6e2s9ail780Z/58ik38=;
        b=P0rYMgmsHK66YDMRRBhA3So7Zc4EyqYpfGx7QNlji5S/vCHoI8JpUoJji2zvDTWW7c
         TVogSbCuGyw23pWyjU/SKt6tiGU0hNV36Kn/Dt+AU135YdroJ/pDIjRepNMmcJxfJkrq
         e+O5uJvwEKtWsWzqfUHsO5z5jRkw/SAl+QgxLzgSQxSK2XiAmIbfoxNYg27+9+6pXCOG
         Mg+WRJyf8pJ5BRpWUWwMvfLWIIedNhSZoDTpyEN/dHAt7Ve4Fw/tBSGw4h7QQ1Cm9vuc
         xS8yp7SgGvRuIg6HSmnITUir4T22JiEaK6ssxm+QzRXuAzvenFzaXEhenFVLKPHi+CBG
         1XBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730739303; x=1731344103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XUR73A1EB/lY4KCXHBgQkAI6e2s9ail780Z/58ik38=;
        b=gcoDBETKnZSpXLPwO4vqSUybjHiTDCsh5DsmzIrkNNbeNDMTP5oijReX0dxPVQZSSl
         VGdYEXgjgqpQfHbw99xHzCcvvfdpAZyZgWTANzg/zl7jFpKJ2+iwJaqcMyoSLe0yr1mZ
         jg/4c5zsU4nLYF8XZNpAjK2ASwalGmv56xIM7j1vzH5kleElQvwXv+TiXt+NnUAcBWyN
         WRznCJ3rSQt8pvPCLPM0hcBrQNk7ttuHfLPzg8rI/VGDS9y3X/FnwfOoKapP1f3qXbXe
         7/UvADcFT/QiQ5aY44H3ZE06bNTskLIxdBCMbcMy+lzDmJa9pfJkbaOFeRqmKpx3+qUE
         ljmA==
X-Forwarded-Encrypted: i=1; AJvYcCU4HlUPV1NLKKYJNKXWB0C8U9cCKcDzK7Ux1KGY4a0Amd4WPIyz2Y63foFfgKEKXyI7f0yiqDeePHlseZMR@vger.kernel.org, AJvYcCUW0/e8mEf8BqpdaiVOCJYmtUDES8Wv4E1hYtUlL+E9xTzlFgUaK+O/tqfU3wfNc7DFjoemyxOQfUw7QSlY@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ0h/6VoVWc6gG71cNDnQGW81UK1/Qpp+0MN78pjFN/JlRs0e3
	/qMHgokMcJTXSjrpbWuwhQFRrgZV+t4SqDZ40vZ0svrolmm7eI9ATieTdbIBbMOLnC9Zs0fjr9r
	oGO8Xni1D8IRC0aUGJKq7hLhb97c=
X-Google-Smtp-Source: AGHT+IFgabJY3MlOmUkApTX3tWXYiMzEsG7DXQ/HOHo3g9GdH/NAinuHn7PyooNEfFQpKUj0Nkzm7FZ9+4at9ONwxwE=
X-Received: by 2002:a05:690c:690c:b0:6e2:a129:1623 with SMTP id
 00721157ae682-6ea64be680dmr130287777b3.38.1730739303448; Mon, 04 Nov 2024
 08:55:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104084240.301877-1-danielyangkang@gmail.com> <20241104120615.ggsn7g2gblw73c5l@quack3>
In-Reply-To: <20241104120615.ggsn7g2gblw73c5l@quack3>
From: Daniel Yang <danielyangkang@gmail.com>
Date: Mon, 4 Nov 2024 08:54:27 -0800
Message-ID: <CAGiJo8RrxaUfLhk1LWPk_iDB+XJc0=gMoKXcxAS02qyqHVxJ_Q@mail.gmail.com>
Subject: Re: [PATCH] fix: general protection fault in iter_file_splice_write
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

> > -                             pipe_buf_release(pipe, buf);
> > +                             if (buf->ops)
> > +                                     pipe_buf_release(pipe, buf);
>
> Umm, already released pipe buf? How would it get here?

If you're talking about the pipe_buf_release before the if statement,
that line is a - not a + so I basically just added the if statement
before release to check that buf->ops does not get deterrences in
pipe_buf_release while null. It's the same two lines as when pipe is
released in splice_direct_to_actor.

> We have filled the
> buffers shortly before so IMHO it indicates some deeper problem. Can you
> please explain a bit more?

I just worked off of this crash log:
https://syzkaller.appspot.com/text?tag=CrashReport&x=16adfaa7980000

If the buffer is filled before, does that mean the issue would be in
do_send_file or do_splice_direct?

