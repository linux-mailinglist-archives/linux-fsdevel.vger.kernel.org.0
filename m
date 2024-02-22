Return-Path: <linux-fsdevel+bounces-12454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E8A85F852
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 13:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76005B25DD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC4512DDA5;
	Thu, 22 Feb 2024 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1xO5VRo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E0112C809;
	Thu, 22 Feb 2024 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605416; cv=none; b=slRcGEn7UHLkbtmeLkH6dWWKe7WGl8mNs1FZ/rXCumhO9E/dbllnoZ3u4Tdz/Jd3uTWm9IdG/5dTF/EB7+i7c/aiJPJvSmru6X9OGP0GGMCkejBzp3H4H0uNPu+BDnDi0KQpDXO+aVWppcSrtymC3thYHnT7vXu+rVbdSrlxexM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605416; c=relaxed/simple;
	bh=5JMBWnzvOQc2q9DWqlLSJhqyKMkqobNiRXLfi0gNSkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMZ9+NTEbnWf0I8lhNnaricC745y7og6+dp6b11AVC4wdHxXPHuZ+qQf497jmOEjPWjftuubhkNycUrveDAIOUMaIRrayWRV1tgA1QdGybgVYf/QglMuUnd3OTq+KVF/mbmtsbv0mW+1GoOc2xKmM4peg0NtIE3o72phB6q6Rb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1xO5VRo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8BCC433F1;
	Thu, 22 Feb 2024 12:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708605416;
	bh=5JMBWnzvOQc2q9DWqlLSJhqyKMkqobNiRXLfi0gNSkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D1xO5VRoWXbIbpcnOhY/uLVhsXx/2oRZ2xD235yMjQklY/wimmoooLrtFXjW9Jd2Z
	 4Nj1KxVN1DvLIa1/KLDUWTU+wbSCz1KQ8tj6JDssXczs9h0SpBTrx+KDnzmj78TzPK
	 0B5HvJD/XEpCogvsZ+B+MdxKl9ZrlYE/ljxwDSq0reRjMdhHSTtcFSdPy3LfF4PqlJ
	 Ywlx5zj+OqnDsEhvPpU4WlBXF1IExGnDeQL0nS7vBvAnXO6Wed5aQEoMhaVfghyMV/
	 sODhTLvWPinMcOY35mJfngLaWw4vzUTgQwd63hFrGlFol3IW7K8oYunizs4JzskfHg
	 6m0ipcTYDF3nw==
Date: Thu, 22 Feb 2024 07:36:56 -0500
From: Sasha Levin <sashal@kernel.org>
To: Pavel Machek <pavel@denx.de>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, surenb@google.com,
	michael.christie@oracle.com, mst@redhat.com, mjguzik@gmail.com,
	npiggin@gmail.com, zhangpeng.00@bytedance.com, hca@linux.ibm.com
Subject: Re: [PATCH AUTOSEL 5.10 7/8] exec: Distinguish in_execve from in_exec
Message-ID: <Zdc_6Jx93folkK6B@sashalap>
References: <20240202184156.541981-1-sashal@kernel.org>
 <20240202184156.541981-7-sashal@kernel.org>
 <ZdJWuMifIiNnrLbZ@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZdJWuMifIiNnrLbZ@duo.ucw.cz>

On Sun, Feb 18, 2024 at 08:12:56PM +0100, Pavel Machek wrote:
>Hi!
>
>> From: Kees Cook <keescook@chromium.org>
>>
>> [ Upstream commit 90383cc07895183c75a0db2460301c2ffd912359 ]
>>
>> Just to help distinguish the fs->in_exec flag from the current->in_execve
>> flag, add comments in check_unsafe_exec() and copy_fs() for more
>> context. Also note that in_execve is only used by TOMOYO now.
>
>These are just a whitespace changes, we should not need them.

Dropped, thanks!

-- 
Thanks,
Sasha

