Return-Path: <linux-fsdevel+bounces-24954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132CF947055
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 21:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F591C2089A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 19:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D806136330;
	Sun,  4 Aug 2024 19:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gWcDPCgm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75671171D
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Aug 2024 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722799107; cv=none; b=LlTcy5yLkbYlqnBwPRD8+1fKzEeebEvC7OihJPU25hvnRHiaTP/3cm/9Fi2Ws9pyWuKsKaC8gDxYqwEbKqfSSQcoMFdirloMofmrw8YhGBu4ezlQkFDF81akIGTAcwSzJ+TC+LfwZZ1XbO1hN52Mzh2Q/HrIQ3SGSokPTPMasM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722799107; c=relaxed/simple;
	bh=Ue6l5shIUrT8wMm17lIP3BKxCaSy6fSCFmIivr24iwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQ1DRkHdVD6CX6AtNOWt0j8PN9Ojc4ulMpIPG0ZmwAM7z1SP/aIKjrO2Citao9NoeoEQ8yU9L1NfPsrzRQPjNt1PWIGjr905d5ISEy6igYjxpaCXo7Wf+zHhUBoH0HFcSeJHbIBjwdTmk9tFnLOLstmUETnOxaXYLKKN2i2BRe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gWcDPCgm; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso10083946a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Aug 2024 12:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722799104; x=1723403904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uxT8jHbQgsljoFK5tUqYBXZZvkA8DBMp9CWiKYLgVTQ=;
        b=gWcDPCgmzVnYpr9byVBJfUdhPBkmgZF8AkuqmFJQQERZ5fAeb/vBpiT8pazXKXsNsW
         1Qs5b3Bj0CGlHh8tr2DPyBwGhecZ+jbBBOAkC5EjEIFjwykKFo869jGEdc5rngjP1Pae
         xkrP0xSCoxAaiCPIqTUCJiKuBSHhNPBj8U3g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722799104; x=1723403904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxT8jHbQgsljoFK5tUqYBXZZvkA8DBMp9CWiKYLgVTQ=;
        b=rtNbt/39i0t8xfIHfTGYjcYSTEz59hf1N0CJoziTbqN7i8exMQNL9tCYVXu8ZODPOl
         ty9eT5HttwL7AYKU97sNCZkzJ3bkDhNgPY1iwyV6OVf1PoUOWW/d8YX5bJks+3E7urCQ
         9zRg8k3o8CBe5RSJn3eCjy6Iz/V2IfEsaqVNYGkC8pmV+CuaRTL3ww0lksSnMpDB8/si
         evGf3JS9GcXQH80ACk+6NKpGE8QoRT4thUdKmu8msK0HaTZLdgVfeGZVEDnJHtQAm3Ru
         xxMkN7C9RjUkjFOZhu9NxJ+QVp9Gv9lGgKqc2tXgI2yy4wU80wb5ODiuEtY1UDSrV9pj
         oeyA==
X-Forwarded-Encrypted: i=1; AJvYcCUBiHY21TRSHAVAF0h9hJVcBb8Ys5Jx5yWnE+Vww29kQc13lGhpYRnfI8PO0k1T2RRKvOX1lTP4tqnqGmtOScePKww8EUl0Fqym+7c/CQ==
X-Gm-Message-State: AOJu0YyhBPKxaNxXY37egtQlwfvUFNJazaz0Gis7b/PdhRiOMyuhfV1v
	E0v51wWvJLjWkqGMngvvc9CQnb41A3oKbABdPl0ygTPB94Xu+reF5ll9uaq3r/EZDhWF1OXHz9y
	5KEfdOQ==
X-Google-Smtp-Source: AGHT+IFF8LkPVbxvqyKgf+GVg8dvvln+BHH91+2OgqhmphISs9M3vTv1UPrgXNqFuNEm9O8m7DkvOA==
X-Received: by 2002:aa7:d501:0:b0:5a2:6e1c:91e9 with SMTP id 4fb4d7f45d1cf-5b7f3503eaemr6468545a12.7.1722799103847;
        Sun, 04 Aug 2024 12:18:23 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83bf3ad38sm3914299a12.84.2024.08.04.12.18.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Aug 2024 12:18:22 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso10083932a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Aug 2024 12:18:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVunYB3S29XCPfxaYxP3SCxvkG5rmBd+gWm1ZzEUkvo/jfjCAxjeh5dAbwlkFoSnR7YqEhcAiJe/4m2C+fhfg3SAlk6uLpbvUj21Yw8w==
X-Received: by 2002:a17:907:1c92:b0:a7a:acae:340e with SMTP id
 a640c23a62f3a-a7dc4fa3fb7mr733558966b.26.1722799102160; Sun, 04 Aug 2024
 12:18:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <C21B229F-D1E6-4E44-B506-A5ED4019A9DE@juniper.net>
 <20240804152327.GA27866@redhat.com> <CAHk-=whg0d5rxiEcPFApm+4FC2xq12sjynDkGHyTFNLr=tPmiw@mail.gmail.com>
 <20240804185338.GB27866@redhat.com>
In-Reply-To: <20240804185338.GB27866@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 Aug 2024 12:18:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjr0p5CxbC-iGEznupau936D24iotTZi7eFXqgKX-otbg@mail.gmail.com>
Message-ID: <CAHk-=wjr0p5CxbC-iGEznupau936D24iotTZi7eFXqgKX-otbg@mail.gmail.com>
Subject: Re: [RFC PATCH] piped/ptraced coredump (was: Dump smaller VMAs first
 in ELF cores)
To: Oleg Nesterov <oleg@redhat.com>
Cc: Brian Mak <makb@juniper.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Aug 2024 at 11:53, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Apart from SIGKILL, the dumper already has the full control.

What do you mean? It's a regular usermodehelper. It gets the dump data
as input. That's all the control it has.

> And note that the dumper can already use ptrace.

.. with the normal ptrace() rules, yes.

You realize that some setups literally disable ptrace() system calls,
right? Which your patch now effectively sidesteps.

THAT is why I don't like it. ptrace() is *dangerous*. It is very
typically one of the things that people limit for various reasons.

Just adding some implicit tracing willy-nilly needs to be something
people really worry about.

             Linus

