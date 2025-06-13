Return-Path: <linux-fsdevel+bounces-51591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EA4AD8F1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 16:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A483BD45E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 14:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4452E11AA;
	Fri, 13 Jun 2025 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Io5trRvU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E82A2E11A1
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749823622; cv=none; b=erprNzaN5JkUnd9ivezD7t8+7QibmQ4gCAI4HSPa2Ype8FfJsQEaAK1pRnGS2nR0j1V/5jPHF6orWfvlL5x/+Ei+74PihCHd0GRx7m+edTA1LLZn73YLEHzHMGtnTSTNiFPrr2YEaezhXvXD3O4GwKBlhtzhKyqsF8tW1PPyBoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749823622; c=relaxed/simple;
	bh=jaoAoq8tAfYXmol42mdw39xz+VSbiU0NtsyL418XT5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gsfadA4Iddt2wPd25d6WAyTCX4gx+pp30BPi59lJWqVd9jCQ3jlLIXBCQAw65eLWc08M38fO9lP4d/ogIZFvgI7aX69aMw+yT71afkIP4ZM1Q4F6wpUj/RCSFLtz54BtjFr/Cs84G51rsSJUFl8dTtaJh0Isq2TexwJb6xnvH1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Io5trRvU; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RxXHhzPJvSA7SKK63R+Cj9qVkYpdEeGEAn+vE5VvfbM=; b=Io5trRvUpg2xembzfy9kNImfL0
	bCvZE/W6lCQ7wKZ4/8XttgHp+bngBZoSrohak8+/R4ymIfI+iJHB1CPxDyPwYrPiTLfSGEu+NBwo4
	Ae3eovbD3GW6IrHoC1k3mXysqxElrr5FLV3z5QxTP95djJR1/9TvjgJ48QH5oJA26cwDMtBR8XElf
	8iXEUuR6yA2Z8pfryPyaDOJne/35qtx60AhVh9UCnvfYTwDfpopGa7UJgKZvDfUzeZcgQqUj+blf3
	/dii3+Dv0Lz7eO5p2Ua0HrCGyicvSmMKAasKFTRUG32v86FvREBVPVq8IgNGNa8c+2tk9ppD/6ByT
	FU4WXMag==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uQ53X-00331c-CY; Fri, 13 Jun 2025 16:06:55 +0200
From: Luis Henriques <luis@igalia.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Brian Foster <bfoster@redhat.com>,  linux-fsdevel@vger.kernel.org,
  Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [BUG] fuse/virtiofs: kernel module build fail
In-Reply-To: <CAJnrk1aD_N6zX_htAgto_Bzo+1S-dmvgGRHaT_icbnwpVoDGsg@mail.gmail.com>
	(Joanne Koong's message of "Thu, 12 Jun 2025 14:56:56 -0700")
References: <aEq4haEQScwHIWK6@bfoster>
	<CAJnrk1aD_N6zX_htAgto_Bzo+1S-dmvgGRHaT_icbnwpVoDGsg@mail.gmail.com>
Date: Fri, 13 Jun 2025 15:06:49 +0100
Message-ID: <871prn20sm.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12 2025, Joanne Koong wrote:

> On Thu, Jun 12, 2025 at 4:19=E2=80=AFAM Brian Foster <bfoster@redhat.com>=
 wrote:
>>
>> Hi folks,
>>
>> I run kernel compiles quite a bit over virtiofs in some of my local test
>> setups and recently ran into an issue building xfs.ko once I had a
>> v6.16-rc kernel installed in my guest. The test case is a simple:
>>
>>   make -j N M=3Dfs/xfs clean; make -j N M=3Dfs/xfs
>
> Hi Brian,
>
> If I'm understanding your setup correctly, basically you have the
> v6.16-rc kernel running on a VM, on that VM you mounted a virtiofs
> directory that references a linux repo that's on your host OS, and
> then from your VM you are compiling the fs/xfs module in that shared
> linux repo?
>
> I tried this on my local setup but I'm seeing some other issues:
>
> make[1]: Entering directory '/home/vmuser/linux/linux/fs/xfs'
>   LD [M]  xfs.o
> xfs.o: warning: objtool: __traceiter_xfs_attr_list_sf+0x23:
> unannotated intra-function call
> make[3]: *** [/home/vmuser/linux/linux/scripts/Makefile.build:501:
> xfs.o] Error 255
> make[3]: *** Deleting file 'xfs.o'
> make[2]: *** [/home/vmuser/linux/linux/Makefile:2006: .] Error 2
> make[1]: *** [/home/vmuser/linux/linux/Makefile:248: __sub-make] Error 2
> make[1]: Leaving directory '/home/vmuser/linux/linux/fs/xfs'
> make: *** [Makefile:248: __sub-make] Error 2
>
> Did you also run into these issues when you were compiling?

This is probably just a shot in the dark, but I remember seeing similar
build failures long time ago due to virtiofs caching.  I don't remember
the details, but maybe it's worth checking that.  I *think* that what
fixed it for me was to use '--cache auto'.

Cheers,
--=20
Lu=C3=ADs


> Taking a look at what 63c69ad3d18a ("fuse: refactor
> fuse_fill_write_pages()") does, it seems odd to me that the changes in
> that commit would lead to the issues you're seeing - that commit
> doesn't alter structs or memory layouts in any way. I'll keep trying
> to repro the issue you're seeing.
>
>>
>> ... and ends up spitting out link time errors like this as of commit
>> 63c69ad3d18a ("fuse: refactor fuse_fill_write_pages()"):
>>
>> ...
>>   CC [M]  xfs.mod.o
>>   CC [M]  .module-common.o
>>   LD [M]  xfs.ko
>>   BTF [M] xfs.ko
>> die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit=
 or DW_TAG_skeleton_unit expected got subprogram (0x2e) @ ed957!
>> error decoding cu i_mmap_rwsem
>> error decoding cu
>> ...
>> error decoding cu
>> pahole: xfs.ko: Invalid argument
>> make[3]: *** [/root/repos/linux/scripts/Makefile.modfinal:57: xfs.ko] Er=
ror 1
>> make[3]: *** Deleting file 'xfs.ko'
>> make[2]: *** [/root/repos/linux/Makefile:1937: modules] Error 2
>> make[1]: *** [/root/repos/linux/Makefile:248: __sub-make] Error 2
>> make[1]: Leaving directory '/root/repos/linux/fs/xfs'
>> make: *** [Makefile:248: __sub-make] Error 2
>>
>> ... or this on latest master:
>>
>> ...
>>   LD [M]  fs/xfs/xfs.o
>> fs/xfs/xfs.o: error: objtool: can't find reloc entry symbol 2145964924 f=
or .rela.text
>> make[4]: *** [scripts/Makefile.build:501: fs/xfs/xfs.o] Error 1
>> make[4]: *** Deleting file 'fs/xfs/xfs.o'
>> make[3]: *** [scripts/Makefile.build:554: fs/xfs] Error 2
>> make[2]: *** [scripts/Makefile.build:554: fs] Error 2
>> make[1]: *** [/root/repos/linux/Makefile:2006: .] Error 2
>> make: *** [Makefile:248: __sub-make] Error 2
>>
>> The latter failure is what I saw through most of a bisect so I suspect
>> one of the related followon commits alters the failure characteristic
>> from the former, but I've not confirmed that. Also note out of
>> convenience my test was to just recompile xfs.ko out of the same tree I
>> was bisecting from because the failures were consistent and seemed to be
>> a runtime kernel issue and not a source tree issue.
>>
>> I haven't had a chance to dig any further than this (and JFYI I'm
>> probably not going to be responsive through the rest of today). I just
>> completed the bisect and wanted to get it on list sooner rather than
>> later..
>>
>> Brian
>>
>


