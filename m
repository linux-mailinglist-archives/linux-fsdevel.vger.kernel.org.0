Return-Path: <linux-fsdevel+bounces-20822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19968D83FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 15:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8B728D797
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2CC12D767;
	Mon,  3 Jun 2024 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHy5ljMU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8CB8174C;
	Mon,  3 Jun 2024 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421493; cv=none; b=jcIGeg5ALyjGK8LTRU31iOhdeuzKjfXtJU239s1bxwgqo2twVX50Cwfs4tNDyvhef7CkSy/LL5ZFA5tzIwy1p9HTppSH2RlsqjUm9H/qieNzrXSiHQcmEFDh/HHBTxClQ+JZUPbyUshQD9Jb93bHYmgQPtiG5MxJe3fOqh0aGTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421493; c=relaxed/simple;
	bh=UptWuo5qgHi9d/+bS7xljBG7+CacnWbYGCzJFJXbkOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJyzj/r9LIQL06PypmHQ8DDKqEmXNdp45vJtq/mPTzuwXKR9RPR/U0SrCD1qbr6R2rQxE/UXpH8cSqagVyUrBK8nvf7xoYimtRuJLb02dQcPamsYGkVRWTv9l6x+9iafMHxhXHd6MUOYD7Sa9g+EdfR9QJ4HYp92rNtaAt5jq6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHy5ljMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72A6C2BD10;
	Mon,  3 Jun 2024 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717421492;
	bh=UptWuo5qgHi9d/+bS7xljBG7+CacnWbYGCzJFJXbkOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KHy5ljMUVZerc5t9oZ2492IgTFmObb/RHi5HJgiiP8DD5dMtXaTPg37EUA3DR0GG2
	 +fzWwU9aaSeS2MqpspB6E7cXl1dNWbIAgL5SJPE//HT5T4cAuNj8IvT1CZ8mkumf5Z
	 hDr7GR4N/ylS8J3H9wMckBy9mj1SwI6oWxK4L9M8kVGA4nvOBkeoAW05eVe7psw5Ij
	 QKFWtNxMyZkuqyAhOeRsRmj1EamRTg7hYGyb7pmL11rFCc/TkwZVDfDsYbzXbt/pyt
	 /dqADjyfBZu0TTPSGTVEErpJgljI8HQt1mMey7PirtU4uQY6mK1peD1UVjC3Ug5sEl
	 gnm8O7JbNKzLg==
Date: Mon, 3 Jun 2024 15:31:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-renesas-soc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Howells <dhowells@redhat.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: ignore auto and noauto options if given
Message-ID: <20240603-holzschnitt-abwaschen-2f5261637ca8@brauner>
References: <20240522083851.37668-1-wsa+renesas@sang-engineering.com>
 <20240524-glasfaser-gerede-fdff887f8ae2@brauner>
 <20240527100618.np2wqiw5mz7as3vk@ninjato>
 <20240527-pittoresk-kneipen-652000baed56@brauner>
 <nr46caxz7tgxo6q6t2puoj36onat65pt7fcgsvjikyaid5x2lt@gnw5rkhq2p5r>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nr46caxz7tgxo6q6t2puoj36onat65pt7fcgsvjikyaid5x2lt@gnw5rkhq2p5r>

On Mon, Jun 03, 2024 at 09:24:50AM +0200, Wolfram Sang wrote:
> 
> > > > Does that fix it for you?
> > > 
> > > Yes, it does, thank you.
> > > 
> > > Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > 
> > Thanks, applied. Should be fixed by end of the week.
> 
> It is in -next but not in rc2. rc3 then?

Yes, it wasn't ready when I sent the fixes for -rc2 as I just put it in
that day.

