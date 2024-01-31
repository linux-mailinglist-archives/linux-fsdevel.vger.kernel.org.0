Return-Path: <linux-fsdevel+bounces-9709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD618447DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 20:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCBD28D576
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0F338F94;
	Wed, 31 Jan 2024 19:17:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5B83EA76;
	Wed, 31 Jan 2024 19:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706728659; cv=none; b=s2hsSovg2BWXNhj4SN9PCx3CFXZVJaXgc9ftmC73Fd/sSB2b54VQLlB4UqUMm5SQa6yuUNy7rWHK8Uig3KFRb9SZl+FSdZ+u8N+9i1jsQDJyTCyVYgSF4UBGLkNJrBUrvphNAQR8PXNbFnoPin/IzLAwuE/6wyqRIdFNNmYNJkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706728659; c=relaxed/simple;
	bh=tT/yVpc6ezGYO3wN+4MZZTS5ig6YKTzdtS9P6KR5VBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6wSArXZqfvVeAviWVFHXfeyKAr+V5413JvX7pBCZtIPf9KHcd7KCvGjQoDhrzL+tsg00g7W//btYWUYI+JpP7KjPoo973QXKHBtjKxJ4HxH9NAP5Kp4oars+y4as4TVTiBWMsKNgfkVN7vs4TpOHG43oiwab4uHkp2HOywPumo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BF9C433F1;
	Wed, 31 Jan 2024 19:17:37 +0000 (UTC)
Date: Wed, 31 Jan 2024 14:17:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner
 <brauner@kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/7] eventfs: Rewrite to simplify the code (aka:
 crapectomy)
Message-ID: <20240131141751.3caf42a1@gandalf.local.home>
In-Reply-To: <20240131184918.945345370@goodmis.org>
References: <20240131184918.945345370@goodmis.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 13:49:18 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I would like to have this entire series go all the way back to 6.6 (after it
> is accepted in mainline of course) and replace everything since the creation
> of the eventfs code.  That is, stable releases may need to add all the
> patches that are in fs/tracefs to make that happen. The reason being is that
> this rewrite likely fixed a lot of hidden bugs and I honestly believe it's
> more stable than the code that currently exists.

If there is no more issues found here, and Linus pulls it into 6.8, I'll
make the backport series for both 6.7 and 6.6.

-- Steve

