Return-Path: <linux-fsdevel+bounces-24429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF27793F468
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 13:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849031F22D0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F872146019;
	Mon, 29 Jul 2024 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsWE2au6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DBD817;
	Mon, 29 Jul 2024 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253566; cv=none; b=OLDBGHsq1kuOkPMRqC5IiMkxu1l9kSx+LMdMALsoekBZHqt2wVqjJDFN47WStjWvedz8qmZuAME1Iq3Lp0DJmgVCyvl4cmKKDJsyZiF4hulny0TCiKOuPWOFOIMDbrBKMOjFZb4KZ+K3gdkWMDVvdkLKcgZS4Sw0N0R4JsrIH2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253566; c=relaxed/simple;
	bh=nkcVycGOmjZ53vAR9tu+gTOhYnSE5zhPRCcc2FArpjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNRxi/aJRz+n4mOIBqgrbT1R0bGBqpBFJZYXClFbqDtcL1si2O4MqeaLm9Uv0lY43MCM9Orz9eQ0g/rS0TXErZoZhXu6zjpbWfO3ZhrPF5R7DhiVREN1syzkAgDkqd0WX2zSGtDN/gAW2QmzvBYEmM7SGsJnoNcarvDOrd0IxVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsWE2au6; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b7aed340daso20293126d6.3;
        Mon, 29 Jul 2024 04:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722253564; x=1722858364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkcVycGOmjZ53vAR9tu+gTOhYnSE5zhPRCcc2FArpjU=;
        b=bsWE2au6C6+jukQE7t+bgHvw2VsGrSytNAxLuWy8WSTOc8Oy4gyrYJO0pxiORbGLzs
         30Oy/JnLOSRIppu84wr9juFlxZca6fRky/BNRXZ4xlhqK299r8QvNohLF2n3ZR7QdCUU
         QNb2RnfSBlu/ndkNHtXuzNsn+F7q39zg9TmwliHZwHRffLlMvAMoiO2tkHQPsi6dXnVA
         oumA9sII4nqlzKy68971yjP62kCtileK4ZKRXpFRLSLVbvsbkq+IA7WqfcKRKom3+Yii
         IHZN6g9BubIzXUWP5Y93NDfk6odrqY+Wz0vWxjaGQr94X0oK0+ciGpad1q5KoMST3v0b
         hkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722253564; x=1722858364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkcVycGOmjZ53vAR9tu+gTOhYnSE5zhPRCcc2FArpjU=;
        b=d2zMhpIyzJIrLqPihSFHgtbQElaek8VNAnSfqjYl5vILv6yimZua6pqgIAN7oZwX7C
         y/QShjqUF7HuhZWu4eWRaqNRL3knqM8xLDxvpIM9U6hEN/1dJSHf4rfXkv3/W33yUOA+
         O4SQhTXXMb7io6V9aKadrLLt3f9J84MlLOWFRLWURtL7pnpwxVCRDnm3eh0WfNXNW+Az
         b6G9VUAmxRQQE/AzslHxvCarAlhe1CrbnkLF6Gddh22TP1KICfNklTkhV++52CNnTEzO
         y8vYkkRaPILv9hzDRGuhzmyUd4yDbcWRF4L738WuPJQv+vAo3LoUJamAF43g216IGhvI
         C3Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVFqwAF/TWLSSU8OHOQDT4dznTBUFJ1fupxh6EyTLcSfmBjU2FDMuZlTQOh2UM8laiWH02amMA4gdmiU1o3dW7XClLGx4QG8nnc2rV/PAoZTD+aoWRHC+5Hw7k5GnMLVOl+clj5UX9lFaVvEDeK+3y/7HlT59T7xE+GcYpmjxQK7SWcwY2oPi3W6FuATGHqvIyou7CsACdu/VYg7IXqtmvRLy0YJidZAGTJPV8CIpJYjqwwuC3XjiHRer5GMQTUn4XCBUPEt6UDe71H4mmiQflhodvbrRHmtkF0xr442rMT9HsZFfAgNkj9nE6YGX7QQjmyEdrg+Q==
X-Gm-Message-State: AOJu0YzPsnvrpFXmZAt2AU1/l7hkdAPc+fe1+BOVhPyw27P90oup90UA
	RcITrDhCj56FmEoPlrJ26RpqAzOZYmUm8NeMvmuJm7cCEXwJwlYqF7AzXK9y3UFDxG4Ze8v3mNL
	wlOIoxfLp9OydATTIinb7qn8Yfks=
X-Google-Smtp-Source: AGHT+IF5UmpKUFOnvoAK9lYxcwohmtfgqa1lFzGyA8Akl+YSskrOYOXqexc6VvI8Xmv0jJTGVagDPu5fB/SRGumTpvw=
X-Received: by 2002:a05:6214:2425:b0:6b7:944f:3cef with SMTP id
 6a1803df08f44-6bb55aa2fc3mr125032596d6.44.1722253564270; Mon, 29 Jul 2024
 04:46:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729023719.1933-1-laoar.shao@gmail.com> <87bk2gzgu0.fsf@intel.com>
In-Reply-To: <87bk2gzgu0.fsf@intel.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 29 Jul 2024 19:45:27 +0800
Message-ID: <CALOAHbCAKEwkDQSmyUqRs-EjM9=aF-QcORr1g=_CnFLoVXsSVg@mail.gmail.com>
Subject: Re: [PATCH resend v4 00/11] Improve the copy of task comm
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 5:29=E2=80=AFPM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Mon, 29 Jul 2024, Yafang Shao <laoar.shao@gmail.com> wrote:
> > Hello Andrew,
> >
> > Is it appropriate for you to apply this to the mm tree?
> >
> > Using {memcpy,strncpy,strcpy,kstrdup} to copy the task comm relies on t=
he
> > length of task comm. Changes in the task comm could result in a destina=
tion
> > string that is overflow. Therefore, we should explicitly ensure the des=
tination
> > string is always NUL-terminated, regardless of the task comm. This appr=
oach
> > will facilitate future extensions to the task comm.
>
> Why are we normalizing calling double-underscore prefixed functions all
> over the place? i.e. __get_task_comm().
>
> get_task_comm() is widely used. At a glance, looks like it could be used
> in many of the patches here too.

There is a BUILD_BUG_ON() inside get_task_comm(), so when you use
get_task_comm(), it implies that the BUILD_BUG_ON() is necessary.
However, we don't want to impose this restriction on code where the
length can be dynamically changed.

One use case of get_task_comm() is in code that has already exposed
the length to userspace. In such cases, we specifically add the
BUILD_BUG_ON() to prevent developers from changing it. For more
information, see commit 95af469c4f60 ("fs/binfmt_elf: replace
open-coded string copy with get_task_comm").

--=20
Regards
Yafang

