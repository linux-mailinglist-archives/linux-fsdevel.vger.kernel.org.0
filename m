Return-Path: <linux-fsdevel+bounces-13604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E92871BEF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 11:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8CB1F250B5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 10:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22784369A;
	Tue,  5 Mar 2024 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4qmZ1kr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB535733D;
	Tue,  5 Mar 2024 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634731; cv=none; b=jzVmgHqvdYBWOWG7JErV5MuTjGX/mpJtEEDQ7L16GJ2Ol+aW1eJd/NkTSzeuLUosAfVGGZjY6G+PR94mgEd8T72iUGs0gKQffPmTN91No1cY48p/SdnjKjD7FENBPC+/IbEHptaDiy6qTv9gwwLrsBngFin7LpxvWz3nRu42Wb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634731; c=relaxed/simple;
	bh=bT/P5l+f4khig/abXkPdAzw4QrPxZvOmunHaLy7aIfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GL4QPYCe4C+qc1YGJJO9fuDclC0lXpYSJr4p4lGy64bwhksnkMCwMf89YChJN9L45Lkiiw4JUh8hMPPXg3HRzh29TQ4MIjscfjd6uoEOkBr90rMtK1NufiDXjctc26M6k7I4zB962bjXGi2Rdu1WDB8nke0jQ+atVOxcIB42yng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4qmZ1kr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AB8C433F1;
	Tue,  5 Mar 2024 10:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709634729;
	bh=bT/P5l+f4khig/abXkPdAzw4QrPxZvOmunHaLy7aIfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o4qmZ1kry8QF5u2cGGcJHGekJvO4LVp9gJLHiDMyZeKrrsHxru9kyszflA3PBqstS
	 4g5BFDTk6xNNSSFDeYhH1sbYNg2SQgmN1RLWNNQ13/rGp1+Ga8wJ7K4/CrnjR4+Pkf
	 HNlvApkNpiVxttOI+rZyV6s+131ljOWIaZpAtFHM2vk11vhhH4YE7CMqOvSlSTLk13
	 bVw9CzxuvfyNZ/tTCsrARaNWO6RUOa7eQiENZ0CrdeZLImqb6QLgSY32bo8Gfv1ToT
	 OwY3LokMeSo7FuwmGXDz2jYrOEfYXdwnLZ4Ea/5/V8N5xilm+ijVC1wJL0PIHbLUmx
	 wZS029d7LJcgA==
Date: Tue, 5 Mar 2024 11:32:04 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, 
	linux-fsdevel@vger.kernel.org, kernel@collabora.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, 
	Doug Anderson <dianders@chromium.org>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Mike Frysinger <vapier@chromium.org>
Subject: Re: [PATCH v2] proc: allow restricting /proc/pid/mem writes
Message-ID: <20240305-brotkrumen-vorbild-9709ce924d25@brauner>
References: <20240301213442.198443-1-adrian.ratiu@collabora.com>
 <20240304-zugute-abtragen-d499556390b3@brauner>
 <202403040943.9545EBE5@keescook>
 <20240305-attentat-robust-b0da8137b7df@brauner>
 <202403050134.784D787337@keescook>
 <20240305-kontakt-ticken-77fc8f02be1d@brauner>
 <202403050211.86A44769@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202403050211.86A44769@keescook>

On Tue, Mar 05, 2024 at 02:12:26AM -0800, Kees Cook wrote:
> On Tue, Mar 05, 2024 at 10:58:25AM +0100, Christian Brauner wrote:
> > Since the write handler for /proc/<pid>/mem does raise FOLL_FORCE
> > unconditionally it likely would implicitly. But I'm not familiar enough
> > with FOLL_FORCE to say for sure.
> 
> I should phrase the question better. :) Is the supervisor writing into
> read-only regions of the child process?

Hm... I suspect we don't. Let's take two concrete examples so you can
tell me.

Incus intercepts the sysinfo() syscall. It prepares a struct sysinfo
with cgroup aware values for the supervised process and then does:

unix.Pwrite(siov.memFd, &sysinfo, sizeof(struct sysinfo), seccomp_data.args[0]))

It also intercepts some bpf system calls attaching bpf programs for the
caller. If that fails we update the log buffer for the supervised
process:

union bpf_attr attr = {}, new_attr = {};

// read struct bpf_attr from mem_fd
ret = pread(mem_fd, &attr, attr_len, req->data.args[1]);
if (ret < 0)
        return -errno;

// Do stuff with attr. Stuff fails. Update log buffer for supervised process:
if ((new_attr.log_size) > 0 && (pwrite(mem_fd, new_attr.log_buf, new_attr.log_size, attr.log_buf) != new_attr.log_size))

But I'm not sure if there are other use-cases that would require this.

