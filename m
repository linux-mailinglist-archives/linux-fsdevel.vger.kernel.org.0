Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304EB4A6824
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 23:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiBAWou (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 17:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiBAWou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:44:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AEFC061714;
        Tue,  1 Feb 2022 14:44:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EC0161348;
        Tue,  1 Feb 2022 22:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1198C340EB;
        Tue,  1 Feb 2022 22:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1643755488;
        bh=dO2ZiNSWR6loVZvexI+PkBxFGJVVZftpKMMgcbecSMU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=an9agKNMXKcOvdlYglAxVxZwJft3R1qKd11ShJ24N53s77YppESIwDKuLEfDGC5Q7
         KZbS3UIRpEMEQucPVSbdSP/BPNzCtDgE928WBXcIi7rsjg7pH7q3R70Weh1AeeDkIx
         2TBHPQOFv3wko+8aPAWdmoYyL9tx2jL8BgxA5NQg=
Date:   Tue, 1 Feb 2022 14:44:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Magnus =?ISO-8859-1?Q?Gro=DF?= <magnus.gross@rwth-aachen.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] elf: Relax assumptions about vaddr ordering
Message-Id: <20220201144448.8b3b322dc58dc3ec71f72246@linux-foundation.org>
In-Reply-To: <202201262230.E16DF58B@keescook>
References: <YfF18Dy85mCntXrx@fractal.localdomain>
        <202201260845.FCBC0B5A06@keescook>
        <202201262230.E16DF58B@keescook>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 26 Jan 2022 22:31:42 -0800 Kees Cook <keescook@chromium.org> wrote:

> On Wed, Jan 26, 2022 at 08:50:15AM -0800, Kees Cook wrote:
> > On Wed, Jan 26, 2022 at 05:25:20PM +0100, Magnus Gro=DF wrote:
> > > From ff4dde97e82727727bda711f2367c05663498b24 Mon Sep 17 00:00:00 2001
> > > From: =3D?UTF-8?q?Magnus=3D20Gro=3DC3=3D9F?=3D <magnus.gross@rwth-aac=
hen.de>
> > > Date: Wed, 26 Jan 2022 16:35:07 +0100
> > > Subject: [PATCH] elf: Relax assumptions about vaddr ordering
> > > MIME-Version: 1.0
> > > Content-Type: text/plain; charset=3DUTF-8
> > > Content-Transfer-Encoding: 8bit
> > >=20
> > > Commit 5f501d555653 ("binfmt_elf: reintroduce using
> > > MAP_FIXED_NOREPLACE") introduced a regression, where the kernel now
> > > assumes that PT_LOAD segments are ordered by vaddr in load_elf_binary=
().
> > >=20
> > > Specifically consider an ELF binary with the following PT_LOAD segmen=
ts:
> > >=20
> > > Type  Offset   VirtAddr   PhysAddr   FileSiz  MemSiz    Flg Align
> > > LOAD  0x000000 0x08000000 0x08000000 0x474585 0x474585  R E 0x1000
> > > LOAD  0x475000 0x08475000 0x08475000 0x090a4  0xc6c10   RW  0x1000
> > > LOAD  0x47f000 0x00010000 0x00010000 0x00000  0x7ff0000     0x1000
> > >=20
> > > Note how the last segment is actually the first segment and vice vers=
a.
> > >=20
> > > Since total_mapping_size() only computes the difference between the
> > > first and the last segment in the order that they appear, it will ret=
urn
> > > a size of 0 in this case, thus causing load_elf_binary() to fail, whi=
ch
> > > did not happen before that change.
> > >=20
> > > Strictly speaking total_mapping_size() made that assumption already
> > > before that patch, but the issue did not appear because the old
> > > load_addr_set guards never allowed this call to total_mapping_size().
> > >=20
> > > Instead of fixing this by reverting to the old load_addr_set logic, we
> > > fix this by comparing the correct first and last segments in
> > > total_mapping_size().
> >=20
> > Ah, nice. Yeah, this is good.
> >=20
> > > Signed-off-by: Magnus Gro=DF <magnus.gross@rwth-aachen.de>
> >=20
> > Fixes: 5f501d555653 ("binfmt_elf: reintroduce using MAP_FIXED_NOREPLACE=
")
> > Cc: stable@vger.kernel.org
> > Acked-by: Kees Cook <keescook@chromium.org>
>=20
> Andrew, can you pick this up too?
>=20

It conflicts significantly with Alexey's "ELF: fix overflow in total
mapping size calculation".

