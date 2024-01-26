Return-Path: <linux-fsdevel+bounces-9132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAEE83E5D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 23:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B62283B3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21F12563D;
	Fri, 26 Jan 2024 22:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Elzshj3+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB8945960
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706309389; cv=none; b=dxV0+KWDIliN2VkOaUxOar3zFfIKR5FgkxHa7VUXTWX6sla1E6Pz4te1qt9eXHAC40iWIrR4MHnpzghzITwVdaDVACLSzIuUa1HHgxb+OwAmJIYJ3WX5Xy9l21VfEqD9YZUrFLZjNT6BwTCB4km98WmWJb+4IESWEDXx9atg+7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706309389; c=relaxed/simple;
	bh=nrNcgKqKEthh661LXbilbwqQcwL+DlDRnFwg8jZPBIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F18Zs5+uMe36H5l2LzCc3WcSxpULHWKKmXBywPX/y6wS19StVUWmpLCBIXJS/xDnQ20pNaM8pJ4kLssxSQk5xYhc4r/nxVtdUMUZaFSoJnOmzHkkjWzZqGWW95FsKtViwugHGzuXywJKHvxewv3k1Qv3zD+gPdHeIKhj2kdb+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Elzshj3+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3392291b21bso1223447f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 14:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706309385; x=1706914185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mat57ocNjJ+2j0yfyUONN2djrK+fYcTcdMIfJXsJdeg=;
        b=Elzshj3+mtNXeaGiELhCIsZspMlq+JNzAmO+Dx8bMiTivsU5WSyxufsX0a2Hr9q7Bs
         mlV9MXE8vVm1B9TUQ4B3/2q8jGKUmF6ttTAmnT+LCFecEFpJuKsuYCWvIT9o+6peeK7m
         1fP1+kBrNncMRFRdDgA7sVxjjxcXbcHX2bs18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706309385; x=1706914185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mat57ocNjJ+2j0yfyUONN2djrK+fYcTcdMIfJXsJdeg=;
        b=jxJAPGHWQewtTmByDH5ea3FOVc6Zf5U+YI+SivzGU9ug//+EZjs6Do8iUXtJIRH9v2
         bqiyeKGLbkhO98fyz1DaW2f5gGh0I3GuM9I24QfSdhz85YIECDaWQPGy0sZQGXjsA640
         sE8h4W0Va8pxoGXZultiUqsnOByaOZg5pyBdyFc+SLoyZp3qgUbGTa71LPBynx+fFuAx
         eeD9haykBFYTg+skiyPyvhcRnn2RaWsLMbqnM8BBZDGFFtV2aGhQkxYIAXbuXBTDFn/S
         GlNBFPduyvAqj0O/6azt0dNlSHBPaDt/x3rSXBZNSv4iOs/CGYDuNTVpALGZ8QiXkaWb
         5sbQ==
X-Gm-Message-State: AOJu0YwD9afIrk2a4S1DnnQksnWMc0ZJ4pRZJPWMMgU9oKILNfZtOkRY
	Fv/HhZi9g0+0qv39pP8IIBXa1FgNCvvGsaZFneUHTsJVYB88plqA4hxRFFHQ6GelMNoBQDg44SQ
	k5uOmHA==
X-Google-Smtp-Source: AGHT+IGgingpcAVKY4Ph8hIE/WUqBK0iFeLJb7a8Y3TT1QuJRIOKELGiWwdR47JhrQvEcDiirDy8bA==
X-Received: by 2002:a5d:4e45:0:b0:337:8e76:ff16 with SMTP id r5-20020a5d4e45000000b003378e76ff16mr230957wrt.53.1706309385539;
        Fri, 26 Jan 2024 14:49:45 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id i23-20020a170906265700b00a34a3751a9dsm1079616ejc.102.2024.01.26.14.49.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 14:49:44 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so612307a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 14:49:44 -0800 (PST)
X-Received: by 2002:a05:6402:b51:b0:55d:37ed:c0f0 with SMTP id
 bx17-20020a0564020b5100b0055d37edc0f0mr256645edb.2.1706309384299; Fri, 26 Jan
 2024 14:49:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <8547159a-0b28-4d75-af02-47fc450785fa@efficios.com> <CAHk-=whAG6TM6PgH0YnsRe6U=RzL+JMvCi=_f0Bhw+q_7SSZuw@mail.gmail.com>
 <29be300d-00c4-4759-b614-2523864c074b@efficios.com>
In-Reply-To: <29be300d-00c4-4759-b614-2523864c074b@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 14:49:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjpyv+fhxzV+XEQgsC+-HaouKT7Ns8qT31jkpN_Jm84_g@mail.gmail.com>
Message-ID: <CAHk-=wjpyv+fhxzV+XEQgsC+-HaouKT7Ns8qT31jkpN_Jm84_g@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 14:41, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Yes, there is even a note about stat.st_size in inode(7) explaining
> this:

Good. Send a patch to do the same for st_ino.

             Linus

