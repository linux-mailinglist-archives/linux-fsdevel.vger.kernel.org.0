Return-Path: <linux-fsdevel+bounces-16424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B6089D56C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 11:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F513B226C6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 09:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA22C7FBCE;
	Tue,  9 Apr 2024 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+yLm1Wj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123147FBBC
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654520; cv=none; b=aUXhQ2YfzfYYM4rBtYlEDfJmES2mhs87z/zMLXJ/YgE5CrtsB4NSGMRUu0Hva+oTNOsC9jozJZjBmgHYVLXVAU9mYyU7YXjNHlMdspvOLoxCNW6JJ0pn5vXVEfsBEkgdkfdErQzXigV7pcV/zTIBwBp0TqpHS7HGFj4LOWRqc/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654520; c=relaxed/simple;
	bh=hWluG3b9a5Mflq1bLrE0LXNC2U563i4MdhjTcOSerdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwaZGh5OqVavlc9MUCZGwoTRL7S///DrN9RLpk76O4WqIuoLRK3ra2UVDEDGzf0/9/d382d06dLiUdzOZ/UCFtt4+Ktylbv1AVSZdDxOChWtpVaLCOk1GvrFFVlyY2/E3j+Hc+gOQIAzs0pUsS7DZb/ekhVN6ZrtXjCOQ4lU0EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+yLm1Wj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD2AC433F1;
	Tue,  9 Apr 2024 09:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712654519;
	bh=hWluG3b9a5Mflq1bLrE0LXNC2U563i4MdhjTcOSerdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+yLm1WjIEtmIJ6z7r/jAhCxA43Q7xEzYIzQUTFtCzIOZQsEMOp623D2ImZu8Ih56
	 Qgy9SrfnY00cpwSy0GZQURvGZisAdKQSPl/+i/XgzcJiDxlxWqYKiXPkJsjAqx1RUt
	 J8vecLwvgCmxYgSwmsiaGPisgYfeESIOJODNmaMQejA9XwKZs8ba4OuMHCBbUBTu8Q
	 6+z8QSuKwEEPN4EFnDUcyVEczhSeW8eHntDm+ORHkishdPYv99odxLcrCjWsqWGRHi
	 7kna5RXG18GBi9iJgWx95ZApXqPY4td0xK2qCr1fLYPo4HCMpw03nGxsxMvwpQEU6H
	 742mGYnolxh/Q==
Date: Tue, 9 Apr 2024 11:21:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 2/6] fd_is_open(): move to fs/file.c
Message-ID: <20240409-wohlgefallen-altersangabe-23ce2ec60d78@brauner>
References: <20240406045622.GY538574@ZenIV>
 <20240406045730.GB1632446@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240406045730.GB1632446@ZenIV>

On Sat, Apr 06, 2024 at 05:57:30AM +0100, Al Viro wrote:
> no users outside that...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

