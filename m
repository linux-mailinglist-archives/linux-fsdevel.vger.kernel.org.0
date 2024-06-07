Return-Path: <linux-fsdevel+bounces-21254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED9990087F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FCB01F22A42
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5087A190672;
	Fri,  7 Jun 2024 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czvuk3N4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DFC54660
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773435; cv=none; b=OHRhfaElHnbjyHrTIKtOthVtSMEnBwxUbgbLmY7EqZNQmD3Xs4tW+G05VjKZB3wx/BSxa+obSvsXhyfdv15pEcUrJEXWqlde4eXwR2C49DjAGKgI3oMV4FG4zC1qQ1k29TD/RYtcKsqetZUU+xI/V805t0AEyf8iW9j1fykbHsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773435; c=relaxed/simple;
	bh=LgXXSfgB8HlLRLvQnAelQ4kabsrqzX6VnOUoGjdbX3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRQaxUYsmXHp7FqMntjS7RmY7HzuW0zdlWcxeulM0N1XFr9jeVDlm6P4D7V2AreImVwxG6yobtqlE7eFOIEls/DbR85kkbVD674Zkn2oTzuM98XnQLiVhJCR1JMOK6FLf/mTCUcy/URuNg1LNGLwivXQO9tgmwI5RQ6csYRmLIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czvuk3N4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D16C2BBFC;
	Fri,  7 Jun 2024 15:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717773435;
	bh=LgXXSfgB8HlLRLvQnAelQ4kabsrqzX6VnOUoGjdbX3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=czvuk3N40/0tWgR+D1S/18vlbf/ixXrhoXfaO2MOGpqilw+tYBz9lH7M4axAFq4tr
	 ro0cDaHnjH96sk5I0S0zxILKMERb4GKcptY9vKuUBNaauZjpGHL5i5PjVw4oQNyhK5
	 4Q1gsVddtXyHHtc7mG71rVfoYm+DIItVCgop7p3+9pndlwpXljkjoYwQq5pid4v+dj
	 4rm7RbloDJWrCpjJsEm8kMkrezBjWAYOEfbVbO+22IIKFvgF3NM5WlZYng+hqvYk6y
	 Tn4A2T5+zMtxPwkiPqse1PG206vhpDEGTdYEIrlQbfTgAlXgmRLxRSxgDloztBGLyb
	 i/y2acxvUaF2g==
Date: Fri, 7 Jun 2024 17:17:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 02/19] lirc: rc_dev_get_from_fd(): fix file leak
Message-ID: <20240607-dient-abkaufen-cd6d234a00a1@brauner>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
 <20240607015957.2372428-2-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240607015957.2372428-2-viro@zeniv.linux.org.uk>

On Fri, Jun 07, 2024 at 02:59:40AM +0100, Al Viro wrote:
> missing fdput() on a failure exit
> 
> Fixes: 6a9d552483d50 "media: rc: bpf attach/detach requires write permission" # v6.9
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

