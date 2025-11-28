Return-Path: <linux-fsdevel+bounces-70122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769B9C915AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 10:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588073AC711
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 09:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1294A30100A;
	Fri, 28 Nov 2025 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7DC3Goj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573492FFFA0;
	Fri, 28 Nov 2025 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764320629; cv=none; b=L6GXZqZch3XjTtjhcMrtBnLd9GeRsGc4CtiilmbOSqPMSS0EqWoTiT8S52CDdfYMkue1NppXnJfKBUC3lfnaC/YkvZdF6U//zUG7/IzNXHBiF7faQB8BeUK9d+cOPFSOFJ8rmpOcW5V3R1vpwT5OW1/i+zMx8I+slvd9uPuwZdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764320629; c=relaxed/simple;
	bh=ynqlz+eII1UCF7j7WQG3t8CGeQiM2V/X/0SccuWBBWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJSJIP6Ll2hvGEnTaaTm4tSWsSwLhR7DYzqtyLG252RvzDAEeKdfek8BnhruJBFzD5VJsKTcJFDh7iQ0PagPQBMdsysikzQPH+CxgwBlQjIxvG5i6woxexKxC/10D7+7EbIx+17ZfA2MQYG7UqU3sm0YHiYgTLopH2HP06nMroY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7DC3Goj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AAFC116B1;
	Fri, 28 Nov 2025 09:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764320627;
	bh=ynqlz+eII1UCF7j7WQG3t8CGeQiM2V/X/0SccuWBBWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I7DC3GojV82J0h2WE6m/E9w8P0GQM5dpEqnmdlozzwuOTu3Ya6Cv5HFV86ESRnlea
	 83U5/XXY1/Xsy7HnnUqsLyA0mcnqxl2vmicxWv7lno6MXSu8yE9zmPH9VhPTxt25bB
	 F7Zg7UOUNXXF5O5Os52vjK/1NG0F8P8l4Jg07lyy5aK8tWM9Y9nikywxPCwls6TIiT
	 1zsqQHr9o6toZzbr2bqlNST67gSqya+m2ABsDQss+w1Z1TI0iCOQxgorevFLGOu1eQ
	 aNncQIF5ZvCIKhPoGTP8XCxMh/0AVqorUUPrnpu9bmjuazGm4O0D2OttQO+sufH4nu
	 egWRbp4aHRyMw==
Date: Fri, 28 Nov 2025 10:03:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Matthew Bobrowski <repnop@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+321168dfa622eda99689@syzkaller.appspotmail.com
Subject: Re: [PATCH] fanotify: Don't call fsnotify_destroy_group() when
 fsnotify_alloc_group() fails.
Message-ID: <20251128-waldarbeiten-eckpfeiler-0a17df98fda0@brauner>
References: <20251127201618.2115275-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251127201618.2115275-1-kuniyu@google.com>

On Thu, Nov 27, 2025 at 08:16:15PM +0000, Kuniyuki Iwashima wrote:
> syzbot reported the splat in __do_sys_fanotify_init(). [0]

Bah, thanks!

