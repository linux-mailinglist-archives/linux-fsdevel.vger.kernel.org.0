Return-Path: <linux-fsdevel+bounces-25828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD51950FC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 00:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51D91F24235
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 22:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03EB1AB51A;
	Tue, 13 Aug 2024 22:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+j9ex3p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85654189BB7
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723588301; cv=none; b=OTXtD+rmmWYDeD8UXLi/7rxG+2rr58+kcW97orRpCf0bos5FvhAEw7wLMLDcezGp4OsszbauM6iOTbDrVwUHUmlxje15Yq0M6QNsBTn6Xi4iNZgHWIvxjsR7gX+9bEQ/3yRBsDVokXsGwM7M0GVrfuQhUMXIHHCyb6S6nSDdke8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723588301; c=relaxed/simple;
	bh=PjDal07NYOKBjkEkz7/rPrI2L3lDW5tzH1NRX7vsX+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLNwgaR6zyAHOYr2gkieInoOn7RHpiNXM+bbHk6tWzVoLc2HusXyt/KfE1GW/eOFsxp6Ncy1VeNI2jcEZ5cc4bdwJW9vNDP4sGRUcymUjSObqCVeDZbbhczY9ObmRYEU5B7V4kaTx0mGIkk8lbltpy1Lo/Ht2MdtiFz/CU1Bo+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D+j9ex3p; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-82c30468266so1984927241.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 15:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723588298; x=1724193098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjDal07NYOKBjkEkz7/rPrI2L3lDW5tzH1NRX7vsX+E=;
        b=D+j9ex3pJWeRWjq0NBYRAHJ12rIjeopGts0r0GTgjexMWWliauckLTij+u2/DtqaWn
         IPQXwFUz1MUSigu0oPStUaFqzldIUc6ZItrjzNZ/XMk8CJsMoIBgaw6AdgZAnuJ74Mif
         HxjrmmUY7YEzRN4Age1V1a/oYDZTMq+Ml6HWBArv3qWfb6CB9PbAegBWfG+qzwhxG1RQ
         8SxkWeeBd79wsXNDRQvBmgxkybLm6z0e9rqqFzohuML5RHyHVhs4s4sDyHpNo2DNY+wi
         +Uz/c6UKDHSB47b66QDOI2Pe1KXWo0XtrMjFe0TmfKB0ldc351LTEsWBPcRG8r1WJ/Bt
         079Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723588298; x=1724193098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjDal07NYOKBjkEkz7/rPrI2L3lDW5tzH1NRX7vsX+E=;
        b=LeNQDix4K0DvNtzTKy4+11qP2Ps9e2NXPPp+kkdP9cd7Adz3GdxBC18eExzV9MZSNS
         zWqZ4UmC1X39HrJ7v8tAQak2Ges++Dmy/JcZccP3yroKqmRWxG7q6JcbI9HT6HilRBky
         aivtY+scxvEO4L9Iyb4KpemkiRPb744zlnY/fs85id7mX3FQajr7CNSMUXTbuKwlquzg
         pOCNOYRDQAhspcrOatWYTZJJXhVw37DxQl80prvnUtQhH8F1jrcKbCtcecLE2iNGSv1a
         qi443COL3m1fTSCjdKov+F+xig9WdEiwBJgfm/6TrcZNgUUx/F2TCuO09iPWAin8Y7qO
         mifQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbAfvnJh1PHEpOVUbX28kF6a8wtc1v17HIn9PJPpxzGyf9HtjoocsPajjmHCzaDnemb0/7epy3Auo/5Sq+0JDoGY1fQoWHszGrPoReqw==
X-Gm-Message-State: AOJu0Yz3cgdFdFBOPD4GX3riHPRJu6yIVtXj0ohNBduHYNOZXsq7WoaY
	ysQXRp+TYnyiQnCLmPBTq0BfF7cfOjn3dJDAO21TauKQdYcyuseXu5LbjcdqcBtN/7HbA6AQPGW
	9FNs58aZY6jU2O8EgzxFXDhS8f8tgEwUcr7By
X-Google-Smtp-Source: AGHT+IH/QraxU2fjWjOPkx0WDZKuaY29L3Zen/pzf+3bC1KTX13QSkaN1GEjq4vqJeNmusG+MLJVL3jxUBZoAMXwy+8=
X-Received: by 2002:a05:6102:c04:b0:493:b4b5:4850 with SMTP id
 ada2fe7eead31-497599e9a02mr915097137.31.1723588298200; Tue, 13 Aug 2024
 15:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812022933.69850-1-laoar.shao@gmail.com> <20240812022933.69850-8-laoar.shao@gmail.com>
 <hbjxkyhugi27mbrj5zo2thfdg2gotz6syz6qoeows6l6qwbzkt@c3yb26z4pn62>
In-Reply-To: <hbjxkyhugi27mbrj5zo2thfdg2gotz6syz6qoeows6l6qwbzkt@c3yb26z4pn62>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 13 Aug 2024 15:31:26 -0700
Message-ID: <CAFhGd8oBmBVooQha7EB+_wenO8TfOjqJsZAzgHLuDUSYmwxy=w@mail.gmail.com>
Subject: Re: [PATCH v6 7/9] tracing: Replace strncpy() with strscpy()
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 3:19=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> Hi,
>
> On Mon, Aug 12, 2024 at 10:29:31AM GMT, Yafang Shao wrote:
> > Using strscpy() to read the task comm ensures that the name is
> > always NUL-terminated, regardless of the source string. This approach a=
lso
> > facilitates future extensions to the task comm.
>
> Thanks for sending patches replacing str{n}cpy's!
>
> I believe there's at least two more instances of strncpy in trace.c as
> well as in trace_events_hist.c (for a grand total of 6 instances in the
> files you've touched in this specific patch).
>
> It'd be great if you could replace those instances in this patch as well =
:>)
>
> This would help greatly with [1].
>

I just saw that Jinjie Ruan sent replacements for these strncpy's too
and tracked down and replaced an instance of strscpy() that was
present in trace.c but was moved to trace_sched_switch.c during a
refactor.

They even used the new 2-argument strscpy which is pretty neat.

See their patch here:
https://lore.kernel.org/all/20240731075058.617588-1-ruanjinjie@huawei.com/

> Link: https://github.com/KSPP/linux/issues/90 [1]
> Link: https://lore.kernel.org/all/CAHk-=3DwhWtUC-AjmGJveAETKOMeMFSTwKwu99=
v7+b6AyHMmaDFA@mail.gmail.com/ [2]
>
> Thanks
> Justin

