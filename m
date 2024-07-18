Return-Path: <linux-fsdevel+bounces-23950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B2C935154
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 19:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C3C1F2243B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 17:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AED414535D;
	Thu, 18 Jul 2024 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj3znlN3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF79063A;
	Thu, 18 Jul 2024 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721324769; cv=none; b=cfZ6t0EcBdwlxFbbT0Qm7ptAmvro7Fkc+6n7ZaaoeWWI0QPJiXbR/Xfhg/VfPicTYjbdoDu4jhczprnZRONjCWPz5RSzW4VZHTNsH641aZAidwV3sFAHGZJ2UWY4F9vUpewCODCUEvVgJ2cdPiFfOpCv6FUeIp+z7thpU6d+0zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721324769; c=relaxed/simple;
	bh=FZDUnmMzTHtLAXj0DJWdawnws+McoB3ISL8JL9ZoqBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qM27iiwuFL6eOh4Ppp77dx9kThvTtHW7cOPhb1CoWsT77V8PcNbzYLaITDTwZC9sVpTfN6OMkByUGZQECfsyWSRlnby0j8WVl9HLPPQaO9cJ7aOHmA+GecW7s1UCpXTBLNYIujv0W7R/9wWWeyC8Xtbn5hYYJWq4EpQzKc5A9YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nj3znlN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE0DC116B1;
	Thu, 18 Jul 2024 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721324768;
	bh=FZDUnmMzTHtLAXj0DJWdawnws+McoB3ISL8JL9ZoqBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nj3znlN3AMkMwF5rQdgZV+lF2XeAWxMV018XmeSJrCra/irgx1ml+Ts4wL5XHFGDn
	 IZh75axRhZ4XO6r2EZ01HBw3E/RtbbPg//PY+ffUvFRO+9k5nNT9qxsslUst13h7TL
	 GmP8K8LH1nvt6u/Lu9zly1GlcC3zTczZ5TGX1mzqjStBvM8EsD1CUjLXM2EkIu0WSp
	 p24PS0vIPCjL9cUeyWvwiBYToHOD/Tp/XnKFpLuSHvSrFvsEK8jnTYwToZlJ956nlx
	 ZvDOSyDkG6jG4nE9B+pAPwZMm4Oluk9q8a7KadRnGtFIBm5IltlobcQxQTOf3jtr4T
	 LGX0zyysQAIqg==
From: SeongJae Park <sj@kernel.org>
To: David Gow <davidgow@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] execve: Move KUnit tests to tests/ subdirectory
Date: Thu, 18 Jul 2024 10:46:01 -0700
Message-Id: <20240718174601.64851-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CABVgOSmKwPq7JEpHfS6sbOwsR0B-DBDk_JP-ZD9s9ZizvpUjbQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 18 Jul 2024 14:04:14 +0800 David Gow <davidgow@google.com> wrote:

> On Thu, 18 Jul 2024 at 05:22, Kees Cook <kees@kernel.org> wrote:
> >
> > Move the exec KUnit tests into a separate directory to avoid polluting
> > the local directory namespace. Additionally update MAINTAINERS for the
> > new files and mark myself as Maintainer.
> >
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > I'll toss this into -next and send it to Linus before -rc1 closes.
> > ---
> 
> With s/_test/_kunit (once the docs changes are sorted), this looks good.

I have no strong opinion, but I agree to David's rationale [1] on preferrence
of _kunit overall, and would prefer having a consistent and simple rule.

[1] https://lore.kernel.org/CABVgOS=B29PcKyhVXtTk47k_BhjSaoxL8eF15fVhzty_0syeSQ@mail.gmail.com

> 
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

