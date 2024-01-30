Return-Path: <linux-fsdevel+bounces-9562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5964842DE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 21:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946DB1C24FED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 20:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8B079DB3;
	Tue, 30 Jan 2024 20:32:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E06A016
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706646726; cv=none; b=KCemYF+nBhRLP0K2gVkCFawXW44hoibEmbBvrHlRXEFUTpXk8LCjd949oTi2W5Z7OuG2RwxspevlsuKcXJDSVR4fHCOh8WC85HXZlUPiUqJJm/qYK4Ph+7UowsyIachpsQ76QAID7PEgsyZ+d8EudoUxPzQRm3JHs2EHhE6cVY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706646726; c=relaxed/simple;
	bh=UB7BQcsJs2vQ3jKIDJCT4WdO5D5ZedyE0DSP+eaeJ4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cChdQtXhYpt1/YqAWO8nx+jK53y8v2k7eCIyNNrbqNr5rro8HZvSBFZb9TmVvQiSam4CGnmT2gNTFWyR8s/8p/R1PqPPcaap0YAzRUuGOIRvgSey+puTGp1z6WSpaqWMXmhUsnlfWZ9JmMfpmPqi/Vrvs1vAMfsoxubcaH2IJnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=libc.org; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libc.org
Date: Tue, 30 Jan 2024 15:17:03 -0500
From: Rich Felker <dalias@libc.org>
To: musl@lists.openwall.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Fixing ELF loader for systems with oversized pages [was: Re: [musl]
 Segmentation fault musl 1.2.4]
Message-ID: <20240130201701.GT4163@brightrain.aerifal.cx>
References: <20240111170323.GP1427497@port70.net>
 <CAFj3ykeFLLS0VAo9xd70SC+6Rqt1H8nV+4u8CURcgPE_zEtj-w@mail.gmail.com>
 <20240112185713.GQ1427497@port70.net>
 <CAFj3ykddo8asH9udkxmybeKzeAP2Xt1QDHjZOOHafTitdU2sgg@mail.gmail.com>
 <20240115223008.GR1427497@port70.net>
 <CAFj3ykeCHGiT1SH9MJTEf65jxZjjrpuHxn95u2O=KN+cPkZCPA@mail.gmail.com>
 <20240116182918.GS1427497@port70.net>
 <20240116204552.GV4163@brightrain.aerifal.cx>
 <20240130104338.GD1254592@port70.net>
 <20240130153730.GS4163@brightrain.aerifal.cx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5G+Imvfxoe+o1e80"
Content-Disposition: inline
In-Reply-To: <20240130153730.GS4163@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)


--5G+Imvfxoe+o1e80
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 30, 2024 at 10:37:30AM -0500, Rich Felker wrote:
> On Tue, Jan 30, 2024 at 11:43:38AM +0100, Szabolcs Nagy wrote:
> > * Rich Felker <dalias@libc.org> [2024-01-16 15:45:52 -0500]:
> > 
> > > On Tue, Jan 16, 2024 at 07:29:18PM +0100, Szabolcs Nagy wrote:
> > > > * Cody Wetzel <codyawetzel@gmail.com> [2024-01-16 09:21:05 -0600]:
> > > > > Here is the output for the old
> > > > > ....
> > > > > >
> > > > > > / # /tmp/ld-musl-armhf.so.1 /usr/bin/readelf -lW /tmp/ld-musl-armhf.so.1
> > > > > >
> > > > > > Elf file type is DYN (Shared object file)
> > > > > > Entry point 0x359cd
> > > > > > There are 6 program headers, starting at offset 52
> > > > > >
> > > > > > Program Headers:
> > > > > >   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
> > > > > >   EXIDX          0x07acec 0x0007acec 0x0007acec 0x00008 0x00008 R   0x4
> > > > > >   LOAD           0x000000 0x00000000 0x00000000 0x7acf4 0x7acf4 R E 0x10000
> > > > > >   LOAD           0x07fd6c 0x0008fd6c 0x0008fd6c 0x0054a 0x02258 RW  0x10000
> > > > 
> > > > this load segment is 64k aligned.
> > > > 
> > > > > >   DYNAMIC        0x07febc 0x0008febc 0x0008febc 0x000c0 0x000c0 RW  0x4
> > > > > >   GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x10
> > > > > >   GNU_RELRO      0x07fd6c 0x0008fd6c 0x0008fd6c 0x00294 0x00294 R   0x1
> > > > > >
> > > > > >  Section to Segment mapping:
> > > > > >   Segment Sections...
> > > > > >    00     .ARM.exidx
> > > > > >    01     .hash .gnu.hash .dynsym .dynstr .rel.dyn .rel.plt .plt .text
> > > > > > .rodata .ARM.exidx
> > > > > >    02     .data.rel.ro .dynamic .got .data .bss
> > > > > >    03     .dynamic
> > > > > >    04
> > > > > >    05     .data.rel.ro .dynamic .got
> > > > > >
> > > > > 
> > > > > And the new...
> > > > > 
> > > > > / # /tmp/ld-musl-armhf.so.1 /usr/bin/readelf -lW /lib/ld-musl-armhf.so.1
> > > > > >
> > > > > > Elf file type is DYN (Shared object file)
> > > > > > Entry point 0x362f1
> > > > > > There are 6 program headers, starting at offset 52
> > > > > >
> > > > > > Program Headers:
> > > > > >   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
> > > > > >   EXIDX          0x07b81c 0x0007b81c 0x0007b81c 0x00008 0x00008 R   0x4
> > > > > >   LOAD           0x000000 0x00000000 0x00000000 0x7b824 0x7b824 R E 0x1000
> > > > > >   LOAD           0x07bd74 0x0007cd74 0x0007cd74 0x0054a 0x0225c RW  0x1000
> > > > 
> > > > this load segment is 4k aligned and offset vs addr is not congruent
> > > > modulo 64k, or 32k, so won't work on systems with such page size.
> > > > 
> > > > > >   DYNAMIC        0x07bebc 0x0007cebc 0x0007cebc 0x000c0 0x000c0 RW  0x4
> > > > > >   GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x10
> > > > > >   GNU_RELRO      0x07bd74 0x0007cd74 0x0007cd74 0x0028c 0x0028c R   0x1
> > > > > >
> > > > > >  Section to Segment mapping:
> > > > > >   Segment Sections...
> > > > > >    00     .ARM.exidx
> > > > > >    01     .hash .gnu.hash .dynsym .dynstr .rel.dyn .rel.plt .plt .text
> > > > > > .rodata .ARM.exidx
> > > > > >    02     .data.rel.ro .dynamic .got .data .bss
> > > > > >    03     .dynamic
> > > > > >    04
> > > > > >    05     .data.rel.ro .dynamic .got
> > > > > 
> > > > > 
> > > > > I hope that helps.
> > > > 
> > > > yes, this is a linking issue, not musl libc.
> > > > 
> > > > alpine linux links binaries for 4k pagesize only.
> > > > 
> > > > arm linkers were updated at some point to create binaries supporting
> > > > up to 64k pagesize.  i suspect some ppl ran into issues in practice
> > > > and decided the larger binaries are not worth it, if they dont work
> > > > reliably and forced 4k page size at link time.
> > > > 
> > > > you have to raise an issue with alpine linux, if you think 32k
> > > > oage size is useful and reliably supportable.
> > > 
> > > Are they using -Wl,-z,separate-code? That incurs a large
> > > binary-size-on-disk penalty when supporting oversized pages, and IIRC
> > > something was done to make the linker default to not supporting
> > > oversized pages when that's used. It might be the reason, if arm
> > > linking is normally expected to use a larger max pagesize.
> > 
> > i looked at this now, turns out they just changed the
> > pagesize back to 4k (i missed this change):
> > 
> > https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=1a26a53a0dee39106ba58fcb15496c5f13074652
> 
> This doesn't help immediately, but a major ingredient to fix this
> situation would be getting the kernel to stop doing the wrong thing.
> Right now, it's ignoring the fact that the ELF program header
> constraints are incompatible with mmap given the oversized system
> pagesize, and just incorrectly mapping the executable and trying to
> run it anyway, whereby it blows up.
> 
> The right thing to do would be either to fail with ENOEXEC in this
> case, or when mmap with the required offset constraint fails, falling
> back to making an anonymous map and copying the whole content of the
> loadable segment into that (no COW sharing). The latter is really not
> all that bad for got/data/etc. mappings which you expect will be dirty
> (modified) anyway.
> 
> BTW the former choice (ENOEXEC) would allow doing the latter in
> userspace with a binfmt_misc loader.

Completely untested draft patch showing the concept is attached.

Rich

--5G+Imvfxoe+o1e80
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix_elf_loader_with_oversized_pages.diff"

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f8c7f26f1fbb..45c50f379377 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -861,6 +861,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (!elf_phdata)
 		goto out;
 
+	elf_ppnt = elf_phdata;
+	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
+		if (elf_ppnt->p_type != PT_LOAD) continue;
+		if (ELF_PAGEOFFSET(elf_ppnt->p_vaddr - elf_ppnt->p_offset))
+			goto out;
+	}
 	elf_ppnt = elf_phdata;
 	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
 		char *elf_interpreter;
@@ -962,6 +968,13 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (!interp_elf_phdata)
 			goto out_free_dentry;
 
+		elf_ppnt = interp_elf_phdata;
+		for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
+			if (elf_ppnt->p_type != PT_LOAD) continue;
+			if (ELF_PAGEOFFSET(elf_ppnt->p_vaddr - elf_ppnt->p_offset))
+				goto out_free_dentry;
+		}
+
 		/* Pass PT_LOPROC..PT_HIPROC headers to arch code */
 		elf_property_phdata = NULL;
 		elf_ppnt = interp_elf_phdata;

--5G+Imvfxoe+o1e80--

