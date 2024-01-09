Return-Path: <linux-fsdevel+bounces-7593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BFF828380
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 10:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05BA1C23D79
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 09:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E5835EFC;
	Tue,  9 Jan 2024 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ5jiUNl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AB73588B;
	Tue,  9 Jan 2024 09:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0674BC433F1;
	Tue,  9 Jan 2024 09:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704793939;
	bh=E0zakJMzNcSQvgcgc8AtRvLO3GWb7iOulE6UYhMFa9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZ5jiUNlx+uIcVw0jOrCRHD/HIgkYHSdkfMeXRC7H6k9CdsTHIT6ytv0You6CYPJP
	 JL2e8ac+pU9wQgh7KeYlMahawI2dCz5kICh0rd9VCJ/Aw4dl4tBwJaNzkSgT66QeZF
	 t5BL4TZD1oRNAL9gqpqSKF6K3ix7ZFHWv8GEdt+qY/tyL1/DtsiuS/VbK5m3amG05b
	 ojdmgauWZcv0NL+IwvdbxBoASiVBsgG41pr6N7/s9C1Qp4Z9VBQd49g6gdfkGlmdAo
	 Nb5Sct9ydw0Iz8l8UbVVGTzz02Xv4ZS5+GV2FAn+uR3NdSCPy+pKd4/cvg7AZxlIfW
	 tBn2k1JrUKWmQ==
Date: Tue, 9 Jan 2024 09:52:14 +0000
From: Will Deacon <will@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs mount api updates
Message-ID: <20240109095214.GB12915@willie-the-truck>
References: <20240105-vfs-mount-5e94596bd1d1@brauner>
 <CAHk-=wjfbjuNxx7jWa144qVb5ykwPCwVWa26tcFMvE-Cr6=vMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjfbjuNxx7jWa144qVb5ykwPCwVWa26tcFMvE-Cr6=vMg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Linus,

On Mon, Jan 08, 2024 at 05:02:48PM -0800, Linus Torvalds wrote:
> On Fri, 5 Jan 2024 at 04:47, Christian Brauner <brauner@kernel.org> wrote:
> >
> > This contains the work to retrieve detailed information about mounts via two
> > new system calls.
> 
> Gaah. While I have an arm64 laptop now, I don't do arm64 builds in
> between each pull like I do x86 ones.
> 
> I *did* just start one, because I got the arm64 pull request.
> 
> And this fails the arm64 build, because __NR_statmount and
> __NR_listmount (457 and 458 respectively) exceed the compat system
> call array size, which is
> 
> arch/arm64/include/asm/unistd.h:
>   #define __NR_compat_syscalls            457
> 
> I don't think this is a merge error, I think the error is there in the
> original, but I'm about to go off and have dinner, so I'm just sending
> this out for now.
> 
> How was this not noted in linux-next? Am I missing something?

Urgh, that is surprising, and I just confirmed that linux-next builds
fine! The reason seems to be because there are also some new lsm
syscalls being added there (lsm_get_self_attr and friends) which bump
__NR_compat_syscalls to 460 and then Stephen Rothwell's mighty merging
magic adjusted this up to 462 in the merge of the lsm tree.

> Now, admittedly this looks like an easy mistake to make due to that
> whole odd situation where the compat system calls are listed in
> unistd32.h, but then the max number is in unistd.h, but I would still
> have expected this to have raised flags before it hit my tree..

I suppose the two options for now are either to merge the lsm stuff and
adjust __NR_compat_syscalls as Stephen did, or to take this patch from
Florian in the meantime:

https://lore.kernel.org/r/20240109010906.429652-1-florian.fainelli@broadcom.com

Cheers,

Will

