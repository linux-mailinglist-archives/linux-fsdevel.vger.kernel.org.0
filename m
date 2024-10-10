Return-Path: <linux-fsdevel+bounces-31606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0257998C7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 17:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20D41C220EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 15:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E261CEAD2;
	Thu, 10 Oct 2024 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSgaAFOs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75B61CEACF;
	Thu, 10 Oct 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575759; cv=none; b=HYBKQLn9vsY7sNylbhhLFPZxmvLhBmeiVSQfmtuTyLgjwTBelShYuHvsyw63IlpQl9wxBuPiK8Dj7YOhZZEYEgdiW++YF7ylUvxPv58muM2UPS73P7PVeSOVjW2O55nH6M8I6hWqrTdWAnqGyKkOcoL7U65gz2R19T0RtbrayTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575759; c=relaxed/simple;
	bh=Ih4UaDkoM6T5XdxgdVqcQJ+chtmD6qc/9PQo87MShcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZblxgc+iC3pOaeK4rSbK3VXQWED3MKKIgfWrMeWre8xUIauTK4mprXYfpgxgjx494uJaiw25z5hoSAAnVGpWfkpM4A3bYFtWvcKMr01W1xTQ5i2/VR3ufj+pOoi/fs7LNAGWjTZcZ1ncTMCQFPNEDU2XmmIiHYFOozQ3HnO9+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSgaAFOs; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e314136467so10446267b3.0;
        Thu, 10 Oct 2024 08:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728575756; x=1729180556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SxsUMgyvfS+vygJkWKqcFB09pVeqV5iXHjDD4/QxFUw=;
        b=NSgaAFOsNgrbbECETm0e/m4IXlqLGfPPqxTnCeBt4mYNsVPBmOia7MwP++yGRCjZ4x
         hWnkBIkopWZ8HWjARK3+B7iNdZpw6Eh4G15loI4gg1EmmoZ47qXSKGepoP+65tKlpdRW
         C5F6V1Ib6Lt/m7baGFMI4o/STsZgERNfcRLpzRYw7Zaowb1t2TJPmrrHse7mYt8+D1pb
         KbSXAlA/aS7hk4vPvsy3hpMZszFau7HMstjyaCairXkqYci4EhkxdlUwkCmjQTFlWDLx
         S5PmtKy0U34bopTAMiTp+ZLbZf1zH9GkYjpk1jsjbMuoOIQ1VP8cGUPJScqs+zLYj+aF
         3coQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728575756; x=1729180556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxsUMgyvfS+vygJkWKqcFB09pVeqV5iXHjDD4/QxFUw=;
        b=hFbq6LDLI9aBww0ScpMFyjHIxGK1b2wDXtkwpMVhwEO4U5h7uuIA38j7YpYBpZUdcN
         aXMaVZRPh+WmdFQ9pWtqjltLRs+Iqt/mAtvBvMcExslLp3z7s4iLzoxY7OnG/QYzFHD3
         pnia5l+unHzTi8Oe8ygnP1Kdq2bkfvYOkR6IcUEWUL1OizH7zMfV4LFukf93OuH0Bk/F
         1TanXzpl0YN6lbO3t1vtfn272Sdufzs+pP5R7tRUbffDttM9ijAz/QEEDNfxO4U5a9nT
         BYFyr2Wx0jvE16DGQuxOiOTFg3vNe96Grp0rzaT3QNgw5R44uizI/xWHt64/J76L4aoS
         YF2w==
X-Forwarded-Encrypted: i=1; AJvYcCUFil/TgZFSa96MXpepSzo4MMTn82hT6VCaNTT6+xA8D5MzMwuq81TUaT0g8aafjpyqdk/HdSMXFym4EmaB@vger.kernel.org, AJvYcCX8g14zT4qclWVt1a4ehfhsgzbHWhwR6dcrO6KKcqwzoe2SpIoQhEvkFp4N2G809XWaYQIjJ8XqjVvwhNHP@vger.kernel.org
X-Gm-Message-State: AOJu0Yzep1gIT/ElAcj2RCypNEp8nqGSEsaJaK+Jkbodql61Pa/k+zkZ
	uH5fFo5ZCp2Z3p1IPuZOUWLFmlMWupB5pXVydopzr861xjjf8n7TdRIY/mAAWukwXv9rD0K6vI8
	P1KvWVQ4jbEa3TwG50BbzlWvuWWoORCI+
X-Google-Smtp-Source: AGHT+IHs7RHd6JMWzZdk7FDJvoBdE504pi4tbzE73D9t92az0pMIB0oDo5fBTOi9qXHRbI/QNJbR/sm14hFCcFLTrAg=
X-Received: by 2002:a05:690c:f93:b0:6dd:ddf6:90aa with SMTP id
 00721157ae682-6e32f134e85mr35474857b3.5.1728575756604; Thu, 10 Oct 2024
 08:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008121930.869054-1-luca.boccassi@gmail.com>
 <20241009.202933-chewy.sheen.spooky.icons-4WcDot1Idx9@cyphar.com> <20241010-ersuchen-mitlaufen-e836113886c7@brauner>
In-Reply-To: <20241010-ersuchen-mitlaufen-e836113886c7@brauner>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Thu, 10 Oct 2024 16:55:45 +0100
Message-ID: <CAMw=ZnSj=3oSgcTu4ESOKtNgs5sESOBWZWESohUEDbe+Z9JWYg@mail.gmail.com>
Subject: Re: [PATCH v9] pidfd: add ioctl to retrieve pid info
To: Christian Brauner <brauner@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org, christian@brauner.io, 
	linux-kernel@vger.kernel.org, oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Oct 2024 at 10:46, Christian Brauner <brauner@kernel.org> wrote:
>
> On Thu, Oct 10, 2024 at 07:50:36AM +1100, Aleksa Sarai wrote:
> > On 2024-10-08, luca.boccassi@gmail.com <luca.boccassi@gmail.com> wrote:
> > > From: Luca Boccassi <luca.boccassi@gmail.com>
> > > +   /*
> > > +    * If userspace and the kernel have the same struct size it can just
> > > +    * be copied. If userspace provides an older struct, only the bits that
> > > +    * userspace knows about will be copied. If userspace provides a new
> > > +    * struct, only the bits that the kernel knows about will be copied and
> > > +    * the size value will be set to the size the kernel knows about.
> > > +    */
> > > +   if (copy_to_user(uinfo, &kinfo, min(usize, sizeof(kinfo))))
> > > +           return -EFAULT;
> >
> > If usize > ksize, we also want to clear_user() the trailing bytes to
> > avoid userspace thinking that any garbage bytes they had are valid.
> >
> > Also, you mention "the size value" but there is no size in pidfd_info. I
> > don't think it's actually necessary to include such a field (especially
> > when you have a statx-like request_mask), but it means you really should
> > clear the trailing bytes to avoid userspace bugs.
> >
> > I implemented all of these semantics as copy_struct_to_user() in the
> > CHECK_FIELDS patch I sent a few weeks ago (I just sent v3[1]). Maybe you
> > can cherry-pick this patch and use it? The semantics when we extend this
> > pidfd_info to accept new request_mask values with larger structures is
> > going to get a little ugly and copy_struct_to_user() makes this a little
> > easier to deal with.
> >
> > [1]: https://lore.kernel.org/all/20241010-extensible-structs-check_fields-v3-1-d2833dfe6edd@cyphar.com/
>
> I agree. @Luca, you can either send the two patches together or I can
> just port the patch to it. I don't mind.

I've updated for the latter, given that series is not merged yet, thanks.

