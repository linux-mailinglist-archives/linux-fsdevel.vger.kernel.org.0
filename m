Return-Path: <linux-fsdevel+bounces-54028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6CDAFA3B3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 10:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF3E192060A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 08:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7191DDC28;
	Sun,  6 Jul 2025 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="swpvIHgR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A904191499
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Jul 2025 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751790735; cv=none; b=hW4jD97p1ZD+3Yhy/yhtgZau6x7ny+0TrN7dNDRJoc8ngVq4m4ZsN1wYu9NSFq3Rr2lEKtBO95iCQypuBzQiGH9UyAPHgeBgMP22zTrfVnjq7BXPnK4gZCVcRpfglM/AVZis6ugt70Fb3hR04jhY1znJwEiUmmLxjInwf03U1wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751790735; c=relaxed/simple;
	bh=SCh0rlkNZFhJ5wI2jry030Huq/MRz92c4m2UkAahWbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTz3XxRgkcJaymV1AhFbjVkKIarFmHr98vuFMsde22NdyC5A9WKGCuMxxAIdoTut7xctQcWyzw0N0f3Ou6vMa7HZt9oUZqh55hW0WJhZUFqwVN0/ydc8uvb995WPWfo/TArZ/EgPyVDk0tAYfN/cHdT6SNyzCYDxbAT6ApqZY6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=swpvIHgR; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso1571588f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Jul 2025 01:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751790732; x=1752395532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCh0rlkNZFhJ5wI2jry030Huq/MRz92c4m2UkAahWbU=;
        b=swpvIHgRiP0Z8YZPjJ4tUiHt7S9FtIc3r6BOnkc8TsPmePUqxRx64/IJSqlvBTrVy3
         CbVigymHiF5wNJxJqL/t9oWBBa+q0j0R7kXUw0igP5lt6l53iExiDbMx4dgdCp8Rigca
         VI+sD1kE6bKbzty6jwXXNLKK5DfZtg2jD7i039B7hkwOlKqN3udxoHMeF2qKbKFqb3Oe
         FE9huP9Aur0ocTsl23mNbSO03Zb0yorzUtj2PwvorsUCiXV5Mx0BY0cWQQPCmZlOAGUO
         BmFCNdPjpX0QpgFagqE0SVXSWLAFm5bJ5bjipFPWTWbzIgaagfrHKUkzUsXmZ+/3acdF
         +Z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751790732; x=1752395532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCh0rlkNZFhJ5wI2jry030Huq/MRz92c4m2UkAahWbU=;
        b=fXbdxJrVnE1HOVrdQXx7ujReEhtPiD0kU18CTu0m2J8ZG4ugCCVkUI+fLSJYMRznYg
         qmb/580/+Homqduhd0KoEu3C9K4/7I/jz4JcnKNsJyza1iD3g3rGc2E1aq1LSDbiDh4I
         SekhKzh0rHG0LXPzhogoGsXoAxYN9ZhqUyyyOWLsLPTflhKqlL/nAzk893wVBvvdIk40
         tqACzbrGTxWPDLXDiulu84mw+QkXqrd3Nc5x0s7tx2D3qBKShSMnTXXVXSUFffxXTeAu
         BiqK5RV1WsBbT5EjGvjzI+Oa5ZhcpacPZw7DpN1Lsc2iTUfhDd8yImmOlU7bppnfk/pm
         Ws5w==
X-Forwarded-Encrypted: i=1; AJvYcCWrA8uqWuC5vbhgjHsS4JYDsdLngD5BHInNWQ1oXGz03tWDD84mmDqJIHizZUDVLmH0IUztLw6UH8mv4uQS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlj67bw0zhqZNlfWneWQaHe3iGFuFLdMkia5YjBzMJuF7IPy67
	Blh17+MX54HlhykFem5OkU80YCgX/e513+QApznIGFAcddcmWcG4VXgpzuSRXbvnT/wgZgHV7aq
	lWMgscmztKa8BapkTjk02hyn2C9yM4fBeo3XkEuAn
X-Gm-Gg: ASbGnctoYwSSK7topAmM4AhWT5NoPijedFFw/QwvqSTRBBOvZuAKb420+vAlol0nLb9
	zq811c5FCW9mll3EKkyXv1TXiutZ6Um4Qvv6giLbhSEuuwclb1jydovn/BeX402AlBO4NScAY8V
	7wNV0u1tp1hTXqOJfHQN5hsus1ioLqUrQAat9bx6WjeHVt
X-Google-Smtp-Source: AGHT+IEGQ1yvGh1y3CB0u/RmI8WwsZH40VLDWwCw3/I8DzRJFsL4891+0YGeKbVlHlDbDSg+hBTaNvwCq+RYP2UKi8U=
X-Received: by 2002:a05:6000:2f85:b0:3a4:e5fa:73f0 with SMTP id
 ffacd0b85a97d-3b4970195f6mr6202610f8f.20.1751790731838; Sun, 06 Jul 2025
 01:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com>
 <20250701-xarray-insert-reserve-v1-3-25df2b0d706a@gmail.com> <CANiq72nf-h86GszE3=mLpWHi5Db+Tj0TRyUe9ANfjdNbesBEEg@mail.gmail.com>
In-Reply-To: <CANiq72nf-h86GszE3=mLpWHi5Db+Tj0TRyUe9ANfjdNbesBEEg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 6 Jul 2025 10:31:59 +0200
X-Gm-Features: Ac12FXwwPurn4FW_8RxwpWJr25A9vazCDxaz3GDmuhMxLJA4Vob4fuczPZdPUVM
Message-ID: <CAH5fLgjmUXUcXFFYdrM4f2iZeD-JbEuSV1DuFbGERNQNM+V51w@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: xarray: add `insert` and `reserve`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tamir Duberstein <tamird@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Daniel Almeida <daniel.almeida@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 6:56=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Jul 1, 2025 at 6:27=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
> >
> > Add `Guard::{insert,reserve}` and `Guard::{insert,reserve}_limit`, whic=
h
> > are akin to `__xa_{alloc,insert}` in C.
>
> Who will be using this? i.e. we need to justify adding code, typically
> by mentioning the users.

Rust Binder does have a user for `reserve`. As for xa_alloc, Rust
Binder may end up using it, but the current plan is to use Burak's
bitmap work instead.

Alice

