Return-Path: <linux-fsdevel+bounces-33568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF559BA25A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 20:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 698FAB21BC9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 19:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896251AB6F1;
	Sat,  2 Nov 2024 19:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdmKgENs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F8A14F12F;
	Sat,  2 Nov 2024 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730577531; cv=none; b=XkOBU8lEZnAjsaUAoFArlfJ0QLwaNF2vsiH9r1tGvJiaFoD02lLLIXUn1q5J7IaaRk/7yZNFhddZgDVLe53SR/D9itndXyQDBPN1Z5MqOESnagC67uP5f6gmsM6iHClOw6nCGDzQ6sm1iiRGF8HW38tJ6Ju5FofA6EJSJSa56sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730577531; c=relaxed/simple;
	bh=JUI6hhefhoPmDatTKsy4pqsfjwmhOnV4eb6LBjksVQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dre3vOaBlrNheU/s3pMAEnDUgyHWbZWIq5zqyzG1qay5u9bCnNBODK8+501P+r88ZIzmp8L/Zf4raD90OKuI5InR3Fq4OL64ohu+HJKdfVdZa+sXugsIWn2sbBHm1Eo+ZwlJ5SV99RijnNxnv2bCIVjBDEd5ywH7xj5XXA5IwSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdmKgENs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E6DC4CEC3;
	Sat,  2 Nov 2024 19:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730577530;
	bh=JUI6hhefhoPmDatTKsy4pqsfjwmhOnV4eb6LBjksVQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DdmKgENsI5ODLmVFU2RNr0QQqkmCaoHm8FA3BgVkYnpB/nGQyoTRgnZbFf0YxSIUD
	 7PEiu6+LBVAiAcb8Zs2CeSt/Cxd7h4p9RlaI5AUmuu7zN6pA/WJ5vQ3xxzG+PnJHju
	 /Q2qZCl5fSwFi8G8rlsBrb3vBX5dLSsvWB2zCNAwaP5KirBFdPFzI6MPeuXBGBG/GC
	 hF6VIdsI5bKImG9CkjtTZw3C64a55hbM9OgPjeUeCuBi89jvJAMnQ5/N8bTpYds22v
	 iqRaBJ3EliDPPKpUlXahMqJ+UNpEfubJl/Q+G+TDFyTJHI3NUFiKFZsmVRAtCs+Det
	 SN2d/j5IrA5lQ==
Date: Sat, 2 Nov 2024 12:58:47 -0700
From: Kees Cook <kees@kernel.org>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc: Tycho Andersen <tycho@tycho.pizza>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH 1/2] exec: fix up /proc/pid/comm in the
 execveat(AT_EMPTY_PATH) case
Message-ID: <202411021258.6F1CD2AE28@keescook>
References: <20241030203732.248767-1-tycho@tycho.pizza>
 <173041263505.1781237.9706368369948860422.b4-ty@kernel.org>
 <ZyYNM58N-Fp_1xB8@kawka3.in.waw.pl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyYNM58N-Fp_1xB8@kawka3.in.waw.pl>

On Sat, Nov 02, 2024 at 11:29:55AM +0000, Zbigniew Jędrzejewski-Szmek wrote:
> On Thu, Oct 31, 2024 at 03:10:37PM -0700, Kees Cook wrote:
> > On Wed, 30 Oct 2024 14:37:31 -0600, Tycho Andersen wrote:
> > > Zbigniew mentioned at Linux Plumber's that systemd is interested in
> > > switching to execveat() for service execution, but can't, because the
> > > contents of /proc/pid/comm are the file descriptor which was used,
> > > instead of the path to the binary. This makes the output of tools like
> > > top and ps useless, especially in a world where most fds are opened
> > > CLOEXEC so the number is truly meaningless.
> > > 
> > > [...]
> > 
> > Applied to for-next/execve, thanks!
> > 
> > [1/2] exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case
> >       https://git.kernel.org/kees/c/7bdc6fc85c9a
> > [2/2] selftests/exec: add a test for execveat()'s comm
> >       https://git.kernel.org/kees/c/bd104872311a
> 
> I tested this with systemd compiled with -Dfexece=true and it all
> seems to work fine. Thanks!

Great; thank you!

-- 
Kees Cook

