Return-Path: <linux-fsdevel+bounces-14387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8491387BA98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 10:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B63901C20CD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 09:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9476D1A3;
	Thu, 14 Mar 2024 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DoZKLHqH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C256CDCF
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409128; cv=none; b=Y15pxB+Dl0IlB47RgenuZl8aH2verf7+RERi/PcqmsLL7Pac8Utvshr0WJh4+mNF5NHxEhufgv1C4L8Tpsrh3V/YksQboahqGD42WsPOAgd2nE43UrW64oJZEYy//vSRCh8lrKxXVsBOqqtAaaP58iHrxR6BlPQfRuoPni0Kvx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409128; c=relaxed/simple;
	bh=99jdUBguX0rRbr0EjMK/qjwxyH/ALk+EX4vPa6MmEgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnRt7MBfTS4bIZgafe+nd9I9nvkDFZycUxsNRCJNYI8yXpslYLALNmISn8al2wMQ4hEukNzOv4yvwxuJRA5LxEVSFv8w76FaaHeNBAmd9EL8Uhqgf7pR4mXSGhMxkTEKtl+16N4+9bNiLXufC205U5YnTY+OkkqSUdIQtrK52t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=DoZKLHqH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3122b70439so81441466b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 02:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710409124; x=1711013924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=99jdUBguX0rRbr0EjMK/qjwxyH/ALk+EX4vPa6MmEgM=;
        b=DoZKLHqHJjKooT7J4OCNGXuI/f8GMQXmFpBykZY+/C9fTvXOxcZEKiAoTGt/S8rt04
         yxflKBrpFbGo4FKn4+nrwDh3K8LqcvIb/i5CNcJ5XH9fYGyxa6FPxk/GA2O5zJMNaEBM
         KJnoscu1Y1vxqItcha1CJPd/4AY+j1q8B+PKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710409124; x=1711013924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99jdUBguX0rRbr0EjMK/qjwxyH/ALk+EX4vPa6MmEgM=;
        b=aj6wbTV6VfwcqwA/OYRsVNjCUBg+jxrmj1Pyrq2pV++2McliQ1hhQjq6+WStaL6/cz
         3FWr+iprArp/kxMn7IvRHUylxQtNIy5apDYhv8lAWYX1e6jj22Smii5QxjE2G8oxvdN5
         F8oDodbRKysS/N/gKirU+Zm0PyLRTU7ACYfxW+rc5KjXvnLufxMUZcNB8AfbFxEdL+HG
         +5Hhq1NrLkBUGbiOsl7W2axMDZqLL4yt9nkap0koKtF+Q0Siu1M/KC2Ry6P9leOqYtxY
         gZtD2PcQn5rxyryJAyIMxUvj0XMoDUyKR81+hOerB8UnbV7dYQnTfy/fiGR1hziZrA0N
         gEEA==
X-Gm-Message-State: AOJu0YyL/bvYks4GoGVTmASmgZoIbPoegQAjLY1X/evXyw3pDmoVvyk2
	GoxT0t5fgI0CW14VFUs5AYVkCsyplGW59HIj+qGE5IcOPPH7jZSZiR13LQNlOMJ9DWguegrK+ex
	WO0oqg/Q4/XsS7MmZy5+4+CDkddsOi7aoEqxFXA==
X-Google-Smtp-Source: AGHT+IFJydnHavfoQj7GUYh55PHRwLEm1dCHo24SSZNO/gRuXbw54y6GXsBk03f130OZZShAe0+mXoV5Dw6q3SS+Q8U=
X-Received: by 2002:a17:907:6b88:b0:a46:7183:14ff with SMTP id
 rg8-20020a1709076b8800b00a46718314ffmr827861ejc.48.1710409124273; Thu, 14 Mar
 2024 02:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000043c5e70613882ad1@google.com> <CAOQ4uxjtkRns4_EiradMnRUd6xAkqevTiYZZ61oVh7yDzBn_-g@mail.gmail.com>
In-Reply-To: <CAOQ4uxjtkRns4_EiradMnRUd6xAkqevTiYZZ61oVh7yDzBn_-g@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Mar 2024 10:38:33 +0100
Message-ID: <CAJfpegu8Rjj1cHkB6JD=TY1CWuVaH8YpSRLQe0cOfG9aQXj6Vw@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] WARNING in ovl_copy_up_file
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+3abd99031b42acf367ef@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Mar 2024 at 21:55, Amir Goldstein <amir73il@gmail.com> wrote:

> The WARN_ON that I put in ovl_verify_area() may be too harsh.
> I think they can happen if lower file is changed (i_size) while file is being
> copied up after reading i_size into the copy length and this could be
> the case with this syzbot reproducer that keeps mounting overlayfs
> instances over same path.
>
> Should probably demote those WARN_ON to just returning EIO?

Sounds good.

Thanks,
Miklos

