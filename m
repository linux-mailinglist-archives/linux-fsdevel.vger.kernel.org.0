Return-Path: <linux-fsdevel+bounces-30669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7F798D200
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 13:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2574B1C21547
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 11:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8301EBFE6;
	Wed,  2 Oct 2024 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nk+QdQcS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90D719409C;
	Wed,  2 Oct 2024 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727867338; cv=none; b=dtiaokCFbnumX1Xs0OCuKDyMKtSVJKvi5U6ZoMEvQd/ucxgXVje/LYCu7mMqbnN9KApr0POWP2is9Wu/TeJtXqNhfVOrHtX21DWqNAuPe3Gr9laSH9FiS6DbjjgDV5GY7Zz6rr1pcs7X17TbDewu/TnK/TgfT+493HDl+TQWCDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727867338; c=relaxed/simple;
	bh=++w/CFmeMI6p9ixo9ipmUY7G3z+c1V1MtOoiuK1svw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+Y3RgPQF0FYxXNaytGHtREM+h5TwYeqhcnokx/ry7ZxRWZKlg3VQXssnv+R8PDji6JSHesiVLgnnLiEHuftjcqkCHf77VXUnNFx4XLw1AvI1zr5EExYlqsCnDJsydjGUeOIGMA4PosWHnMK5o8HJ9detP5P67LOolMfXMQtKDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nk+QdQcS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b03c9336cso5778725ad.2;
        Wed, 02 Oct 2024 04:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727867336; x=1728472136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++w/CFmeMI6p9ixo9ipmUY7G3z+c1V1MtOoiuK1svw8=;
        b=nk+QdQcS6hgyuS8NblEJDuBtwg4eXkIAkC5psUZ1OAkPpwkBFPk8FXETgLsFZG4jer
         Ljk6rSQfAKsaCLtqL4DiPFzvD1cDTqaPug8QJlwwhbgtg+hybr551k7vD27toFRb5AH/
         anKgMK8uTGdgt+Zm5XBp/0ZZt+7YCfBQ9f0rntwTJZ34Sf6lRW9w07Shkyhj3imU6R2M
         qX2NkXRQ4pWyt0T9GPiMQ7HywzjKrrAIZLReBAjM5g/UIgwnj2ttQZiGhUNcI4ywe0ly
         aI+htWsyvbxFy/+Ag3D30UbGHpEA5sk0SkyumU9Y+3tFVxAIr44nWT5C7KjVg/cJQhig
         DYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727867336; x=1728472136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++w/CFmeMI6p9ixo9ipmUY7G3z+c1V1MtOoiuK1svw8=;
        b=HCK1p1F0sRgqYoGEmcHRqqI3x7VxGix41Gg/A5m1Bm0UJKW1gYbkIvTW/zHXkGuyf0
         WwTXhAEXgm71MPvBMDyUktuXLENlxVblkykRnNH35KApmQ3dvgej/C7WE4VxR0bXcHts
         3d4OSWhF+gMlO+RpiVpLdVnjFBTXKnf9VBBjKgOY76Zdv3nOpg49tOExKQLYKoOYGcpn
         5+ecDa/alKI+PeO6XE17kbGSL7zpiSKTwAjRGWfdbT26mLkhwxd3VcHl2TX+iCPXT6C/
         3FMgS12cuBKVPUrpdHP8FSDzXSHQ06guZYt3+vNF+SfRdtJB/2hRWzTEgz10hDfQSn41
         fN+w==
X-Forwarded-Encrypted: i=1; AJvYcCVFJJFwgUR7XKmva/k+o6dqMcngh/de5KoCUwQZQ+4r2mrdUgW9EDrLzCBMUhRMUmMEGCrTgygC3e3S70zL@vger.kernel.org, AJvYcCWKHrjm7IElPjLQf8viX2jSMmMh4hUMQudBwEKFDqCMMDve6WOPPVmotkqKf/j3RwleMMvI7e4DWSA8qehTYs0=@vger.kernel.org, AJvYcCWOlaXJoxDJlSWtP2eINki5UEtLieozjiQtcMmefhQaNG8i4mkTPyTUKURuG5Rfit36QLam3TiF6kZEtpQ5AJDX8GAZiBtJ@vger.kernel.org, AJvYcCXCXDEMUWLn3X/Pn4fQxmEHrIy2R76LXtdvMEg/k2E984MmdmXwByXq8C+O15si22jRapLQXyg3mB+OJZgg@vger.kernel.org
X-Gm-Message-State: AOJu0YzS0ipiVE69uX0luUrXY/1ap5koFVTwtJKIaESFTk218aZ9WnRJ
	K3XswQKOKKQ9nmzreBpwYAONH1/GfsDGXno8ksTQ580uMyGXSYcl+ELBCirgEQ3Ang+kR+fUJxP
	DJ8hALqvIu6IgGkg5TF5byarm6tc=
X-Google-Smtp-Source: AGHT+IH8jvqo/FcePOrIXT5KP6MVh2BtKDtfffXnIWNV6iZYbBR99b7MS0BOnYQ/7istTfy1FF3ZfhWvbfPErTAVElI=
X-Received: by 2002:a05:6a00:22ca:b0:717:6bb0:53e8 with SMTP id
 d2e1a72fcca58-71dc5c4333cmr1870943b3a.2.1727867336095; Wed, 02 Oct 2024
 04:08:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926-pocht-sittlich-87108178c093@brauner> <20241001-brauner-rust-pid_namespace-v2-1-37eac8d93e75@kernel.org>
 <CAH5fLghaj+mjL63vw7DKCMg3NSaqU3qwd0byXKksG65mdOA2bA@mail.gmail.com>
 <20241001-sowie-zufall-d1e1421ba00f@brauner> <CANiq72nJbmhicsNqZHV9=j_imXPPZWxuHiqr=N4wTDxwGaMW5g@mail.gmail.com>
 <20241002-dehnen-beklagen-f7f6ca460b5b@brauner>
In-Reply-To: <20241002-dehnen-beklagen-f7f6ca460b5b@brauner>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 2 Oct 2024 13:08:43 +0200
Message-ID: <CANiq72==AkkqCDaZMENQRg8cf4zdeHpTHwdWS3sZiFWm0vyJUA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add PidNamespace
To: Christian Brauner <brauner@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Alice Ryhl <aliceryhl@google.com>, 
	rust-for-linux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Bjoern Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arve Hjonnevag <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 12:14=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> You could consider adding a way to turn it off then instead of turning
> it on.
>
> Imho, since Rust enforces code formatting style I see no point in not
> immediately failing the build because of formatting issues.

For maintainers, it would be better if we could unconditionally do it,
but like with other diagnostics, it is a balance.

If there is a way out (like something like `WERROR` or perhaps a "dev
mode" like `make D=3D1` that could encompass other bits), then I think
it should be OK. Any preference?

(We also need to be careful about `rustfmt` having e.g. bugs in future
versions that change the output, but since we are in the Rust CI and
we can test the nightly compiler, the risk should be low.)

Cheers,
Miguel

