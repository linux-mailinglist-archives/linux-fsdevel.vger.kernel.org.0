Return-Path: <linux-fsdevel+bounces-45066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89383A71393
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 10:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA35178465
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 09:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691E41B0437;
	Wed, 26 Mar 2025 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EF6XbPGe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54182899;
	Wed, 26 Mar 2025 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742980977; cv=none; b=mGR5bnMetfPQr2YQus+t9YLcE2Bca5g/OZpFBErzqqy0p0Z0vGrpJCPgxgxjh3HcTx0fu0fm94ozQo2JGr/YeADIiCPmHcRrjj+OvkjibpL1cCRXZn0KZ/4zD/CDAHsO7rsDAvSPY1IIznzRx91w0KoKWVjXSnj4jR01IrImaCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742980977; c=relaxed/simple;
	bh=qxtF6khLwId9LK15aaIK1R6QxhmJS+7IKsOAe3rcYSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bX6ZRxDQ2Y/BJW612gg2WtSVWWKR6apYXjqlIvfreuGT5JkDy+zUqxcvdOwZBeDy52pc3p0DFzj6fguB4ZNxd2+vMWNKdjXheawpuEc1ArT2Kst6DRGL9pyy5AvFgMo6xVnsSLyAOP1x4eulSukgBJr2gQb1NQiBzqGDUwzw6wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EF6XbPGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF39C4CEF0;
	Wed, 26 Mar 2025 09:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742980977;
	bh=qxtF6khLwId9LK15aaIK1R6QxhmJS+7IKsOAe3rcYSQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EF6XbPGeROx9ck2/wMy52MgkOBBSN6jJZgg+Qn7v2SpbfIjs3lPg5064JNPk7o+XB
	 G1Tew5HffEconjh69vqk0mkBcJUkflqrA4iEgj8SLwf/seTS5HNbir1OII2p80HCq1
	 +P6MGiOjaR7a5JVZ74K7sotrO+OjvMlB+74YwpsUUz/VCy+aqYWnTo4aU1OuAb4FgW
	 0GHvjOa2MnJWvc/1Jq3iLVDexkOqxI841MEL1MoUTcRS71vj+1AwOZNNPn/RpUSODi
	 EeA4LrZKsWryeAiFK73Wxu0fFqyV2Xsa003JAYcobxqu52MLjTaulBGXlKIgFqvHzf
	 xi9mxcCv6ROpQ==
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso5503473f8f.0;
        Wed, 26 Mar 2025 02:22:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUc8gByDTA+y4jLrjnVT+D+NajkB6he05uMv2siTpZxYgUsfz5seIbGyva/6K0kTmszR3MMfOs91Agby2QuE029@vger.kernel.org, AJvYcCUcfMaoghdRcWHxzUVWOOPTrMi05nysSMoQ7VUXD4CNJNAqLES7JqBnC3XjqiAa2rD8xmEXJOM320jSwgKl@vger.kernel.org, AJvYcCUeKjUiGkWE+hed4XnAkV4zzvhvv1Oz0PWRfbB6tzFf360XqQ1A/2YqTmy7I1xFfSdwKVxkiZSo7zw8/fOyd/JrDQ==@vger.kernel.org, AJvYcCUqSjWDspjv89ZFAHNz/hsnKqT3GivklTcHUxTK7ACZRhPZ6NidplaS06nrmNZBhfYfO7mjkr3efI4h@vger.kernel.org, AJvYcCUzoucVGMxUVMGid7ICQEIsvTxDAsKf4Fstk/HUjHZI2QiRRmRWt70ILDF3t45Qh7oa9/JQuIqjQwte@vger.kernel.org, AJvYcCV7l/amYKZAlCn9WE8y/HWNGD5yKiskPL31/cPx1lVX7PxSQqOY2cJjKNYKOGh057r2LuuHf2R0uFf2+FFb@vger.kernel.org, AJvYcCVLEpjBmJKKs+tzOKGsWVC8siYoRVJSZofrDdnU0VqNde2j+m4o/0ai7UFnm9aG/3H43TMGfJnU4IDNpA==@vger.kernel.org, AJvYcCVMijWAPnjoL4ebc/BiOwwncKCxl+QMPzs6xZOkuil+GgDi6syib5l7VWaJB7GcQdcsISg4caqmoaazc0CW@vger.kernel.org, AJvYcCVQ9mvQu1CKA31sd7ieo5GezpS2fkQ8h0t+gQdgNaNMR/TZB3yrIKRb5Y1eBj0P8DCmFBfu28sqIuwi9IynxQ==@vger.kernel.org, AJvYcCVk
 ByU2/arJn9n2P89h30P7eB2tBsB00l1AVTiZUVdjEqVz1sXJVEFwa9gu1QEA+bRirNXfEs7S@vger.kernel.org, AJvYcCVphGFTcH3OhfTweELZxIK5DflZp5lSEZgBJLmc2cDiukmXz1X6rGj15JW6DstYBnm0Q14=@vger.kernel.org, AJvYcCVtFk2dgMm9TiCEGhSzjKeEGU+llGh9YSzLT2wjsnar4nnBc6R4S8C5+i8R/yNMN6FK8IkKHRJ29aXLucq9xi99Xazi@vger.kernel.org, AJvYcCWyOeU1NO4cL27kHRCjyGZk+KB/BW7DrMaa/OfRFtpbJlIx8NDkdJEQWg+mUhyVyMVrm9MNfXnahdXvFQ==@vger.kernel.org, AJvYcCXQSKqv9X80fSM1PwiHgr3SGSAqS1eWJx3Cs4c3kBIIug5R8gdVn3v+5s7mRIjYqJYUJBEHBGFTMFpBwbY=@vger.kernel.org, AJvYcCXWpl539WuYSorncZC1i5EzXF0joC4CdmXh7T2XbRbaOdNTqbsTa31d3iAoEXKvvotCYexQ@vger.kernel.org, AJvYcCXXaRW4ZXnGHO0YAPZhjcQMdUTVzJkNIN5sNdNuqgyLYCUKHO5AVg/ilPUu9AicoM3h51yGOkwKAHJ14rM=@vger.kernel.org, AJvYcCXoYW+ZRkn9iifUedaybAZwpA9Mlj7s/BYGFl//TJUxAgllnbrmgXnQLOZLNlkP/7UAmhj9ZHzDEujhExs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdGiSNqHeHeWPgTZxC+sskj2+8tkqkh/TbxgyRyZJNskn1E61G
	jvEh57bFmd8Yhp0AQrYFy1pLlaclsM+Hw/fnYVrMz7im2iUO9VdZNFHHFxfWfwcPG3FMTDwry9m
	+hr1hgVqdd4cprwHNTZI+9fzdARk=
X-Google-Smtp-Source: AGHT+IF3jZFlaB+ZbNTy99aWKHRW0ahCYMSSdgm6iKEF0x/RcYEZFdBlnTMpJzR5i/QwTCeteoihHBZi+8MLpfxSmpw=
X-Received: by 2002:a05:6000:2a6:b0:391:20ef:6300 with SMTP id
 ffacd0b85a97d-3997f93962dmr16836387f8f.37.1742980974678; Wed, 26 Mar 2025
 02:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325121624.523258-1-guoren@kernel.org> <20250325121624.523258-26-guoren@kernel.org>
 <05fec753-cdaa-45a5-a029-b6435c30eb07@omp.ru>
In-Reply-To: <05fec753-cdaa-45a5-a029-b6435c30eb07@omp.ru>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 26 Mar 2025 17:22:41 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQTfD3yVCePWi_Jxu6Vc878K4P-quy4ZKw1OOF0X30UwQ@mail.gmail.com>
X-Gm-Features: AQ5f1Joqx3oO-95jEhIdt3VHkcZ-PNWMEgaxjEOC2faFZmARHVgyLTPNu3C9X9I
Message-ID: <CAJF2gTQTfD3yVCePWi_Jxu6Vc878K4P-quy4ZKw1OOF0X30UwQ@mail.gmail.com>
Subject: Re: [RFC PATCH V3 25/43] rv64ilp32_abi: exec: Adapt 64lp64 env and argv
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, anup@brainfault.org, 
	atishp@atishpatra.org, oleg@redhat.com, kees@kernel.org, tglx@linutronix.de, 
	will@kernel.org, mark.rutland@arm.com, brauner@kernel.org, 
	akpm@linux-foundation.org, rostedt@goodmis.org, edumazet@google.com, 
	unicorn_wang@outlook.com, inochiama@outlook.com, gaohan@iscas.ac.cn, 
	shihua@iscas.ac.cn, jiawei@iscas.ac.cn, wuwei2016@iscas.ac.cn, drew@pdp7.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, ctsai390@andestech.com, 
	wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com, josef@toxicpanda.com, 
	dsterba@suse.com, mingo@redhat.com, peterz@infradead.org, 
	boqun.feng@gmail.com, xiao.w.wang@intel.com, qingfang.deng@siflower.com.cn, 
	leobras@redhat.com, jszhang@kernel.org, conor.dooley@microchip.com, 
	samuel.holland@sifive.com, yongxuan.wang@sifive.com, 
	luxu.kernel@bytedance.com, david@redhat.com, ruanjinjie@huawei.com, 
	cuiyunhui@bytedance.com, wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn, 
	ardb@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 1:19=E2=80=AFAM Sergey Shtylyov <s.shtylyov@omp.ru>=
 wrote:
>
> On 3/25/25 3:16 PM, guoren@kernel.org wrote:
>
> > From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> >
> > The rv64ilp32 abi reuses the env and argv memory layout of the
> > lp64 abi, so leave the space to fit the lp64 struct layout.
> >
> > Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> > ---
> >  fs/exec.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/fs/exec.c b/fs/exec.c
> > index 506cd411f4ac..548d18b7ae92 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -424,6 +424,10 @@ static const char __user *get_user_arg_ptr(struct =
user_arg_ptr argv, int nr)
> >       }
> >  #endif
> >
> > +#if defined(CONFIG_64BIT) && (BITS_PER_LONG =3D=3D 32)
okay, #if defined(CONFIG_64BIT) && BITS_PER_LONG =3D=3D 32

>
>    Parens don't seem necessary...
>
> > +     nr =3D nr * 2;
>
>    Why not nr *=3D 2?
okay, nr *=3D 2;

--=20
Best Regards
 Guo Ren

