Return-Path: <linux-fsdevel+bounces-42139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D2CA3CE2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 01:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21BF3B40A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 00:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F117C35979;
	Thu, 20 Feb 2025 00:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z1NGxv4r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556798488
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740012003; cv=none; b=d0uQN8B5fwoNNHfFAI9mCmcTRvdCeqUGc+9gOSE1uRLU1nMH5LcH18fVCbpYx7RIz0YsAN7Tm1NWSoALzLMK2GJXN6EZKkpnqOpc2JY8EeacirvZ8L5p4Y7BIaHw9USbeVdqSLWpV1c+m+GswG9Sf5kAH/4hJvSvDwKt81pwfBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740012003; c=relaxed/simple;
	bh=g7DErytRUuAKrZakuD3eHoT8POJrCda3VPRgb8Uz+54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVmpO0zEkM+fgHsDwKsSpwW+crdIRnffDcKm9apgsvRE+KXKFt59zoCRw658uHsxusuOixTaNrzHF1W9C9dUQUsIRo0g1cLk2d+3ypASvkJGCc6y732wnrs2W0GmDiJWueYbR1fKeDHC6hnTKVHg3H/dVqyxnK+qlVHhq/SgW2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z1NGxv4r; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaec111762bso93180166b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 16:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740011999; x=1740616799; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5bX5q6XO7RyF4eoxd1NJpEY9bnTw/y/W8pyoru60AG0=;
        b=Z1NGxv4rarlXSEpFPzaC6vMv8xCZO7iOpdUsSvy+pqcbNLUWPmKwG+wz0+GfqdORWo
         fW2tDTTo5pEq9R6zLrO3bRyYeqbbxoOm+c0rweOZd7P//LQM8D1OuIG+m28Nvanjly32
         OQEa2mDJKQff4lnsAz4OsCNr7rxoyPwpOUNhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740011999; x=1740616799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bX5q6XO7RyF4eoxd1NJpEY9bnTw/y/W8pyoru60AG0=;
        b=tG4u4RF3A5kH68UpC8nIqBcbd0yr/CGWyMC238TmD6ynqFsgAssFAO5hkzZj7/HJ5T
         usAjHuGAOjsNcxad/3P71c1uslS8acYawZPtCQzY8wWmSoofOpjr2HN3cQaQ7ujhlFLC
         PR+Jmdgll6TTKe73DemhAbcPJLSSu93KuHKMB46mPCso7NjeEs2ql5+bnB+oeHvVf7Rd
         9ZRN9CgdOl9lLBDBKIt+v7H4sYV+2P6bAEXFPuTUnz4aYi6nLJtnbfMHveGtHSfjQq0X
         q0Lk7SJagoyctJK+9nuceZ7+4XeJ6swk7tFXM2U1Hgr90DP7kSsDrO7tL8Sd3+Qr1ZMH
         swog==
X-Forwarded-Encrypted: i=1; AJvYcCWc4qvs0sp1dqz9YzyF8HDP+NKUE5dlHrrczxUMXI/6WxlcuRuhbY2P6awgHu5mZuZdSdI6L83tS0Vk9iCw@vger.kernel.org
X-Gm-Message-State: AOJu0YzI0LrrI/sLMLeWh/Uj7pjtmfYG5Xbhd4/xFaJGbwGYShbkDByB
	kx+v/yNluFwUmGrSI78XeIwCcSa/PWouG1l7vJ3zW55bvTUNkPZfilDdks65OxbwrIUSpLY8XIE
	cue4=
X-Gm-Gg: ASbGncvfeqO6goV49a4+Fo86DFYe0+mGzR4fxwP/0XWSIE/zMFDC7STTqn5wKXKNDUg
	IB/1FaumAY9zyja0PRBR8MCX+VnPE2GgwJAPtbEicXudAhC7ktmy49wCn2CKK69P1pTHfFcMpPI
	Ig+yqRRnewg2mHqjSixAS6sl+qWQfv+RzwXONZ+UVojyf221VbeCsR6fsODLryiVbTIHL72nfPn
	Mzti5tXJSR+K7dhtitDd9ygOyjZbwJS25p3eHd5gd4cjsRrUX6XeruXh+KdjVoIz5vv/qmIFp7r
	nRkJvy74ANhJbN/t4YE+KbyfnlG6Ay4iXu07XZIxGSIKVXrURWh+rPxGRORx9eiPYw==
X-Google-Smtp-Source: AGHT+IE34hqlkPg/eKfHSFKgGP3drgHWG+FLl79W/iNpTVD8UBmBzsdXfBGINc+oImB0uiEnc6I28Q==
X-Received: by 2002:a17:907:7fa9:b0:aba:6055:9f5b with SMTP id a640c23a62f3a-abbccd005aemr508643666b.2.1740011999485;
        Wed, 19 Feb 2025 16:39:59 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9654a6b2sm730626566b.135.2025.02.19.16.39.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 16:39:58 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abb86beea8cso82948066b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2025 16:39:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjNLTowjqmYStbpIv4byNDWuxOqrmZJ+v1VKFAosar2rOgKIA0stw0+eYqUrHW5hbD1/7V5R128tAqgpk+@vger.kernel.org
X-Received: by 2002:a17:907:7744:b0:ab7:c43f:8382 with SMTP id
 a640c23a62f3a-abbccf1013cmr573598466b.31.1740011997709; Wed, 19 Feb 2025
 16:39:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
 <20250218085407.61126-1-michael@stapelberg.de> <39FC2866-DFF3-43C9-9D40-E8FF30A218BD@juniper.net>
 <a3owf3zywbnntq4h4eytraeb6x7f77lpajszzmsy5d7zumg3tk@utzxmomx6iri> <202502191134.CC80931AC9@keescook>
In-Reply-To: <202502191134.CC80931AC9@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Feb 2025 16:39:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgiwRrrcJ_Nc95jL616z=Xqg4TWYXRWZ1t_GTLnvTWc7w@mail.gmail.com>
X-Gm-Features: AWEUYZlyX3Ars0jVy2kh6EWta3z2VTRB7NefiwUH34z96MyiOgY5ii4BnshdGmo
Message-ID: <CAHk-=wgiwRrrcJ_Nc95jL616z=Xqg4TWYXRWZ1t_GTLnvTWc7w@mail.gmail.com>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
To: Kees Cook <kees@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Michael Stapelberg <michael@stapelberg.ch>, Brian Mak <makb@juniper.net>, 
	Christian Brauner <brauner@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Oleg Nesterov <oleg@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 11:52, Kees Cook <kees@kernel.org> wrote:
>
> Yeah, I think we need to make this a tunable. Updating the kernel breaks
> elftools, which isn't some weird custom corner case. :P

I wonder if we could also make the default be "no sorting" if the
vma's are all fairly small...

IOW, only trigger the new behavior when nity actually *matters*.

We already have the code to count how big the core dump is, it's that

                cprm->vma_data_size += m->dump_size;

in dump_vma_snapshot() thing, so I think this could all basically be a
one-liner that does the sort() call only if that vma_data_size is
larger than the core-dump limit, or something like that?

That way, the normal case could basically work for everybody, and the
system tunable would be only for people who want to force a certain
situation.

Something trivial like this (ENTIRELY UNTESTED) patch, perhaps:

  --- a/fs/coredump.c
  +++ b/fs/coredump.c
  @@ -1256,6 +1256,10 @@ static bool dump_vma_snapshot(struct
coredump_params *cprm)
                  cprm->vma_data_size += m->dump_size;
          }

  +       /* Only sort the vmas by size if they don't all fit in the
core dump */
  +       if (cprm->vma_data_size < cprm->limit)
  +               return true;
  +
          sort(cprm->vma_meta, cprm->vma_count, sizeof(*cprm->vma_meta),
                  cmp_vma_size, NULL);

Hmm?

             Linus

