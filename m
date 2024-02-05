Return-Path: <linux-fsdevel+bounces-10308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B466849A4A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103291F22234
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7D11CD02;
	Mon,  5 Feb 2024 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXEoNFdN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48CE2421C;
	Mon,  5 Feb 2024 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136267; cv=none; b=ZVVD0pi7UOhWHM/D4e3cNQXp9lViTxM3o1MbXC4+XnQO/08RynL/jpmK7vqu7vE8jd+0wWDeTKetCBLUZ70WTMXW/94jfgmVZEDgCImTrRzbd1ZBAehw9HqN+knOGniT/mtVF3MwDEmxL0FGbStTDbsbmGsvOYQKarygEH5gY/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136267; c=relaxed/simple;
	bh=AGGZrY3G4SIsXq5IpjdPkltQ3Iv5YmrxHHI5qXQcuyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IK8+xD6cuxRHpTI1F8TXyauQlmNee37F+7AD5kcKBV1kIYGFFK/dkFSVuy1OZxWBNjAkcByaHhbXkglWpbK1BP0GKWWKE2pQgOs80Gtz25UgBPeOWXXna/bbzrdW7MnLc7ko/A89NGrqiIyA+H9wDswrnhMT6HRVQXDQ9XrIcvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXEoNFdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6840EC433C7;
	Mon,  5 Feb 2024 12:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707136267;
	bh=AGGZrY3G4SIsXq5IpjdPkltQ3Iv5YmrxHHI5qXQcuyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hXEoNFdNYmcOHWBeQ42HFlY4GEZM0jsDjvjCgFYdp5XnCSa0rl3EA+J5ylSq4NDUD
	 WzkxWhee9ARc7ZvCqrPHS0HQLx40CdiJ6TNRG/cI4UA75G3ctwJbV8VVUn4uk4ey/5
	 CwmA6/s3y8e0ZBrFu/gyV7LDo5zH7MJx/ydJbOafz/VZ6cL2RgkA3LfsBcoPNnbRS0
	 jsy6dhsDCoHUdxQXgN1dWkQphy+kgbLZrNaZk7jB+w1SWOjd0w5Xlo9/LqapYD19vE
	 JW26tv6sqCUHErIKyB7FHF9DmPOKsojeZWrT1w01EIBQewdCypPSCcEfOqgPmtZxL/
	 0shYjFzzhhC8w==
Date: Mon, 5 Feb 2024 13:31:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH 10/13] procfs: make freeing proc_fs_info rcu-delayed
Message-ID: <20240205-felsbrocken-krisenfest-8590c6f6a2b6@brauner>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-10-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204021739.1157830-10-viro@zeniv.linux.org.uk>

On Sun, Feb 04, 2024 at 02:17:36AM +0000, Al Viro wrote:
> makes proc_pid_ns() safe from rcu pathwalk (put_pid_ns()
> is still synchronous, but that's not a problem - it does
> rcu-delay everything that needs to be)
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

