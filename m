Return-Path: <linux-fsdevel+bounces-37464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C139F2860
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 03:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8411A1885073
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 02:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB90A17C64;
	Mon, 16 Dec 2024 02:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLKdy3Kl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D4C8BE8
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734314846; cv=none; b=raw6HHHgPHxYe/YKnqntNkBlsDJ8AGGCF0tWwpC/VKefdH41/O8rMzJEr4khPwrbl5XAaMcRcgQ8HyPcnBZb95XxbYsXdJ59MV7zrj8md6+kwpMeXoxg7xF6vFzsVfbtUT3m0GaJjrA6F5XQPXUihndtUsY2NJKGnxsd92SPe3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734314846; c=relaxed/simple;
	bh=t2kONODElXTF7fzOZdarCbTjwaqRs4Q8nMs3mV9hLMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILu2rVH+xOKSbHnJodvEP2pHzE/rI+7tl2EEV255AT0dpLjfe3x814+l2WkXkxNRWwq3U5b7/24hDzASzvwGrxMSwdUCEH+0E881qMAtBkCq2FfuyM5pSqnUJ4DOhp9Dh6dWtnsglwP7WMMKUpiS6GJ2WPIyjRplTjffpgYHHtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLKdy3Kl; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d918f066c1so18855816d6.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Dec 2024 18:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734314844; x=1734919644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2kONODElXTF7fzOZdarCbTjwaqRs4Q8nMs3mV9hLMY=;
        b=bLKdy3KlbUXBeDjZ04kUfF6vaHd2HvWEZldynLKB5ynQ1Hq3cbyJN/mvmqMM7pGb/l
         u4LB5m0SJt3Oms8VR61ASLnYXrv056XR0u86qbGqnA8XGSbxDywgirn4KopMa63UBe4K
         Vp82WCQuKqm8sbzK26AjZJWTt4s6c7/7ctkcZ29dXz+mHYb43AL6/ZasSfuTVvK6Aomw
         fGW3mkuYQsF2fAoIDF/Nn+ehUZUe67u43TF74GZJhyCqgmAFxpV5HKemQycYjkK0sImW
         SbEeFaJ8fKvgzPhaYYqBF0iAQThiky4JFVK1YyqDjVhANC09P4EXOz6f5K375qhu7FvH
         S7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734314844; x=1734919644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2kONODElXTF7fzOZdarCbTjwaqRs4Q8nMs3mV9hLMY=;
        b=vrN1qUyicEMA8ximcLxI7r1WurOP+U5v58TO50+xLwQueAvoYXBc14LDa06iZ0FTHY
         1f9Dcvx0B9TmmkhE793AE4haO8jMXirzvnMLa9deVLVrs1bBxumGhvykSgRphBDZeXB0
         Fa6PrjOoc26zeJ6Z7eH+p/EjZayZseLBwmhwW/h5B1POoWcD9JzjeVr30wFcspfKVEVC
         kzWRtl3VMbvBpoZpkMDi8QPvdFWbGl9SwAggU3JhPQeGK1875nh0KvsMb3s4EKVD/T9q
         W63ZZVX/TzXiVL8uSm7eXS+bGyoMPWMTKqXNj9tP7TZzo/PA7xwRgVFreSC2edCWXL02
         OPUw==
X-Gm-Message-State: AOJu0YyyKbvAGIM5JdbjxnylbGB5v5sPQWabIBXAOyWjXYNLLB46RhQE
	BCGQKJ4dC+7ShOxcTqJNFEQMTKBUY2/tiyFR+WiYTfKKLpKJVEyOU9ayN32VdYNKJxaBNI1JFsK
	56BG793ti1fYDxD3bBsdQwPyWgxDb0w==
X-Gm-Gg: ASbGnctj417NwLHJS4WR9/g4eAF1prCJ8FDkWyWxdDwR5Om0BC2MqvoyxqIBYKx7yN9
	q77FMqsq2/cDSx5cGIsSHPj1GDDaqu3gxtckp2HE=
X-Google-Smtp-Source: AGHT+IF/JNqespJNG0dfyGH9NfZkdw9P62P6kyJ8K8mVP1tp49Yau19qbS/2psIivmStR4PU87GHkC1NDTG9M5m9WUA=
X-Received: by 2002:a05:6214:20a3:b0:6d8:899e:c3bf with SMTP id
 6a1803df08f44-6dc9032067bmr195958016d6.34.1734314843592; Sun, 15 Dec 2024
 18:07:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211194522.31977-1-etmartin4313@gmail.com>
 <20241211194522.31977-2-etmartin4313@gmail.com> <CAJnrk1bE5UxUC1R1+FpPBt_BTPcO_E9A6n6684rEpGOC4xBvNw@mail.gmail.com>
 <CAMHPp_SqSRRpZO8j6TTskrCCjoRNcco+3mceUHwUxQ0aG_0G-A@mail.gmail.com>
 <CAJnrk1bBFGA8SQ+LvhENVb5n+MOgg=X3Ft-9g=T_3JN4aot7Mg@mail.gmail.com>
 <CAMHPp_SkzQ6pzoiFh9YFp1vC+2JvJ1NDdXtor2uN-JzLeicVwg@mail.gmail.com> <CAJnrk1azDwJ0BFm7Y40XHqqHmDvsfPpw2WR9LeZTzZ6M5uarXg@mail.gmail.com>
In-Reply-To: <CAJnrk1azDwJ0BFm7Y40XHqqHmDvsfPpw2WR9LeZTzZ6M5uarXg@mail.gmail.com>
From: Etienne Martineau <etmartin4313@gmail.com>
Date: Sun, 15 Dec 2024 21:07:12 -0500
Message-ID: <CAMHPp_TvXdWNk-g9e5kVQKS7VwThnMT13kfGbhdJY9EkGWPFtw@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Abort connection if FUSE server get stuck
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	laoar.shao@gmail.com, senozhatsky@chromium.org, etmartin@cisco.com, 
	"ioworker0@gmail.com" <ioworker0@gmail.com>, joel.granados@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 6:30=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> > Yes, based on the comments received so far I agree that generic timeout=
 is the
> > prefered approach. Looks like we are amongst the few that run productio=
n
> > systems with hung task panic set. So yeah, I will match fuse max reques=
t
> > timeout with hung task timeout to get the equivalent behavior.
>
> Sounds great. Just FYI, the timeouts in fuse won't be 100% precise -
> they'll have an upper margin of error associated with it (this is
> included in the documentation for the sysctl, since it's very
> non-obvious). For example, if the max request timeout is set to 600
> seconds, it may fire off a little after 600 seconds. So it'd be best
> if you set the fuse max request timeout to be below the hung task
> timeout to be sure. IIRC, Sergey is doing the same thing [1].
>
Understood yes.
>
> [1] https://lore.kernel.org/linux-fsdevel/20241128115455.GG10431@google.c=
om/
>
> >
> > On a slightly different matter, I realized that in some scenarios
> > there is no benefit
> > in stopping the timer when reaching the last request because another
> > request can come
> > right after and then we have to start the timer once again which keeps =
bouncing
> > between cancel_delayed_work_sync() and queue_delayed_work().
> >
> > So I think it's best to stick with your approach of starting the timer
> > when the connection
> > is initially established. I can re-work this patch if needed?
>
> Thanks for testing out the timeout functionality. I'm planning to
> submit v10 of the generic timeout patch to use workqueues early next
> week. The time granularity will also be changed to work in seconds
> instead of minutes, as noted for Sergey's and your use case. I'll make
> sure you get cc'ed on that patchset.
Thank you very much. I'll take a look
thanks
Etienne

