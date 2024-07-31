Return-Path: <linux-fsdevel+bounces-24647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3315942405
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 03:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48DD828633A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 01:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4239CD2F5;
	Wed, 31 Jul 2024 00:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yOaRG6xQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E68C8BEA;
	Wed, 31 Jul 2024 00:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722387584; cv=none; b=teNlGGkw+JMhvQf9I+yWXzw9VhKHqWf2sOmtSG8bszWmYG2kvOCxyQ+zjAGTS0kiztiilNYxu492EjepRgdT0fosZcxQFN121m5gufeucg+vV02aoLVtkUvRoQotZhNU0QwukDHFwGNL5SZJ8SBvTXw8gnNUVHjzuuwhDkXkzKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722387584; c=relaxed/simple;
	bh=i55BjG4Az1uMgUYMNpiUqocgXqxkBYbCX/reUu941+c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=asl+Z1mQ0m/GrcMrg7qAqh+GyZz4dUr/YyxxJbVFsuL9Wad1rfrv6+gfcX9/hGOj+4GYrZHI0ga6XpHYDUG8ig6noTxWJlDg8chMD6q1oDBY1VmUUUsfPMpA4nRrW6SiHn5Z+oT+FoUeXs58Hk+PGoHXQ6MW1B06z2HEw7Co/Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yOaRG6xQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C1AC32782;
	Wed, 31 Jul 2024 00:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722387583;
	bh=i55BjG4Az1uMgUYMNpiUqocgXqxkBYbCX/reUu941+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yOaRG6xQyEFQANhk5kmfHuS8MU5QddMfdLCoZb7Fn3Dn1jftyjHTx1ybi8jCeft8n
	 6h764jvhO3CQ0c5o+TVnmS20iygHQc9sgKpPD36OTPvk2zso5q2it+qi/r+Kaaa/QE
	 ytAyGSH7qM171MciKceHCDOOZDW+rPYccVVdYelg=
Date: Tue, 30 Jul 2024 17:59:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, ebiederm@xmission.com,
 alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com,
 penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 audit@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH resend v4 00/11] Improve the copy of task comm
Message-Id: <20240730175927.673754c361a70351ad8a3ff9@linux-foundation.org>
In-Reply-To: <20240729023719.1933-1-laoar.shao@gmail.com>
References: <20240729023719.1933-1-laoar.shao@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024 10:37:08 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:

> Is it appropriate for you to apply this to the mm tree?

There are a couple of minor conflicts against current 6.11-rc1 which
you'd best check.  So please redo this against current mainline?

