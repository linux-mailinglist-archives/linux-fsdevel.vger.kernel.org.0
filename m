Return-Path: <linux-fsdevel+bounces-16849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B2B8A3B09
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 06:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97AD1C233B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 04:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A6C1C6A7;
	Sat, 13 Apr 2024 04:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="TbnQtMH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFE717591
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 04:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712982981; cv=none; b=o8CBqy+lyTS8QlA5qqFkgBNYnPx7jOgedrIHplUl5BwOCsfQXW7Ncmisa4HSZcMPPWUOPuf3EoVFhPKe46ubS4luBaZatFKxHNp9bYIWSfwkNhPgD1xe99BQ4VPOe64kKlC4VlYZEQyIwEyUxlBIVmMNokjp8sB34jczsWvEhdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712982981; c=relaxed/simple;
	bh=fbIpJRyqCzHbHwHwiGGAvD34UuOfNcgBOS9zc+epVds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsolatCQnM9hn3jXA26k1PcjISIkXDNts8JpOnCFpWMX7b6jT1HSqxR4C0RDgoQ0VBcLajPVfhQlXdZQqgiNBYhXqTtyxAU/6k+2bMLnKgnUEssoTX8eMtOzIgOT4a0lw69rNfcmjQimM2sByzvgTjUUJ5qXBsGJ2t2AZ7oaegI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=TbnQtMH6; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43D4ZgBU018660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 00:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1712982946; bh=/B4pXAPsMRR82DA1Wh7RuqgKoBHilarf9qCJOIPKqF4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=TbnQtMH6TFa+kLU/M/0hqC87t19sYAJN33+wvj898a7IJ849R+CNp8YkoxJc/Eeqm
	 I2PCmWvJ0bGYq9M9QpnVJo0D7W+DMRoH2GHhUJAP5O8E8XWOtKLsZlCprWefjOuJpC
	 zsYq77DgwqdyyjzyOGaLj+eVsx7pFRn771AUsyRhDjbuR5qA+8fLh273p/m7yumP98
	 djtYmjbKvdy3xFtzs0yaGDs2tVDUtytiErDSfYlSXQUDHzYXGGstKUVL6NVEF2ie/f
	 Qe78Fkdk33nf6FYe0NcVWu+C/fZdkYwQQ1tQRiic7WUtjR7NLiVjj3mdNn2fty2KSS
	 LXpNi5K/SoXmw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 2A66215C0CB5; Sat, 13 Apr 2024 00:35:42 -0400 (EDT)
Date: Sat, 13 Apr 2024 00:35:42 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        Conor Dooley <conor@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Message-ID: <20240413043542.GE187181@mit.edu>
References: <878r1ibpdn.fsf@all.your.base.are.belong.to.us>
 <20240412154342.GA1310856@mit.edu>
 <87a5lyecuw.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a5lyecuw.fsf@all.your.base.are.belong.to.us>

On Fri, Apr 12, 2024 at 06:59:19PM +0200, Björn Töpel wrote:
> 
>   $ pipx install tuxrun
> 
> if you're on Debian.
> 
> Then you can get the splat by running:
> 
>   $ tuxrun  --runtime docker --device qemu-riscv32 --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2esMBaAMQJpcmczj0aL94fp4QnP/Image.gz --parameters SKIPFILE=skipfile-lkft.yaml --parameters SHARD_NUMBER=10 --parameters SHARD_INDEX=1 --image docker.io/linaro/tuxrun-dispatcher:v0.66.1 --tests ltp-controllers

Yeah, what I was hoping for was a shell script or a .c file hich was
the reproducer, because that way I can run the test in my test infrastructure [1]

[1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-xfstests.md

I'm sure there are plenty of nice things about tuxrun, but with
kvm-xfstests I can easily get a shell so I can run the test sccript by
hand, perhaps with strace so I can see what is going on.  Or I attach
gdb to the kernel via "gdb /path/to/vmlinux" and "target remote
localhost:7499".

I'm guessing that "ltp-controllers" means that the test might be from
the Linux Test Project?  If so, that's great because I've added ltp
support to my test infrastructure (which also supports blktests,
phoronix test suite, and can be run on gce and on android devices in
addition to qemu, and on the arm64, i386, and x86_64 architectures).

> Build with "make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-", and make
> sure to have the riscv64 cross-compilation support (yes, same toolchain
> for rv32!).
> 
> It's when the rootfs is mounted, and the kernel is looking an init.

Hmm, so this happening as soon as the VM starts, before actually
starting to run any tests?  Is it possible for you to send me the
rootfs as a downloading image, as opposed to my trying to paw through
the docker image?

> I'll keep debugging -- it was more if anyone had seen it before. I'll
> try to reproduce on some other 32b platform as well.

Well, it's not happening on my rootfs on i386 using my test infrastructure:

% cd /usr/projects/linux/ext4
% git checkout v6.8
% install-kconfig --arch i386
% kbuild --arch i386
% kvm-xfstests shell
    ...
root@kvm-xfstests:~# cd ltp
root@kvm-xfstests:~# ./runltp

(I don't have ltp support fully automated the way I can run blktests
using "kvm-xfstests --blktests" or run xfstests via "gce-xfstests -c
ext4/all -g auto".  The main missing is teaching ltp to create an
junit xml results file so that the test results can be summarized and
so the test results can be more easily summarized and compared against
past runs on different kernel versions.)

Anyway, if you can send me your rootfs, I can try to take a look at it.

       	       	       	    	      - Ted

