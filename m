Return-Path: <linux-fsdevel+bounces-36504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4F59E4A3A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 00:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4828D18804CD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 23:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073A91BA89C;
	Wed,  4 Dec 2024 23:59:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kawka3.in.waw.pl (kawka3.in.waw.pl [68.183.222.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA00E1AF0A1;
	Wed,  4 Dec 2024 23:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.183.222.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733356744; cv=none; b=DIG6mXTPWmu62lzZbVoGiVld2Yx4gpeBHpnc05aj7wZKOBO6LZgIBPnOaVu0f2tl4Weftwnn2y9h8v2TtIzNgGxdnmn+/B5xDlknkUdI3UfvS0KGMtNK7TJ3qIHC1KolHIFWC45djZfX/HQBE/4/utojTd+3QlCjOA+wkOG0Qf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733356744; c=relaxed/simple;
	bh=2cHuMuL3bbquJfw1YnlX4Rf7lFZ8x9rfe9wja96Zj0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMEDQ6Ama+ueisL/vzFDHxiTYMjQUZ6CNZhTA1bbP7w34JD0Db5fRCl5gG/7XZWs/Vok3hUovF4AuwvKDf7vpRSrobZQzfhrbFDbqyRLnBI2MtGL7pu8Xz1mYVFsblDHxnJVHrpzDLWKzaTbyg4lsUO7mU4FJA4+RevWHMGWSpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl; spf=pass smtp.mailfrom=in.waw.pl; arc=none smtp.client-ip=68.183.222.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=in.waw.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in.waw.pl
Received: by kawka3.in.waw.pl (Postfix, from userid 1000)
	id C2F315B99BA; Wed,  4 Dec 2024 23:50:08 +0000 (UTC)
Date: Wed, 4 Dec 2024 23:50:08 +0000
From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Kees Cook <kees@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Tycho Andersen <tandersen@netflix.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exec: fix up /proc/pid/comm in the
 execveat(AT_EMPTY_PATH) case
Message-ID: <Z1DqsDSYxLF85ljc@kawka3.in.waw.pl>
References: <20241130045437.work.390-kees@kernel.org>
 <20241130.055433-shy.herds.gross.wars-zGaSWwzAa56n@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130.055433-shy.herds.gross.wars-zGaSWwzAa56n@cyphar.com>

On Sat, Nov 30, 2024 at 04:55:09PM +1100, Aleksa Sarai wrote:
> On 2024-11-29, Kees Cook <kees@kernel.org> wrote:
> > Zbigniew mentioned at Linux Plumber's that systemd is interested in
> > switching to execveat() for service execution, but can't, because the
> > contents of /proc/pid/comm are the file descriptor which was used,
> > instead of the path to the binary. This makes the output of tools like
> > top and ps useless, especially in a world where most fds are opened
> > CLOEXEC so the number is truly meaningless.
> > 
> > When the filename passed in is empty (e.g. with AT_EMPTY_PATH), use the
> > dentry's filename for "comm" instead of using the useless numeral from
> > the synthetic fdpath construction. This way the actual exec machinery
> > is unchanged, but cosmetically the comm looks reasonable to admins
> > investigating things.
> > 
> > Instead of adding TASK_COMM_LEN more bytes to bprm, use one of the unused
> > flag bits to indicate that we need to set "comm" from the dentry.
> 
> Looks reasonable to me, feel free to take my
> 
> Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

Thank you for making another version of the patch.

I tested this with systemd compiled to use fexecve and everything
seems to work as expected (the filename in /proc//comm).

Zbyszek

