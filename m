Return-Path: <linux-fsdevel+bounces-42338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2403CA40968
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 16:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B3817C846
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 15:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F389C190477;
	Sat, 22 Feb 2025 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTkn4MJG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2C62CCDB;
	Sat, 22 Feb 2025 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740237332; cv=none; b=LC4a36cn1VRWOS0xgRqCgVzvBoxBblHDXv6AWsKSVmM8016eNKFbqP/eSycIX8u9vy2P7K583yC6m7o+bX/YHNluGqByK0fOPWm/J2MxJoAuHGpcsERt6kTkX0XeZ3XIE0CYBMuzgBrEbuGFV8TYQkYJ0ad1L08AywgTJJewt0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740237332; c=relaxed/simple;
	bh=sJrdFo5kUWwYj0rpinJ3eGq+yCAES26qMAIh9ssBxzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWPPr9KFgUkHFmX5rtwquigP5VS+EG1mH37Z3t9n8HBttXDHHuffJpaEYiceionBYpVQQwWruL5bP+JKzYFe8OvafUhnJatu7o3A8TP3iepzmaIOlAVxgbjxYhQjRrOwVqP1zNm6HJqy4ssakk0a+0Kgd9eHRdIIE1c77UZU3k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTkn4MJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FF0C4CED1;
	Sat, 22 Feb 2025 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740237331;
	bh=sJrdFo5kUWwYj0rpinJ3eGq+yCAES26qMAIh9ssBxzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTkn4MJGpYwOtt6j6SRHE/mTp03KEyEK/OjJSG1ziLWqoPWuuej9YtU+Jo+q83r0B
	 5JVumBS6v8Ekwe//m4GrKTf8Jw0riW2vD+pcPi7XSaZpZrv8Ec0hSF2O6wWguDy3wJ
	 RB/5ozFELdkJCUwlduTbpftDKtzlFZ7S5SteC5mCpkto0ONTEwRXkBRr/U1xKNri8z
	 uwhL8QNNv4YAcvuvg1ZMikPPmFV2JFSCyscoU504ARiBA7k78UFse5y63g6xk6HYX8
	 nK0gdUgMr3IuQt+BquKciEROuycR4LVcONBcWBiIJlcqSk2zI3zXCdptO1yYBvGzdj
	 IlKEk6YPSAo3g==
Date: Sat, 22 Feb 2025 07:15:28 -0800
From: Kees Cook <kees@kernel.org>
To: Brian Mak <makb@juniper.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>,
	Michael Stapelberg <michael@stapelberg.ch>,
	Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Message-ID: <202502220712.D7B251910A@keescook>
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
 <20250218085407.61126-1-michael@stapelberg.de>
 <39FC2866-DFF3-43C9-9D40-E8FF30A218BD@juniper.net>
 <a3owf3zywbnntq4h4eytraeb6x7f77lpajszzmsy5d7zumg3tk@utzxmomx6iri>
 <202502191134.CC80931AC9@keescook>
 <CAHk-=wgiwRrrcJ_Nc95jL616z=Xqg4TWYXRWZ1t_GTLnvTWc7w@mail.gmail.com>
 <202502191731.16FBB1EB@keescook>
 <5870D095-D47F-447F-A079-B32D9C415124@juniper.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5870D095-D47F-447F-A079-B32D9C415124@juniper.net>

On Thu, Feb 20, 2025 at 10:59:06PM +0000, Brian Mak wrote:
> One thing we can do though is to iterate through the pages for all VMAs
> and see if get_dump_page() returns NULL. Then, we use that information
> to calculate a more accurate predicted core dump size.
> 
> Patch is below. Thoughts?

I've pushed this to -next for a few days of testing, and if it's all
good, I'll send it to Linus next week for -rc5 (and -stable).

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-linus/execve&id=ff41385709f01519a97379ce7671ee4e91e301e1

-Kees

-- 
Kees Cook

