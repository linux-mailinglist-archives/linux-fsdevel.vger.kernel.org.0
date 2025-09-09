Return-Path: <linux-fsdevel+bounces-60623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F82B4A516
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 10:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B446160336
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 08:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F85242D63;
	Tue,  9 Sep 2025 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NWiqhN1Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9B524167B
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406045; cv=none; b=MsHKL7NhU2smLGQCA0X2HR9IhZEHwNjtsXU6qpZveRS4PKxvLiaVQQQnYsz18Y9W0PjDKFRK4X39Lsn+p4MiJml1UEw055WjNdwINAwpSo45h/UdInKx3l5Zih5cC9YEcZDUf0TrTxZZn4P/kAiXNm62ug8ebK4picFr4gTSJvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406045; c=relaxed/simple;
	bh=ivh49+Milyho8CRmuJJhly16qQeLBw6j4Yk6bSVZNC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8AGCnPMdrNr/Big1t9SviK6phc6Pu8e8lBwKE8HXJiC9JP7WijE4ep1uN50F6V8hMRt6FVcBtjTnwQzNgiEobUCE6+GizesOIN3gmVTRrO9NQRXEtSpoCwiQQwij2pyT+Z2R3kCUj/Dht9jThEgFU0zlaNvnPP9KKDYBZ8XVSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NWiqhN1Q; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kHfA3+sNv1eT7BUS/0xwxFcmAwQqkucJlspqyCDH5ns=; b=NWiqhN1QJg58rGBUvYnZzhqhJT
	0CfqsaxEXEEagvfArfluGYL0pUXftl7gWUBTFypBGqZPI9EYxDk+QEQ+MyFEIdDM33xS3fEhUxGJC
	fHzDL0GaA6V2cR8c5OAAhNVAgsv1BJFT6DuDnN8j5l5ZAQTJq0QjLkpArb9vzfLkTOyBs8srO4jxz
	UwgXuFpFY/gR/qLl8ay2WVE0LtKC8EZD4BhYplATlS9ml+GGq16dR2xxlBELBZxzqJy4lf/eho7Gp
	WBZT2xKxOR0W6ohUDEn1z3aNlOawN4K1pFVv/52zzPdIG4eXKycPj0pBRMsP2iK44fPfl4eIpYiBR
	UuQJD5/Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvtaj-0000000GmYs-0oIN;
	Tue, 09 Sep 2025 08:20:41 +0000
Date: Tue, 9 Sep 2025 09:20:41 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: neil@brown.name
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] VFS: introduce simple_end_creating() and
 simple_failed_creating()
Message-ID: <20250909082041.GN31600@ZenIV>
References: <20250909044637.705116-1-neilb@ownmail.net>
 <20250909044637.705116-7-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909044637.705116-7-neilb@ownmail.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Sep 09, 2025 at 02:43:20PM +1000, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> These are partners of simple_start_creating().
> On failure we don't keep a reference.  On success we do.
> 
> We now Use these where simple_start_creating() is used, in debugfs,
> tracefs, and rpcpipefs.

NAK, for the same reason as with the next commit.

