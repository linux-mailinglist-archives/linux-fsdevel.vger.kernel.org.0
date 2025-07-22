Return-Path: <linux-fsdevel+bounces-55712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4473B0E315
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6CC0564554
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 17:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE78327B50F;
	Tue, 22 Jul 2025 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="brTG1yiy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF091422DD
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206912; cv=none; b=csvgjVBtxVS7FW26xUkGGxLA0jrNM/k8qrEmrO4egxFbegIBAuQYG8PHrufNU/VEVJ87DNA2EZPkCiji3SNkxq5ohOKP6TSEPO7X7f9TQO+0/VsMpGtsTM2xkCQf5b0xq+boMtVDpjwhesiOOztFNv9RClg0ELwwNMU+T4CevDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206912; c=relaxed/simple;
	bh=wJdYOngkgWC0aeC2r+zC/QGcV6RGLv1GZlAKGoT3220=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grbGkl2pJ0rPFB8bnlDehXUWeEGpB4z2WqhKIBEKnfFVmm7f9Gpb6G3+BJqnqUcGSf8L8NXxpVaH6Zs2HSqIdcrqMvW360V9MvdNNaLq65bIulSEBbsT36lpB8QLC1bmhm/NyRDBbZd+w8CeNo3sBrfnbyX19Z7Ru7Sa4oMOt20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=brTG1yiy; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Jul 2025 13:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753206904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wJdYOngkgWC0aeC2r+zC/QGcV6RGLv1GZlAKGoT3220=;
	b=brTG1yiyg+5CdPhPZjGkhvNW6G8LuB9uUvrk2lLwC4GqVWOq6C18R/YWkW6YvFgl3Joz1Y
	v/XKP1qS7748XZy3z8We3eOOFTLTMFhQ9UEPr022FBfTica/mtEQGTqmWZqlG7TS29o3Q7
	QsGnSz1r07IXeqAVaca0Xx94ogmd8cE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+4eb503ec2b8156835f24@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-bcachefs@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [block?] [bcachefs?] kernel panic: KASAN: panic_on_warn
 set ...
Message-ID: <xq4a62ukblverdhefpn3e43dkhaxvk2brdytqonrbzy3mud76m@srllmpvcv4e5>
References: <68036084.050a0220.297747.0018.GAE@google.com>
 <7mzjrydosm7fnkskvwjwvzpdverxidzfdqgjjyfmqljffen5ou@jy6c626sjrxr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7mzjrydosm7fnkskvwjwvzpdverxidzfdqgjjyfmqljffen5ou@jy6c626sjrxr>
X-Migadu-Flow: FLOW_OUT

On Sat, Apr 19, 2025 at 08:23:50AM -0400, Kent Overstreet wrote:
> I'm not sure which subsystem this is, but it's definitely not bcachefs -
> we don't use buffer heads.

I think there's some incorrect deduplication going on with this bug,
some of the reports do not look closely related, I believe they're all
buffer heads related.

#syz set-subsystems: block fs

