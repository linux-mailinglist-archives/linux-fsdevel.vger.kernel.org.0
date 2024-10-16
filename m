Return-Path: <linux-fsdevel+bounces-32122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D433A9A0D46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 16:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581B01F24008
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 14:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0861620E003;
	Wed, 16 Oct 2024 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ne/K0iNO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6083020ADEA;
	Wed, 16 Oct 2024 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090304; cv=none; b=rLEyHGnalnMPJ4Rxkl/6e+DwXh6NfQqv96NEbcHfLP+bF9CGIz9Ipc9xa3k9dhMt3WSq08V3s2IX1BT95l+rxKpZi1wI/9Z4QIshVL6WPiqoEg7zdtjkZ9o55X8Fdfalry4R9+U09FSdi+5wUV63fIu1an9Y004ksdIHViQvn94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090304; c=relaxed/simple;
	bh=bUJhhQ8g376NHKbQ6j9vlx1OTk2JcxGmdHodaX8yHcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFoFAFDrRLgAWJJJOkF6VkZLQh7QQQvA0QV8hHLsXCjjzEGrCFQlz85L3VwuMeUf0kdYZMZINiZJEvuLq/6Q41x1JSJIveY2xrQpFcvtpGwVADdhRdMsEyxCQnHQ0CJFBwS97qOMD4Rt2kdGePUwpOeXqaafoclfvFhUQGcLuws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ne/K0iNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D38FC4CEC5;
	Wed, 16 Oct 2024 14:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729090304;
	bh=bUJhhQ8g376NHKbQ6j9vlx1OTk2JcxGmdHodaX8yHcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ne/K0iNOJ5pP7VzyBUN9yTYkxawvs0hYx8fsjY0aMEY+GJg1moxPZL+EmcAVp+2Yr
	 KW5pPQtcNhwIy2MSK6Y8B5GGbcJFJpjjp88J6t3vgPtwPv12prtthKuQpZHsHEH8LU
	 CzBNUpslMZ2aF2MmZit/BZuwTM/t4zzy/rQVoB3ieu3jO5y1V8sg0284OnAyzUG1UZ
	 LdntCHimIjojMlHlT2FiEKPjLXbsKz9PpKzqils72ViCZdW8TBAx9iCOkvEamI5v5v
	 A1uN1xR0NWC+qiFvNCq79+DfX82hLRfSyYXZVWTngadRA/7aH4GiyIgbrFFpqr56vJ
	 kdxWeFx9wb9QQ==
Date: Wed, 16 Oct 2024 16:51:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Song Liu <songliubraving@meta.com>, 
	Christoph Hellwig <hch@infradead.org>, Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Al Viro <viro@zeniv.linux.org.uk>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Message-ID: <20241016-luxus-winkt-4676cfdf25ff@brauner>
References: <20241002214637.3625277-1-song@kernel.org>
 <20241002214637.3625277-3-song@kernel.org>
 <Zw34dAaqA5tR6mHN@infradead.org>
 <0DB83868-0049-40E3-8E62-0D8D913CB9CB@fb.com>
 <Zw384bed3yVgZpoc@infradead.org>
 <BF0CD913-B067-4105-88C2-B068431EE9E5@fb.com>
 <20241016135155.otibqwcyqczxt26f@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241016135155.otibqwcyqczxt26f@quack3>

On Wed, Oct 16, 2024 at 03:51:55PM +0200, Jan Kara wrote:
> On Tue 15-10-24 05:52:02, Song Liu wrote:
> > > On Oct 14, 2024, at 10:25 PM, Christoph Hellwig <hch@infradead.org> wrote:
> > > On Tue, Oct 15, 2024 at 05:21:48AM +0000, Song Liu wrote:
> > >>>> Extend test_progs fs_kfuncs to cover different xattr names. Specifically:
> > >>>> xattr name "user.kfuncs", "security.bpf", and "security.bpf.xxx" can be
> > >>>> read from BPF program with kfuncs bpf_get_[file|dentry]_xattr(); while
> > >>>> "security.bpfxxx" and "security.selinux" cannot be read.
> > >>> 
> > >>> So you read code from untrusted user.* xattrs?  How can you carve out
> > >>> that space and not known any pre-existing userspace cod uses kfuncs
> > >>> for it's own purpose?
> > >> 
> > >> I don't quite follow the comment here. 
> > >> 
> > >> Do you mean user.* xattrs are untrusted (any user can set it), so we 
> > >> should not allow BPF programs to read them? Or do you mean xattr 
> > >> name "user.kfuncs" might be taken by some use space?
> > > 
> > > All of the above.
> > 
> > This is a selftest, "user.kfunc" is picked for this test. The kfuncs
> > (bpf_get_[file|dentry]_xattr) can read any user.* xattrs. 
> > 
> > Reading untrusted xattrs from trust BPF LSM program can be useful. 
> > For example, we can sign a binary with private key, and save the
> > signature in the xattr. Then the kernel can verify the signature
> > and the binary matches the public key. If the xattr is modified by
> > untrusted user space, the BPF program will just deny the access. 
> 
> So I tend to agree with Christoph that e.g. for the above LSM usecase you
> mention, using user. xattr space is a poor design choice because you have
> to very carefully validate any xattr contents (anybody can provide
> malicious content) and more importantly as different similar usecases
> proliferate the chances of name collisions and resulting funcionality
> issues increase. It is similar as if you decided to store some information
> in a specially named file in each directory. If you choose special enough
> name, it will likely work but long-term someone is going to break you :)
> 
> I think that getting user.* xattrs from bpf hooks can still be useful for
> introspection and other tasks so I'm not convinced we should revert that
> functionality but maybe it is too easy to misuse? I'm not really decided.

Reading user.* xattr is fine. If an LSM decides to built a security
model around it then imho that's their business and since that happens
in out-of-tree LSM programs: shrug.

