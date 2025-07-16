Return-Path: <linux-fsdevel+bounces-55167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ACAB07731
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 15:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A833A634D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 13:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961E71D5CFB;
	Wed, 16 Jul 2025 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsHrILJK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE114E2F2
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673485; cv=none; b=uMnODGsOozMCftWtLxrDCJhmP51J05o0VNIPqD8NSDllDr2Y8tu2juUpUXx2U+XT4NxZo+WLEOpEdhMopW9JahL2GAcWnIBDoOYFYZ3VvRzIUWrFiWbjqOdRh9fHZhPqeir+ciRBCMFl6z5oP4h3+KaxIyyx3DCsYupzA8OBQqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673485; c=relaxed/simple;
	bh=d/H0Jw+X19SpOIMIEiRmQQao35fuDw8n6h9Yp3eTm5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1egVqql3MrLtZZm6Lp+PzkwMDsHaA63PDmvKCF6Hp25ueYW0G7zOa8djCGPUiYvx6Z3+5uVEGISVb+VTzMnmzXi5xvGhe6pB0zs9R1iL43Apn04R5RIoNvwwDQvLPHOJOoc8QQYqruto8cnAONhO44laj4hxe8H+Ni0TK9yZF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsHrILJK; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e8bcbe46cf1so416062276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 06:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752673482; x=1753278282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPhzLGBrUxkDcphOfkXTEGaFxR1AOdhdzSyaQerjIVg=;
        b=bsHrILJK1R/2DEemoFRGl8Om1c7FuJAJ2W8/SOwWkL/Zr+tTDy5bXnfho9PQd8kzYK
         p35UA6GDXkbeJ4kkOQVY9CFBZzLEyru+MOWk+SX1E4TfgRR2x3bdo5E1HivUg4yOsjWj
         G8/Dm2y9WpJx8ovWd2B/2caBz7a60gBmctWh3kwct1IfRAvWKGuHNj9cWVolx49ku5Zf
         Qie0ljBvga/vjojYi8j8B/npSJdVtmmWNiwSqEhge22jYVCxyIH8mc/+G/O0pworVdKn
         RRg3/2RgusAtvCuBa7O0VRSSbZweQKFifKRYK7h5/sZLiqIGwh92oJX3iv9FvkRE1+R5
         wzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752673482; x=1753278282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPhzLGBrUxkDcphOfkXTEGaFxR1AOdhdzSyaQerjIVg=;
        b=Z1ftiiHaPMIBQzxnJ3Ksg3HsYzr4GQP4eUNY+dDu/JP8q5tfQSlNTspF/EzsQWUxEx
         YKrDThiwePSfUQIZPPOdJqgTQHEoevkGsmzVRL0brSAFC7GHE1G51NOJqSlbTjlS6m2r
         JLg2jk2JMzDZwoCp29J6Jxw+13ViYKD5Y9rlvlMMdRtyM76ewjDJMqq20SvVuFvPEYMI
         QqewH/WXkMXinlqUUQm/X3sLOAQFznrTONqL+EYsyqu5Qks7kSMhRIMlPDMcOSEdk0bs
         S+ldPC41bT8tPQs8aLDC6L20o3ej2WaxzHOU9BhkJkKQe5+jbf7Ajs32AppjJZHtQv3f
         1/Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWvh/xcskVblp+oNOhVx6AF64QGf0arUi7QFe7A6hl/XvKo4TNuzeS7Wb4kCyEpPCCJO9lr0894/lVHQonM@vger.kernel.org
X-Gm-Message-State: AOJu0YxXYk3kJJUr4Oa5dqEI4o1Z1ccdofl5HZHbeGiOv1O7uY/kv4ey
	CmMhR2bk69mGYR/M+GbEqninipBWecw6ioRoIu3K2vljQgGnT5La5AWntv6C5q6PUeOVui4LDVB
	QdthzVTmrAZj9yzEGCJP8kfYNcIfAH/U=
X-Gm-Gg: ASbGnctJjdKMZ7r91uAXYc5ydHBzd2ISI5vATAa6q+WRLiR+4fX1LpYd9tmeRrsUqO2
	vp3Z8qa1XTeauRfHyvfTp/Qqia8xvLBHR7coPMqT8Hd4zSalGijdMYka/YurCR4XFLyFNi5phVL
	m8X6sfJE9pSDLD5Z7e2ut8dn0R7axxp5OwAuEOb6ksv/jb7v0O6N63YCFLoN2/nUq5rLYSoqo=
X-Google-Smtp-Source: AGHT+IEkGiq4OUTcIb3DWQnM3HbpA7vTbjyukz/WiL8x4L/5uqe0IvlinxuvwEryqMyZQA7vTzUnhp3iQdwfD+ZlRqY=
X-Received: by 2002:a05:6902:161c:b0:e89:a3a9:cecb with SMTP id
 3f1490d57ef6-e8bc269eef7mr3008910276.4.1752673482222; Wed, 16 Jul 2025
 06:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716125304.1189790-1-alex.fcyrx@gmail.com>
 <20250716131250.GC2580412@ZenIV> <CAKawSAmp668+zUcaThnnhMtU8hmyTOKifHqxfE02WKYYpWxVHg@mail.gmail.com>
 <aHesCjzSInq8w757@casper.infradead.org>
In-Reply-To: <aHesCjzSInq8w757@casper.infradead.org>
From: Alex <alex.fcyrx@gmail.com>
Date: Wed, 16 Jul 2025 21:44:31 +0800
X-Gm-Features: Ac12FXwXlXsTvUytgCSbD8Mu2dlEtwaoVuLzvoCwyJrovMVMmdbnH_qZkFebbJw
Message-ID: <CAKawSAkQd_V9wJn6fiQQWVguTB0e7vDNnQqjuZRUZ1VwzXuvog@mail.gmail.com>
Subject: Re: [PATCH] fs: Remove obsolete logic in i_size_read/write
To: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, paulmck@kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 9:41=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Jul 16, 2025 at 09:28:29PM +0800, Alex wrote:
> > On Wed, Jul 16, 2025 at 9:12=E2=80=AFPM Al Viro <viro@zeniv.linux.org.u=
k> wrote:
> > >
> > > On Wed, Jul 16, 2025 at 08:53:04PM +0800, Alex wrote:
> > > > The logic is used to protect load/store tearing on 32 bit platforms=
,
> > > > for example, after i_size_read returned, there is no guarantee that
> > > > inode->size won't be changed. Therefore, READ/WRITE_ONCE suffice, w=
hich
> > > > is already implied by smp_load_acquire/smp_store_release.
> > >
> > > Sorry, what?  The problem is not a _later_ change, it's getting the
> > > upper and lower 32bit halves from different values.
> > >
> > > Before: position is 0xffffffff
> > > After: position is 0x100000000
> > > The value that might be returned by your variant: 0x1ffffffff.
> >
> > I mean the sequence lock here is used to only avoid load/store tearing,
> > smp_load_acquire/smp_store_release already protects that.
>
> Why do you think that?  You're wrong, but it'd be useful to understand
> what misled you into thinking that.

smp_load_acquire/smp_store_release implies READ_ONCE/WRITE_ONCE,
and READ_ONCE/WRITE_ONCE avoid load/store tearing.

What am I missing here?

