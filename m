Return-Path: <linux-fsdevel+bounces-45130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E70A7328D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 13:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F683BA8A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 12:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658E021506B;
	Thu, 27 Mar 2025 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ry+3lJ4j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7023B4C96;
	Thu, 27 Mar 2025 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743079651; cv=none; b=EvAQMG5VESu7WGFcANCMq8XWSQ2ypSObJdG/8OQivYqTeVgXP5HzTziTSfSvJvtE6aRRLtqKFSiOFasws7eHyo1ZD+k90BQ/Df+zYjHLVpZFQMsqWTGXY434u1C9jksHTrCR9jzi/jmZygMgejsKlUaO4Vb8kp6qhT7q6N/e1/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743079651; c=relaxed/simple;
	bh=tWRtgxQFfYLGIe+M3bP4npfrIUeWm1/2DsIIszdvZ1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=k4S+jnDoUCWuvrSHqjDtgq+sqlvtRW/6KtExIwqX7DNH2wgZF2T25JuLZL4BJ+S3D77oX9pgflFDjXTpJS+i0f0kmBsSbhIzTdwX6YMKnAKJo9jEBl2pLn0ItHPJmkKzK3eApkIEqFphg4iD84nXNJgt5aGXasmbTRs6aOxaKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ry+3lJ4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA731C4CEF5;
	Thu, 27 Mar 2025 12:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743079650;
	bh=tWRtgxQFfYLGIe+M3bP4npfrIUeWm1/2DsIIszdvZ1Y=;
	h=References:In-Reply-To:From:Date:Subject:To:From;
	b=ry+3lJ4jOXxi94y5mI1NbXnalzo+G/pnZhSjrID66dTcLVpvSN5jxYLjoTFSpm8t2
	 RVmKewcN7zdZNd9LKSrvUmI7Bitb6RSvE7xtBxsyaXOJotG+IzA+4cSiX8s5XJcd4a
	 Gflk19wroRN6hPkMWa+MtGfvaJAZL2ppLItlCErXCvjy0HVn2BGenZE8FkLMdyZJYX
	 btnwncSVrJy5++ND3g+6x3gmSehP4lsafQ7UigXG8+8I+Idsw/U+sgz5n2nwr8zWSp
	 H++QkUGRCbXL4b+bUxPVKQyPP9wfeJA4D52pvQD5Qmb8PrgNvDFT5Gco7rpxg0Rv5D
	 +Xv0BqRwjjbZg==
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3913d129c1aso661635f8f.0;
        Thu, 27 Mar 2025 05:47:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5hcNep0PjlWuCjj4NMUHFm818rHYcrYyQ+DkL6NGKfFUJ4v/BcyFUrkel3sqzxPC+7UF4Gw0g7dKhWw==@vger.kernel.org, AJvYcCUpRF0LMC3Q/GxxnFl/SikHq8Eg1luCylG1nbvLCJPcP1H53E4fn+LAE7K8vpNsMPpG/fJCB/D7+PaJPcWB@vger.kernel.org, AJvYcCVsX2WU+aFIb+EtrTeOVhAhki8Xl8hnQccFte3jiXy7c+SoP336Isp5FOeu28FBGIlB2ROIeI3963eLc8op175jdLwY@vger.kernel.org, AJvYcCVsk9ryKBUmTtDTK3JMNACZZtZh3qUdTXBK9AUM7MpPooozj33rGfhHocYseLf3Hdvnbmv5iThAw60eV2s=@vger.kernel.org, AJvYcCW47Pl062oNYCMWE8maqYFeRsEBRX/OxIBtYxI+7yUwLObmkUp5z0ZRT6ORYTgwSsjyqPGDyRK1@vger.kernel.org, AJvYcCWMFNhPKyVBg8HzwapRAVSxnRnVozy30gmOACtgCyfhUIQf8mrsaEm6Sr0iSgGBOwVXrSe4RcIX6ekyUeg=@vger.kernel.org, AJvYcCWfBcnAb8xTLS1kbS+egemf7Ox6oWbJw8R88CXPeQ0Glbkxo3FEAp9vMhTnXT5oEvMPFPp8IajlFhVU@vger.kernel.org, AJvYcCWiTPAJ35xrAthksX8h3zgALJzAxpvYYIzj4lBvCXKn6jSapgtIYpu8ec64/MPLpAN6Lk/O4smDXiCYNlWYHlZrng==@vger.kernel.org, AJvYcCXAaymzApg5BY0elxAd++hiveDmgW/TXCPDnh29ZmDTNqH2o51O7w2VXjIPXhfRsvNGxrY=@vger.kernel.org, AJvYcCXHDwYP6ZaCTiL9My6z
 7yC6suW8qxpYc6dfkuhtoE/tOzDutoWCp0ns7baqRFBrVHzAXoQZ0151LFwp1WvP@vger.kernel.org, AJvYcCXL7YZFQf+f7P0qMC6EyEWiFbU79B0NU19DRu6ijcezGqQaBzbRmZ5mucWTZSA6w/8E70sTbVqSWZUdpnw=@vger.kernel.org, AJvYcCXbhSiKRWI9uyLNQQIsOEaFgZ/HxBAa7FVwybOlYAZASlseozeXHHaatK5zgAC488cNoZTwVseTG0h4VovH@vger.kernel.org, AJvYcCXc6FX30ucCj0pToZvuhkKqueU0sQe1vh6WfGO6OeFMjQYGCKQ709smTtbZe+9HllwgggFsuYuz695hqA==@vger.kernel.org, AJvYcCXd8kfvoPg1KTWlkTs6C90VCMZcmZaq9dnCLd/cBTgsqBFc5W0Cbbsci/9CyNUK3B65G5+bbV3X0RKSJF8U4ACe@vger.kernel.org, AJvYcCXgDYubmSZhvljBWKbJvpmcObj9oe/3BqtnZEQzuGIRwSlPUW2zpRQConp7qmzVn5I3i6VYXSB9+8ITYsFDTA==@vger.kernel.org, AJvYcCXjVLv+hm+wtOOo17m+XfrZWp3wVaANCLv+x+sHaEYWHFOqWt6rWdfRrUC8LpXl+CWVf08r@vger.kernel.org, AJvYcCXmUOIyGgfZKIULNMQLTqLSv8rJGp/ez2BeSn9pjUHExJDst1Bcq5xifH/YedVQF4xWXsxckkx1bYzA@vger.kernel.org
X-Gm-Message-State: AOJu0YwJoiSfrI8TdhC5XKmUGK85XKg9Y46zYQOWy/j6Hv+i2J0vqjyE
	eSR/rKOCuNSh8OsxjIXx1kSpDAAggC3xYT7ED8pCXthmRDFmY4F1Whz1DfDNzZMcDuRKcQa6C4W
	p0wmuvj1AH6Wi7z+BkqbF/M8p9Ss=
X-Google-Smtp-Source: AGHT+IHmUYVhD/X+fFCk9mo6iUY3GGy6zSlwPlvt9V5E3bXgq4+AzDcNpwzxGBSsif+BeffRslEST7FtUwPlgXmmxiQ=
X-Received: by 2002:a5d:5f43:0:b0:391:65c:1b05 with SMTP id
 ffacd0b85a97d-39c099cd2bbmr115764f8f.11.1743079648810; Thu, 27 Mar 2025
 05:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325121624.523258-1-guoren@kernel.org> <20250325121624.523258-32-guoren@kernel.org>
 <4gph4xikdbg6loy2id72uyxgldsldecc7gquhymusl3vreiw3a@ephk5ahhrdw7>
In-Reply-To: <4gph4xikdbg6loy2id72uyxgldsldecc7gquhymusl3vreiw3a@ephk5ahhrdw7>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 27 Mar 2025 20:47:15 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSR+jh04BT7rCjALL6eWek=VWm7nFTW57vzwshkTbrtVg@mail.gmail.com>
X-Gm-Features: AQ5f1JoN57xvarY3Pp887PY64wPP4HS8fDT1YiKKfNiabWlzF5M2aRc4_YpAz7M
Message-ID: <CAJF2gTSR+jh04BT7rCjALL6eWek=VWm7nFTW57vzwshkTbrtVg@mail.gmail.com>
Subject: Re: [RFC PATCH V3 31/43] rv64ilp32_abi: maple_tree: Use BITS_PER_LONG
 instead of CONFIG_64BIT
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, guoren@kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
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

On Wed, Mar 26, 2025 at 3:10=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * guoren@kernel.org <guoren@kernel.org> [250325 08:24]:
> > From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> >
> > The Maple tree algorithm uses ulong type for each element. The
> > number of slots is based on BITS_PER_LONG for RV64ILP32 ABI, so
> > use BITS_PER_LONG instead of CONFIG_64BIT.
> >
> > Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> > ---
> >  include/linux/maple_tree.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> > index cbbcd18d4186..ff6265b6468b 100644
> > --- a/include/linux/maple_tree.h
> > +++ b/include/linux/maple_tree.h
> > @@ -24,7 +24,7 @@
> >   *
> >   * Nodes in the tree point to their parent unless bit 0 is set.
> >   */
> > -#if defined(CONFIG_64BIT) || defined(BUILD_VDSO32_64)
> > +#if (BITS_PER_LONG =3D=3D 64) || defined(BUILD_VDSO32_64)
>
> This will break my userspace testing, if you do not update the testing as
> well.  This can be found in tools/testing/radix-tree.  Please also look
> at the Makefile as well since it will generate a build flag for the
> userspace.
I think you are talking about the following:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
../shared/shared.mk:
ifndef LONG_BIT
LONG_BIT :=3D $(shell getconf LONG_BIT)
endif

generated/bit-length.h: FORCE
        @mkdir -p generated
        @if ! grep -qws CONFIG_$(LONG_BIT)BIT generated/bit-length.h; then =
  \
                echo "Generating $@";                                      =
  \
                echo "#define CONFIG_$(LONG_BIT)BIT 1" > $@;               =
  \
                echo "#define CONFIG_PHYS_ADDR_T_$(LONG_BIT)BIT 1" >> $@;  =
  \
        fi

$ grep CONFIG_64BIT * -r -A 2
generated/bit-length.h:#define CONFIG_64BIT 1
generated/bit-length.h-#define CONFIG_PHYS_ADDR_T_64BIT 1
--
maple.c:#if defined(CONFIG_64BIT)
maple.c-static noinline void __init check_erase2_testset(struct maple_tree =
*mt,
maple.c-                const unsigned long *set, unsigned long size)
--
maple.c:#if CONFIG_64BIT
maple.c-        MT_BUG_ON(mt, data_end !=3D mas_data_end(&mas));
maple.c-#endif
--
maple.c:#if CONFIG_64BIT
maple.c-        MT_BUG_ON(mt, data_end - 2 !=3D mas_data_end(&mas));
maple.c-#endif
--
maple.c:#if CONFIG_64BIT
maple.c-        MT_BUG_ON(mt, data_end - 4 !=3D mas_data_end(&mas));
maple.c-#endif
--
maple.c:#if defined(CONFIG_64BIT)
maple.c-        /* Captures from VMs that found previous errors */
maple.c-        mt_init_flags(&tree, 0);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

First, we don't introduce rv64ilp32-abi user space, which means these
testing codes can't run on rv64ilp32-abi userspace currently. So, the
problem you mentioned doesn't exist.

Second, CONFIG_32BIT is determined by LONG_BIT, so there's no issue in
maple.c with future rv64ilp32-abi userspace.
That means rv64ilp32-abi userspace would use CONFIG_32BIT to test
radix-tree. It's okay.

>
> This raises other concerns as the code is found with a grep command, so
> I'm not sure why it was missed and if anything else is missed?
>
> If you consider this email to be the (unasked) question about what to do
> here, then please CC me, the maintainer of the files including the one
> you are updating here.
>
> Thank you,
> Liam
>


--=20
Best Regards
 Guo Ren

