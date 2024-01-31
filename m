Return-Path: <linux-fsdevel+bounces-9665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB3684428A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 16:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9109D28435E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 15:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F57D84A3B;
	Wed, 31 Jan 2024 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="BAAv8q1r";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="BAAv8q1r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081F68287A
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713184; cv=none; b=Mzje+AcC9gHiyZwuOLjQWaQxO4yez5lcYiVAny8NoC2sc/uxDe9LlL5QJWNdLBE+WX9S7clvVVqPRm79jz2w2MBWAjuQ6jQ9enMDKJuE4cq1aW8nrIo3fXG/tq8FoUTVC+lzQ45cDvD2LT6vVN3vJJYfstTpRELSVI7k1MQ8fY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713184; c=relaxed/simple;
	bh=a7szF6hmx9T2F43Euef+pr1V5bx5JmztREnRbaLY50M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RsV4MJ4QYODIryThkLKoELfWw46gesjlhotz3GocZl7f8mwcpCKbUhDCoO3Sakq8qlcN3db6BW+T7Pcsbfom4GRBmLWQEYNEYW/Ke7eU8/UQ6TfB+G+ESxPajyoDNNNafyIRuCFU+Q2d8O1ZyZeEyOLiGe3oaSZBtBJnAekKO90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=BAAv8q1r; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=BAAv8q1r; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706713180;
	bh=a7szF6hmx9T2F43Euef+pr1V5bx5JmztREnRbaLY50M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=BAAv8q1r5RkfKP9aAm9ATPzAUOnnKOMSgR2o6YnkVecdE3Udm/iLbSE6ahN2VKWJw
	 0FKp/g9I2qxPPuEaCj+7sVsZcFatGKo5k1/xjIN0vsB4cnnR9T8ldJ+tMpWi1NO1z2
	 r7eXYQsRpfcmX7vc23qh5FWInH24kaA6GdFohLEk=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8E7DC1280C65;
	Wed, 31 Jan 2024 09:59:40 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id NJOuAxqo-zRf; Wed, 31 Jan 2024 09:59:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1706713180;
	bh=a7szF6hmx9T2F43Euef+pr1V5bx5JmztREnRbaLY50M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=BAAv8q1r5RkfKP9aAm9ATPzAUOnnKOMSgR2o6YnkVecdE3Udm/iLbSE6ahN2VKWJw
	 0FKp/g9I2qxPPuEaCj+7sVsZcFatGKo5k1/xjIN0vsB4cnnR9T8ldJ+tMpWi1NO1z2
	 r7eXYQsRpfcmX7vc23qh5FWInH24kaA6GdFohLEk=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4753A1280AC4;
	Wed, 31 Jan 2024 09:59:39 -0500 (EST)
Message-ID: <9a86f45b2b06de898b8f6cfb3315f69e564cec8d.camel@HansenPartnership.com>
Subject: Re: [PATCH DRAFT 0/4] : Port tracefs to kernfs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Christian Brauner <brauner@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>,  Linus Torvalds <torvalds@linux-foundation.org>,
 Amir Goldstein <amir73il@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, Al
 Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>
Date: Wed, 31 Jan 2024 09:59:37 -0500
In-Reply-To: <20240131-tracefs-kernfs-v1-0-f20e2e9a8d61@kernel.org>
References: <20240131-tracefs-kernfs-v1-0-f20e2e9a8d61@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-01-31 at 14:36 +0100, Christian Brauner wrote:
> * If we have a session about this at LSFMM and I want to see a POC of
>   tracefs and eventfs built on top of kernfs. I'm tired of talking
> about
>   a private implementation of functionality that already exists.
>   Otherwise, this is just wasting everyone's time and eventfs as it
> is
>   will not become common infrastructure.

Note: I asked for this to be updated to be a "how do we prevent this
happening again" type session.  I believe you took this as "the VFS is
insufficiently documented" but that wasn't my intent.  There's clearly
something missing that should give people looking to do filesystems
like this a clear direction on how to start, where to look and what vfs
properties are required, which properties break some tools if not
implemented (which may or may not be important to the use case) and
which are nice to have.  When I did shiftfs, my biggest problem was
actually getting configfs to work for it due to being unable to operate
without a superblock, so learning all the VFS intricacies came in
second to that.  I did think at the time I should do a talk more
focussed on what I learned about the basics of the VFS for psuedo
filesystems, but that got lost in the need to push shiftfs itself. 
After that most of my subsequent talks were about extending configfs
because that was the area I had the most problems ...

James


