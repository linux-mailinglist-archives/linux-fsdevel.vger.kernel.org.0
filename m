Return-Path: <linux-fsdevel+bounces-53642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A475AF1657
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 15:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 283867B1E7A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 12:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB59275842;
	Wed,  2 Jul 2025 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Z9HK89E4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577291E1DE0
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461173; cv=none; b=a6vYPEsZUtE03J3INOAJnh1I8yF+M6J4+ZViVJpLvktFRSMSRuZK4KUd6QWwp7oDQpFUYjfGtZNLnXba+66nweANX+yra3n2ohfKz6HMScIfa9NPQb5EYca4QCuyGrJ9ZoAA3ttGlyTWizSO5WyVhpKiG1sE0J2NGQ7xQsXYp90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461173; c=relaxed/simple;
	bh=RdghsNeUlHbxHdMrJoDo/Hn6WmpubB9kWWqFa/2UJw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9OK/cffCHvrjwejEaioUhdyX5aKZNiuqh+H0eHQjK/oGfpPChM9OO3t2b5rDzeVDSrSHjMWuF/labpQh2xj3e6sP+S0dAHPkcL4HgaFDVTxTp/tYLutCX+hWE3zXo7qUOYBnzd7+OTejddPWlknDimaKCk3xQjhefTVdwtDQUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Z9HK89E4; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a52d82adcaso58065501cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 05:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1751461169; x=1752065969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UkUcASf93F33U6ZGNKqIIGKB0FsFcDmBc6tNYJB0dm0=;
        b=Z9HK89E4Ie87qTVUfstidJs1eu2C2uFIubeRDnRKaxdRr+yYy8No4g9Vyzx2iEJatz
         5PpeJniulGe+vyQzvajDmQmqsAUYqQg14eBOObA3ubQMZhcZtOJzWzJnRyl5zLU67I+G
         hJjpKFboDcAThQ4HGCFSirrR8GDuwImVilrfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751461169; x=1752065969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkUcASf93F33U6ZGNKqIIGKB0FsFcDmBc6tNYJB0dm0=;
        b=glN0EtlefxZyvgIKpEnW9cus8EcXGt/VmjO5Rrs4rAwy7cyZbA3azsyLsGoutd910u
         moBarxeSmR6m29wpLbUKrJy8MfHtW9PsF26VdAgWppIUvmydPY70O0o7xxL9AWTxzY6O
         0EVyEecLqUsPYwNLQTE5NDfdVP5tvcI5qjN4gKw0p4kVB7Vv+5eI/NRcijmS3MbWMAB1
         mBcQhbOoBzDWduw2MYwsFvBN12mWOfW+nK9CKDRD5K8eg4V4HVZHbzjNq4DEO5cVqJ9X
         8SWlg8nhCXgTlmQk3gl4Mo4HYk4VSdEiVKgEGaMCiBXD22ihbicnEcsSr+8ew2W7ZTeS
         Ujgw==
X-Gm-Message-State: AOJu0YxG3h8CND/+0p0sqs7LrXgdQrStQKwuCBQMp3D/0awml1ZcCW+H
	Yax1HT2q6nytEEFpZCtZE8Qa1OrmVY+uAbxZCYjW4ggHOlOvDWSWYIY6lrUe7hWmGepnrKHfoqL
	arb1UOh9a4iVptOx3d4C9rOLmuBQy8eORpkzhzypQ/5drXJURdCMUrB8=
X-Gm-Gg: ASbGncuQqwfRc0zqdIrPEJ97aHndZZ00gAtAP5jbg36RNTBrBMJT4/fEkeqRAS41G0E
	ZjmVnnpSU/V2v6mwIRIlqndGf7FxzTXF4fjjzllq/J61/R69TA/P0mrH+sI1+5xwyC+pV8ZZ8dX
	9B+X/6hFkfxPsl0+9vJ2G4A5QfzBJfESbTAJdRitDxGOi2eMkGHaU4j/sdo4EQWh1NfPTnKR6C4
	v/o
X-Google-Smtp-Source: AGHT+IHxl+NEYjI9S7LcUeODRw9nNOQr9FET3aoroPSUJ4DnNpITGbMut00R3sC4DE5xOD/BlmCHLXuFRrP8pKn4LOE=
X-Received: by 2002:ac8:7f94:0:b0:477:13b7:8336 with SMTP id
 d75a77b69052e-4a9768f0c61mr41971901cf.17.1751461168747; Wed, 02 Jul 2025
 05:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+AidNeR+_SZPQjD37JcibOoQEwtDEYz6bBef1O3PfboS0BJtw@mail.gmail.com>
In-Reply-To: <CA+AidNeR+_SZPQjD37JcibOoQEwtDEYz6bBef1O3PfboS0BJtw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 2 Jul 2025 14:59:17 +0200
X-Gm-Features: Ac12FXy7uaeToFNUvxNeuXfF1zskVIz9ivpnlwYTnnbLulPAbRWcYryB9g8s75I
Message-ID: <CAJfpegsdhqnxCmQfQzGRP=zbkuNofExcqoCi5dMk4jAFc14EoQ@mail.gmail.com>
Subject: Re: Query regarding FUSE passthrough not using kernel page cache thus
 causing performance regression
To: Ashmeen Kaur <ashmeen@google.com>
Cc: linux-fsdevel@vger.kernel.org, Manish Katiyar <mkatiyar@google.com>, 
	GCSFuse dev email group <gcs-fuse-dev@google.com>, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Jul 2025 at 14:27, Ashmeen Kaur <ashmeen@google.com> wrote:
>
> Hello Team,
>
> I have been experimenting with the FUSE
> passthrough(https://docs.kernel.org/filesystems/fuse-passthrough.html)
> feature. I have a question regarding its interaction with the kernel
> page cache.
>
> During my evaluation, I observed a performance degradation when using
> passthrough. My understanding is that the I/O on the passthrough
> backing file descriptor bypasses the kernel page cache and goes
> directly to disk.

Passthrough opens the backing file with the same flags as the fuse
file was opened.  If it had O_DIRECT, then the backing file will be
opened with O_DIRECT.

If your fuse server implementation removed O_DIRECT from the open
flags before opening the backing file, then this can indeed be a
regression.   Otherwise there is probably some other issue.

Thanks,
Miklos

