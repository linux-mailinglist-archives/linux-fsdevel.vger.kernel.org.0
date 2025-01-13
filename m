Return-Path: <linux-fsdevel+bounces-39086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A95A0C1C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 20:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83037A0813
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 19:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111CF1C9B62;
	Mon, 13 Jan 2025 19:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LCy8H8mm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC171C3BE6;
	Mon, 13 Jan 2025 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797669; cv=none; b=jslcYAJAB+7JbuBhBUR7bNiasZMgx3oW3QsOreBqSGDf/4Cclzftsg4gz5PwIObSOjNWRPFMi3p2N72c03YvcxJM6n6JCpqsza4CWkTqxvoemAQxT/VpzoAbGQrxGaPykbw5nyAHHoIc0E0AkHpamHyfxgcF+NMhMQ2VdIwQAJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797669; c=relaxed/simple;
	bh=Z0O6V++p6h3ibBUVu+D6FDZHIzvMMQREaaD2dV7NhY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qyl/tAZ+d2WY3egBPNQ5kn4ZDWC3axAVwIhUCP8dkbcj7rXTO0176OyMlhJh6kBt2asptLoXyCHdol5VtUR0ePPUfxbh0xnq1UMoRrGziKtuy/xi1+v9W5ZMbz/2kkOUEIf0lW2AR4XPu3iL5gk/bkTqlodBfODrljRgEC1x3xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LCy8H8mm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/tfPUo2EO2PAFpHSyL8n5WUMBZY0Ez9O+GdUFRQZDug=; b=LCy8H8mmNuUrQvYmf0T58GQmN1
	owAyWWzaGL46R2hedjAuzzp5C7N559UXyDXIzbX0/HGurPRFDleoYZMWv1mZreb6aQEdlJKTJeuAQ
	O67mnbanGT+5vmcx5ReqlgxtWIDh3Po3R2c5i8l4i/BRuRbpj0jINSCsaRv8uUv71JTEzckird+iw
	+uEYYHQDSCGkhiKtd/NN0bQJV2vzjoCnEMlH9fAtWcavfM8BCeEFPlZO58n/66pMU/42Q+PUX+AQL
	Bkm7L8BatLEY5NQ2+ydOQ6D4ay7Auds6fMAzBLocSeGoFl2QO8Tz4PwYdMSEk/eoovROGiOMRu7qE
	rF5GbxXA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXQPY-0000000113X-2J4k;
	Mon, 13 Jan 2025 19:47:44 +0000
Date: Mon, 13 Jan 2025 19:47:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] select: Fix unbalanced user_access_end()
Message-ID: <20250113194744.GZ1977892@ZenIV>
References: <a7139e28d767a13e667ee3c79599a8047222ef36.1736751221.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7139e28d767a13e667ee3c79599a8047222ef36.1736751221.git.christophe.leroy@csgroup.eu>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jan 13, 2025 at 09:37:24AM +0100, Christophe Leroy wrote:
> While working on implementing user access validation on powerpc
> I got the following warnings on a pmac32_defconfig build:
> 
> 	  CC      fs/select.o
> 	fs/select.o: warning: objtool: sys_pselect6+0x1bc: redundant UACCESS disable
> 	fs/select.o: warning: objtool: sys_pselect6_time32+0x1bc: redundant UACCESS disable
> 
> On powerpc/32s, user_read_access_begin/end() are no-ops, but the
> failure path has a user_access_end() instead of user_read_access_end()
> which means an access end without any prior access begin.
> 
> Replace that user_access_end() by user_read_access_end().

ACK.

