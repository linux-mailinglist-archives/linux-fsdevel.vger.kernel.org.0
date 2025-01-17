Return-Path: <linux-fsdevel+bounces-39551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DFDA157C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 20:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592FD3A834A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D5A1AA1DB;
	Fri, 17 Jan 2025 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBI6zOLa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8B61AA1D0
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737140736; cv=none; b=XtE/5scpeExdKmjarH1dKAh3bKhsvLj5UCGUu2rA26zzAwyrUKSxZsvQcxu6WqV5vmINRFn4ZopanA09IedvUW8TmlDdCXaope4sAShUamtLxhbB+2hXW0NS8XhQykhW/jjP9jtpxUUN+19mJKOY/JlWo3Bt3DEDFuC0RJ46VH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737140736; c=relaxed/simple;
	bh=At8t34cjaTW/df31Ig+UYz6PT0DT82tzoFoYhp9Y/YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhR8JWiyc3QnXAfUDJ3Aq1BaXFnQSWOpbE3LTUITscermBkNpMbHoyChvDaKTJqVajnFz/jMi6H5eI77E8iAvglIbXhJvncZb9WTsjYJ6yNlE3co8YmicqepoPfyNvbjalgMdsvMSeSVPlMVDBGmUhL3WHXW4p9sDscbljEzoW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBI6zOLa; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467838e75ffso32328311cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 11:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737140733; x=1737745533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BojgGPHlqGKFVoHw+zSnuwHo4WsloiX+aW+D3TryFp8=;
        b=YBI6zOLaDzwpe/cV7t6adRoMrOYaAJW4qP28q/B/LIqOg3F2TZHZ+TM/OllRHszQad
         Edz29TTG/FUbM2asHAJNb0HrRMa7e73LbxzV+A7tVB/HFScXYI1AMeqwDtTkNhLp0obi
         ANeYntj2edFX2S+0tjoXPfhI/+rW0KxXQXSaXbkuaEilgGlF2hAROWKnYzMfyYjBPGzY
         WsxTPzbQWwpXrQ+jPteFh0UdTFzRXTUEBCcSutUe3V4uD/qvq2W7VIiP20ZrsaEb6GgV
         dSpK2YwFctJCg9553TKHXpq0xnH1wy7DUDN5PK279XZuZOntS+66Ov/+qkKuIPZFMvmi
         YmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737140733; x=1737745533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BojgGPHlqGKFVoHw+zSnuwHo4WsloiX+aW+D3TryFp8=;
        b=eNn0LZDd5CyCgwrXIGH1luW4EH5V3es1HYJo5UAj3KpBqmwWZCFllSU07w6gdSJC2v
         eyLVrDjFawAxETx78ygzaIAKH496bQnVoBQTEI6fALimcZ1aQd1q6MGOut7eYdRh+nCW
         ax3Npl2Pw4v9Du3q3oBNkQ7dPqlLs64FIPjoFxYcLMA6tr0sCahEQHRR0Ln569BfUDpI
         Qf6+s47VTkF+0tLe7y7kV/sLLIZDidx72+Un2VlL6kiPfwtgwXuKGI87V3fUa/dGkl1a
         wYoyAAsAmPg5tMjowkllXd1E507gm5yrvYOANsT0oHz87PJHYMCeUhhRidoBseLm8omP
         9ZLw==
X-Forwarded-Encrypted: i=1; AJvYcCWWSK68F2JxKMcuEAPlPZr9kd8A7GuLVywcNS21ly4BbZUqwzOmw239HxlcErgOzoFhNh3MYGWfSOuEePtO@vger.kernel.org
X-Gm-Message-State: AOJu0YyvWocNbdPbAtBVNOrrwoBvHlcEsctm19jx+patLZ2Bq2HxJiUV
	6Bc3hlVTy7/oicKTfkLpYb8jh80O+Kai+Uh/gcoQm7Tp9OuEnWEZzenQjBSZYnu9BNXf1/JHlJZ
	qWH6A69hKXSogqlYGjH8BQydu2DQ=
X-Gm-Gg: ASbGnctwP26BgKcnngKw/fvIyzWPhYpaMHAHP4BlChfbyzyv4JrOVFmyD7J/TkEq4xN
	HX1IbchPAFLrDETabxpL3wPrRsIwFXH7co4txSqs=
X-Google-Smtp-Source: AGHT+IHl+W43P1WfYDZ2dPxgK/4evJ2yCuZfgqzilwxhAmC7Fc9AHcPNBXfwV6bu1SNJ5jcEDGB7QUVD84yQ1Xxfjp4=
X-Received: by 2002:ac8:7f16:0:b0:466:af35:92d5 with SMTP id
 d75a77b69052e-46e12aaf834mr53524341cf.25.1737140733241; Fri, 17 Jan 2025
 11:05:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218222630.99920-1-joannelkoong@gmail.com>
 <CAJnrk1YNtqrzxxEQZuQokMBU42owXGGKStfgZ-3jarm3gEjWQw@mail.gmail.com>
 <CAJfpegus1xAEABGnCgJN2CUF6L6=k1zHZ6eEAf8JqbwRdAJAMw@mail.gmail.com> <1dfcf698-2c85-458c-820a-ca9ec4d26de3@linux.alibaba.com>
In-Reply-To: <1dfcf698-2c85-458c-820a-ca9ec4d26de3@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 17 Jan 2025 11:05:22 -0800
X-Gm-Features: AbW1kvYey71d_NfCNcup0h3KKVI9bIH7QmDQzQqKzfJs06uMURzlUOZRt0gLti0
Message-ID: <CAJnrk1YYF6g=s1+T2HPjXp_wrCMC-Emc9UES2qhz0Ue0U-Htng@mail.gmail.com>
Subject: Re: [PATCH v11 0/2] fuse: add kernel-enforced request timeout option
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, laoar.shao@gmail.com, jlayton@kernel.org, 
	senozhatsky@chromium.org, tfiga@chromium.org, bgeffon@google.com, 
	etmartin4313@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:41=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
>
>
> On 1/16/25 8:11 PM, Miklos Szeredi wrote:
> > On Wed, 15 Jan 2025 at 20:41, Joanne Koong <joannelkoong@gmail.com> wro=
te:
> >
> >> Miklos, is this patchset acceptable for your tree?
> >
> > Looks good generally.
> >
> > I wonder why you chose to use a mount option instead of an FUSE_INIT pa=
ram?
>
> IMO this timeout mechanism has no dependence on the implementation on
> the server side, and it's self-contained by the kernel side.  Thus it's
> adequate to negotiate through the mount option instead of the INIT
> feature negotiation.  Although the FUSE mount instance is generally
> mounted by the fuse server itself in the libfuse implementation.  IOW
> INIT feature negotiation is required only when the server side shall opt =
in.

My understanding (maybe wrong) is that fuse servers only get mounted
through the libfuse interface (eg fuse_session_mount()) which is
directly called from the server code, so with either the mount option
flag or INIT, both would require server-side changes. Am I wrong in
this understanding? Is there a way to mount it through the command
line? I know the fusermount3 utility exists, but AFAIU, that only
supports unmounting.

Thanks,
Joanne
>
> --
> Thanks,
> Jingbo

