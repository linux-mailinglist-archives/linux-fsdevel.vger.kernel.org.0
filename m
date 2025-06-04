Return-Path: <linux-fsdevel+bounces-50674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5CFACE5A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 22:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3BCA189B8F6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 20:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFC2231A37;
	Wed,  4 Jun 2025 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cnuCQFnH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822351940A1;
	Wed,  4 Jun 2025 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749067885; cv=none; b=Z4U/MENFc/fAv3rSJktgzIemWA2EU8CTsAswDtGU+xd2nvH6+nPfIbCG+eZJekLnG5k01weif0QGA8to2SPqPSm+j4/YojK/6SpEQGVM/kNsylp4/bdQxsK/1ab/b7JS9rFc5Z9Jm07/kTTHfhx5SqkovVbXrG56Ay6SGU6cm6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749067885; c=relaxed/simple;
	bh=GB3QGY/bYwuT0G9fFt7gKi7UU4WWertHJDQO/gjWrWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzMeabZplScz/PieV0FXO1D7D1iYV0eqZXvn3/OsqjBXKeBdt1xEomFRmsgV0YuRnyRfoktkCAKkX9cBs6mZk1HVXS0ubiQ49mt5ANI1Y+9KKq9Bi/0TEPPEVViOLX532Bvx+RukPOO5Maxb/Hux/LLMoQ6HLCcRu/AxV+m4Dlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cnuCQFnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB100C4CEE4;
	Wed,  4 Jun 2025 20:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749067884;
	bh=GB3QGY/bYwuT0G9fFt7gKi7UU4WWertHJDQO/gjWrWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cnuCQFnHQog3Yy2zL0mN9Rm6DYshRfpgEz5hEYSEW8/NTlSE6fqjcluypojM9jXTv
	 MqLJ5baQLpwuXlvQlIa/2AN00aoarL0X8nZ/vTOv6BjlpWEkQH9v8UXnyKKJFb3gtS
	 CEPq+2hBMvXityes9yvxlLeyVC5AwHZoM4OQgHxA=
Date: Wed, 4 Jun 2025 16:11:21 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luka <luka.2016.cs@gmail.com>
Subject: Re: [Bug] possible deadlock in vfs_rmdir in Linux kernel v6.12
Message-ID: <20250604-daft-nondescript-junglefowl-0abd5a@lemur>
References: <CALm_T+2FtCDm4R5y-7mGyrY71Ex9G_9guaHCkELyggVfUbs1=w@mail.gmail.com>
 <CALm_T+0j2FUr-tY5nvBqB6nvt=Dc8GBVfwzwchtrqOCoKw3rkQ@mail.gmail.com>
 <CALm_T+3H5axrkgFdpAt23mkUyEbOaPyehAbdXbhgwutpyfMB7w@mail.gmail.com>
 <20250604-quark-gastprofessor-9ac119a48aa1@brauner>
 <20250604-alluring-resourceful-salamander-6561ff@lemur>
 <bfyuxaa7cantq2fvrgizsawyclaciifxub3lortq5oox44vlsd@rxwrvg2avew7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfyuxaa7cantq2fvrgizsawyclaciifxub3lortq5oox44vlsd@rxwrvg2avew7>

On Wed, Jun 04, 2025 at 05:44:22PM +0200, Jan Kara wrote:
> > Malicious in what sense? Is it just junk, or is it attempting to have
> > maintainers perform some potentially dangerous operation?
> 
> Well, useless it is for certain but links like:
> 
> Bug Report: https://hastebin.com/share/pihohaniwi.bash
> 
> Entire Log: https://hastebin.com/share/orufevoquj.perl
> 
> are rather suspicious and suggest there's more in there than just a lack of
> knowledge (but now that I've tried the suffixes seem to be automatically
> added by some filetype detection logic in the hastebin.com site itself so
> more likely this is not malicious after all). FWIW I've downloaded one of
> the files through wget and looked into it and it seems to have a reasonable
> content and does not seem malicious but it is difficult to be sure in the
> maze of HTML and JS...

Yes, hence my question. I think it's just a bad medium. It's actually the kind
of thing that bugzilla is okay to use for -- create a bug with attachments and
report it to the list, so maybe the original author can use that instead of
pastebin sites?

-K

