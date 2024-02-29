Return-Path: <linux-fsdevel+bounces-13192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F2A86CCC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 16:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497C61C2151C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 15:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAE41419BE;
	Thu, 29 Feb 2024 15:23:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C0D137747;
	Thu, 29 Feb 2024 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220214; cv=none; b=CpGXg25+G1iyExjDdszILmI9zu6CUprX853sEjR2NLuWcGWvLycl1tblNgXcee7nC451taPLqxUPAaHclm5XyJaOBVdjeaEo4GEoBlYWC7IlDRZOvJs7bXCgOvKRtcv/mcJO1d2SxqHIpGBle0vQEuN+WZ3+rDlNq6yA/Szedn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220214; c=relaxed/simple;
	bh=k7crVsD5v0qeg9j9DQK+km2c/pv7bSk2LsFkgOUaYeA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLAuyFS3Wf5muPw6hLa1FO/t8oE4M5+EMZ+WROZNb8aHHjyK5Am0eliJLI5DnXH+aBIukpsnK3xbqotm8Rd0jrFqiJNyAmDSJkxw+LJQXtO8BMexPOUAEeWkF/dAV+0YUbPuIAkf4FSGPisV0V34XnELP10iJbjoCbioX5okow0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CB9C433F1;
	Thu, 29 Feb 2024 15:23:31 +0000 (UTC)
Date: Thu, 29 Feb 2024 10:25:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Huang Yiwei <quic_hyiwei@quicinc.com>
Cc: <mhiramat@kernel.org>, <mark.rutland@arm.com>, <mcgrof@kernel.org>,
 <keescook@chromium.org>, <j.granados@samsung.com>,
 <mathieu.desnoyers@efficios.com>, <corbet@lwn.net>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <quic_bjorande@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_satyap@quicinc.com>, <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
 Ross Zwisler <zwisler@google.com>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v5] tracing: Support to dump instance traces by
 ftrace_dump_on_oops
Message-ID: <20240229102537.28d46135@gandalf.local.home>
In-Reply-To: <dbcd66cd-4d59-4246-88ab-db32abbd8e00@quicinc.com>
References: <20240208131814.614691-1-quic_hyiwei@quicinc.com>
	<20240226204757.1a968a10@gandalf.local.home>
	<dbcd66cd-4d59-4246-88ab-db32abbd8e00@quicinc.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 17:11:49 +0800
Huang Yiwei <quic_hyiwei@quicinc.com> wrote:

> > And you can add here as well:
> > 
> >    ftrace_dump_on_oops[=[<0|1|2|orig_cpu>,][<instance_name>[=<1|2|orig_cpu>][,...]]
> > 
> > 
> > Thanks,
> > 
> > --Steve
> >   
> The explanation is below, I think it's correct?
>   - "ftrace_dump_on_oops," means global buffer on all CPUs
>   - "foo," means foo instance on all CPUs
>   - "bar=orig_cpu" means bar instance on CPU that triggered the oops.
> 
> I'm trying to make the example to cover more possibilities.

Ah, I didn't think the command line processing would work with commas. I
guess it does (I just tried it out).

OK, then I guess that's fine.

-- Steve


