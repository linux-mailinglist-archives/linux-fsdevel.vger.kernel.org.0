Return-Path: <linux-fsdevel+bounces-25265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 498F794A571
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78E51F2238B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF83F1DE844;
	Wed,  7 Aug 2024 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rqdybt7a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB4C1803A;
	Wed,  7 Aug 2024 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026464; cv=none; b=Hq3Q4DwSxMpwEu01U748BX3YoAOr77iKD2g8swU/gBDbEtNqaYpqGhcrfOx5nlL7hmkqmdh3osqAXEbcOJ0dTvRcOKLTGzhLcyhI8II4TchYF8evbZhgoCqqvU+fjS9EmPH8qB58ED8DdwUSckAYbbI4MXc8gS3UpOr2Z0glZ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026464; c=relaxed/simple;
	bh=M3gzZQ9mkfzsz6uDsF9mQcdnG7IogWbhMbEQrzDMv+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXf8noYGpFb3E31tEjOQ4Q5nf4mgmz7NYE6fKCDuK4BPhb9zFVYHOxOyf8pn8Uz018qgbCWf6hcMXNOXuF1y/Uaf2g6M+1Yn2bZblwar5xWoJkEm0UO6cnB9vSbnpLy7RMCZb32gkf/UAkdhGVItUZZ3K15RU+JGQYMMTI9aYYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rqdybt7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D967C32782;
	Wed,  7 Aug 2024 10:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723026463;
	bh=M3gzZQ9mkfzsz6uDsF9mQcdnG7IogWbhMbEQrzDMv+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rqdybt7a20pzjzgLvUOsFGC1YWtUEssEDmny847lFJ9n1+ECvawKZmykaXsmAg+Ya
	 eX36MIt8BnHNZTs583u3C19oZ+cAXJCjcIfawGZFpPLEILaMN+UPkC5N/KXV17vRfu
	 ghR38SfBi/yPxB4QI5dJxOwBeRZ4L4L5/0bDdA8CQIWQK79rlH9I6w7KsEGLR9DONU
	 2k1CeG/6uVMjLN6ltoHEJ5Dq5BZ7QnwhZyUWyB5xT5ayPfAaZ8S1GKfpeq2KmyJSeR
	 bcpxCkDYiABXrtX0m85z/eGYZggnqn6nxy4xHkjB/V0X4wObdGLU/5MRB3aPSnj3f2
	 C1wEJ/Oap33yw==
Date: Wed, 7 Aug 2024 12:27:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 15/39] convert vmsplice() to CLASS(fd, ...)
Message-ID: <20240807-autofrei-klebt-bb6a361ff137@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-15-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-15-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:01AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Irregularity here is fdput() not in the same scope as fdget(); we could
> just lift it out vmsplice_type() in vmsplice(2), but there's no much
> point keeping vmsplice_type() separate after that...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

