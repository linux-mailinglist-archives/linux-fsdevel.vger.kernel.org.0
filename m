Return-Path: <linux-fsdevel+bounces-49534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA18ABE0E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 18:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E9C7AB03E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 16:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BDC278E47;
	Tue, 20 May 2025 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NPIHoEP8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8F26FA76
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759249; cv=none; b=NxM90+W7PbRtruNCGlbfEXpOrQnA8bHv6Ax1gMmIKdAlXC+Aqvv9XHVEo+yvQ1ac4emCPH7NRWpB95o4B1g97AnkZxOW2l4TnC8FobWFKohpHAU4qAJX7Qe5hzCGqb9tN7Yl35mhLE9s3Rj/wNA1VcIl5GnobEZCR2M8v57ojRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759249; c=relaxed/simple;
	bh=Fe3SQr1Tgdxaicu5cMlLYaBvQLQauJdBDwx6I3UeaTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FI4hXDeh9+d12h/rXUozn02Y9WeG/LSViX1Fj9Rf828A6ybrgPiBeAhFyc+Tk7JXXUUrhYm9X54+4tfDe+TbJ9wvPiZ47zu90uZ3BHKtzhsh4jQ2WD+SSbtHgs/h8XLb2iNryrJUndyRQBp+P1sCqnBTcu/VQbBxTnZVWgu8Y84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NPIHoEP8; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4766cb762b6so64408521cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 09:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747759246; x=1748364046; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fe3SQr1Tgdxaicu5cMlLYaBvQLQauJdBDwx6I3UeaTA=;
        b=NPIHoEP8I0v4jVfOFQgeBnsfO2dMGrxStkdVOCjql1tFy997FZrjPtZb5Yel48sVqW
         WbtjdNXvtydcwO7tXDbARo4XUWmNMiEqBytQjx62bN5eP5aRkreHA4kNMWqQQY2d+1E9
         n4uNwrcI1sbC/jf++m+/Q8oQJ+LsYKRWJWEqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747759246; x=1748364046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fe3SQr1Tgdxaicu5cMlLYaBvQLQauJdBDwx6I3UeaTA=;
        b=CdmkcFrZcpbOB7P/wUnaXp2x3b+AKAsUuHvyxVaZTbMQKhiaTntNBCCSObZKTjtzSl
         3wokBWQ4tamRH6W3ars0y0YBROQ/XgoBul+g14T1qBxPbB4KUYr/WVLpuL+gRkAjStuB
         g6kt5JIy8CInod5yaR+Aad/n2uaDRHC2ZLLKk5j0Zce590CS8TgwsIUJU3VhVISovq2u
         wst2tDkXU3g57jITIPcCG822N0uP37qdy/QSErWrGXMBqVSLUO5ulEe6cnx0wICfmQ4z
         dnnk27QRcY6s7Ba4AUFg7jSWwKwaFbLD5HHdNpqnMzlfJ3HViUPXmoFpxpJY/czWx53/
         KW7A==
X-Forwarded-Encrypted: i=1; AJvYcCWt1clNMCoxhwbzwRjx/15goCETLE5bFbDSHvAcwao4cFhs577XAZ+cOYHU3JNLLf5lmSbIOkXvBJ2mBIJ3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2nu2x/eUqZbDIqjV23FZNwEQDnozoXWcBBVnG7ZgyTzwhHE64
	Z6lsodN0SRHI1icH1S18nVCMUjj4PQMI1eQh5Dili0diLf/DAnGU0hyM3BsyITWSeW8ZA3mJu7I
	n3SgzoRG5IIk9+4AS8Jvi/fwle7Nuwdbor0jZYjuUxQ==
X-Gm-Gg: ASbGncvsVHltQrGHqQh69xGPM3fsTbAtpGbPa74s5MYVqhL/6NcuUF14HeVIJLskiG3
	nyFd4ZpbS2YHl8ANeLBimBHqi2rmgXBaFD2cqAfoHkyY+kBeENbnKtBI0ZC8w533XNhLKRut9EE
	S5W0XDq9b4JPbVupUMHbhF9aYwe6HaxIX4W1H1hSo/pqZHRw==
X-Google-Smtp-Source: AGHT+IGTCe96EYzLfgh7qgkaiolx8qzDK1c7n7H14UCJuDGekDjcM0Kg4qSMxoWF61rkkDgWe1ioI2e3TjQwy9nHcEs=
X-Received: by 2002:a05:622a:6118:b0:494:a7b8:d63c with SMTP id
 d75a77b69052e-494ae314548mr330690061cf.0.1747759246134; Tue, 20 May 2025
 09:40:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
 <CAOQ4uxg8p2Kg0BKrU4NSUzLVVLWcW=vLaw4kJkVR1Q-LyRbRXA@mail.gmail.com>
 <osbsqlzkc4zttz4gxa25exm5bhqog3tpyirsezcbcdesaucd7g@4sltqny4ybnz>
 <CAOQ4uxjUC=1MinjDCOfY5t89N3ga6msLmpVXL1p23qdQax6fSg@mail.gmail.com>
 <gdvg6zswvq4zjzo6vntggoacrgxxh33zmejo72yusp7aqkqzic@kaibexik7lvh>
 <CAOQ4uxg9sKC_8PLARkN6aB3E_U62_S3kfnBuRbAvho9BNzGAsQ@mail.gmail.com>
 <rkbkjp7xvefmtutkwtltyd6xch2pbw47x5czx6ctldemus2bvj@2ukfdmtfjjbw>
 <CAOQ4uxgOM83u1SOd4zxpDmWFsGvrgqErKRwea=85_drpF6WESA@mail.gmail.com>
 <7sa3ouxmocenlbh3r3asraedbbr6svljroyml3dpcoerhamwmy@gb32bhm4jqvh>
 <CAOQ4uxjHiorTwddK98mb60VOY8zNqnyWvW=+Uz-Sn6-Sm3PUfQ@mail.gmail.com> <ztuodbbng5rgwft2wtmrbugwo3v5zgrseykhlv5w4aqysgnd6b@ef56vn7iwamn>
In-Reply-To: <ztuodbbng5rgwft2wtmrbugwo3v5zgrseykhlv5w4aqysgnd6b@ef56vn7iwamn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 20 May 2025 18:40:35 +0200
X-Gm-Features: AX0GCFtCQXc8dfOCmu22fg-gXqXE1YObKOZAbGs4WfDGBDzTD5kto0juBR50CeE
Message-ID: <CAJfpegs1AVJuh1U97cpTx14KcnQeO2XmtvrOwbyoZ8wvqfgqPA@mail.gmail.com>
Subject: Re: [PATCH 0/6] overlayfs + casefolding
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 May 2025 at 17:21, Kent Overstreet <kent.overstreet@linux.dev> wrote:

> Docker mounts the image, but then everything explodes when you try to
> use it with what look to the user like impenetrable IO errors.
>
> That's a bad day for someone, or more likely a lot of someones.

Wouldn't it be docker's responsibility to know that that won't work
with overlayfs?

Any error, whether at startup or during operation is not something the
user will like.

What am I missing?

Thanks,
Miklos

