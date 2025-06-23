Return-Path: <linux-fsdevel+bounces-52624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C8EAE48EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 17:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDBE440B6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0886A21B9C8;
	Mon, 23 Jun 2025 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TQOp3TGz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09731275B11
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693084; cv=none; b=m5V6EdAR6xLI+ctHZKJayvMSUkETxYA0mNUFKXjaFO6L2uuNGKZPnv8mqKgqqRgkrq59K7ztuk508WpE0QCdVt31NG9JWRmAukDxv9JuRVtR95tZC7++y7hxle6izB9T9VFg+D82X5dlYAxibNcH1spCU31+x0XPm1xG6C5OOKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693084; c=relaxed/simple;
	bh=oZU6hP6jKIp69mIs2SxKSH9C6Gt17UDk/axZM3n0QFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDa7Wz3Z7PaMUtuL0wMONHuR2a6qUf5x2nOvxY1OKAgxW/aX1HY47D+kWIPImCGdg5mTXhf9/V5Q5R1QW/YJ6T3RRUFzAQ9U/Opxsmmn66MR18x5svXnDMiqIcyIULlGsDrVYZ2W99sA0+US4ZRYgO5SoPNbsINaAWTi2t0G9RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TQOp3TGz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yECWFHRLSICScsLOODrvX0DQ34E/EbLJe+lPxiG6Glc=; b=TQOp3TGz8kq77hJhTi06F4zhTa
	BINDn/7EKsY/vh/O7xAGtYCBscW3ZlricdEKuWaexP2oytH+J0zniZt6y5vT6HSwBVqRlyWon3v1O
	ly7teNgezkyEmmOK6HlJMr3S8VxIQTA3kOAz+XmYlEuKrZziaYw2OWCxdvhO5NynHbjeu6xgA612H
	AqY4nyKouyk7BBvliLgdGn7juI1A4cadaiD1ZAwokzYLJvx482h/DkF61LV+MQ3UYzwdElEanKetO
	h4UKcBC74sdznTWLCoS6KMeA2X2eJLnt0e6mOnsdpesnsxeZ/OciKEcvjgL2so5HX6JWrY0vOh/G8
	lRURaang==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTjFA-0000000DcEA-0L7n;
	Mon, 23 Jun 2025 15:38:00 +0000
Date: Mon, 23 Jun 2025 16:38:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eric Biggers <ebiggers@google.com>, linux-fsdevel@vger.kernel.org,
	LTP List <ltp@lists.linux.it>, Petr Vorel <pvorel@suse.cz>
Subject: Re: interesting breakage in ltp fanotify10
Message-ID: <20250623153800.GE1880847@ZenIV>
References: <20250622215140.GX1880847@ZenIV>
 <CAOQ4uxioVpa3u3MKwFBibs2X0TWiqwY=uGTZnjDoPSB01kk=yQ@mail.gmail.com>
 <20250623144515.GB1880847@ZenIV>
 <CAOQ4uxhTXgTt62cX-F00e4vAyhDn=fCTxDqONcGT9+tBH-DkCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhTXgTt62cX-F00e4vAyhDn=fCTxDqONcGT9+tBH-DkCQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 23, 2025 at 05:19:26PM +0200, Amir Goldstein wrote:

> I have no idea where this strange TWARN is coming from
> I did not investigate it, but the bug is there anyway, so I sent a fix.

OK...  Current LTP + patch you've posted does not screw that sysctl
anymore, so...  Tested-by: Al Viro <viro@zeniv.linux.org.uk>

