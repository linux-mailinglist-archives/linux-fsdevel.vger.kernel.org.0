Return-Path: <linux-fsdevel+bounces-363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A773E7C965F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 22:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0D2281CE7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 20:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709A526E31;
	Sat, 14 Oct 2023 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cmEtZtL0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAA326E27;
	Sat, 14 Oct 2023 20:51:51 +0000 (UTC)
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FC9E9;
	Sat, 14 Oct 2023 13:51:50 -0700 (PDT)
Received: from [127.0.0.1] ([98.35.210.218])
	(authenticated bits=0)
	by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 39EKoEiA2727570
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 14 Oct 2023 13:50:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 39EKoEiA2727570
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023101201; t=1697316617;
	bh=LX/qZh+W7D0BjzC3kMTpoByXLORwLrw1issq1DeNzOI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=cmEtZtL0/Pi2yHywxxrW/vo69bVUWzREGKAQgcbfeQGp95YGmHSJanruTBO52bnTp
	 c/NpKM0f69S6I4fKqBAVW4BQaQWygmM6rcwzaEkqlA6Z+6SkC94pbM+EhsrUOaxoBF
	 Nz+Ig3h1APbpOVSA9QtIEVK4Dp0Vd72eRQqjE7uAyeeF7EVqWLrJ+EVZzpHEcVfeur
	 +4Tc/tRbfMLQ8QgcoKkIWYylpJjzWGtY4MNezyAKCI2niAAY0FLfF+maHpaXpJnnw9
	 nK5nIBxIgvaan1hi1DbfDAHRxBXik2Dka7C/Cl7KNf+o5Ruwp0qT/LUgs0qT43MYj9
	 tS/QvgasZ2CMg==
Date: Sat, 14 Oct 2023 13:50:09 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: comex <comexk@gmail.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        Ramon de C Valle <rcvalle@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        David Gow <davidgow@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?ISO-8859-1?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 25/27] x86: enable initial Rust support
User-Agent: K-9 Mail for Android
In-Reply-To: <BDD45A2A-1447-40DD-B5F3-29DEE976A3CD@gmail.com>
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-26-ojeda@kernel.org> <Y0BfN1BdVCWssvEu@hirez.programming.kicks-ass.net> <CABCJKuenkHXtbWOLZ0_isGewxd19qkM7OcLeE2NzM6dSkXS4mQ@mail.gmail.com> <CANiq72k6s4=0E_AHv7FPsCQhkyxf7c-b+wUtzfjf+Spehe9Fmg@mail.gmail.com> <CABCJKuca0fOAs=E6LeHJiT2LOXEoPvLVKztA=u+ARcw=tbT=tw@mail.gmail.com> <20231012104741.GN6307@noisy.programming.kicks-ass.net> <CABCJKufEagwJ=TQnmVSK07RDjsPUt=3JGtwnK9ASmFqb7Vx8JQ@mail.gmail.com> <202310121130.256F581823@keescook> <CAOcBZOTed1a1yOimdUN9yuuysZ1h6VXa57+5fLAE99SZxCwBMQ@mail.gmail.com> <20231013075005.GB12118@noisy.programming.kicks-ass.net> <CAOcBZOTP_vQuFaqREqy-hkG69aBvJ+xrhEQi_EFKvtsNjne1dw@mail.gmail.com> <CAHk-=wjLUit_gae7anFNz4sV0o2Uc=TD_9P8sYeqMSeW_UG2Rg@mail.gmail.com> <5D8CA5EF-F5B0-4911-85B8-A363D9344FA7@zytor.com> <BDD45A2A-1447-40DD-B5F3-29DEE976A3CD@gmail.com>
Message-ID: <C0631F27-43CE-4F2F-9075-25988CBD97F0@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On October 14, 2023 1:25:12 PM PDT, comex <comexk@gmail=2Ecom> wrote:
>
>
>> On Oct 13, 2023, at 12:00=E2=80=AFPM, H=2E Peter Anvin <hpa@zytor=2Ecom=
> wrote:
>>=20
>> Transparent unions have been standard C since C99=2E
>
>I don=E2=80=99t think that=E2=80=99s right=2E  Certainly __attribute__((t=
ransparent_union)) is not standard C; are you referring to a different feat=
ure?
>

My mistake=2E=2E=2E I was thinking about anonymous unions=2E

