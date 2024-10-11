Return-Path: <linux-fsdevel+bounces-31779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB4D99ADDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 22:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F12028B80F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 20:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085F21D150C;
	Fri, 11 Oct 2024 20:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZgsjuJu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F35D199231;
	Fri, 11 Oct 2024 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728680270; cv=none; b=pL6FB3kBTE62WOiclFAtLR9oS8oWl9npLdYe1z39y9w9Ov+qKAGoA8q8T6aIzzAeNj/nRZaYg9hsr28Kb5BIMArASGrjr5vBQkYNdBxag/9qYhFHf76LwIDUE5nNvXbsR51vzWgKaFbSeXWhrfUy/e25oM+a5xHYpP9+giOH3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728680270; c=relaxed/simple;
	bh=v2N0a/Yur6GVpp1VVlX+ze23d7R8hMgMApwH0R/R570=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDsOhG9t27KOOnOr0ql5czGphLwFK8XCLkhKRa3ynPc87mxjF1eZ38sAcK9wzPiptStJYDTCTHjS+rF/Y5A9WAn5UtFVMLpF3hNK/nJRj+TzGeyXUYS0lBEZr5kYliWh0Xf2zI2q5knnVpiX+X2J7W34N9zZAB1DOyQqo7HUDOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZgsjuJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28ACC4CED0;
	Fri, 11 Oct 2024 20:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728680269;
	bh=v2N0a/Yur6GVpp1VVlX+ze23d7R8hMgMApwH0R/R570=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZgsjuJu0eV8PYlvOAup0IL2ATbcZFjDRbjqMVrxK/nHo1DJceshmnbdBgJZEb5eg
	 19DQoZ4sGgnkpZuq/uJWDaetbPzQy7524qtGX5crbTqmjkShJdOwhMwZCDi1Kqr8Qs
	 7yQ55n4EZEL5Qub+NPOIYD+EnUiQpgnkIjpk0XWKnIPipa3aMDYH+UsLbanBcuGglb
	 O0Iwl2SjqHFtonDVxogIX4oAl6rq5beB2+hzLlJ7HqWG+bnQTgya4I9q2x1SpO2JLG
	 doU0xhxSR/I7eco9JJx3IbGAvbTRJaOP+d7MlVKyjxB/abZZhWZHiqSgII3vHbVQXb
	 kUPFg5hcZmPuw==
Date: Fri, 11 Oct 2024 22:57:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] ovl: specify layers via file descriptors
Message-ID: <20241011-bestform-sinnieren-0b5ec266b26b@brauner>
References: <20241011-work-overlayfs-v1-0-e34243841279@kernel.org>
 <CAJfpeguO7PWQ9jRsYkW-ENRk6Y0GDGHJ6qt59+Wu6-sphQ75aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpeguO7PWQ9jRsYkW-ENRk6Y0GDGHJ6qt59+Wu6-sphQ75aw@mail.gmail.com>

> But the fd's just represent a path (they can be O_PATH, right?)
> 
> So upperdir and upperdir_fd are exactly the same options, no?  Just
> the representation is different.

So I misread the code which lead me to believe that aliasing would be
more involved but it really isn't. Just give me a minute to fix this.

