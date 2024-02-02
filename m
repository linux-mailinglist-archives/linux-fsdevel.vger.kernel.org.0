Return-Path: <linux-fsdevel+bounces-10007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98854846FC4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 13:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384681F274EA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6667513E22D;
	Fri,  2 Feb 2024 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pzu73jt0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB44822067
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875605; cv=none; b=XOOci/zG9MVSkiHbZ1swVdX6I+StLp6glBnw2L8Wc3L3/QufhOOWKbLIRTiGLR8kGmAbsnaUUzXv48b1xkP+iu8KGqeiyI8nNlJ+kPURXZZ2MRFX7CoqZ1Xql/Ff+V5Jr1QrCo5lZGQErWPJqivne95MXmKmJY1iTK5kvxbjqX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875605; c=relaxed/simple;
	bh=68Hxx3whoOh2VHvPfnGybbSOle4QgRTULRqLI4JA63U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTU015eu4rCe5nTWiWiTRnvvJybkuhd4Gj5DTUGMBj0KXLzO9JO/kP1xoH15bxHBFZZ9pl08RJ6gdedmmKoJgP0iehi9fN0RNzIkM9RP69jrM9Wn42XceC5clTULY74VEJmyHCXC0TAaRG9cFejubcdz3C1/2wEaOM1sZuTvMIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=pzu73jt0; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a35e65df2d8so274061266b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 04:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706875602; x=1707480402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4J7fnzbx1xDAdhtSIlO6B/DcPHOFLIcscqApV54Cc7s=;
        b=pzu73jt0dt+rhWRpXzbTa0SSUN+XWSkYx5MKY8qPQTiz2HPVI77QXx2tw8djm3yW68
         UH1RmmSkBxML8HpfnqyuQEVrw0Bwb5T2cDY7MXak4GZwiHV+cpCqKSqIOFtcHi9fP6Vb
         zcUHH8SLyamIlXEbu1qyVkO/dgw6zbWRMbD84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706875602; x=1707480402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4J7fnzbx1xDAdhtSIlO6B/DcPHOFLIcscqApV54Cc7s=;
        b=OPKKQ6JUicgVU5aOAxeepgbOxyOd6sv6mUgpGLly0oUaDHv/t+Ieak3gnqZGjuhYAO
         2ymTvqWhUQPoFETm4T1FzDYb1Tsbo/XRqLMpKrdy67eFwLXzepS2Ab6cGdH/6mE6UxUo
         tHIrB8vWBnyRF6erLbJnjYS6K2veJIGD6pcR/k1FNTg3GXzAkTarD9FpoRRg5KM2m0Ba
         wOZ0493b/xqXMzoOjcnDRv7pbcBLHxOpfC2uywEC1dAXgv46ErP9cnWvZGWYxgSWjLh4
         GZgeHfNGxwcuUUKCvfeJa+8gvYvI2CcvSo81ROox7HRPoemXhWYQwnyFhE8INe7sEGbC
         pCkg==
X-Gm-Message-State: AOJu0Yw4AF57wxp2FnbIZhCwhK3vjsn5WI4agj6VZBg9TO0Ie52cLFx3
	h11PXRszTFdyx7gE7cWRSKJGUQmLgIWiQVqqMeBBSx+Vb/wB34Y7+dvrvf4MCMlGPa0H5Qgpj6w
	DBmyb1ZMUQrwNCBwMu1b3eGGOW9O7qWidn5BhLg==
X-Google-Smtp-Source: AGHT+IGT+R4xfo2W1HCBZKYBCtVJpZ7FfMewJa3OZ0noVW9nd7FIW/mJClbV9E+SYcF0WMzz+Gwg24VjEKzgP9xfSJI=
X-Received: by 2002:a17:906:3590:b0:a30:84aa:c2f5 with SMTP id
 o16-20020a170906359000b00a3084aac2f5mr1350195ejb.56.1706875601817; Fri, 02
 Feb 2024 04:06:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2701318.1706863882@warthog.procyon.org.uk> <CAJfpegtOiiBqhFeFBbuaY=TaS2xMafLOES=LHdNx8BhwUz7aCg@mail.gmail.com>
 <2704767.1706869832@warthog.procyon.org.uk> <CAJfpegu6v1fRAyLvFLOPUSAhx5aAGvPGjBWv-TDQjugqjUA_hQ@mail.gmail.com>
 <2751706.1706872935@warthog.procyon.org.uk>
In-Reply-To: <2751706.1706872935@warthog.procyon.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 2 Feb 2024 13:06:30 +0100
Message-ID: <CAJfpegu-s=K0W6M7BqzrkaNsnXiJ25LcGLLMS-E-roKCD0dVZw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Replacing TASK_(UN)INTERRUPTIBLE with regions
 of uninterruptibility
To: David Howells <dhowells@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org, Matthew Wilcox <willy@infradead.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, dwmw2@infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 12:22, David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > Just making inode_lock() interruptible would break everything.
>
> Why?  Obviously, you'd need to check the result of the inode_lock(), which I
> didn't put in my very rough example code, but why would taking the lock at the
> front of a vfs op like mkdir be a problem?

No problem in theory.   It just looks like a tedious job doing all that.

But please go for it, it's a worthy goal in my opinion.

Thanks,
Miklos

