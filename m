Return-Path: <linux-fsdevel+bounces-27579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AB396280B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168B21F22A0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8653918784A;
	Wed, 28 Aug 2024 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glE3HYO7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63203172767;
	Wed, 28 Aug 2024 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849942; cv=none; b=TL3Y9b0fq7w1iBJyIcFCPNQkrEQQIwQxS9PSskZuYaSboturzYVNk5aG4Rs5zMqmD7za3mPjt921xGDS7BF+YtsYccU+H4obWyCdDgzb0dxAKO0LMWYdylzFUO4FNGfeCVe8+YWyhTk5G6DRdJXEbvhZdGRXa+mYxEtKmb3X1OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849942; c=relaxed/simple;
	bh=pH7WFnf9Z5U9s40gHaojKFntzdW0wQvoSDRbtMTVsPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slw7vPuKI6i0G4dofiLoUkrKa0SjOLUpePyPKNTJf2NZ37gURf/fM0kUjaIMr9vMgFD9q3Jcd3qN9LO60Ud05t3BLaRt76UJ2N0yoJBWxTsNt1VVve7RR4eXuNQ0bZlKcy7eXmu4zsbKH+GW/RVUUexeadDap289fp5342C9x7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glE3HYO7; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5df9433ac0cso57204eaf.3;
        Wed, 28 Aug 2024 05:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724849940; x=1725454740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pH7WFnf9Z5U9s40gHaojKFntzdW0wQvoSDRbtMTVsPI=;
        b=glE3HYO7TUbpBAS+SRDfmOdDzC27biH2FDDvZ6gbKiN+A9ySBHqbs9Hr7taUBHNtRd
         GHQPVEKloqN9LM/qq/QUQ3X+qzDSFEG39by0+ALBG2JVkE88ZWI+aXtfRH/Dl4rmXYz7
         ZCFOb3+9vif75gnxal9HbnV/bh2ftsZ6NIzaeTXEgwOs/rqxPVzPlayak5nfmmJoHg02
         4ikYHhecrBkc9qC9NoR9UHLOV+U4M7RtgFZmIl2Fooawh4y/97PLe8mZmxHJ2DKf7wuE
         NWIg7yxmqODSNk/JlkfpV2v7+NAEW+0WbevpmFPkSdSW1Rs2eqk4XHCWh6WgEoY4rW0b
         zyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724849940; x=1725454740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pH7WFnf9Z5U9s40gHaojKFntzdW0wQvoSDRbtMTVsPI=;
        b=CW9VC00gvbBKc+tLt/77nd4MV4ssrEy0RCPcnD41rYvRSNdD56v8DS4IbFDsAhPwUv
         Q8OkNuKUa1LrF3KFcdp/7QA6eyEj5rH9wvuII23XA9W9Dju1sJDgSpDfllVjKZcjOFLw
         HecAxcYXnLery4XUv6oLbhYoMKPYMk1g6HZ4TjZ4WvHexiWld2pYHfPNi/9OQ2drIUkj
         rhg1B5XTtGLRrXDLMTY8XGnBt8Do25XsRZ5c3NM50qV/mf6vGmSOTnI8/K646RkaILrd
         u6Wf9xARG47nQHUYJucYt/l6EE5urTJFaPmwrQWtEPB0JFKGLEidqYrVyZ3mptpkBlNA
         vuzg==
X-Forwarded-Encrypted: i=1; AJvYcCVGDyiPQEE7CAcS0PDE6W49p5MxXFBM80da4QovK8oJMwYZhcJTolwn6xoo9XqFU9ru5TWo/1SH@vger.kernel.org, AJvYcCVXQxDw5gd1JAe65HLYeeiRFxuVpO61MNeRrxJsNwNvOwZRl/Z2cpNEbxGXjJzC2kDRDeQIw+RDZHQBQm/8MY7GrYsT@vger.kernel.org, AJvYcCVjIaHDB44+/3HG8u89FnEtF8BY6x8QbMo878x1Q69N8PGLiDofnVx2PZuIRxp/2Xkh0jn7+lprGblxJRaLcw==@vger.kernel.org, AJvYcCWZ0zJw6dveMgiDtl7w2GiBliJpHsr5zqlBDaveLHpSvjR0KbZpOITfsnBB76ROtLVclY0kjcQh3FIGE/8WhLrFYDPJNDA0@vger.kernel.org, AJvYcCXVgGeYau45TKBlqDIpn3bSpLtkn4lM3XSCtCW3Ml0I/PwQ2XRWVtNGNmNvJP3dGTCaFXzBxQ==@vger.kernel.org, AJvYcCXb+gPx9faU0tAzP4q5P44MMgcwdod/dqoMBsQd1RoMdDk758/JCpI/EwvcFLYPVXHZkV8fzFXYow==@vger.kernel.org, AJvYcCXsIhnDTOqKOTtOwmiHfuhD6+f8FMKYiMukHd9qdOAV+Y8uxSjv2rjZsD6gySMT/nCbIAhl@vger.kernel.org
X-Gm-Message-State: AOJu0YwjiCXcIPH+4w4qMSNJHYZH5AXa/ITIv4eJbAEZVL1J4x999o2W
	oHH5NeuLTt+xbLrWi+m9lYWTDfN/UYzksDfO4SS8KlLMw0bK0TEvgQwq38cQl8B8tBy8awBZmlQ
	3tVimLUtHLT/oY6jZtpKkFJasvwo=
X-Google-Smtp-Source: AGHT+IH+dDHakcMPvkuKOsY8mULW4jaimlsccjCHmLOHF71l0LdgzI569jfkq53KV+Wjzqed0wUcjeuwQ65gQxSdFXk=
X-Received: by 2002:a05:6820:1611:b0:5df:8577:e7b with SMTP id
 006d021491bc7-5df857711e2mr1981136eaf.0.1724849940444; Wed, 28 Aug 2024
 05:59:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828030321.20688-1-laoar.shao@gmail.com> <20240828030321.20688-7-laoar.shao@gmail.com>
 <byi4tx6l2lrbs5w6oxypr44ldntlh4kp56vnsza3iuztwb37oa@2qtdx2kgz4bq> <bbdhr62fk7jts6b4wok6hpbjtoiyzofbithwlq7kl5dkabn3bz@3lf47k4xrmhc>
In-Reply-To: <bbdhr62fk7jts6b4wok6hpbjtoiyzofbithwlq7kl5dkabn3bz@3lf47k4xrmhc>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 28 Aug 2024 20:58:14 +0800
Message-ID: <CALOAHbBC=2g0R=zM0iNXexMzaJq5rKykM=4rSGbNLLwGja1-HQ@mail.gmail.com>
Subject: Re: [PATCH v8 6/8] mm/util: Deduplicate code in {kstrdup,kstrndup,kmemdup_nul}
To: Alejandro Colomar <alx@kernel.org>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	justinstitt@google.com, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Simon Horman <horms@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 6:33=E2=80=AFPM Alejandro Colomar <alx@kernel.org> =
wrote:
>
> On Wed, Aug 28, 2024 at 12:32:53PM GMT, Alejandro Colomar wrote:
> > On Wed, Aug 28, 2024 at 11:03:19AM GMT, Yafang Shao wrote:
> > > These three functions follow the same pattern. To deduplicate the cod=
e,
> > > let's introduce a common helper __kmemdup_nul().
> > >
> > > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > Cc: Simon Horman <horms@kernel.org>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: Alejandro Colomar <alx@kernel.org>
> > > ---
> >
> > Reviewed-by: Alejandro Colomar <alx@kernel.org>
>
> (Or maybe I should say
>
> Co-developed-by: Alejandro Colomar <alx@kernel.org>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>

I will add it.
Thanks for your help.

--=20
Regards
Yafang

