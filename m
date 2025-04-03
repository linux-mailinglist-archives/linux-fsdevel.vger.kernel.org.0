Return-Path: <linux-fsdevel+bounces-45669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B906DA7A88A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 19:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1842A1885D8A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 17:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13EC25178E;
	Thu,  3 Apr 2025 17:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtt8EJ9S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D2D1547C3
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743701112; cv=none; b=uVwLNutWl5iTIUGqljNXiz2jsBJkKSHVXty1mFutjrXu3KuQdvPfxUcNLsVfhPJSA3nKc/hjGoj62MGOB8ysL484oCcmeyejsQiLudkiNyTEOYUckBkUTCFg0oZ+1wnBv92lxz8Yc69Wt2Q2T+ksY6Ej7Wxv2ydxbIetCZPxdsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743701112; c=relaxed/simple;
	bh=ccRtAb+SViMVWgobZYGfg6sxXfop3Vut5KFsT+hO/28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRM0KX7K0rlRLvROc3Q4Hmt9LLBRX21Kd0vnOed9RtxMzWMdkMeEhbZLbz08Phfhgb378ZiXiMEjmLPV63UEMjP3zzUGpLbD6SMcZm3bofkE1Pl2e4G8jLN8meYrQdGdFkS364TyNxsEX11Y4fjcPfLsGXh7NPM1btZUny/GGSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtt8EJ9S; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso188440866b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 10:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743701109; x=1744305909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccRtAb+SViMVWgobZYGfg6sxXfop3Vut5KFsT+hO/28=;
        b=gtt8EJ9StbQC4qSp71FQsWWk+hDWPufgscR9cRdfWEu4fN/MMLOAx4cs+UU6MQkDqI
         smjkPIAiGFZGcSEkn4SfE2qOEsU2aYqwzILzI9jEqlGsNMjhyko6XelL1cBKjDdXBSeD
         4lbIkY8C2v+eRP8LhjuoCf6kkpYKpMkaqO2STHr7wSJc8UXWV1ryfaLkDgWFZCfVbwhy
         j02/rEcl0AeM+EVk/J+apPS+6hVMDTexOlK4F1ini6LwptwajBHomYeBx7P/9G4ivd0N
         t4hUBMwsMaj3CUnLbq4GplW5ZNl9OpcHZJYYDoHf0yN0TwSsmceRJF0CBVNIGy7IUq1S
         q/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743701109; x=1744305909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccRtAb+SViMVWgobZYGfg6sxXfop3Vut5KFsT+hO/28=;
        b=egsvPrKHFLaZNs9z+kZ8STkOEz/ER4chDhSTLYrWnNrt5dvWxldDko1i47S2uMRE7o
         xbHn8+Sa7eAVYlmuQJl9qNgpDDk/ai1KIyoDcrXe1cXH4Z0djzRxj0QBTc8i23bzK+Dy
         uFfyreGO8W1iyguT3SXMUmfjndFeFsnA6+O8tsvXamge+/Cp+XNd1iypnVJt/D33Hfem
         oFWdyMGGO4H9dFE494jcIKHv41+WnqolafoSdUb2SD0d3U9JvnhLJegbmOGQS+vD7xJL
         vJSd8JPkcvoiz85hCfjQN39rOQKb6VcT74jxNJg+zQLUz/TKofZ6ez6tlGwwLYVG1Jw6
         J/vw==
X-Forwarded-Encrypted: i=1; AJvYcCVm61xvYiORPH6gy4iWrKo8oQC15VSQ29fRDWxDwDR7G2LjJ/+S7Qc9drB1e87pXUEMB4tq8nltIE6yJbBB@vger.kernel.org
X-Gm-Message-State: AOJu0YxbrXxxLNbf2H+gPifqg0VSmPArSxw6yU9R8IkS3IhvBGvc4Or9
	c7em6aAmyTxL7Ql8xEKdjhiau7iU933oJzw75WEyrGZqpPHIN5mxtPUnJS9IvGGCGQ4v2N+VgU1
	9zccF4vDU244SufIGGH8JJUnPVZNZFEy4DyI=
X-Gm-Gg: ASbGncu1e2WmaY+yaCBum96zwp5PkppG9MQeFGVI2wpMCMz+VhyE33EBa3lvlPi1jtd
	uUWuZuAfoWhygf1sC1bLAvSQACyO7bSn6aOEEgB+OCsHIQrzoVOEruNSPe2JmrIn+gtjHRy7qbs
	t0kbX3vkg9bJNZG4xJ48I6mGapIw==
X-Google-Smtp-Source: AGHT+IFHprkgXyaRTP58WfSePMbjF2fBR7p5LHVSGmWoyuUwi5BOZysL0LAU2zdMnscghoK6rBz2YARt3Zh7xjkg+nM=
X-Received: by 2002:a17:907:7b97:b0:ac7:cc21:48f9 with SMTP id
 a640c23a62f3a-ac7d166c346mr39795666b.5.1743701108281; Thu, 03 Apr 2025
 10:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402062707.1637811-1-amir73il@gmail.com> <u3myluuaylejsfidkkajxni33w2ezwcfztlhjmavdmpcoir45o@ew32e4yra6xb>
In-Reply-To: <u3myluuaylejsfidkkajxni33w2ezwcfztlhjmavdmpcoir45o@ew32e4yra6xb>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 3 Apr 2025 19:24:57 +0200
X-Gm-Features: ATxdqUGl7YhlJ6HQsxhckfl8xppuHgAVx-9gAj-j7rsHieiopYEeIzVHvDHYKN4
Message-ID: <CAOQ4uxh7JhGMjoMpFWvHyEZ0j2kJUgLf9PjyvLeNbSAzVbDyQA@mail.gmail.com>
Subject: Re: [PATCH] fanotify: allow creating FAN_PRE_ACCESS events on directories
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 7:10=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 02-04-25 08:27:07, Amir Goldstein wrote:
> > Like files, a FAN_PRE_ACCESS event will be generated before every
> > read access to directory, that is on readdir(3).
> >
> > Unlike files, there will be no range info record following a
> > FAN_PRE_ACCESS event, because the range of access on a directory
> > is not well defined.
> >
> > FAN_PRE_ACCESS events on readdir are only generated when user opts-in
> > with FAN_ONDIR request in event mask and the FAN_PRE_ACCESS events on
> > readdir report the FAN_ONDIR flag, so user can differentiate them from
> > event on read.
> >
> > An HSM service is expected to use those events to populate directories
> > from slower tier on first readdir access. Having to range info means
> > that the entire directory will need to be populated on the first
> > readdir() call.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Jan,
> >
> > IIRC, the reason we did not allow FAN_ONDIR with FAN_PRE_ACCESS event
> > in initial API version was due to uncertainty around reporting range in=
fo.
> >
> > Circling back to this, I do not see any better options other than not
> > reporting range info and reporting the FAN_ONDIR flag.
> >
> > HSM only option is to populate the entire directory on first access.
> > Doing a partial range populate for directories does not seem practical
> > with exising POSIX semantics.
>
> I agree that range info for directory events doesn't make sense (or bette=
r
> there's no way to have a generic implementation since everything is prett=
y
> fs specific). If I remember our past discussion, filling in directory
> content on open has unnecessarily high overhead because the user may then
> just do e.g. lookup in the opened directory and not full readdir. That's
> why you want to generate it on readdir. Correct?
>

Right.

> > If you accept this claim, please consider fast tracking this change int=
o
> > 6.14.y.
>
> Hum, why the rush? It is just additional feature to allow more efficient
> filling in of directory entries...
>

Well, no rush really.

My incentive is not having to confuse users with documentation that
version X supports FAN_PRE_ACCESS but only version Y supports
it with FAN_ONDIR.

It's not a big deal, but if we have no reason to delay this, I'd just
treat it as a fix to the new api (removing unneeded limitations).

I would point out that FAN_ACCESS_PERM already works
for directories and in effect provides (almost) the exact same
functionality as FAN_PRE_ACCESS without range info.

But in order to get the FAN_ACCESS_PERM events on directories
listener would also be forced to get FAN_ACCESS_PERM on
special files and regular files
and assuming that this user is an HSM, it cannot request
FAN_ACCESS_PERM|FAN_ONDIR in the same mask as
FAN_PRE_ACCESS (which it needs for files) so it will need to
open another group for populating directories.

So that's why I would maybe consider this a last minute fix to the new API.

Thanks,
Amir.

