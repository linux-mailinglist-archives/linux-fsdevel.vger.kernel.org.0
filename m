Return-Path: <linux-fsdevel+bounces-51587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F04AD8ACE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 13:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00EB1189ED80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B0B2E2EF7;
	Fri, 13 Jun 2025 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9TgHrjH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03A62E175B
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814886; cv=none; b=Lp3fMJyf8QDLzCzsGlLATzOApb5ju0tK3WwnOs1FaefVB8yqdkf9rKwlNQNhstBt3HKJkocb5sucbbwrNf+boMMXqBU2gRixDSKZ+ye1KC4C2MFsr63nOzEZc8NlkT2m/GMrE6iCy9joDVY1xY9Z7aGz4OoPNpy5TgsalNsgbU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814886; c=relaxed/simple;
	bh=bPOM1DbKygjiYRYTopA2XM0ezXPB0Iiz6igXcowIpbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=od5Zho4261RBhtSWwiDTkwagygUy8e4GlLhfC74bOV9aW9kNi4VFwDvQ81t0ORp/2Fz/wvRJ6LLkLf40NFuN0WhGLNXXNs3Nco3S8p0e8zAyWJscqgXpJisP5fxSj0yjeq0dDFKTHpcEWpGMSJY4G1loLmDDfxUZzqCWzIGZp9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9TgHrjH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749814883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d4wmhnbGVKz7lcJqCNGH28Zkju+eEmedqT1GB+u5T3A=;
	b=h9TgHrjHFkSIWYsog1eP1v5yo9qGQ0QXw8sXVxUyubyUGgzXcBTaGYI89CAx27lCMJh/WM
	N2KIWsBzksBZCfi05DSxvAl/otMw8Lhc1inBipxvXLuogcxh+5nzclw1R4DRyHbOPlAlsp
	fq91a8Sq0bQamB4qe/ve1r4YrUBd8cc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-X2JFtXzsMd-NCea11w8p7w-1; Fri,
 13 Jun 2025 07:41:22 -0400
X-MC-Unique: X2JFtXzsMd-NCea11w8p7w-1
X-Mimecast-MFC-AGG-ID: X2JFtXzsMd-NCea11w8p7w_1749814881
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3E4718002EC;
	Fri, 13 Jun 2025 11:41:21 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.100])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 707F119560A3;
	Fri, 13 Jun 2025 11:41:20 +0000 (UTC)
Date: Fri, 13 Jun 2025 07:44:55 -0400
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [BUG] fuse/virtiofs: kernel module build fail
Message-ID: <aEwPNxjEaFtnmsuR@bfoster>
References: <aEq4haEQScwHIWK6@bfoster>
 <CAJnrk1aD_N6zX_htAgto_Bzo+1S-dmvgGRHaT_icbnwpVoDGsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aD_N6zX_htAgto_Bzo+1S-dmvgGRHaT_icbnwpVoDGsg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Jun 12, 2025 at 02:56:56PM -0700, Joanne Koong wrote:
> On Thu, Jun 12, 2025 at 4:19 AM Brian Foster <bfoster@redhat.com> wrote:
> >
> > Hi folks,
> >
> > I run kernel compiles quite a bit over virtiofs in some of my local test
> > setups and recently ran into an issue building xfs.ko once I had a
> > v6.16-rc kernel installed in my guest. The test case is a simple:
> >
> >   make -j N M=fs/xfs clean; make -j N M=fs/xfs
> 
> Hi Brian,
> 

Hi Joanne,

> If I'm understanding your setup correctly, basically you have the
> v6.16-rc kernel running on a VM, on that VM you mounted a virtiofs
> directory that references a linux repo that's on your host OS, and
> then from your VM you are compiling the fs/xfs module in that shared
> linux repo?
> 

Yep. Note again that I happen to be using the same repo that I was
bisecting, so technically the test case of recompiling the kernel module
is targeting different code each time, but the failure was so consistent
that I believe it to be a runtime issue.

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
> 

I don't recall seeing that specific error, but TBH this kind of looks in
line with what I'm seeing in general. My suspicion is that this is not
actually a source code error, but something is corrupted somehow or
another via virtiofs.

As a quick additional test, I just built my same repo from my host
system (running a distro v6.14 kernel) without any issue. Then if I do
the kernel module rebuild test of the same exact repo over virtiofs from
the guest, the error occurs.

What is interesting is that if I try the same thing with another module
(i.e. fs/fuse, fs/nfs), the build seems to work fine, so maybe there is
something unique to XFS going on here. As a followup to that, I set my
repo back to v6.15 but still reproduce the same phenomenon: build
failure when compiling over virtiofs and not from the host.. :/

> Taking a look at what 63c69ad3d18a ("fuse: refactor
> fuse_fill_write_pages()") does, it seems odd to me that the changes in
> that commit would lead to the issues you're seeing - that commit
> doesn't alter structs or memory layouts in any way. I'll keep trying
> to repro the issue you're seeing.
> 

Apologies I haven't really had a chance to look at the code.. It's
certainly possible I botched something in the bisect or misunderstood
some tooling differences or whatever, but I'm pretty sure I at least
tried the target commit and the immediate preceding commit after the
bisect to double check where the failing starts to happen.

That said, I suspect you are actually reproducing the same general
problem with your test above, regardless of whether the analysis is
wrong. If you're able, have you tried whether that same compile works
from a host (or non-virtiofs) env? Thanks.

Brian

> >
> > ... and ends up spitting out link time errors like this as of commit
> > 63c69ad3d18a ("fuse: refactor fuse_fill_write_pages()"):
> >
> > ...
> >   CC [M]  xfs.mod.o
> >   CC [M]  .module-common.o
> >   LD [M]  xfs.ko
> >   BTF [M] xfs.ko
> > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got subprogram (0x2e) @ ed957!
> > error decoding cu i_mmap_rwsem
> > error decoding cu
> > ...
> > error decoding cu
> > pahole: xfs.ko: Invalid argument
> > make[3]: *** [/root/repos/linux/scripts/Makefile.modfinal:57: xfs.ko] Error 1
> > make[3]: *** Deleting file 'xfs.ko'
> > make[2]: *** [/root/repos/linux/Makefile:1937: modules] Error 2
> > make[1]: *** [/root/repos/linux/Makefile:248: __sub-make] Error 2
> > make[1]: Leaving directory '/root/repos/linux/fs/xfs'
> > make: *** [Makefile:248: __sub-make] Error 2
> >
> > ... or this on latest master:
> >
> > ...
> >   LD [M]  fs/xfs/xfs.o
> > fs/xfs/xfs.o: error: objtool: can't find reloc entry symbol 2145964924 for .rela.text
> > make[4]: *** [scripts/Makefile.build:501: fs/xfs/xfs.o] Error 1
> > make[4]: *** Deleting file 'fs/xfs/xfs.o'
> > make[3]: *** [scripts/Makefile.build:554: fs/xfs] Error 2
> > make[2]: *** [scripts/Makefile.build:554: fs] Error 2
> > make[1]: *** [/root/repos/linux/Makefile:2006: .] Error 2
> > make: *** [Makefile:248: __sub-make] Error 2
> >
> > The latter failure is what I saw through most of a bisect so I suspect
> > one of the related followon commits alters the failure characteristic
> > from the former, but I've not confirmed that. Also note out of
> > convenience my test was to just recompile xfs.ko out of the same tree I
> > was bisecting from because the failures were consistent and seemed to be
> > a runtime kernel issue and not a source tree issue.
> >
> > I haven't had a chance to dig any further than this (and JFYI I'm
> > probably not going to be responsive through the rest of today). I just
> > completed the bisect and wanted to get it on list sooner rather than
> > later..
> >
> > Brian
> >
> 


