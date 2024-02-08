Return-Path: <linux-fsdevel+bounces-10760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D23984DD15
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 10:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11569B23E33
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 09:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F5C6BFA6;
	Thu,  8 Feb 2024 09:37:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE8967C72;
	Thu,  8 Feb 2024 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707385028; cv=none; b=vET6TQPznBm4Wv+yrNOYH/6AUnbiqKkQQBHoSWg2wxnSyIgEM8tgIHY0ppkHtgj3F1IRWwnRFkqmYHDfQebSVpo+ohFAUxQO4nvgceBu6A67H3g3M0bXRKRe57tFFsXf4II7lbi7mQbXt3nZPwGiOlBTE/FLGosDL2Ufot/8oQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707385028; c=relaxed/simple;
	bh=Baq8xnvrDhL72IbU782BS9bRzNoGy/UvAQL6CzgdUlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPeuO3+WkPMbp6B4AXeybqRz3QXJal2+egIx5Af3jJ0c0GoVboUkUGcfTmGI3LvfGexxSYGOjZTI9n/0FTDg4u4PP82/dUKnkLcFhMNhLe22mEGWgT99p9R9mpj5wBEgWaQg9EMGgg64mz6i1qNZW6MICc2OdCdjzctI1biCoMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9B0C433C7;
	Thu,  8 Feb 2024 09:37:02 +0000 (UTC)
Date: Thu, 8 Feb 2024 04:36:59 -0500
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
Message-ID: <20240208043659.7476b3a1@rorschach.local.home>
In-Reply-To: <497fdb48-9fce-444e-8d51-2073a37f697d@joelfernandes.org>
References: <20240206094650.1696566-1-quic_hyiwei@quicinc.com>
	<50cdbe95-c14c-49db-86aa-458e87ae9513@joelfernandes.org>
	<20240207061429.3e29afc8@rorschach.local.home>
	<CAEXW_YSUD-CW_=BHbfrfPZAfRUtk_hys5r06uJP2TJJeYJb-1g@mail.gmail.com>
	<ec99fdee-8d3f-476f-842f-f57b2b817dae@quicinc.com>
	<497fdb48-9fce-444e-8d51-2073a37f697d@joelfernandes.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Feb 2024 04:26:30 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> > And for this patchset, shall I fix the typo and resend again? Thanks.  
> 
> That is fine with me but it is up to tracing maintainers. ;-)

The rest of the patch looks good to me. Please send a v5 with the typo
fix and I'll try to get it into the next merge window.

Thanks,

-- Steve

