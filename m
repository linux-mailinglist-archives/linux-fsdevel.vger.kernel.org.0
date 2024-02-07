Return-Path: <linux-fsdevel+bounces-10597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C783784C94E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 12:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6679A1F2788F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 11:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E635718EB8;
	Wed,  7 Feb 2024 11:14:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802D519470;
	Wed,  7 Feb 2024 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304477; cv=none; b=ci3VkIP4JiR1yPpXu5j9CR2dKQX7L0xcMcmEJnYtlKv0yL+drvEkYU7JWOsS9dKNcvWGlwlNq1c8hH5uHNthGtTWfiLT+uCyDPJVE4lcOkuiyeUH3Vja6ERnX9rgQzWswWDSogF3jRuQcAaehcnsqEDIjd1HPjM/yfycaTP6Tac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304477; c=relaxed/simple;
	bh=9jzCdFGI3TfxRBeaXMxWU6D4GDbQ3HqO5eHHtKZjJ1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rE2wOaALEar3sM+0vPKts389q9keuAYDZ0GASHoEer9zK+hVSXswJYlOg5whgDNdTeMrC7AVWAkBOWOZAeBdPUyoJWb5mhiyQfFJPmCVOUz9XZk9V8U3e/X70b8JsSBIzPpZ9Tx9FgSYKnn0CGYZBSPdWUEF3lvrm0lxz2YpNlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD655C433F1;
	Wed,  7 Feb 2024 11:14:32 +0000 (UTC)
Date: Wed, 7 Feb 2024 06:14:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Huang Yiwei <quic_hyiwei@quicinc.com>, mhiramat@kernel.org,
 mark.rutland@arm.com, mcgrof@kernel.org, keescook@chromium.org,
 j.granados@samsung.com, mathieu.desnoyers@efficios.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 quic_bjorande@quicinc.com, quic_tsoni@quicinc.com, quic_satyap@quicinc.com,
 quic_aiquny@quicinc.com, kernel@quicinc.com, Ross Zwisler
 <zwisler@google.com>
Subject: Re: [PATCH v4] tracing: Support to dump instance traces by
 ftrace_dump_on_oops
Message-ID: <20240207061429.3e29afc8@rorschach.local.home>
In-Reply-To: <50cdbe95-c14c-49db-86aa-458e87ae9513@joelfernandes.org>
References: <20240206094650.1696566-1-quic_hyiwei@quicinc.com>
	<50cdbe95-c14c-49db-86aa-458e87ae9513@joelfernandes.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 05:24:58 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> Btw, hopefully the "trace off on warning" and related boot parameters also apply
> to instances, I haven't personally checked but I often couple those with the
> dump-on-oops ones.

Currently they do not. It would require an updated interface to do so,
as sometimes instances can be used to continue tracing after a warning,
so I don't want to make it for all instances.

Perhaps we need an option for these too, and have all options be
updated via the command line. That way we don't need to make special
boot line parameters for this. If we move these to options (keeping the
proc interface for backward compatibility) it would make most features
available to all with one change.

-- Steve

