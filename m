Return-Path: <linux-fsdevel+bounces-34624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C17DB9C6CBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 11:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796D81F21AFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B0A1FBC8B;
	Wed, 13 Nov 2024 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rB28S6uC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300ED189916
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493263; cv=none; b=agNiYVo70UgR24hodq1Nr0ExAYr0bnW3j6VednUZrofFaWbyzarZdcSJXYcSnIKt04u5WPLa0XflM8+d8Ex0jMNUJcxyAJ7h7dukaxHKHXc4LYeM5Lt/fyG6FcMrnV6JAmPS7p/KvGBG7ceeBTDlgGWrEuZyZK8qPndlxcEycpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493263; c=relaxed/simple;
	bh=odJurfg2NHfQBBiaiHDAJzaYifefHORO/VTZ7Rx7tlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdW/kg1Ov3SfKfIjDwFL0TRGJ+EiDXMiG6IWlQv9082a8WhvmG7OfdJDmlInC+GvpTNT3YRSp9Yd5JVcjEQDadUDk75i49MorgkdNx6e+A6HSq4B39np/FK1W5aO3vTqTm4Rv5Vjp3TQZnXUBCm4BprpQQ5LcT6HcqdRcIfq63Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rB28S6uC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5922FC4CECD;
	Wed, 13 Nov 2024 10:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731493262;
	bh=odJurfg2NHfQBBiaiHDAJzaYifefHORO/VTZ7Rx7tlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rB28S6uCTgGcsJRRtLQjGOYupfkAkWF4NL8OOiN+7lVd8pzNhKSFygephYNNTXfH5
	 2oldf2yPmxpSvIcrJy0Qg5ePLinyBYaywy6bz8BhDAOwcCPef5lgtOSI6rOh59/q1P
	 V8XwTplCX0QeuqueMPX6v/gxsQr808ecz7rzjeH1l6flzFfXd0+U42ZPiFEIZopw8J
	 azZm1S5uAtixrtZirjM8LbpoIdcpH9E1HFhJ56fnDzyvgsdzoAEJqb1F59YDmHD+rs
	 cee42ihg2IHJ3ku5NEePZELEcZhDQUM9nR7Na36FK1jpRSfTD44tsyl6QPp++o33Sq
	 uOvxVXajieQUQ==
Date: Wed, 13 Nov 2024 11:20:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/5] fs/stat.c: switch to CLASS(fd_raw)
Message-ID: <20241113-zoomen-gleis-56251b8eede2@brauner>
References: <20241112202118.GA3387508@ZenIV>
 <20241112202552.3393751-1-viro@zeniv.linux.org.uk>
 <20241112202552.3393751-3-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112202552.3393751-3-viro@zeniv.linux.org.uk>

On Tue, Nov 12, 2024 at 08:25:50PM +0000, Al Viro wrote:
> ... and use fd_empty() consistently
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

