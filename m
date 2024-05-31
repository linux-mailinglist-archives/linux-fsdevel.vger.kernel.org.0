Return-Path: <linux-fsdevel+bounces-20607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C838D5F2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 12:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9E12857DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 10:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84711465A1;
	Fri, 31 May 2024 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiBN1MwW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EC81422D8
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717149741; cv=none; b=QXGcf8cqnNP7zzCiisCgY0/hUWs9i/EYJRoA7u99SUxBIHaUiKa+0G/4rPMBKpD+iiEz9d++bviZMqAS9zpRxQIZDKDaNH60pwS4xgmPCvfr96XVz4Pn0vM6ot1Fk1G29GD9eoTrMxN2YbYgW4HgnT6hG+i6e4rq7F2RTigjQl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717149741; c=relaxed/simple;
	bh=7uCZGVi0uhWTEBvA/ZPloQh/u/c8TsQf8iJc9auI77U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocbxpU646I/hJvj9q9U4jFmKiY6Elq7Rk1HrwIa8LV5+BRcobLzQTPdk4nmcu/GBUjcOozuaiWw+GKZkJJTx5CTQO2ri4nh1UuvcK30SrZY0P1k0yPnrM5mzZ8ch2934lX55UkbtPiFyGTXFCRrm8QKy136cStRHhRrPH3BdTqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiBN1MwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA64C116B1;
	Fri, 31 May 2024 10:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717149741;
	bh=7uCZGVi0uhWTEBvA/ZPloQh/u/c8TsQf8iJc9auI77U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iiBN1MwWwd6L13iAeqIvmoSGijzDDL4TtwsTa06Y7ws5JFCB0ToNjBjQmuGsDFp1Q
	 oxbpDAdLuK4Js0K4Fs1ah7aiGR/uQG3INZrzFRM68U8ztvGUzZTbx7Wn79yWqhkhfb
	 dFq03f3M2g465FHGgU4c8t1S5tEFcXawhgxzzqvvKHhk9QIRWvRdjlLpJNWwYfKCuh
	 gZPWQzB7N5nWv1ABk8GGCiv+EX/cfMcHJZvg8pWougRzDvt5CUbmuA/Hbj1/R826IS
	 66zjBaSuuFhT+bxVGAIOy0y7KLOM3Ji4JCth2SLsgvMEsDlNzBRdmhW23B/7Nu6t92
	 NMGkzynrcLLUQ==
Date: Fri, 31 May 2024 12:02:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, david@fromorbit.com, amir73il@gmail.com, 
	hch@lst.de
Subject: Re: [PATCH][RFC] fs: add levels to inode write access
Message-ID: <20240531-ausdiskutiert-wortgefecht-f90dca685f8c@brauner>
References: <72fc22ebeaf50fabf9d14f90f6f694f88b5fc359.1717015144.git.josef@toxicpanda.com>
 <20240530-atheismus-festland-c11c1d3b7671@brauner>
 <CAHk-=wg_rw5jNAQ3HUH8FeMvRDFKRGGiyKJ-QCZF7d+EdNenfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg_rw5jNAQ3HUH8FeMvRDFKRGGiyKJ-QCZF7d+EdNenfQ@mail.gmail.com>

On Thu, May 30, 2024 at 08:49:12AM -0700, Linus Torvalds wrote:
> On Thu, 30 May 2024 at 03:32, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Ofc depends on whether Linus still agrees that removing this might be
> > something we could try.
> 
> I _definitely_ do not want to see any more complex deny_write_access().
> 
> So yes, if people have good reasons to override the inode write
> access, I'd rather remove it entirely than make it some eldritch
> horror that is even worse than what we have now.
> 
> It would obviously have to be tested in case some odd case actually
> depends on the ETXTBSY semantics, since we *have* supported it for a
> long time.  But iirc nobody even noticed when we removed it from
> shared libraries, so...
> 
> That said, verity seems to depend on it as a way to do the
> "enable_verity()" atomically with no concurrent writes, and I see some
> i_writecount noise in the integrity code too.
> 
> But maybe that's just a belt-and-suspenders thing?
> 
> Because if execve() no longer does it, I think we should just remove
> that i_writecount thing entirely.

deny_write_access() is being used from kernel_read_file() which has a
few wrappers around it and they are used in various places:

(1) kernel_read_file() based helpers:
  (1.1) kernel_read_file_from_path()
  (1.2) kernel_read_file_from_path_initns()
  (1.3) kernel_read_file_from_fd()

(2) kernel_read_file() users:
    (2.1) kernel/module/main.c:init_module_from_file()
    (2.2) security/loadpin/loadpin.c:read_trusted_verity_root_digests()

(3) kernel_read_file_from_path() users:
    (3.1) security/integrity/digsig.c:integrity_load_x509()
    (3.2) security/integrity/ima/ima_fs.c:ima_read_busy()

(4) kernel_read_file_from_path_initns() users:
    (4.1) drivers/base/firmware_loader/main.c:fw_get_filesystem_firmware()

(5) kernel_read_file_from_fd() users:
    (5.1) kernel/kexec_file.c:kimage_file_prepare_segments()

In order to remove i_writecount completely we would need to do this in
multiple steps as some of that stuff seems potentially sensitive.

The exec deny write mechanism can be removed because we have a decent
understanding of the implications and there's decent justification for
removing it.

So I propose that I do various testing (LTP) etc. now, send the patch
and then put this into -next to see if anything breaks?

