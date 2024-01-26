Return-Path: <linux-fsdevel+bounces-9097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FD183E228
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 20:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9105BB23403
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 19:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4831C224C2;
	Fri, 26 Jan 2024 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cb6c0M8u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129D521A1C
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 19:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296014; cv=none; b=T6tyXSPMUsP7K5W4Au9ilSRseCDJC4Hw4JTCKenD0DhHgIxnbpDShKgTJjZe8yll7C5gfagoN160rqibYvoVc+td30/kV5B7CzhWSpKA0VbVxTHtapFW9lsltFl63ru5cRKLf3lH4ZuT0z2wsMzl8kx+pFKY4RLnN9GFjDxfs0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296014; c=relaxed/simple;
	bh=u4QMmyhqfZPexfauxvPU4+cj2+a1AaNdzp8EfyoHBcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B54sMHPgt5jZirKOhCBQWxg4h0PKHgWMz09JKStpaJ+7lRt/Ysfp1e4SDkGmWarGS8aAdVTgnIe8z7xSkhC/IXGgH6O6GT0jHBpcCdaj4Ldmq31bqhnxisxcrGM/Lext+yKn/x5M4qsuSyvneCKl9m8Ddwn75KAQ0NF7VoTQoi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cb6c0M8u; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28a6cef709so69823866b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 11:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706296011; x=1706900811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1dP7C1f8EQhzrHBctOG/vK1/Bgm4Z5gBZgBjg0ZQiw0=;
        b=cb6c0M8ubZW7HoFcqS3ikmBd69xWIDX3NWURSzf2rVUJTGOo1yj24X8aRCcuJichXM
         XXQh14UkDG3utibOXs7FNERUc/TXm9BGElsuszIlLEsosG7V7AiHgu5Z60uzwjhX6pEp
         eN74UJ8lMUMV9WslrvJGyDN5CYFooLUArHp7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706296011; x=1706900811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dP7C1f8EQhzrHBctOG/vK1/Bgm4Z5gBZgBjg0ZQiw0=;
        b=icA7tBE/EIMaMy3/A7W4zQeSNEos1DWcPsuLLAUk3K7BhGlW8s6Ma9Vw/hRWKhj5s0
         wjbUgaZYOUp9Ib+RWsiSWelwaj/e+oHJIntw8ervT0VeOW35R7M5G25oDUmi9v0PpeHX
         2PQUOAxtBTpl1/haE+kO1NnrB7uV2zhtheTkaIMXCoPCAFSccQVbt5305sHMSfEdzQoI
         rqN77CqgTi6zSX624enDMUH/OkEcss9P2A5zzH5zHrK499d8NkpxwNgHtAK9B9WBms1E
         0kQH83wZxV0JRLaw5iKksWQh8FtUGZDUjLqKEqtxt2K1cSHu/R96wu+3cFp1UiNLumPZ
         NRQQ==
X-Gm-Message-State: AOJu0YxnhQu9IKnITYqYnaWnmntQGJaUtVJA9subnelVfCTzMiLIpPua
	AFFEprmmK2f68n81ZwGXktf/JQyM5GYNTG5dV1MUMsPDIRl6U4XhWiAhBvrGkSTEEhghu72grRQ
	x3lS1XQ==
X-Google-Smtp-Source: AGHT+IEwtVmjrW8PeQlGB5FKIg4lfe2mfoNVtokBu8LBF4wfDDVNl9Vm0WLgG0V3uHErZOABtZmAPg==
X-Received: by 2002:a17:906:81cb:b0:a2f:b9be:66df with SMTP id e11-20020a17090681cb00b00a2fb9be66dfmr78814ejx.17.1706296011138;
        Fri, 26 Jan 2024 11:06:51 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id p7-20020a170906784700b00a310f2b4b91sm920826ejm.48.2024.01.26.11.06.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 11:06:50 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55790581457so541476a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 11:06:50 -0800 (PST)
X-Received: by 2002:a05:6402:1d9c:b0:55c:d7f5:d1e1 with SMTP id
 dk28-20020a0564021d9c00b0055cd7f5d1e1mr89897edb.22.1706296009700; Fri, 26 Jan
 2024 11:06:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126131837.36dbecc8@gandalf.local.home> <CAHk-=whA8562VjU3MVBPMLsJ4u=ixecRpn=0UnJPPAxsBr680Q@mail.gmail.com>
 <20240126134141.65139b5e@gandalf.local.home>
In-Reply-To: <20240126134141.65139b5e@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 11:06:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjTECUZLBgALpvm9zDN8TJCGxyc3VCEXXHMsFNAN+x5Fg@mail.gmail.com>
Message-ID: <CAHk-=wjTECUZLBgALpvm9zDN8TJCGxyc3VCEXXHMsFNAN+x5Fg@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Give files a default of PAGE_SIZE size
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 10:41, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Fine, but I still plan on sending you the update to give all files unique
> inode numbers. If it screws up tar, it could possibly screw up something
> else.

Well, that in many ways just regularizes the code, and the dynamic
inode numbers are actually prettier than the odd fixed date-based one
you picked. I assume it's your birthdate (although I don't know what
the directory ino number was).

               Linus

