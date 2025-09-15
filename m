Return-Path: <linux-fsdevel+bounces-61332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A79DB579AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099A91887481
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A16F2FD1A5;
	Mon, 15 Sep 2025 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3bJmRX6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E3F2F0C58
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937723; cv=none; b=T0o2pOd1pQVIyF9QcWnzZvQ5IA107CRgH9wyDXkyuGpBS1qdHSxlbx9cfzCQ33cI6/iL4eIo/qliprFWb/ZoXj7TkY09d74LgBO4rpi949XiY9hrjW2VUqLrv+vEN1Ij+xSu5sI48SJjnbC3mg4RsHN0ZXyLox5IPZGQy94Aha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937723; c=relaxed/simple;
	bh=Z14AJKR0ozYpwB73oY3GYNN/qDa63jJs12fbWD+pHE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGn6MSuyAKZR1jel1o5lrJIyqUWvzsarWY6GDTcUItEklw8n97QvTIK8vhZm8QIKXLkGoEMiJHX9NFe33ig8Fpqz9YUyJts0cR3FJEBS5q7wKaUhVwywrizRoYIt/DeFQvbs6Sq+Tky8vPlxaSo0uha83ERemvvZCy7kGYbl+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3bJmRX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62BAC4CEF7;
	Mon, 15 Sep 2025 12:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937723;
	bh=Z14AJKR0ozYpwB73oY3GYNN/qDa63jJs12fbWD+pHE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I3bJmRX699HwnqpEBWjXAHn0YnpeBZtahliW22LiuYUbB/LUTja/mot7eeltTLEpg
	 o0wQOeOj2QkJu9hc7wwKi+L0xCKc28z+PJ+K36gCsY4gu8hwNYxSuLyDgkFWHwr7Ty
	 ePJ+jqTXlikt7Ca7/8V7NqN2CLDFN63v+0xfv0+G3Xjib9AUmC8zNBPNuwJEiwgFrX
	 TJ/8Zp/dvlPNjnVPEnosixIUx73KGNvH4WMcwXbRumsXPgN4vdqA1TMR4NG0T2lE98
	 VsX+rYuYSYFHNP3dxXLAgw1OxP7+CtGSUFeK+me29gmsyHG8XAO8xG8vqjGTOwGVpK
	 6XgI259T0R2nA==
Date: Mon, 15 Sep 2025 14:01:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 05/21] bpf...d_path(): constify path argument
Message-ID: <20250915-trapez-deshalb-54e92a2232af@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-5-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-5-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:21AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

