Return-Path: <linux-fsdevel+bounces-21010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA188FC1EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 04:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3442851D5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 02:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6050B61FEB;
	Wed,  5 Jun 2024 02:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nCoMZlR6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8EC184E
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 02:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717555171; cv=none; b=sVQAOmCy2K58keJgUKNRhXt8FsX6966LM9pI2E5yD/E1Wu0gL3PyJq/968FDPYdeEgI+eT9jApfHG9whrLQui+Pm5Hp4qHazqZkEFxRAYxVnT+saN8rj78OQrog7KMrZnFL40ptl8cJTUhLj5dtRNWok8O6ShHbkxhxTWJO7i4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717555171; c=relaxed/simple;
	bh=qm+qijNIC8P4tcV0tC3mT7uYej35fwTOeTBu8iId8iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJlxwJyo0rdHKqg+p5U0fLUds0m4/nIXpu04Xa3PI7kOgzOB/VARM8Y62L/KJKmkB32zyZGak/aFwiEYHT0kULXin4/06e6lOgAPRaycmYtNS0Z5+FYF7Uk49saidgGnqAgo9YEgVrZq2t8124DIUkY7FEW4ggf/eVM0NwXrckU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nCoMZlR6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jXi+2tU6agYYNivAaVd67hb6DcD8rsFGsjYYjUgmTVw=; b=nCoMZlR61X4DIkwvSD5ZvZMuF9
	8oIk/TTWZNM8xn1VFFv7DzVyUkVDD9tDiitsobUWJT4Xd0k198fxdFHCJsflqPy+5S9zvlbJB/+gw
	fjQLxrJ1tt6w8d0meZM5xYfyn85poql726np/kR5SOTT7GYaWMBlbb2dFbfqb1CvJspRf/6il2Xs0
	au3d1RpA8NLlrn1VIe1XlZW43MApOKqIPDDj6l6ssrRLnt5+gDQzPdapUtaBKNEdzWBOO5puclBJg
	foOCPN1+ZlcbaQ5iGE3EazzmIbEC4VoEGECF/NboF3rWjW3eTKz3/XKVihD+inIaB/JqOlUaJTKgh
	prcTHNpA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sEgYh-00Ex5W-2A;
	Wed, 05 Jun 2024 02:39:27 +0000
Date: Wed, 5 Jun 2024 03:39:27 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC] possible way to deal with dup2() vs. allocated but still
 not opened descriptors
Message-ID: <20240605023927.GW1629371@ZenIV>
References: <20240605022855.GV1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605022855.GV1629371@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 05, 2024 at 03:28:55AM +0100, Al Viro wrote:

> 	Current solution is to have dup2() fail with -EBUSY.  However,
> there's an approach that might avoid that wart.  I'm not sure whether
> it's worth bothering with - it will have a cost, but then it might reduce
> the pingpong on current->files->file_lock.

Gah...  Nevermind, that benefit is no longer there (and I really need
to get some sleep - only went "wait a sec, that lock hadn't been
taken in fd_install() since way back" after sending)

