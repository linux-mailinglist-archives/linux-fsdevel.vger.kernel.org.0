Return-Path: <linux-fsdevel+bounces-20506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07308D4631
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 09:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83228B22CB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 07:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70EB4D8B9;
	Thu, 30 May 2024 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECLs8GzH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5C3168BD;
	Thu, 30 May 2024 07:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717054674; cv=none; b=fH183GKnLQ23f7YIDOdxiUSh5IieocmOBq9e0fmZFKwf1TB/cF4KRkWs7BM6XSnoJGsYBmXdWn9jQtivJhuKqALGUWmH1vj7kFUndT8BQJf0IUCQyeEKI3KzRNQOYpqnQgpJ2azNfGbVzLV354GivxeqneMQTyajKxrWGYmML4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717054674; c=relaxed/simple;
	bh=gFvPGd/GOwdbWalVNT4aW5mjXz8rzEAiL3wltYmPa6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PF3a1BmX2G5hYozQ09WNUYpMoCWI2H4nxrtk11SzSlkTIKP9O46klcUEsgl2ikAwqKijuVfS51e2HqnwG9EjNrJJntLlflPgD432t9xW6oAPnCsoi4636DgDZfbSBbZdGottX3nbVG0drjslZNJo81KiBsUYH0nkM3bhJ8ioGLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECLs8GzH; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ae259b1c87so432776d6.1;
        Thu, 30 May 2024 00:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717054671; x=1717659471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=550m7jm8I2c4tBa/pg01mJQwXAb2hba6vqvQBtGQrp0=;
        b=ECLs8GzHZB1didcuXiNWDyZUwVKcFZSeS1mSGNeEzL7Z07RH3WvSWrYUW+/D3l/OFo
         EA5Divt8Wl8OUMp0qiCV3+ZM+gHzHEPAYTLH0MGfdvSf3sfz2PM6q2O8gHVDwhYVJAO4
         sBvgh3tqLyPnKV8tino9njMhyfoCdEt2Bj/HWNTGA+sCvoHOHbngQ7pZWk4Q1m9wZeZx
         tk3af+91igHMvdCtcxf0FB4nbN5RR+vb9+fo82IuKazo9/0KRE5U8N9HYPhkJXw7en18
         ZlA7bMoNh7Xni1LdBImwdcKFGUb7CJ2y75GF4oZoYy3L4JzkgrKLPboY5abBwSe38pHG
         cy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717054671; x=1717659471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=550m7jm8I2c4tBa/pg01mJQwXAb2hba6vqvQBtGQrp0=;
        b=gPDi99NuXMOnZS6fDITnCnEDFsrxeKU0JpvgduN9Ti60RvqQSwfcHWuVFE+x0VFHI7
         vgKeaqCfo2BXkjDkIfqApT8vVY3JhrCRmbbDHQooj343mWIOsmH3YKGPFP171qHT5jxb
         WaYH1dZAjlUg5wexSKkc626dzakeaGhPuc3maecyoRwr8cpQ3mBcssFsGl7lWxw+xe7N
         EoEka3HoQaA3Az9eMTc8dVVTZkvuDFM1UOdZXM7tD+KnOQRerCs66s2f8oYgkfUfTiik
         RlGOEHnUz/IU53KDarBg22YHShanw9vHQzC7ZQ5wupWSAlTHygxUbm6bj77B8H1TX71Z
         yi1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeTYjoL4QOK9MxL2t/gSj/IofTiNeKbupavQwlNWWj4Lr+NgKORvnFueF8yPEjwwGBByHcZC1AM3L9hzV5gZ0tja1RRdcML9IO3vU+Q0sD7Wq+ns87/rea8js/cyYCmlceqMvhutFRUeybLA==
X-Gm-Message-State: AOJu0Yw+i/oQ0t1Ykuy9jqTaV0PLxvXW2N0wbmbx5n4A5AKkQQRIbxoy
	riNJcV1yVunr7TDmGSfx4Q/Thvj9zRR5+yyOFGzz3LPkSJuc8GRIDwjYhMaZbxfSfxgOIZ4JSRS
	z6RSd8RNVyVP8LVuF2si5jd1xgdU=
X-Google-Smtp-Source: AGHT+IEM6EoEcqJtHVn4gpWAdF7QhgkkO41aWkjwpJKVm9CM2RuEAKjVBtYHiEW+YYjJv5m71Z8+96lIKYufz8AVhYg=
X-Received: by 2002:a0c:f40f:0:b0:6aa:2d64:2015 with SMTP id
 6a1803df08f44-6ae0fad1a32mr21653536d6.18.1717054670651; Thu, 30 May 2024
 00:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405291318.4dfbb352-oliver.sang@intel.com> <CAHk-=wg29dKaLVo7UQ-0CWhja-XdbDmUOuN7RrY9-X-0i-wZdA@mail.gmail.com>
In-Reply-To: <CAHk-=wg29dKaLVo7UQ-0CWhja-XdbDmUOuN7RrY9-X-0i-wZdA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 30 May 2024 15:37:13 +0800
Message-ID: <CALOAHbDYSXzv-c-bOBTR0Rp70zZWGWBG0Hwd-0OkA-YzA-QHtg@mail.gmail.com>
Subject: Re: [linus:master] [vfs] 681ce86235: filebench.sum_operations/s -7.4% regression
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Waiman Long <longman@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Wangkai <wangkai86@huawei.com>, 
	Colin Walters <walters@verbum.org>, linux-fsdevel@vger.kernel.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 12:38=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 28 May 2024 at 22:52, kernel test robot <oliver.sang@intel.com> w=
rote:
> >
> > kernel test robot noticed a -7.4% regression of filebench.sum_operation=
s/s on:
> >
> > commit: 681ce8623567 ("vfs: Delete the associated dentry when deleting =
a file")
>
> Well, there we are. I guess I'm reverting this, and we're back to the
> drawing board for some of the other alternatives to fixing Yafang's
> issue.

Hi Linus,

I just checked the test case webproxy.f[0], which triggered the regression.

This test case follows a deletefile-createfile pattern, as shown below:

  - flowop deletefile name=3Ddeletefile1, filesetname=3Dbigfileset
  - flowop createfile name=3Dcreatefile1, filesetname=3Dbigfileset, fd=3D1

It seems that this pattern is causing the regression. As we discussed
earlier, my patch might negatively impact this delete-create pattern.
The question is whether this scenario is something we need to address.
Perhaps it only occurs in this specific benchmark and doesn't
represent a real-world workload.

[0] https://github.com/filebench/filebench/blob/master/workloads/webproxy.f

>
> Al, did you decide on what approach you'd prefer?
>
>                      Linus



--=20
Regards
Yafang

