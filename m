Return-Path: <linux-fsdevel+bounces-17715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EFC8B1AA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 08:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 908DCB228A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 06:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47283D0AF;
	Thu, 25 Apr 2024 06:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mixn5Q1O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5F23A1AC;
	Thu, 25 Apr 2024 06:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025183; cv=none; b=RXsFCUZJC6oz1p7CNWZ+KhjjStrQLYr4zdschUFXtK0gzyb3e0n2TJnu7b/IR36olxBeQw4yEMPG6R9p32DbqJhhja2EPrOgoqon0l4x9hhRuSsQ0ZRfjWZUU4EVvZQBZ89EGXkiyc6t6DKz9yUZJy/c+EUABIZMListtZC7cFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025183; c=relaxed/simple;
	bh=dvKTlg+kg92Mkx6G+gt4m/08khRB2H/WrYx/Ku1ZpbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHqFh3vhuus6sj3JsLVbthWygoIPh+nWJPY45h/hDR9KQkYNSgwRnilkmjjkroUCupct29SbTsgg5h8up+ILNAPPs7ar33L8YyRT6w7B692cFRbnME9zOBGqrNKYsI2AjsJbiDYdPUFC5OckQ+LM9652EsjsC2v2otqqLK60rA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mixn5Q1O; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso723735276.2;
        Wed, 24 Apr 2024 23:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714025180; x=1714629980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kdu2kkuJAVCmKf8384cv38eneufBKUPC8ObGdfPhtmQ=;
        b=Mixn5Q1OFXDc81vU1Qdk7R/RDlRfa2UKOxDOD7XfW5uvAxrahf6wGID1IzzdVPZp6L
         XglxnuhY5ChneLfq1LG4chcmKLwn/p88UytBylHPAj1XUmf/LemcsH0X5epYlU9xQl2c
         fuJA2aeoU98Ro2WcfcJr4mGGHSUYblr5xSx16+79DEurtuKPbAG2/i9jGDE1EmuMTxZ2
         jkGynFnSxao8Dqg26mGdn92aXRB10EGBLD/DqK552YC3RLSVyWlyl2lmUVNBICYBGSq9
         3IldWuDGHV3x8LKoJT6/8hZjp02k8tR9tHYPOl0WPHqSvq/jCZvLp3h5gjefQfN0AzPa
         +e9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714025180; x=1714629980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kdu2kkuJAVCmKf8384cv38eneufBKUPC8ObGdfPhtmQ=;
        b=FhWMeyavrreRrhYlYmWI0NwdEqpq87TmboVnNaksegQ8HL5M8xg6oTuIi0Y74hORzC
         Hih/ZKxtczyrwGB4hfNlJlVQf1Z5V+AeJ49vh0fKuBaG3epPUwr28aQguYB2vb/Jfdzv
         71Ki+N/g6XqICQSl9WGlhd9XUeuClkCzZ7N33CzUd/8U9wmw1tExz58yOL99yhYoMlsx
         7kHOEvyxUqxTuEvgdodo9MBO1kCcdoZd5tnklufog/sZDipVcHuS8nI4Cx4emSjp3MGi
         AmR8ujx6GAOQGobwc25QJo5spDX+gNBGgGIvodWDl6tL4COiF+pIMXdpruuGrUQsIfXd
         EpxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5aTSGdrrpCbzC7j3VOZHQziFjq/Ohgpn+vXhSGZ4xIQ0t+zoNcLN205ruwD+HxidSKIg6NV9HTPp9eI+rhQ92MOTKsinUo6noIpMC78WKhWPAik1sxi9apkjLj+ek4nvVO9ePXlRIkwzdrUIPYpI28rm+J2I509Ppa9BmLEW+vMzygOi29WfWG7I=
X-Gm-Message-State: AOJu0YyWRIWUd3u2LxZ9odkbj6DiftUs5Knt5lxtfO2SfyUuvvlZCKH8
	o0D2/tVts3agzgxt14T0Klvv0LZwNE0GtUjjL5UKaQ5rpCg2iRIFu0Cl+Lfyq4uWcQ5dIeql6C7
	R/L/ffcmvC7K0ntznJtr9UK8Fj+E=
X-Google-Smtp-Source: AGHT+IENHXhgpA97vo8Z8o1YE9P1ifZkeyeBBuDFVW1qXr8kV4Qe/F0s7PmxJlJbfZt8J+wV8LY3ZwcjiLWwmN0OIXE=
X-Received: by 2002:a25:820a:0:b0:de4:70e2:16c with SMTP id
 q10-20020a25820a000000b00de470e2016cmr5037857ybk.14.1714025180256; Wed, 24
 Apr 2024 23:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403021808.309900-1-vinicius.gomes@intel.com>
 <CAJfpeguqW4mPE9UyLmccisTex_gmwq6p9_6_EfVm-1oh6CrEBA@mail.gmail.com> <87frvay47x.fsf@intel.com>
In-Reply-To: <87frvay47x.fsf@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 25 Apr 2024 09:06:08 +0300
Message-ID: <CAOQ4uxjdk47CVbihhsErzNQdUBiPshBOd8rg-PerBuOPjY=e5w@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] overlayfs: Optimize override/revert creds
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, brauner@kernel.org, hu1.chen@intel.com, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	lizhen.you@intel.com, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 10:01=E2=80=AFPM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> writes:
>
> > On Wed, 3 Apr 2024 at 04:18, Vinicius Costa Gomes
> > <vinicius.gomes@intel.com> wrote:
> >
> >>  - in ovl_rename() I had to manually call the "light" the overrides,
> >>    both using the guard() macro or using the non-light version causes
> >>    the workload to crash the kernel. I still have to investigate why
> >>    this is happening. Hints are appreciated.
> >
> > Don't know.  Well, there's nesting (in ovl_nlink_end()) but I don't
> > see why that should be an issue.
> >
> > I see why Amir suggested moving away from scoped guards, but that also
> > introduces the possibility of subtle bugs if we don't audit every one
> > of those sites carefully...
> >
> > Maybe patchset should be restructured to first do the
> > override_creds_light() conversion without guards, and then move over
> > to guards.   Or the other way round, I don't have a preference.  But
> > mixing these two independent changes doesn't sound like a great idea
> > in any case.
>
> Sounds good. Here's I am thinking:
>
> patch 1: introduce *_creds_light()
> patch 2: move backing-file.c to *_creds_light()
> patch 3: move overlayfs to *_creds_light()
> patch 4: introduce the guard helpers
> patch 5: move backing-file.c to the guard helpers
> patch 6: move overlayfs to the guard helpers
>
> (and yeah, the subject of the patches will be better than these ;-)
>
> Is this what you had in mind?
>

I think this series would make a lot of sense.
It first addresses the issue that motivated your work
and I expect patch 3 would be rather simple to review.

Please use your best judgement to break patch 6 into more chewable
pieces because the current ovl patch is quite large to review in one go.
I will leave it up to you to find the right balance.

Also w.r.t the guard() vs. scoped_guard() question, remember that
there is another option that may be better than either in some cases -
re-factoring to a helper with a guard().

One example that jumps to me is ovl_copyfile() - seems nicer
to add a guard() in all the specific helpers then adding the scoped_guard()
around the switch statement.

But really this is a question of taste and avoiding unneeded code churn and
unneeded nested scopes. There is no one clear way, so please use your
judgement per case and we can debate on your choices in review.

Thanks,
Amir.

