Return-Path: <linux-fsdevel+bounces-8781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3E083AEA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 17:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566481C21F77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 16:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D2B7E57B;
	Wed, 24 Jan 2024 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YY7UOkgr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B629E7E565
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114782; cv=none; b=h1VKl+kZM6Orrj32AFwrRCvAiNBiDR6DMgeVUBz56m46zW+1J96pER0tcYVNwarmWuE0vg40TiKhdNOOfqEIDWiXulhIrifgc+hslwfM9MbcVmB288bxoFO8BtY/4NbJhRB7oSP0dyGxeFhfBqhrcvosRyuRIUga59I9vitXxGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114782; c=relaxed/simple;
	bh=2p6qpEQ0FQqgHQ9MZJ6hGygl88/GlnO048hMSuetf9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJPh2Opgloi/Mtkk0KvhG/xU08J2J7e08j2C6Vfk6pW2WfaHFsx79fneMF4bkGH6FkNqq7+hSQfEAvo3GUlqBuu6d6lTB95V9VI7l0TBJboAMxwThh1t1nvZzeIcleENoXcU+PRoB54G/f3DA/fy/WZvP8XX4eQQMn38gQUUrA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YY7UOkgr; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55cd798b394so894506a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 08:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706114779; x=1706719579; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gAV9hUjIFjsOqBZPLiRvCMjNyiBrTHJa47CjdZfZGyc=;
        b=YY7UOkgrcoCkIX9HqOfeZH8cSOfYV6pc/n8VKZU0XbyLxyHdiys8pSVs7rwd77w0GC
         TUKKwav8anLAfrDlGvosBw37C18eteHk+RuJ/fKCTRKu0o4KsYqXalEATj2YGGMW1pj3
         HeNB/USxnnHNxIppfWTefrcoRnGetzQ+Zt8iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706114779; x=1706719579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAV9hUjIFjsOqBZPLiRvCMjNyiBrTHJa47CjdZfZGyc=;
        b=lEmG/vSPBZtNeC+Wxp6oBw9/MTWMVXJ53dShEzSUbMdT+MXQIdjpGR+dVI1+DsIACJ
         3CYjLPMw2/MBQ3dzGKZGL9YQickCPipcEY+G8seEIexSDqAJZi9kCyoTcyv8lubuUVJS
         rKV5TkM2QcON14Wvq2zzQeCiTOIQa/ALynzRrFeT6EBMbpJid+Zm23gRk4TJljjUTXnX
         JDbj+UrsxjKWd6ykxUwisfoiK1ZFbhtqD0vV0bborjZhgrglGjjeXmR1wqGlpYk09d2o
         hGaVueQac3XEzsh2LEFIFqk8uYi2RJDvNJrAPZuhLFP4FfTwHRGqXpGEfypVBmzcF5Bd
         /tZw==
X-Gm-Message-State: AOJu0YwoOX3E4XVoq6r5HeUwTo340CjKSBRCPKA0UTOISQzW+tpmZaHU
	r6fwEa44cjpZNAu47PVybLMJVn4x4d4qNbGx5VW8F+cNARUFPtBq4X6CvCbxTmyrZ7WtiNfCXOZ
	AqroXhg==
X-Google-Smtp-Source: AGHT+IEx8ah6ljfL6t7OPHKqV6ID2YL2PUlZ+gyknkd13iIt04NBZpwCm0Y8NztuTR4ISYpXCgVFAA==
X-Received: by 2002:aa7:da44:0:b0:55c:d773:95dc with SMTP id w4-20020aa7da44000000b0055cd77395dcmr725638eds.3.1706114778581;
        Wed, 24 Jan 2024 08:46:18 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id ez15-20020a056402450f00b0055a82fe01cdsm5674954edb.67.2024.01.24.08.46.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 08:46:17 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-559f92bf7b6so10274215a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 08:46:17 -0800 (PST)
X-Received: by 2002:aa7:d44a:0:b0:55c:c7f5:4ce3 with SMTP id
 q10-20020aa7d44a000000b0055cc7f54ce3mr1287114edr.5.1706114777365; Wed, 24 Jan
 2024 08:46:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
In-Reply-To: <202401240832.02940B1A@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 08:46:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
Message-ID: <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Kees Cook <keescook@chromium.org>
Cc: Kevin Locke <kevin@kevinlocke.name>, John Johansen <john.johansen@canonical.com>, 
	Josh Triplett <josh@joshtriplett.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 08:35, Kees Cook <keescook@chromium.org> wrote:
>
> Oh, yikes. This means the LSM lost the knowledge that this open is an
> _exec_, not a _read_.
>
> I will starting looking at this. John might be able to point me in the
> right direction more quickly, though.

One obvious change in -rc1 is that the exec open was moved much
earlier: commit 978ffcbf00d8 ("execve: open the executable file before
doing anything else").

If the code ends up deciding "is this an exec" based on some state
flag that hasn't been set, that would explain it.

Something like "current->in_execve", perhaps?

               Linus

