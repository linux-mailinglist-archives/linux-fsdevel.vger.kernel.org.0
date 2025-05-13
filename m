Return-Path: <linux-fsdevel+bounces-48913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53414AB5C53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 20:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C66D865D65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 18:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6797B1E5200;
	Tue, 13 May 2025 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SplhXMJh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEA48479
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747161408; cv=none; b=EEg5Lct460w2OuCEfmQp3i2/jwqUETbYzdAviQ+jlIcpDBsK8PPW52DXHEY5IPsW77765IlwOPpY8v4cmm6wjMta6JN40otJWuav0EZKm5lsQj7M5KXGlyNHrtBE8NCn7rfXjsnCoyMIzTOw3X7VRVIjIuaUanN1xw26Tt3d4To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747161408; c=relaxed/simple;
	bh=Na2fHXZdetFBUMmHq6MczYAZ6qQDpqutvAOtvEJ0rcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZihiemxb4CWGbPKoR0dg5e7pJ/ifzsXuzU5v/rsMzTW7wRMwVHXyRmXO8dzIwzrYhQUviS4yZEQtn5HsYFkP58YI3/DBdg0badeF7mEA+l+Q30fAfKAB8dq21WuMKydf3Dmi3w1RUsCxbEoPAjsZNOd01adI45CB+sij4P7WnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SplhXMJh; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47666573242so57921cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 11:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747161406; x=1747766206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Na2fHXZdetFBUMmHq6MczYAZ6qQDpqutvAOtvEJ0rcc=;
        b=SplhXMJh54P3I8GHQoaOF/PM2GMsO1NMDEQcGpxOlO+L7YCR93GLbN/6o80yi69Rtf
         RN913Kcx858DowRPKqpdIKVGuB0JvmNxzdbkzGKMOfjKUcbJqz5kIW1Os88LR+mYvpFr
         T73NaBHXM7JsFzRfHthkVB5kB70905YAlSmDSnBJptbzopxJFil7LJW7RrPn9/m3j9kn
         v49E7m3xrTdayu6iw2KeXZWlgClE6Hd6MULH5QlxrGnyiyyCZWRVJjtB5J6Pl6lgDlEz
         iv9cwBH8KVo8eSVaPs8FNP9XX8O5gIJW+Hji6jEYNxbwlFX2svIfckI5iUwKPpUyxG5/
         gdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747161406; x=1747766206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Na2fHXZdetFBUMmHq6MczYAZ6qQDpqutvAOtvEJ0rcc=;
        b=Yfd6BbbkAryNVQ+Zgsn7rU4mzhZGxcHHAmtmQihkIE/9L4B7qKudOpcJ9kExu0QW6n
         Ed9726NhE62IUymph0UZyPWlgqaTg/NbUcmXAPylmw2jnhVcOIVh6VqJC+L2F2lPOuf+
         SmsN45eyk++v64RKj9ZETLLaqDlgd7PxlorQv4Efsn5ffURUJza6TuJ8YboMKu3HGdQ/
         Dxn0Pri03RKlpE+ZSbJCTL7bDtfQasVpQTtLN8Dh4ooGlp7CzBNZm0GW1R+RGj0xpoPS
         lbLzNQ5j453HbWAsT7ZChliQzNu6cO8+L3WGGw/S/0TxERCTP+ZPxVf/y9cjdtrsjREU
         E2Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWseU7dhzi4ZjlxAdM24XsX7eD/Ctxw0zEcyc3iBC0tZ7gfqPKz34InVDGgJylnOCLVPu7vL+N1pWraJldX@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ7N86mB+OaWe23zXZEKDs/cytvy5Y/LfpzY+36cm7yOs8GgOo
	rWRstqU2b6qpjDguJqevRGytm387dsDddDzAu2L0SDYCedlDDBJN6omvF1bWWA6Uvs9b6HvrAAK
	utqkx4P5M2jVjod+evCJggMmTk+Qi6Bm/Xmh54mQz
X-Gm-Gg: ASbGncsuXY2HgkLytmQaI0cVR4y6BftELUc2ECBc4J37TH/qrU+oR9e/MHv53aZHNPO
	U8MbLZ4qFuTTOyFsk5ot7jg42DHg3LaOrwFO5RSH0JM7Cqo8XhFOajZsBPbVT2k3fgBsxwgNAb3
	JaRij6BzUk+UzG9GMrSoiSN63YjORlT0A=
X-Google-Smtp-Source: AGHT+IEAsJRj3/krbjuluehqZ81DfjO1H3nqI93C4c5mZa57iJTIHhSoAhYus4oh0sjqqo+3XAFFGWOgNQczCtZMTsw=
X-Received: by 2002:a05:622a:14d4:b0:480:1561:837f with SMTP id
 d75a77b69052e-494960f16ebmr376281cf.8.1747161405986; Tue, 13 May 2025
 11:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507123010.1228243-1-jbongio@google.com> <20250508050224.GB26916@lst.de>
In-Reply-To: <20250508050224.GB26916@lst.de>
From: Jeremy Bongio <jbongio@google.com>
Date: Tue, 13 May 2025 11:36:35 -0700
X-Gm-Features: AX0GCFtkQZZOx_ImXfmHzrKxdyMLN5x0VsYqqkfEGKXXHVNmNKGQh4x3SVMGQFI
Message-ID: <CAOvQCn5UySp1U2SmfDG59GZAavfOa4dbRwSWzfT3tumQ8OCBQg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: Remove redundant errseq_set call in mark_buffer_write_io_error.
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

Friendly ping. Can you take this bug fix?

On Wed, May 7, 2025 at 10:02=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>

