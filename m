Return-Path: <linux-fsdevel+bounces-35451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1E39D4E2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 14:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FE6283591
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 13:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D0C1D89F5;
	Thu, 21 Nov 2024 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqbbM5a6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C11474068;
	Thu, 21 Nov 2024 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732197412; cv=none; b=dCV57xgL8sja/bp60RB+Y1oYfvF8NPAFW4cjhmIYvx3cAFxN1jQi2hlWytOn7VTJFwaOmVIwCMmkHu1EQH0J1xPNub27e/irn3h2rmot9QIxd0eoFbCk168X+6lSbRL8V1gAoWkqnlI8OrgtFyrPHziLDOxgbzWCWpWqcHyLw+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732197412; c=relaxed/simple;
	bh=ePTbVWGeSfRNtNOCTV+I6F4vSdmqOaS362+3xuGclys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNqdaDrnIR5Ew0IGFJ16jpN0kfkBQ/nlHtez6iV5Q8JYpiJeaBrCJCryT4n0IJRw+QwFHgch1DQFb5ulTKVy194FR96Z/Dwceym79nEdhtYhQyOTD2JJdyFtvBW5OZc27tpTM5pRwqxlxwBJ59FmjMtjkkj6/a6USRn/K81ymcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqbbM5a6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cfaeed515bso1212456a12.1;
        Thu, 21 Nov 2024 05:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732197409; x=1732802209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6VTsKEKFH+lx7r6h+YAEcJh+xm3cvslfQa17q41ek0=;
        b=QqbbM5a6O9BeuJKdKj/2ZesKJSG3yPDr8twocT4YLbdppmelkI7d1yL3XkI3ZnGzIJ
         15G0KZlfa3PhHF2g7tCFUAFmo6FVB9lA2noghmIVz7+2t9Ef6epnuTKKKk02K+rTHO0I
         y/3pWRKVe6LS2++pkLr5lv1TW7a7VLhcUYtEj4Gjx7KqpmKv+jTitSdDL85Ae2o/j/om
         mp2Yrq3VBWaMAQfIM72kuAWWRD1CeW/xSOvxdUqFh5NxvewkN7N+JcUuh98AVMw9Zoup
         zL1u/C2Lc2tBmuGxnL5+OpOyhFnWHdTjSpy/ULmNyJFJVbMCDjGhCfsckV42+J7g2BHj
         +n6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732197409; x=1732802209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6VTsKEKFH+lx7r6h+YAEcJh+xm3cvslfQa17q41ek0=;
        b=TXEDCFsApIH/HQT3O8EPRTDJZUjzaisVlO0tf1mhoaDgVwgEfgHzCpc99Sf+AydCTX
         tNBNDHjbhN0DREga9uFvYDmZn8MVTcXkt/q6w0XS83WeIMLLFG0QL9b6NFmyS6n4w+Vc
         HHmRp+pGlmxSvFHG9yDoo5xW4RmTMJUyE36LsE3PHnevN55teUYh7OdSpbjN7CVr544o
         +6kNsnWM1abGVoctQ0p82Y693wpb8vYgfLIAJcO/BHH8HhXyPTzhj3bsIlqa/KQTg0Yb
         kNZaY0haChVzuYMaoNByHqwjoS9bRoiTwFY4HEG3bvseN662dzWkz7VGLAbfshD5OZVJ
         DqVg==
X-Forwarded-Encrypted: i=1; AJvYcCUA7BfLhgHIliaen2iFjluFgXJxn9V9+4utKa/9LdTJi52157GzP2YHSSS/ObdeVDZ9RZs80R4j9cLk@vger.kernel.org, AJvYcCUwC5Rh2prUsOQpWtxdVixpkWdSplkR9AHh7vp0WnaxzQkjahAgjos9dayz3cH8Gxy3K/2OsIpu/f67TcugUQ==@vger.kernel.org, AJvYcCWcWIZtuOLzGWMggJVJ+zlBo6gk06Fvws5GXo58YGtV8qWok+e2teuv3g20etnh/jjij0KneJNLYhXUbDv7@vger.kernel.org
X-Gm-Message-State: AOJu0YzsfCflKZEjq6k0bRhQGdau96lb6Hnh5u3WRXprQI7aeIubqmXh
	cTYtvbSCrKSee3kd7SNRG3Xg054lpLQ7b/1Ovxjhb5BXRSQfYpXTrlq8vtVIAigIneWHyvKFgNq
	r+yS8DYGyQp1ser6PZNj3qJOHZyg=
X-Gm-Gg: ASbGncsKjmXHeiQMm6a9HiEyJnaydrDp7IDptgyCWV4rFMMmo5loyaG9A/L1yP+F3C7
	eRb97OgyinYpLVJEF9DznWHcve5RRLw==
X-Google-Smtp-Source: AGHT+IHbmuJ7KgininVEU/ALyo+nC03rV8ASRUHLBsEK8cAvNbVaYmbKGLO9xiUHXWLwlDvA3LbY4pqkbb8Fahimsy8=
X-Received: by 2002:a05:6402:5108:b0:5cf:d078:c9dc with SMTP id
 4fb4d7f45d1cf-5cff4ccfa11mr4811055a12.22.1732197408592; Thu, 21 Nov 2024
 05:56:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120112037.822078-1-mjguzik@gmail.com> <20241120112037.822078-2-mjguzik@gmail.com>
 <20241121-seilschaft-zeitig-7c8c3431bd00@brauner>
In-Reply-To: <20241121-seilschaft-zeitig-7c8c3431bd00@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 21 Nov 2024 14:56:36 +0100
Message-ID: <CAGudoHFDHbN9Zo4z9BPu5TbhNYa4sSYeVHD9UShnWNrY-Cr3eA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] vfs: support caching symlink lengths in inodes
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, hughd@google.com, linux-ext4@vger.kernel.org, 
	tytso@mit.edu, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 11:12=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> I think that i_devices should be moved into the union as it's really
> only used with i_cdev but it's not that easily done because list_head
> needs to be initialized. I roughly envisioned something like:
>
> union {
>         struct {
>                 struct cdev             *i_cdev;
>                 struct list_head        i_devices;
>         };
>         struct {
>                 char                    *i_link;
>                 unsigned int            i_link_len;
>         };
>         struct pipe_inode_info          *i_pipe;
>         unsigned                        i_dir_seq;
> };
>
> But it's not important enough imho.

I thought about doing that, but decided not to. I mentioned some time
ago that the layout of struct inode is false-sharing friendly and the
kernel is not in shape where this can be sensibly fixed yet and it may
or may not affect what to do with the above.

On the stock kernel the issues are:
- a spurious lockref acquire/release -- I posted a patch for it, Al
did not like it and wrote his own, does not look like it landed though
- apparmor -- everything serializes on label ref management (this *is*
used by ubuntu for example, but also the lkp machinery). Other people
posted patchsets to get rid of the problem, but they ran into their
own snags. I have a wip with of my own.

Anyhow, with these eliminated it will be possible to evaluate what
happens with inode rearrengements. Until then I think any messing with
the layout is best avoided.

thanks for taking the patchset
--=20
Mateusz Guzik <mjguzik gmail.com>

