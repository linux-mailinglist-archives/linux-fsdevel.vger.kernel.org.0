Return-Path: <linux-fsdevel+bounces-27852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FECF964777
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FF31C22F4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5AE1AD9EC;
	Thu, 29 Aug 2024 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qn5KBPdk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E5E1849;
	Thu, 29 Aug 2024 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940235; cv=none; b=DAeYS/DlcCklCdcYKDXmQnRbR7tCUrgzmmBYdiUF41kekNLdQhMJRjdKGHSdbzn2bBfH+/1eEIG1ZTwMFekYlS0SBV60VsYH3k8QWVtRI8gOHV7ppu9DThhwKasegaXabUpwxn0H/H3gQ0Rxt3qQu15nNFU3Z0vIUINIbU5pdIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940235; c=relaxed/simple;
	bh=TAXyig5NLDB4wI/mZ3FOS2Zx8+/+72uMPMe6S+uturE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dfy8+eXxngGSxPRM/LfMqee+pEFRT4KSHUgqGHdIbZPWGWBVlC8ova/7TtKCUVnITD4zNDX7JYQ687dCHE2YYXTTVIFqjMaUoyL/wZfjedhRybSaRNjNtLfx1//pkjUIktwOpSErly7sTnDkLwwIui4MErjPdiFL4fEuSFo3OI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qn5KBPdk; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a35eff1d06so47342885a.0;
        Thu, 29 Aug 2024 07:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724940233; x=1725545033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BgFf574JTx40WrMhFgMzoeXEI17RrKv5ZxttaGBHEE=;
        b=Qn5KBPdkE7W9lXt/NhNUJ98dwKo3751gxLhk2qHB+CNYNzbHuyuDWQ8Q0IY7q+cB+d
         6BeXB/1cLKlepKNOkJkNqPRXkcr0/Xscn8P2+zHt7h3b1o5mvVvyZel0wOzdlWZgoavd
         1vDzOFL5q9+cP5livMrRxj9XfU6IMSYClbTlYAIyS+CdyRxdO+1mKG46+pF8CCdweMpW
         9+Y4X7Gr1TboNZkEavptE42sOh5ODrT0XHJGuHXvZzbqrs5m/yOYZCaCMC2/ji3y4WGY
         3fFMpLSGC2RkCnOnv2aI08ulFqJs8y7KMCWCaYgjlc3Aj1p3CgeajjhiWCCv4NSAFDP/
         qGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724940233; x=1725545033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BgFf574JTx40WrMhFgMzoeXEI17RrKv5ZxttaGBHEE=;
        b=coQ12O9/K/TvqsCW8tie3l6xkfGJzVjMvAvb6TZXTFJW2JyAotjqCnILPnYXhbwjhO
         DMeoL5e9SbWcK9ncT7XljBGCr9REvLwkOSfrJwR41CguXAzQZdMOXmziMk7Nn7sUjGTS
         Ostye4dqjxTmTDF46zIOppzQl4e++3R4kMAc6X/epqDRAls/eh7u4K4D5A1AWmsLLyqt
         pHjZPdEjaPdds54jabb0cbbwQtqA9GDlBOye4oHD9DoCIPLQxPJLWZl2fIwUBZoLz41n
         44EDqlKi2x+qRCqKDocyrU5+DU+usCc30rva1HP9VyrRafiNQlTUKRwWSz0I5h2AekOV
         2PaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtBjyRLQrJYH+AIeS9MPhQYS9Ldok2HRrll9p6Ha16Eyp27BF18Bw+OMp5mFKM1lapDmXip+OTprM/gK7NYQ==@vger.kernel.org, AJvYcCVviIb+F9fkGxpar73odEgd3u/XreU+1EvfvjXwXc9SqyR8m7n3hA6oqeoiIMcD/JBqxTkw1ouaAfMRsebK+GXNY1jEuDrw@vger.kernel.org, AJvYcCWEeNPrf25rWLFPt0t4ofTqyIxnvX31wFaoCOi821ZTDC/TGonzoB+eKk+nB2pbppS31P0Ub8laO8pCfQpcpQ==@vger.kernel.org, AJvYcCX3GciUzdKrCYOHdpmgPagOnjIvjTZz+GUg3sK1asa3nRxA5nEGRYOfNaHikuBRvlTlKXHxTagCKWmSm2Yr@vger.kernel.org
X-Gm-Message-State: AOJu0YylbDwGmX4jQaZVfIW14Unw1rphRfCYHnJ5h0lEKlkFreLK5QrK
	4YG3A37fZCVd668LN1AjT7JT3S9EI718FjxrLcTQWFXdo/rXzkXYb+RGBKGkC59W26kbKxgB5Tz
	4uaXpgC+4lSvCeYJ6/FOBY9aqPn4=
X-Google-Smtp-Source: AGHT+IE8ENS/FNKAiTfyy1wjMrk7L4JOC8ww92sKUqtOBl0i2cK69m+/WPO54rS8ejBMB/SRrpl1/sSCwlHSsoG43JA=
X-Received: by 2002:a05:620a:2804:b0:79e:fbca:5ceb with SMTP id
 af79cd13be357-7a804263264mr296071485a.47.1724940232400; Thu, 29 Aug 2024
 07:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826085347.1152675-2-mhocko@kernel.org> <20240827061543.1235703-1-mhocko@kernel.org>
 <Zs6jFb953AR2Raec@dread.disaster.area> <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
 <ZtBzstXltxowPOhR@dread.disaster.area> <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
In-Reply-To: <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 29 Aug 2024 22:03:13 +0800
Message-ID: <CALOAHbA+s2akXcb2kBAOqiUSn7RQaBtvUEGMFwU=dBroBh_+qQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>, Michal Hocko <mhocko@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, jack@suse.cz, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 9:32=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Aug 29, 2024 at 11:12:18PM GMT, Dave Chinner wrote:
> > On Thu, Aug 29, 2024 at 06:02:32AM -0400, Kent Overstreet wrote:
> > > On Wed, Aug 28, 2024 at 02:09:57PM GMT, Dave Chinner wrote:
> > > > On Tue, Aug 27, 2024 at 08:15:43AM +0200, Michal Hocko wrote:
> > > > > From: Michal Hocko <mhocko@suse.com>
> > > > >
> > > > > bch2_new_inode relies on PF_MEMALLOC_NORECLAIM to try to allocate=
 a new
> > > > > inode to achieve GFP_NOWAIT semantic while holding locks. If this
> > > > > allocation fails it will drop locks and use GFP_NOFS allocation c=
ontext.
> > > > >
> > > > > We would like to drop PF_MEMALLOC_NORECLAIM because it is really
> > > > > dangerous to use if the caller doesn't control the full call chai=
n with
> > > > > this flag set. E.g. if any of the function down the chain needed
> > > > > GFP_NOFAIL request the PF_MEMALLOC_NORECLAIM would override this =
and
> > > > > cause unexpected failure.
> > > > >
> > > > > While this is not the case in this particular case using the scop=
ed gfp
> > > > > semantic is not really needed bacause we can easily pus the alloc=
ation
> > > > > context down the chain without too much clutter.
> > > > >
> > > > > Acked-by: Christoph Hellwig <hch@lst.de>
> > > > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > >
> > > > Looks good to me.
> > > >
> > > > Reviewed-by: Dave Chinner <dchinner@redhat.com>
> > >
> > > Reposting what I wrote in the other thread:
> >
> > I've read the thread. I've heard what you have had to say. Like
> > several other people, I think your position is just not practical or
> > reasonable.
> >
> > I don't care about the purity or the safety of the API - the
> > practical result of PF_MEMALLOC_NORECLAIM is that __GFP_NOFAIL
> > allocation can now fail and that will cause unexpected kernel
> > crashes.  Keeping existing code and API semantics working correctly
> > (i.e. regression free) takes precedence over new functionality or
> > API features that people want to introduce.
> >
> > That's all there is to it. This is not a hill you need to die on.
>
> And more than that, this is coming from you saying "We didn't have to
> handle memory allocation failures in IRIX, why can't we be like IRIX?
> All those error paths are a pain to test, why can't we get rid of them?"
>
> Except that's bullshit; at the very least any dynamically sized
> allocation _definitely_ has to have an error path that's tested, and if
> there's questions about the context a code path might run in, that
> that's another reason.
>
> GFP_NOFAIL is the problem here, and if it's encouraging this brain
> damaged "why can't we just get rid of error paths?" thinking, then it
> should be removed.
>
> Error paths have to exist, and they have to be tested.

I completely agree.
Adding a dead loop in the core of the page allocator just to bypass
error handling is a reckless idea.

--=20
Regards
Yafang

