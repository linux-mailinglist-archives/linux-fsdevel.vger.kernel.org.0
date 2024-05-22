Return-Path: <linux-fsdevel+bounces-20017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BF08CC621
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 20:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687D8B20B91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 18:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34CD145B33;
	Wed, 22 May 2024 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q5/wOZXM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA228003B
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716401536; cv=none; b=D+DUpZMibzqnj8SeCTyhb5QMJbTZ/pe7tzlwSchHxie9yAfzlErhfGTPhO2mUMIg17QeoW8TL2nQgJCBE7gdHV0uR50eufqJ7VkeCEDnqr8iBRItc2LLufQkH5Gye2/sA8Qg67b+gbnmui9ojfXv1x3ALZ7z0I3xMYOeSNz/ocU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716401536; c=relaxed/simple;
	bh=ayimWCKkgfYo+0x6XeVSOVgCcBa5dhPMekRUmdgIThw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=less80FqskwangWwAQ2E9cvvNSh3fTMXM/Ac8KBL8smJSweY7LjPEiccDBtLP8Ay4n4k3kA64Wft36QoJ1KRVp/BYunwF8fESDroVMhOhJBpBm9TaFKi1c3gNfEFB6Qu6y/Jd5rFa+YIuvc+eExa0o2Ynnr5flbxbV+nd76a/Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q5/wOZXM; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so914316866b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 11:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716401533; x=1717006333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AugUKhaYwKDJ/9b03MK/LG9RwwxS/6pxd40CuSzPjmc=;
        b=Q5/wOZXMiRbWA/fXG8dJVdto9U/Ie+P3carHPQskZPGO1ElvZRq6YhRMc/1jBm5fZ7
         qiVW2a5ptIBDqiVxZ3MeWuuJTn+665wXlemiqWV4a9DqabA9m6+DTDAniPO7NGYyKxm/
         hqySYUKvI3OxoVuRNS03/K7pqI+xchyOu2Fms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716401533; x=1717006333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AugUKhaYwKDJ/9b03MK/LG9RwwxS/6pxd40CuSzPjmc=;
        b=UBbPJkNu2h7iptu+MHN8jQC2cNP/N6IuraLmynS4E/fvsDEYVytBNAQWsPUt1fTp/y
         yjonj1EbB2nXoExWSLKoEV4vr54jLrKGKQd5QfVTccykRTJebjBEVhz0A8dyMMOAehMq
         1V47qdlX4KuB72I1ZDYEZqSgWeSwapk9TNJJfWOgm6zETWswEUO9qAHWnONgHTjdrRa0
         8r7+aEjynKFIiQLMxsfSQ7mvBxUh6uvVDQ+C0fCtPxUq3wtBFXi5R1ULWd+mMv5Qfp7H
         vbTPDNISD6DwTJjIhtoWJ1nKfvSD92f2PNmzE7v4YNcT4cbIQ08Pu1V+099br5rWJCbU
         NhRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8O5XdAkiyIbGjtorFS0McKgQvz2i6fV0D4qMdhpFYKkR/tUOHUyO0WM+PcG28A2TBWRmd5WCE/fkWmnF/fQLxFffdNRcvTNW3Ayj1uQ==
X-Gm-Message-State: AOJu0YxPgNc/jwQvW4WCYYCadChxx9LZvTsM37hZMNGZAzvtEV71VJ/L
	etpWPu5f51GLjgGpgsuHpfSaTr1GoKfw+xZfRUWxy8r65Z0qO5IAJoIyI/XYb8o2NhR4jCK5Nn+
	zOBCR2g==
X-Google-Smtp-Source: AGHT+IEJLOjViWGbztG4aClH5HeOj8ntbXL4TXNBzpiGqd0vz2baSYtt3xGY9ymD8gO2yJ5qYWun8w==
X-Received: by 2002:a17:906:3ac1:b0:a59:bae0:b12c with SMTP id a640c23a62f3a-a62281e18cdmr229141766b.48.1716401532747;
        Wed, 22 May 2024 11:12:12 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cec3d9b5csm900344666b.16.2024.05.22.11.12.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 11:12:11 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so8522343a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 11:12:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMNA88MQzP4NE9coXwOYeirSmmjDsyaKyw24ulkxhltiGRW57jIvzZpMFam1JtAlwWrwnt/9N7wIT1/m5TTccu1j9pGuERCxs/TXz0gA==
X-Received: by 2002:a17:906:488:b0:a59:b1cf:fea0 with SMTP id
 a640c23a62f3a-a62280d5059mr234104266b.19.1716401530325; Wed, 22 May 2024
 11:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515091727.22034-1-laoar.shao@gmail.com> <202405221518.ecea2810-oliver.sang@intel.com>
 <CAHk-=wg2jGRLWhT1-Od3A74Cr4cSM9H+UhOD46b3_-mAfyf1gw@mail.gmail.com> <Zk4n1eXLXkbKWFs2@casper.infradead.org>
In-Reply-To: <Zk4n1eXLXkbKWFs2@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 May 2024 11:11:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdm4SN_ofM1gFuF7CTRgVcbAGuopgS3NWP04zRCn_SKw@mail.gmail.com>
Message-ID: <CAHk-=wgdm4SN_ofM1gFuF7CTRgVcbAGuopgS3NWP04zRCn_SKw@mail.gmail.com>
Subject: Re: [PATCH] vfs: Delete the associated dentry when deleting a file
To: Matthew Wilcox <willy@infradead.org>
Cc: kernel test robot <oliver.sang@intel.com>, Yafang Shao <laoar.shao@gmail.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Waiman Long <longman@redhat.com>, 
	Wangkai <wangkai86@huawei.com>, Colin Walters <walters@verbum.org>, linux-fsdevel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 22 May 2024 at 10:14, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, May 22, 2024 at 09:00:03AM -0700, Linus Torvalds wrote:
> > Of course, if you do billions of lookups of different files that do
> > not exist in the same directory, I suspect you just have yourself to
> > blame, so the "lots of negative lookups" load doesn't sound
> > particularly realistic.
>
> Oh no.  We have real customers that this hits and it's not even stupid.

Oh, negative dentries exist, and yes, they are a major feature on some
loads. Exactly because of the kinds of situations you describe.

In fact, that's the _point_. Things like PATH lookup require negative
dentries for good performance, because otherwise all the missed cases
would force a lookup all the way out to the filesystem.

So having thousands of negative dentries is normal and expected. And
it will grow for bigger machines and loads, of course.

That said, I don't think we've had people on real loads complain about
them being in the hundreds of millions like Yafang's case.

> plan9 handles this so much better because it has that union-mount stuff
> instead of search paths.  So it creates one dentry that tells it which of
> those directories it actually exists in.  But we're stuck with unix-style
> search paths, so life is pain.

I suspect you are just not as aware of the downsides of the plan9 models.

People tend to think plan9 was great. It had huge and fundamental
design mistakes.

Union mounts =C3=A0 la plan9 aren't hugely wonderful, and there's a reason
overlayfs does things differently (not that that is hugely wonderful
either).

             Linus

