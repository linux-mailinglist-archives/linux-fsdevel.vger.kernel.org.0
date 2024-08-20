Return-Path: <linux-fsdevel+bounces-26343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91513957E5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 08:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495E1282C4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 06:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000801E6752;
	Tue, 20 Aug 2024 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMi/vOG0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AA61E2122;
	Tue, 20 Aug 2024 06:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135678; cv=none; b=u6gISV62KybrXl+5CchUYgnWDU+PajXWhGl/YxjGpLJr00NX3Kru2BNIdKwkjT/QLtFcg74NEKGywsR1SfhO/LChPkTroT4XT130qRf+FkWgrCpyEAf6SEUSmNQjJBXAhgymmtctPQi9QPXV1QmLxSVFeiaIm+8nAV/RLKL+pq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135678; c=relaxed/simple;
	bh=Cp3w7kkVxT1uWBiSkJuqzh8y0qcCGvAe5kQ4ewJ5zHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfsLQmtZSm7z2jSXHOsjvPS+9Ja6/bTtivGY2/H7+JErL2neFRIufa0J2XFQypVtKU7TkL6fSOAmQ5CSUJogPBoKC1VzRe8dXXn6ydrD7ztVL7UE+Unxqqmn+RuNXqeyXHASE32gWmsBzeaxGpRF49+qjqtDNc5Yp8aPuBoi8K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMi/vOG0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4280bca3960so44799175e9.3;
        Mon, 19 Aug 2024 23:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724135675; x=1724740475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cp3w7kkVxT1uWBiSkJuqzh8y0qcCGvAe5kQ4ewJ5zHg=;
        b=aMi/vOG0w4Ujctyqn9JdNEMZot+mwgry6EY1K+2p3E76SrYdPCfvRbXWP+twFoYWCP
         H7Ky+JnCrF5RfFHOjm1EbSCEtHKiI69HzcsBFvg0SXR+89uYMe7lbLq6iz7/pYdLjhRB
         WsO7X5PnHagvB1+l1akD3vOvmRShzp+fBPYzD3WychOBGLyanwPzcmrNgOH7TM8kDR6w
         1bwvv2KjmsqNsJGHaU2q24RueNNVfj8MRJo2QW3THhJcCOTf80VIC9kfRvxpqps7M35c
         OvyUMysOlxgl/PPFQoJ+BVOSlx1+iLGZqNvdelAKb+AzEffL1T1oO/z0TDYRuJ8ErW6+
         QgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724135675; x=1724740475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cp3w7kkVxT1uWBiSkJuqzh8y0qcCGvAe5kQ4ewJ5zHg=;
        b=gOj9+lfbykWidLGYX3sYOlkFRZ4fWXRmRkyhIs2EhK26fPYjDfFMU5CLa0Ct+XQvp7
         MkBGK5a0eDOGFe5Fv6jcREucSlyTO2K0YBJesdL1zWEERt3atnb5HXnQ2Y+fxmee7ikb
         db4zK3MYkhDQiUl2FxR/Raw9krb5SkqeasUeZzljFaNIJ/J6lbFJ6bun/apa9oYRUCS3
         CN0OeMxopxJ1KAkwZ/NC+GjduiClszT7/DZt1KxU8J00bpoDs6ipzMT0binahYBarF+m
         QIxHrcV+L1edSDQ+iaM5BxgLp5VC1eBpXfYeFpwN/iEC/1Cb4fEzecCELfg2LYg607hs
         khSA==
X-Forwarded-Encrypted: i=1; AJvYcCUHDiIOVPg1g91eSD7OGexSLDOFJvS3zcMkHGHVztWvqoYcTsPxyX1my3iKjmxl5WBd2+3lyDaC/vLhbpfRqIvjbUUT@vger.kernel.org, AJvYcCUJ5Z2+yEWh/CRA8eQvvtD/R+pbemEekHTU2kMxl7R9gxqblUpwiz6n7iESUst86PtpJH01ugJmawwJiRzhsg==@vger.kernel.org, AJvYcCUJC+giXO/G+aMc5k0Zwp6AbUbHVNgnf+1c9N3APxDh6joo/EFoa+UfQQ4QTjidce+QKNSaGcoX6AGS762l@vger.kernel.org, AJvYcCUWftmaz7HN34cJrsabgktD87GlhM4op9c83UGxLEnW0MYn91om7DaW/N/1FuDPrfX+1W2Mept+eQns@vger.kernel.org, AJvYcCUYo3pZyseWL8Rd4St27B6ilQBBF1kwYlj0YzOmBnDRGGHvbaQjel1RUk+dEthY4BlUrVP7uYSE@vger.kernel.org, AJvYcCV0YfjI+lkLrSE9VmW5gSnZBigdVF/gHk+x5/FNQQSoy2EgQIcLDG35lyIO9iM+wRT2Ia0WO+dewGIrjLh5mPSH@vger.kernel.org, AJvYcCVKX6LoBJMKg4DlseA0aT3Pt6nLmqKg70sUPox43oZsc95LTZwj8oeyCEzCBVVtmEU0NZwucOzw7k66lRcM0X9S@vger.kernel.org, AJvYcCWboRS8CSBbE9+epPETx7FSt6DWFSfq4fagxTl/B6WOVvpKjIQibierJ8P89Mno7iJ6Gl11N1dHVBzqXzE=@vger.kernel.org, AJvYcCXjmZW0MVweeOUmZH20WONnv6dIAXZN8tYdgPjaNUl6ws7omwM6pfFfBdITk7cR9oET7v+spaYR@vger.kernel.org
X-Gm-Message-State: AOJu0YxdYOX985kSnkyz8+Y7BFXhKep7fL18Y/djYC9kVMsaK7Tq1mAn
	Q048aFSrIh1KR66ZIP2aICBmzQw7WRUTKxon82zJyDnjfH06q97Mnx5VvD7NLXcPUUfc/SO6Iwo
	coSD0lqwNLwY1WjjHPC0H/BggP2M=
X-Google-Smtp-Source: AGHT+IF6za5LfGR9PignCMfdAU4RNKydBE/DzDRowSAFw6jEwJKhTPBuMISHwbyJUdIMUQaOdSTMFb1oGckbgA2aLOw=
X-Received: by 2002:a05:600c:3ba5:b0:426:6667:5c42 with SMTP id
 5b1f17b1804b1-429ed7856camr83213885e9.4.1724135674405; Mon, 19 Aug 2024
 23:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820000245.61787-1-technoboy85@gmail.com>
In-Reply-To: <20240820000245.61787-1-technoboy85@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Aug 2024 08:34:23 +0200
Message-ID: <CAADnVQKYLu4gW95gK=kbFUCT+vCZtb595vdd5jVNVzcLn7qsiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: use kfunc hooks instead of program types
To: Matteo Croce <technoboy85@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	fsverity@lists.linux.dev, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, netfilter-devel <netfilter-devel@vger.kernel.org>, 
	coreteam@netfilter.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Matteo Croce <teknoraver@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 2:03=E2=80=AFAM Matteo Croce <technoboy85@gmail.com=
> wrote:
>
> From: Matteo Croce <teknoraver@meta.com>
>
> Pass to register_btf_kfunc_id_set() a btf_kfunc_hook directly, instead
> of a bpf_prog_type.
> Many program types share the same kfunc hook, so some calls to
> register_btf_kfunc_id_set() can be removed.
>
> Tested compiling the kernel with -Werror=3Denum-conversion to catch all
> the occourrences.
>
> Signed-off-by: Matteo Croce <teknoraver@meta.com>

I think it's too soon to do this kind of cleanup.
We need to refactor this logic to accommodate sched-ext
allow/deny pattern for kfunc per struct-ops hook.
Let's keep this code as-is for now.
pw-bot: cr

