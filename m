Return-Path: <linux-fsdevel+bounces-75870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLjZB9R6e2kQFAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 16:20:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E19AB163A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 16:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18096302291C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 15:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A322238C1F;
	Thu, 29 Jan 2026 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdDfV2Zb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB61426A1A7
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769700022; cv=pass; b=WWIGFSKRsBQG51N+fiQ5RoHE6dLWbZC2OO3aHHWScCkBq4MahLnMO/M+PWzKpngJLWpe5OOabbp8kIReNLWTnlZI7vuOwgsaUyVVVqOujNuiFNv/9zO6n9d582JFMKmsyWyMYCNIRKNyImSeIZQb71mZuBK/z+4Jm3qSRdQqh+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769700022; c=relaxed/simple;
	bh=IZLvhCZKZC06QId3xKvjBRdE6SfdKAgiRYfaFalRpW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYn6WSQEfCQTiKZ0rCH4W0GgsRgwSqnkY7j+KedH/CenEGAqo49u+e28qyGy+1Mrogd/MMwuJQ4H96Fq/b4AjZQW8HzuG4bRqsD7bpNzgpI1KtQAIrwHj5MEuIPZdmF6IrycrayqPXvpimxKiZ7ErwVJjv8qAiPUvQ8P0bLYs+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdDfV2Zb; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59ddf03f341so130710e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 07:20:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769700019; cv=none;
        d=google.com; s=arc-20240605;
        b=ItUx21ByDTwAaEwdDJGNwQQd7jrIPyyAta+7bJXiXoBevkAaejLnzS2CeFvcmOaUZk
         JSMcIb6QE7KosPPJLUKbNsd6oD3vTHEJEwKlkjzAM0qomR+axDMQKyKPqcc6O7d9+tkv
         ShyTNFOx7cNi+1fM91ZEQUYT1ZNgJXo8rlz13UJVZZIrghdtGqbDONIQs3E20qHYGZUJ
         7Iep7PJMrWKCv53z8/HTLy2Z/oA8evSjN3RQa06wSfvdY3ztifWdSkgVUOuOkFYJC8cn
         sN3IQeM4lK5rHwKI20e5mZACCt6+fZTw2GFCNxSv9GU6KDrDCmaeA9Lw5hqWuI3VvnoO
         kmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IZLvhCZKZC06QId3xKvjBRdE6SfdKAgiRYfaFalRpW4=;
        fh=PW7Dn08UkiHTq0P+ZnWxqzMluKCeNxpHyKDIrG4BOOQ=;
        b=PwQvIghk9qcB5pQM8OPblW55q+6+3hi1mAXKSKsDYGrxLHSfTmBFoX6NTz/bKclNa0
         mJbHhjYFxQt1XoLeYTNDTiGLwPn5YcRQBS83eFPXskmmOJpMJUx139twpAxI6tW3H4D8
         1lqQb9Xdvi3H5AhSRmmxcNc1eh4OXg5RRiorLY7YWgNogpNXFADFPxNgUo0FbYYzvDwb
         /IA4nT8w+LMrisKJv7OCU7YxfZ7KGfDmkporFTqNKd3Vf58C0HAv47ZJECIy0TrA3B29
         /jmOL9JykVawwBYfp3jDQMfzbKKGq7GvONFI/Lvlfe3th14snRVYlKiZVlM03x4Gl0yR
         dRhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769700019; x=1770304819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZLvhCZKZC06QId3xKvjBRdE6SfdKAgiRYfaFalRpW4=;
        b=NdDfV2Zbf8ADOpN5uuj9LZACM+m+5sS1+RBw0hVsTOWJU1pTOBgfgZWdPaHg/dLAd8
         HP15O5GSWyu0NBNNmh8puiztzmWc1Dfp9CgI3iRHQ1xocBKl5iCMu4DItZyzvymUVUu7
         Z4elb55RqLYXSZzQJYH1DlTpU7KTyr6RDpPAUNN1bOTYizxSCvRjIOJDulpfYe25dmZa
         g3wRpBCYAciVdtlT8aZqXVUy350fkraR9BEhHPlw+2vUpKUedjbjoL7YyX1vn7SlXgk+
         fDRMrFOZJNeT1MjYHe2D51VC2hNB8J6TDDRKzg+cRCMdybEt3yZGFPlyyTRiJWcJ+L7d
         dVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769700019; x=1770304819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IZLvhCZKZC06QId3xKvjBRdE6SfdKAgiRYfaFalRpW4=;
        b=JrtDMWvEjhZtJZCmMjIU7FuADBbV6wuhEueIteELr/cVdyBQG1cQLl0c7o/2LjXuio
         CSvmiw6upqCSkQZTI2hT7PYMSU2QZVveUHqZYciOGg5Qm6YlAdMklAI7fxaqjsJG+tSX
         5TyF5FrM7thiFr7rmK1m+eNLHW1pBIfXaEiwMqEa4zJbf7qu4t4uTekpo5grZdiLK738
         pikYK0n3E1xH28C8cOeCJhp5S3PtBCELbhNNsFf0Y4rCeXjujQPyxHl6fLJ8OyFW3V+G
         HPBNE904hezquX2TUb60pHvWky6J+VuGZmh1mi3EHqVZOQybAa0jYC6FZgPx3qOdt3Oz
         dWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYl0/SGoRlCTl6DwLGnGe+AF5GbD4EFy/Pi7qB7FFeMcttuK3sXsFFhhbQzj/3sHP5gccFgeAeIFEJ8slp@vger.kernel.org
X-Gm-Message-State: AOJu0YyvqkO+bTijaReE7BEnlLA5lIYWpYTplL5mL+7ltAQzAMMdv5XD
	mPkOSj9NEAn7ev8Ac3JlXijiYp5hbO4TtWZW0MG3JeCdqFNQFUMvnCZwHZEOVNnvU90z1tR9cD2
	cmM2IGdEI/x0kafJkB5MtGkAPoAB2JiI=
X-Gm-Gg: AZuq6aJYAxJAeodjNB1ekGX4YS/ck8FkxhK6CRfaTiloZSIDqwx6pkRDoix7bGFwInz
	sbAYnY6UFygoEIES7PTdUWIjiBQYwlKaCpeCKEXRSocrE6tV+5+Q2Hqxw8H+oMVd802iiwZoOd7
	m1ZTMqI7KyAoTX4lqNYjhgolIPKLairEwxO4RULlWS1vNoikU24JCaXPyBdVKvz8mX9qsLvxIHU
	v0sjkifHfQdSkelJ+8p/poR8A+CcRmi0RxfvaW4RUDMK5r7Vj3fiKJ11BvheUZaIR5OWOGoXro4
	+rGXgDdSF2UGuW4wwMSDy5nI/IGA3OIUblpLbW8Je76hLrOpDmye5wxU2d3GnuBTX8aJkWzwys7
	8LfmUuwvBPlsP
X-Received: by 2002:a05:6512:140f:b0:59e:13e6:6f1f with SMTP id
 2adb3069b0e04-59e13e66fb5mr141459e87.0.1769700018658; Thu, 29 Jan 2026
 07:20:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-cstr-vfs-v1-1-18e3d327cbd7@gmail.com>
 <20260129-erwogen-vorfeld-85a7dd7df060@brauner> <CAJ-ks9=+30hkc7+AJF4Sd7T0+odPtiK4p+XrNyDJUU2rrqOP7g@mail.gmail.com>
In-Reply-To: <CAJ-ks9=+30hkc7+AJF4Sd7T0+odPtiK4p+XrNyDJUU2rrqOP7g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 29 Jan 2026 16:20:01 +0100
X-Gm-Features: AZwV_QhtI1nai9iulKRzjbiJ2v8mEzklhRbqribtH8ZTSgpSql_yloY735wsZpc
Message-ID: <CANiq72m9sG8K6zJWCpG_yMih8KmX-V998e3C0LviWoo5p5ZA1w@mail.gmail.com>
Subject: Re: [PATCH] rust: seq_file: replace `kernel::c_str!` with C-Strings
To: Tamir Duberstein <tamird@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75870-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linuxfoundation.org,zeniv.linux.org.uk,suse.cz,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8E19AB163A
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 4:14=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> Thanks Cristian. The commit doesn't seem to exist (with this hash or
> any other, see https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.gi=
t/log/?h=3Dvfs-7.0.misc).
> Is this expected?

Christian may not have pushed the batch yet, given the dates in the reposit=
ory.

Cheers,
Miguel

