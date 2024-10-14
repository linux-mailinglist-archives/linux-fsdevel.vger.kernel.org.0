Return-Path: <linux-fsdevel+bounces-31905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B053799D4B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 18:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71947288B80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 16:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3801B85DB;
	Mon, 14 Oct 2024 16:31:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132CE219FC;
	Mon, 14 Oct 2024 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923516; cv=none; b=jwv3MZTVgs1/xEkbinyq6Xc0JqXhPsgQD4fJ+ousJoQ6XBFwh3etBFwyIUFsSjVfDeR+xIk2h/RpDKSSXmVAPv7S4D1l31CqRFa2iZz5aVzF5R1lrcVHBylVsK9X3y//nF4PxWNjT4WYPIe2IMypiID3HByWxw1qnZi66KmLbKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923516; c=relaxed/simple;
	bh=J4RYJQdbHZ8u/a1Vqi8q8LZYmuKpwmhzcaKo3jaJF0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4XBHie9NIDQmOKi5fidbWMsGHiUzHZqkdlercUI9p9oGybtQwqAgMC6+SZ4gSl+MDQrCI/oMEQdSwrlwdHWik0tDtPMPDrMHjZyf+VoASoV4IxfqzU0NzICHOf49KY9c5dWlb6lZKcFtsBDpToCfR8u9WdUbM88LyFdlhCPLLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EACC4CEC3;
	Mon, 14 Oct 2024 16:31:49 +0000 (UTC)
Date: Mon, 14 Oct 2024 17:31:47 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Mark Brown <broonie@kernel.org>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	David Spickett <david.spickett@arm.com>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v13 11/40] arm64/gcs: Provide basic EL2 setup to allow
 GCS usage at EL0 and EL1
Message-ID: <Zw1Hc38CwFS2XE6c@arm.com>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
 <20241001-arm64-gcs-v13-11-222b78d87eee@kernel.org>
 <20241009204903.GA3353168@thelio-3990X>
 <86msjc56mi.wl-maz@kernel.org>
 <ZwgMBAhR5-5R5EYC@arm.com>
 <86h69i6bpy.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86h69i6bpy.wl-maz@kernel.org>

On Fri, Oct 11, 2024 at 01:55:05PM +0100, Marc Zyngier wrote:
> On Thu, 10 Oct 2024 18:16:52 +0100,
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> > 
> > On Thu, Oct 10, 2024 at 04:18:13PM +0100, Marc Zyngier wrote:
> > > From 20c98d2647c11db1e40768f92c5998ff5d764a3a Mon Sep 17 00:00:00 2001
> > > From: Marc Zyngier <maz@kernel.org>
> > > Date: Thu, 10 Oct 2024 16:13:26 +0100
> > > Subject: [PATCH] KVM: arm64: Shave a few bytes from the EL2 idmap code
> > > 
> > > Our idmap is becoming too big, to the point where it doesn't fit in
> > > a 4kB page anymore.
> > > 
> > > There are some low-hanging fruits though, such as the el2_init_state
> > > horror that is expanded 3 times in the kernel. Let's at least limit
> > > ourselves to two copies, which makes the kernel link again.
> > > 
> > > At some point, we'll have to have a better way of doing this.
> > > 
> > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > Link: https://lore.kernel.org/r/20241009204903.GA3353168@thelio-3990X
> > 
> > Thanks Marc for the quick fix. It looks fine to me, it will keep the
> > linker quiet for a while. I pushed it to arm64 for-kernelci for the time
> > being, see if anything falls apart. I'll apply it properly once it gets
> > a bit more testing.
> 
> Works for me. But if that helps, I can also queue it as a KVM fix for
> 6.12, leaving the GCS branch unencumbered. Just let me know.

That would help, thanks. The for-kernelci branch merges the latest mainline
rc anyway, so it will no longer blow up allmodconfig tests.

-- 
Catalin

