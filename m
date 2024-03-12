Return-Path: <linux-fsdevel+bounces-14220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CB88798DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 17:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E661F22EAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 16:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018C07D41F;
	Tue, 12 Mar 2024 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hLhFbqVs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46027CF29
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710260656; cv=none; b=RxBwfacqp8G4ptSqsJbFqy/7FFNirwdEWwGp80a0ii01zV6k7avX+pTdp4jvjU7aIngCXN23Yb1LvEWsP7vJKEMyEMY+fsM79Z/BNVNC0nCRcXyAcFZ4YL2aBpz+aHguHTUOfNfbVmEWbvz6pk4h9gf4DHFlEGoZ8BPhZqUA/dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710260656; c=relaxed/simple;
	bh=gUpiTTtVdCSdTNsFAXy4anMcCYBGsbVSB3nOkoY3sic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SN1owUCQD7UxTdhR+yXQrgTCa9v60OhiebQwprHiIdcemh3pjloL7Yk+0cFRum0QD90D4CADVAZTOYthP7cbhpzwp311QTRGPjRPtRrVW9HVeDEiL1YSYJOEyAUCjIlfLhoGLkM09D63kkAoui306rUnImq5iMqiBlzbY3VYaPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hLhFbqVs; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a461c50deccso21924166b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 09:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710260653; x=1710865453; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=404ludRtPDabZjwWi280UhL8x7uLqEhd2I82RVxtiI0=;
        b=hLhFbqVsMVlqgpxJFVOrS4BTX3pmrSwCOHIskavf761fKdbdJZBD5SjTRqIV8rg3K/
         Dw63Lg/4TNEL76dHdjjQ3Wm3eq0cOotiXSXk1/k0LkMY77cnUFVn6yy86QFmmwVFK/sp
         DCDPjyVNrMpkMj/VttS8iberWiNGBrGTTeIPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710260653; x=1710865453;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=404ludRtPDabZjwWi280UhL8x7uLqEhd2I82RVxtiI0=;
        b=cy0uKzrmqjDuEOO0o80ehMeQut7CKS2q0fmvUyJ/XHrLP3ziO3NgZePhKSKhhfzxsM
         eBwkrc3to/Q7PymNxK3DyQtncucb3Efw7Hh29IX7ZDSaUDWszK3+oimYtANXaQaXookd
         GmR3KAJYwPXDC6lBqxA92ajaPP99zS1LhdMydMirRoi62m7OCinJEnW7NlghCJB+GFsv
         ZJJGKTA+wrjVFyPZzkIuSfHZsM47B10Bd9LVsfSmI4Et5R5UnTHQfq0orx/8P5ki+hNO
         K52U78qdaZrKvrhRyWe8D/+7tWQZ4H8TiQQ+PQnQrsLyqjkEyauNRJ/IUcYpkZ9EEooG
         pHuA==
X-Gm-Message-State: AOJu0YwidvS13rfbHQnHWFshCeX7DKkR+S/bonuSvx9ZEj6hQ/fKCk2N
	dbyo1vAAF7xbwDR0N+2Kt9Wk2EiivHByCkylSV33zkc90lvnQk5Jk4JtV2xIiPtH8XDr3C6f72m
	04qPfVg==
X-Google-Smtp-Source: AGHT+IEoPXJp+Yb/6Gx8Cqi5ZhFwB59t9kmuTQPFwIyEKSV0JbCAX5EaE7qepna9AdSGATF6NFLZMw==
X-Received: by 2002:a17:907:c287:b0:a45:ed7f:2667 with SMTP id tk7-20020a170907c28700b00a45ed7f2667mr657118ejc.17.1710260652626;
        Tue, 12 Mar 2024 09:24:12 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id bn13-20020a170907268d00b00a461526a185sm3126709ejc.204.2024.03.12.09.24.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 09:24:12 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-568107a9ff2so33605a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 09:24:12 -0700 (PDT)
X-Received: by 2002:a17:906:ba85:b0:a46:2a85:b37b with SMTP id
 cu5-20020a170906ba8500b00a462a85b37bmr685796ejd.51.1710260651798; Tue, 12 Mar
 2024 09:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308-vfs-pidfd-b106369f5406@brauner> <CAHk-=wigcyOxVQuQrmk2Rgn_-B=1+oQhCnTTjynQs0CdYekEYg@mail.gmail.com>
 <20240312-dingo-sehnlich-b3ecc35c6de7@brauner>
In-Reply-To: <20240312-dingo-sehnlich-b3ecc35c6de7@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Mar 2024 09:23:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsjaakq1FFOXEKAdZKrkTgGafW9BedmWMP2NNka4bU-w@mail.gmail.com>
Message-ID: <CAHk-=wgsjaakq1FFOXEKAdZKrkTgGafW9BedmWMP2NNka4bU-w@mail.gmail.com>
Subject: Re: [GIT PULL] vfs pidfd
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 07:16, Christian Brauner <brauner@kernel.org> wrote:
>
> No, the size of struct pid was the main reason but I don't think it
> matters. A side-effect was that we could easily enforce 64bit inode
> numbers. But realistically it's trivial enough to workaround. Here's a
> patch for what I think is pretty simple appended. Does that work?

This looks eminently sane to me. Not that I actually _tested_it, but
since my testing would have compared it to my current setup (64-bit
and CONFIG_FS_PID=y) any testing would have been pointless because
that case didn't change.

Looking at the patch, I do wonder how much we even care about 64-bit
inodes. I'd like to point out how 'path_from_stashed()' only takes a
'unsigned long ino' anyway, and I don't think anything really cares
about either the high bits *or* the uniqueness of that inode number..

And similarly, i_ino isn't actually *used* for anything but naming to
user space.

So I'm not at all sure the whole 64-bit checks are worth it. Am I
missing something else?

                Linus

