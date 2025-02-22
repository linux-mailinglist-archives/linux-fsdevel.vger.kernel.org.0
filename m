Return-Path: <linux-fsdevel+bounces-42337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41D9A4093A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 15:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B184E17EEEE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 14:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71D5199FA8;
	Sat, 22 Feb 2025 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+Y6vDpu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8FC1386B4;
	Sat, 22 Feb 2025 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740235867; cv=none; b=WNjwIFRLbhL96gYkJa0/t/n7sMkSb34bEOtcmaWs3+2On1d0eQczFeHi9CBygqCssRQXFi3tQinKZdcjAr5VHqueiKzOvzgl/LuTpcAxf+arZEcRS+M6BjN99X53QDHfgublXJL5vZZgDNKO06oyYsE+HGr7W2YE9lb8izv1+/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740235867; c=relaxed/simple;
	bh=gBxM8tvdfd2PMBLv7RTxItVJfVROKTcaFuwa68QoYUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayEiVbM/FxrG6nxKanhE49eZVFhHLsrnZg8T2lbCCkjlLwXdtTpBpX2yyNgObwJmwq+pbgQ3zb3w3RSjKBURs3DYElmGeevsfFRw5eo6geUyZCYhV2XetbAum4aqBxYMf8knp1adX+dFd0Wwx8+upqcXPhe1D1uBqtjs6tAv6uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+Y6vDpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94563C4CED1;
	Sat, 22 Feb 2025 14:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740235866;
	bh=gBxM8tvdfd2PMBLv7RTxItVJfVROKTcaFuwa68QoYUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D+Y6vDpupTWoBky9TbcnGqpd1BFqsqxaFaPUT4ZLMBR326vrKF5hqeKx6p3nncKjS
	 4DGOd1oU9IUXPq1eibU+/G3Y8YhvN27bHwhV7/scSLbBTPhHHx8peSlLD/yra3NL6f
	 Z2/b44zGOLA/bVi4MtAPheZxsxgF6yNAK9ntam/VE2nwsJ9XbHub3dpQKiRMW/qXI7
	 SCa3Vpn+kSq/M9QKaXC6ekT3CZgV15k3vCUxO50LIsN//bJvqrJLwEB1Qc5VzJfkYj
	 d92PVci5XVX05UqaGPeeVC13LglHPJKARKRhhsDwI+ag4eXEm9h02fNmYEKRmEFT7K
	 qZsw6q/60AyTw==
Date: Sat, 22 Feb 2025 06:51:02 -0800
From: Kees Cook <kees@kernel.org>
To: Brian Mak <makb@juniper.net>
Cc: Jan Kara <jack@suse.cz>, Michael Stapelberg <michael@stapelberg.ch>,
	Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Message-ID: <202502220647.861603A725@keescook>
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
 <20250218085407.61126-1-michael@stapelberg.de>
 <39FC2866-DFF3-43C9-9D40-E8FF30A218BD@juniper.net>
 <a3owf3zywbnntq4h4eytraeb6x7f77lpajszzmsy5d7zumg3tk@utzxmomx6iri>
 <202502191134.CC80931AC9@keescook>
 <F859FAC0-294F-4FA7-BAA1-6EBC373F035A@juniper.net>
 <F9EA3BEC-4E23-4DBB-8CBC-08EEBB39D28F@juniper.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F9EA3BEC-4E23-4DBB-8CBC-08EEBB39D28F@juniper.net>

On Sat, Feb 22, 2025 at 02:13:06AM +0000, Brian Mak wrote:
> On Feb 19, 2025, at 12:38 PM, Brian Mak <makb@juniper.net> wrote
> 
> > I will also scratch up a patch to bring us back into compliance with the
> > ELF specifications, and see if that fixes the userspace breakage with
> > elfutils, while not breaking gdb or rr.
> 
> I did scratch up something for this to fix up the program header
> ordering, but it seems eu-stack is still broken, even with the fix. GDB
> continues to work fine with the fix.

Okay, thanks for testing this!

> Given that there's no known utilities that get fixed as a result of the
> program header sorting, I'm not sure if it's worth taking the patch.
> Maybe we can just proceed with the sysctl + sorting if the core dump
> size limit is hit, and leave it at that. Thoughts?

Yeah, I like that this will automatically kick on under the condition
where the coredump will already be unreadable by some tools. And having
the sysctl means it can be enabled for testing, etc.

-Kees

-- 
Kees Cook

