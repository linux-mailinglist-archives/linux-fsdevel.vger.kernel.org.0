Return-Path: <linux-fsdevel+bounces-15483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC9F88F17B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 23:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6E81C25FA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 22:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C156115381B;
	Wed, 27 Mar 2024 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvVXCXaV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD64D9E0;
	Wed, 27 Mar 2024 22:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576978; cv=none; b=q9EVDh1936MpVFz2p1BRS1Eq5Liq8m+l1nwGpWmhbt579wEHp9HQ1M84N5MKt3oSDY0VBxOxtBQRAi6yZk/UfwOaUxMhI6DaWETroFXu2GHlI7jYgfo/JbwOR/ZzjMQwJiHqjM9YSl0PvmRUWYOpzFeLNiS1iSvqNTx8PqcN4iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576978; c=relaxed/simple;
	bh=qCrAxiwO3Y3xJfB5K5VP4H9pbMMbTuTp4N5vA4Mo5GU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Vdo/6rJn0qqPqI+J0oq8ekaU7J/cef4GYkBIQvD585CATBD4d4iQGCnwdB4nUP71CoCMEEon20lK0yhV/oAq0pys2+NFU/sZCt1pD8dZf0lt8sNTgTuRW9ijQ0/yLTIsWkfz/hupAlcQJcLZDYU/xmg0Cv/yC8GBu7f2LltNShE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvVXCXaV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e0b889901bso3329225ad.1;
        Wed, 27 Mar 2024 15:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711576976; x=1712181776; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxkaKw+rfpAE85eGdYCUsNCxHsvss1V9iaOZ0vj/Dtk=;
        b=JvVXCXaV0oRyCOVtMysJTbUJRCFcEVM/4IyGH8vbp5BFhRZcBHHw5PdpmUIle3QoVY
         V67Fv9VqbcYuXp31dXCpRClK5w+WhVlMgiwboPjrcjHSA9PRnV2qHCK1bI5Uog+NTyuC
         aQb/Y3DVS8oBY0SGdepCsz0/mh35Lh3t3p6XBcLnok+2l1QceLk+z02sXBEUL7F7CYc5
         jFOcFQGwpKR79idSzW4J7HmEf5DGCwuj8NJCX2BQKKF8qQkmc2lDzaI0CPLIGzY5wvU1
         CAH/sfvdq66pyaZDL6OG1BdiWNGDrm/nf51LBXZNgSvqxyEHi3fyfyO7iqQiWLL1XMwH
         FvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711576976; x=1712181776;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxkaKw+rfpAE85eGdYCUsNCxHsvss1V9iaOZ0vj/Dtk=;
        b=BMIGRcJf9LKi6Wl88zZlKVOO1FSHzxIsEMsDyWp7IWj4PJbAtJ06/7iUFNZvtzk0JD
         FQJUwC/xvocDllqfucjlNPZlor849RZIcZEYtG4AUk9hVPPLQq8nJFwiWet6evjsOp+/
         Kpb/1VaW9IkXXkV4X7cV5uaAkMPaO3SUZgH1tx1BqRlGfQ/WcZVQiWCR+c62KckZFZZt
         vlq8y1h+k1BFjVypXkxJMz4I4pXxQ1QxkLjNpceFM0c3sx82xHh3CU7l1bCXhlqCOCna
         WUlR1orDc1FYGpAYz58bEJjS6NN704APZV7vBV1YwaQ47hNX2YVFhMOSHYwQiO+pavDF
         Bm6w==
X-Forwarded-Encrypted: i=1; AJvYcCVgV4ASCz+OlCQH0oSsvOshRLYR+HKonufioVqECp0vCE7W03QB/jCiE3kaI2EpmiCHRaJyNklJF/hder6FYzTa46E1yI5Qw8vU789B+yZu5R3O37jHTqrFa31ftxjPUAq7UhGhkQDwyMmJCZZigN21zGjkLCeUhlIKjAog1eJmhkrh342zWWZOQL/E4pCyhcwz6vllVSgN43HBB2kR7wtIq/lyEiqKwg==
X-Gm-Message-State: AOJu0YwHe7QnmkmiAEomQ3SpObklrbj45tOpWwj7l9XyMydijWeyqhtj
	/L5W+lZHO8GuhXUlTekl/EUvW6LY9KYwNyZ4r3TDNvReTDrkFi9o
X-Google-Smtp-Source: AGHT+IFaDb6HlSC3POSY7TW5AUU1z57wmA9MdM0r0RpaOuimMWYaaCvmMKDgxeih3R65FO4kDbGvfA==
X-Received: by 2002:a17:902:dad1:b0:1e1:1791:3681 with SMTP id q17-20020a170902dad100b001e117913681mr1131591plx.61.1711576976035;
        Wed, 27 Mar 2024 15:02:56 -0700 (PDT)
Received: from smtpclient.apple ([2601:647:4d7e:dba0:5840:a196:2bf3:3600])
        by smtp.gmail.com with ESMTPSA id n18-20020a170903111200b001db5fc51d71sm9469plh.160.2024.03.27.15.02.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2024 15:02:55 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
From: comex <comexk@gmail.com>
In-Reply-To: <5246D3E2-E503-40BA-9A72-1876BCF1186B@gmail.com>
Date: Wed, 27 Mar 2024 15:02:41 -0700
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Philipp Stanner <pstanner@redhat.com>,
 rust-for-linux <rust-for-linux@vger.kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org,
 llvm@lists.linux.dev,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Andrea Parri <parri.andrea@gmail.com>,
 Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 David Howells <dhowells@redhat.com>,
 Jade Alglave <j.alglave@ucl.ac.uk>,
 Luc Maranget <luc.maranget@inria.fr>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Akira Yokosawa <akiyks@gmail.com>,
 Daniel Lustig <dlustig@nvidia.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 kent.overstreet@gmail.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marco Elver <elver@google.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <041BE680-1715-4C9A-BBEE-7547108F04BD@gmail.com>
References: <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <ZgIRXL5YM2AwBD0Y@gallifrey>
 <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
 <160DB953-1588-418E-A490-381009CD8DE0@gmail.com>
 <qyjrex54hbhvhw4gmn7b6l2hr45o56bwt6fazfalykwcp5zzkx@vwt7k3d6kdwt>
 <CAHk-=wgQy+FRKjO_BvZgZN56w6-+jDO8p-Mt=X=zM70CG=CVBQ@mail.gmail.com>
 <bjorlxatlpzjlh6dfulham3u4mqsfqt7ir5wtayacaoefr2r7x@lmfcqzcobl3f>
 <ZgSNvzTkR4CY7kQC@boqun-archlinux>
 <5246D3E2-E503-40BA-9A72-1876BCF1186B@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On Mar 27, 2024, at 2:56=E2=80=AFPM, comex <comexk@gmail.com> wrote:
>=20
> Right.  When I said =E2=80=9Cstrict aliasing=E2=80=9D I meant =
type-based aliasing rules, which is what GCC calls =E2=80=9Cstrict =
aliasing".  But Rust does have stricter aliasing rules than C in a =
different way.  Both mutable and immutable references are annotated with =
LLVM `noalias` by default, equivalent to C `restrict`.

=E2=80=A6oops, this should say =E2=80=9Creference-typed function =
parameters=E2=80=9D.

> On Mar 27, 2024, at 2:49=E2=80=AFPM, Kent Overstreet =
<kent.overstreet@linux.dev> wrote:
>=20
> That's not really a workable rule because in practice every data
> structure has unsafe Rust underneath. Strict aliasing would mean that
> unsafe Rust very much has to follow the aliasing rules too.


There have indeed been a lot of issues where some innocent-seeming piece =
of unsafe Rust turns out to violate the reference aliasing rules.  Miri =
helps (it=E2=80=99s a tool that can detect violations at runtime), and =
there have been attempts to loosen the rules where possible.  But it is =
definitely a case where Rust=E2=80=99s UB rules are more subtle than one =
would like.  At least it only applies to unsafe code.=

