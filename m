Return-Path: <linux-fsdevel+bounces-36411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C12289E387A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E188160E64
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 11:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0991C07F0;
	Wed,  4 Dec 2024 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQX1fD7f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6919D1B652B;
	Wed,  4 Dec 2024 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310667; cv=none; b=m0TgEqClq2iE2TWIIif/+NkkhOF90+aFDoyiaoQ5s6q1Uh10PpR3XqdRS+Rj/cwWLlquwh/vrfX1aTivO/6g6GY2jAZkK0gMRR2JxmNrWW9By4uulT051l6416HJjaRCWMC35VzTFP9bORvbeZq8yb6tobPAgylsyBbMr2gZ8vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310667; c=relaxed/simple;
	bh=zsuO6m/a+CdGIafKXj+0U5R1TzEt6mOdXdkn9j112GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BU46uPWzqDylx5AQzuvjEXZxZLnT4p+ccbmBVlahV1bsRxSETuCsXXIfeCkKdFGlP6PdpvsYxtCZxrRh6hQfdfmGOT0Scm641E2hrln7QHtpRkusF7peoQjU2cxvJdyu2Cenc1Qtk/RLRd4x83PJoL7N4WU8bgvPHVcl82F4Bs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQX1fD7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D74C4CED2;
	Wed,  4 Dec 2024 11:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733310667;
	bh=zsuO6m/a+CdGIafKXj+0U5R1TzEt6mOdXdkn9j112GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQX1fD7fTGhIx5s47l2ES2IDqiwVURdK/YYgT959cIsLhfDgRGNzJbnOAOmU2sNfl
	 wFua/i+N9ExLckrOz1Qz/n4k/HKlYUIDQWPJm1Qls9zof5SYAEEjn0SuiIUcpFoCNr
	 tOzKnWFXVLyzcdJXYV4H6oXe0QzTae0JTQDLe/vyCyqRSFvYckVMN3xxqmr9/IrPzB
	 qArhR5zNI2voe03Hhc13YN1gAFYN2dPA5YxDZS64SA9QjIsHxsfwaqaOB5t0gjjMXb
	 au87r4GwdxAeDWkPSzdgtYwiZL7+CpmgMZmcm9uJk50QMNEbnh9/nb8W2gviVxd44s
	 dZy8rk3tymj2Q==
Date: Wed, 4 Dec 2024 12:11:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: I Hsin Cheng <richard120310@gmail.com>, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] file: Wrap locking mechanism for f_pos_lock
Message-ID: <20241204-osterblume-blasorchester-2b05c8ee6ace@brauner>
References: <20241204092325.170349-1-richard120310@gmail.com>
 <20241204102644.hvutdftkueiiyss7@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204102644.hvutdftkueiiyss7@quack3>

> motivation of introducing __f_unlock_pos() in the first place? It has one

May I venture a guess:

  CALL    ../scripts/checksyscalls.sh
  INSTALL libsubcmd_headers
  INSTALL libsubcmd_headers
  CC      fs/read_write.o
In file included from ../fs/read_write.c:12:
../include/linux/file.h:78:27: error: incomplete definition of type 'struct file'
   78 |                 mutex_unlock(&fd_file(f)->f_pos_lock);
      |                               ~~~~~~~~~~^

If you don't include linux/fs.h before linux/file.h you'd get compilation
errors and we don't want to include linux/fs.h in linux/file.h.

I wouldn't add another wrapper for lock though. Just put a comment on top of
__f_unlock_pos().       

