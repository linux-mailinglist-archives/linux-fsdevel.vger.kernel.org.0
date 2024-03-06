Return-Path: <linux-fsdevel+bounces-13735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B75A0873447
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 11:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82DA1C212F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519D0605A4;
	Wed,  6 Mar 2024 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpmesp3C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB35D8E5;
	Wed,  6 Mar 2024 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721119; cv=none; b=DL9LJcMA3lrKDJJhzJ0UIzrT/GZcsgGnTLBTq1aIJXo1u8GqwHINMyJruWmL3OOlvepTfzNUkqB+WQaGUFsym5KbwpAPKjYmChlKFhiikZEI/o7/9YNe3xekQNY7PByiMwEIjgRSoO/Nvg3QXQVLxW3aKJI4p+uZPxFpi79K03M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721119; c=relaxed/simple;
	bh=V9dupUdmdDT6oqMU+vmjgEz0vS/DRI+SFGdX0PtriQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loFToO6NXIfuxGBAkl+JOpq419XkiKQo/NAGC5FASkzqIE7JgWJN6IovV3/5wjJxfROpEQdefppWhflJUCDD3xJyUJ6EHJkvTnccyLPcHELHoJpSt55RCeE5sDaCdye519auo3rBsjEA5vx0NElllrpc8MMSfYJfLToq+cFq+Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpmesp3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC6AC433C7;
	Wed,  6 Mar 2024 10:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709721119;
	bh=V9dupUdmdDT6oqMU+vmjgEz0vS/DRI+SFGdX0PtriQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bpmesp3Cf3UOtm/WOXArUNMhwaWIE02nRlh4xtXs3Lh+cjLxTwDyVb9a7EvRli1OH
	 V3yOaOwtcial4MmChZfRxrsm5JPUEFQq6KidAXXVD09QgVJ8RxrvaMAYAVfdx4VkrH
	 01uPTpsgVgwNB3vv3U4JgFPhbAfJ4UgBVO93iaCx3vdYAmvjAKcX4IKOBno+pfFc3a
	 MlI41Sof4sfd5ivtkmsxMdrD02aBRPp7ctv6JnaTC/ItG8SYJaaLIiTmUFJ2W0VQVE
	 SapT+bLxNol8QCCptrm5K0aM4EzjhsOUcDw0rsD+19VyhhKgHSb/2a9uRbqDmlS0JO
	 /figxLtEqJODQ==
Date: Wed, 6 Mar 2024 11:31:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, 
	linux-fsdevel@vger.kernel.org, kernel@collabora.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, 
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH v2] proc: allow restricting /proc/pid/mem writes
Message-ID: <20240306-titan-gerade-6e3bbb057213@brauner>
References: <20240301213442.198443-1-adrian.ratiu@collabora.com>
 <20240304-zugute-abtragen-d499556390b3@brauner>
 <202403040943.9545EBE5@keescook>
 <20240305-attentat-robust-b0da8137b7df@brauner>
 <202403050134.784D787337@keescook>
 <20240305-kontakt-ticken-77fc8f02be1d@brauner>
 <202403050211.86A44769@keescook>
 <20240305-brotkrumen-vorbild-9709ce924d25@brauner>
 <202403051033.9527DD75@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202403051033.9527DD75@keescook>

On Tue, Mar 05, 2024 at 10:37:20AM -0800, Kees Cook wrote:
> On Tue, Mar 05, 2024 at 11:32:04AM +0100, Christian Brauner wrote:
> > On Tue, Mar 05, 2024 at 02:12:26AM -0800, Kees Cook wrote:
> > > On Tue, Mar 05, 2024 at 10:58:25AM +0100, Christian Brauner wrote:
> > > > Since the write handler for /proc/<pid>/mem does raise FOLL_FORCE
> > > > unconditionally it likely would implicitly. But I'm not familiar enough
> > > > with FOLL_FORCE to say for sure.
> > > 
> > > I should phrase the question better. :) Is the supervisor writing into
> > > read-only regions of the child process?
> > 
> > Hm... I suspect we don't. Let's take two concrete examples so you can
> > tell me.
> > 
> > Incus intercepts the sysinfo() syscall. It prepares a struct sysinfo
> > with cgroup aware values for the supervised process and then does:
> > 
> > unix.Pwrite(siov.memFd, &sysinfo, sizeof(struct sysinfo), seccomp_data.args[0]))
> > 
> > It also intercepts some bpf system calls attaching bpf programs for the
> > caller. If that fails we update the log buffer for the supervised
> > process:
> > 
> > union bpf_attr attr = {}, new_attr = {};
> > 
> > // read struct bpf_attr from mem_fd
> > ret = pread(mem_fd, &attr, attr_len, req->data.args[1]);
> > if (ret < 0)
> >         return -errno;
> > 
> > // Do stuff with attr. Stuff fails. Update log buffer for supervised process:
> > if ((new_attr.log_size) > 0 && (pwrite(mem_fd, new_attr.log_buf, new_attr.log_size, attr.log_buf) != new_attr.log_size))
> 
> This is almost certainly in writable memory (either stack or .data).
> 
> > But I'm not sure if there are other use-cases that would require this.
> 
> Maybe this option needs to be per-process (like no_new_privs), and with
> a few access levels:
> 
> - as things are now
> - no FOLL_FORCE unless by ptracer
> - no writes unless by ptracer
> - no FOLL_FORCE ever
> - no writes ever
> - no reads unless by ptracer
> - no reads ever

Doing it as a prctl() would be fine.

