Return-Path: <linux-fsdevel+bounces-58340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 615C0B2CE5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 23:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18ED81C25F5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 21:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150DE3115A7;
	Tue, 19 Aug 2025 21:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zdm/h0tQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3A03101AA
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755637770; cv=none; b=oUbxVqO39VuvvVO53dBrZFpXb355voh8tj+8ORlZeSopwtd8gw0/quswQYYMl1CGyAyJHhGVXMTl2EOxCEOFS9U9h+rF6wIGob1nG9ZHqr6qpghnA2lpoBpHTTLz6PE/RM5Zj3W1G6JgQO52Nex0XWGwSgbLh60Fr4FnA6ni43g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755637770; c=relaxed/simple;
	bh=3rZ+q5cLLXRErhPZiHmBNpCHlthNKNGRrQui7ZOooqA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=V8ODm+OTi05gHqQ25zfghYFu4D1fJysz8jDV1SncE8qlLCkXNKcSqDbvCkn424T2MiJo4ar39mcOOqKWNzLSCx5SYHVRMz0lTz03qpxSAw7CZe98n9BXai8tZWYy95rC+HEv3HElAJzFhchvyGZ+KMqu20Ex9ew5lMTqKEjCxuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Zdm/h0tQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BDEC4CEF1;
	Tue, 19 Aug 2025 21:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755637770;
	bh=3rZ+q5cLLXRErhPZiHmBNpCHlthNKNGRrQui7ZOooqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zdm/h0tQw3tDGJz2xzMaBzEMqhwaPTfScir6hr1+bROc4ESAiukI/A77b657YWS8c
	 9hMpdX3k6jJIbNBUuKeeQHQksX80lTZxxaMLrGcaUYh5dlf/7mIumt7/LKTThZfOr/
	 UQXTQaIPY27/dju57NOyjC8uIjHinaChpjCKRCjk=
Date: Tue, 19 Aug 2025 14:09:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: test lseek on /proc/net/dev
Message-Id: <20250819140929.e408f2645f01e74e16c34796@linux-foundation.org>
In-Reply-To: <aKTCfMuRXOpjBXxI@p183>
References: <aKTCfMuRXOpjBXxI@p183>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 21:29:16 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> This line in tools/testing/selftests/proc/read.c was added to catch
> oopses, not to verify lseek correctness:
> 
>         (void)lseek(fd, 0, SEEK_SET);

Can you expand on this?  Was some issue discovered with /proc/net/dev? 
If so, what was it?

> Oh, well. Prevent more embarassement with simple test.

