Return-Path: <linux-fsdevel+bounces-54167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3D2AFBBB5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 21:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55676425155
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 19:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC241A23AC;
	Mon,  7 Jul 2025 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHhhVFw8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7392E36F4
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 19:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751916657; cv=none; b=cc/h5NE3AUlbuSETUYtnmLHbTnvkKu/8vOn1xH/KjB2mvHHA1k3Fan5HNc1sCibTklRMYzHCYXVyyoJjTWz8duyBHbsV6b0Cr6yTJB0tyMnKFmydaPnxIxoaKvfx1agVYcp5eXncZvCeB+exUecjYYee+dsCzjIfEJ9Y8wcQqBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751916657; c=relaxed/simple;
	bh=wfYWUZe3j57VSianY9z9JYtVPnnq/S3SB8ZmagnU6AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbLtKLoLh48AIEiqJq1oy4L+IsH74p0dDVF40fXBosPyxMNolmeHQswV4gxvsQu48z/W7nfN+OS4+Wr/Ic/TydNAI8W0Jhq4WyyIsdz+dBfrNuHgi0jLv6oR2UQ9GP4no9JBrSk/JS5jvuMrY0+MQ2foWRV6eY9lfoUsfOv6B0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHhhVFw8; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-714078015edso30493647b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 12:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751916655; x=1752521455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6Xq8hbY4c7WFInkWhYnksKQ2dsCuSDS2JuTLat/LZc=;
        b=iHhhVFw8nbYcnYcO9TpVcbj1O2CcVQC8KTjAwLO+tU3ORqxwQjy58osZz4W2BpvCCR
         heOdEtodZXVz9POO+xJbQXoH+D+TyX6/Hx5rk+ArfEHDqFJ78dg5K0dZfd0vQsCUQ5yu
         8B/f8nIsmY9saWa2G/lgVDluUs9uuFmcSCc87/vMNk9oZToWmq/AHwe2RlbqTpsowqct
         wZj/CgDiPZmyYUU10VSXjJjZHArbaZKJOCeZlmKs4enyA+z9xa0QX8NExw+lx4qT1bjW
         gfz90JyBP+7MGMvyYIIeFxb4F+g6dMCG6HQ7i0IdVNpFClF9t2TAj02vq7kT1USjCGLR
         ZLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751916655; x=1752521455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6Xq8hbY4c7WFInkWhYnksKQ2dsCuSDS2JuTLat/LZc=;
        b=Nr3h+7TV0S2nX4iI29EW4F/faTsdY45dMRIJmtCjwquTxfUtOiKIGX9wxIblWJUxIZ
         vlL2uImCBhTqTmIFL5z/U1h9hl/xGt+Xa3neQUvj1HYM5HfNpOZHfl5XCoaCJrCCfCxk
         Uc0RSQ7dz7lU8ekZWUf2lKlygrwKIH8e80f8NvmtIdLg6iYtdbLpm9gdG/WCZ/Y05oTI
         dFvbfSYvy/U9Sav3IjzGwqVG2wNJicoZlcMlQT6clQDzaNVEHjvDS1KNlyN8FQwNlUcL
         TY+eu6AYlEqn/0iZSRAteF3I0+bZ1Q//qQZMwsN1lXeA9P/OAmkUk4KE7uJP4HLFkd+1
         S+Dw==
X-Gm-Message-State: AOJu0YxKCOGfDbn9EcvbiThwZTF+MpZY+8gJ+OZ4AujeJuTsAhyihUaS
	gIEf3i6d3Dal9UTVUMtH1I4slhFfai/uEfA0Y46tDMOozfAHcE9NvZrGTzmTaY7Ej+tHXCUHfI5
	q5bN+EC17jZuRRBpaGFxKiGq+xyHvhco=
X-Gm-Gg: ASbGncsphuGRm6EGQU9/I+cAM2lB4YjA0q8EVqpRyrnj7G/L7nR6dpqqL8o8yyl3kTZ
	SYFAwCDcFFwHudrP5tsSenywUc35IusIYkQAZc8n1gPX9wKXXQVdTQiYD9DgIfOVjhosBaTjqxV
	9lcHnHTdYg9YUSpZEHvS5Wl8mkcSoZZjJ+LweNZTpR/rOh3zo5oyGd72Q=
X-Google-Smtp-Source: AGHT+IFpP0B9b5yMAu6/U6oP1VHMG4ql11LJaVerV+IEp3hbQ6mPl2St8DET40wm/7QJH1yMzJ64RrSwmgBj35WLEnI=
X-Received: by 2002:a05:690c:84:b0:714:13:357a with SMTP id
 00721157ae682-7166b66fbe9mr192584437b3.20.1751916654733; Mon, 07 Jul 2025
 12:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702212917.GK3406663@ZenIV> <b3ff59d4-c6c3-4b48-97e3-d32e98c12de7@broadcom.com>
 <CAAmqgVMmgW4PWy289P4a8N0FSZA+cHybNkKbLzFx_qBQtu8ZHA@mail.gmail.com>
 <CABPRKS8+SabBbobxxtY8ZCK7ix_VLVE1do7SpcRQhO3ctTY19Q@mail.gmail.com>
 <20250704042504.GQ1880847@ZenIV> <CABPRKS89iGUC5nih40yc9uRMkkfjZUafAN59WQBzpGC3vK_MkQ@mail.gmail.com>
 <20250704201027.GS1880847@ZenIV>
In-Reply-To: <20250704201027.GS1880847@ZenIV>
From: Justin Tee <justintee8345@gmail.com>
Date: Mon, 7 Jul 2025 12:29:55 -0700
X-Gm-Features: Ac12FXwfwvnW62uFprVl-on0kWP75yQ4kiGJrlckSCgSqSEcNqpHMB5vDUTxKKk
Message-ID: <CABPRKS_hSYbJHid=GJo4r9RGUjNWMYA04CwM+M=yPHY5kQXUTw@mail.gmail.com>
Subject: Re: [PATCH 11/11] lpfc: don't use file->f_path.dentry for comparisons
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, James Smart <james.smart@broadcom.com>, 
	Justin Tee <justin.tee@broadcom.com>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> is OK only if all updates of that thing are externally serialized.
> If they are, we don't need atomic; if they are not, this separation
> of decrement and test is racy.
Agreed with this too.  Vport creation and deletion is serialized, so
we do not need to declare debugfs_vport_count as atomic.

At this point, cleaning up the lpfc_debugfs_terminate routine may be a
little more involved.  If it=E2=80=99s alright with you, Broadcom will take=
 up
the responsibility to clean up the lpfc_debugfs_terminate routine
during our next driver version update, and we will of course state
your authorship in that particular clean up patch.

Regarding this thread=E2=80=99s enum selector patch, I can provide the sign=
ed
off by after we see that the enum declaration is moved to
lpfc_debugfs.h.

Regards,
Justin

