Return-Path: <linux-fsdevel+bounces-51799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FACADB984
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 21:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502DE189077D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 19:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9938A289E14;
	Mon, 16 Jun 2025 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="F9EPORtD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56DB1D9346;
	Mon, 16 Jun 2025 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750101993; cv=none; b=VcezIg1oEjP0wY1BHWwdvK/+lwy2Kzhul2CUIplp7WBKG8OfcdsApWOHpRUECS7q0hlN+YRFi/LzIAs91yukkqt3WBntsoOf/iPHkqO0772+uoRiUGxttv9V2XDMTKLpvq0LvYacTaoO8uYTMk7HYr49Orbxr6b/Q/S6yezEvj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750101993; c=relaxed/simple;
	bh=MnzhXC229opggvjo3K/cUWOEA0U7OHCZ5sQe3zrO4Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuZgBYuzP7YbmOakfBdeZfGhxp0MSLwUutCxJlhqmMgijvAg4p15ROr5VOCUh4QgaeDwAf9fYabnplUhyVrX3DriBsAqTdy3nBDgZdMK+cyzGYSeoydaq29VcqKR7A9+eIfAnf3uFAEN16twWKsJKJEKP8BesmiVZ3+Qj0kbX+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=F9EPORtD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KT7dHJJ5pKmkNCduZTf91EBdEW9hu3YfWg2JZORC++o=; b=F9EPORtDatoDok2FTq3vKCpOT0
	S60V/pkGiFOE456RKh0ahM4mQja7ooc3ligfvndoXH50rzh+NGnE8P1QHltWM0bbGmUlzAEFusWhB
	bx33xQ13GwNfC0y8edMtMFW32GgDA8UEdwGTd+JQ6b9UnRdkTUsJN8qCYku711EN2So2Ftgj3mvrG
	m1TTkFmRkayHcIMJRtR4kjDHIJtuy7VzIIXR/jeFqC4Bbev8SH94NkhZ6TNwU4I8I3PDWtO+IP/Ma
	/KuToR5H5bAFbBnpBjPjhzW6fVvNy+uSWIg+6vuLBUiwE2rrtGbgTu+9sMALMPgjp+yzZrUZxEq6O
	1UU+ULVA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRFTQ-00000001hRA-0laZ;
	Mon, 16 Jun 2025 19:26:28 +0000
Date: Mon, 16 Jun 2025 20:26:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, chuck.lever@oracle.com,
	linux-nfs@vger.kernel.org, neil@brown.name,
	torvalds@linux-foundation.org, trondmy@kernel.org
Subject: Re: [PATCH 12/17] rpc_mkpipe_dentry(): switch to start_creating()
Message-ID: <20250616192628.GJ1880847@ZenIV>
References: <20250613073149.GI1647736@ZenIV>
 <20250613073432.1871345-1-viro@zeniv.linux.org.uk>
 <20250613073432.1871345-12-viro@zeniv.linux.org.uk>
 <6ccc761034c253704988b5a7b58d908e06127a9f.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ccc761034c253704988b5a7b58d908e06127a9f.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 13, 2025 at 03:27:39PM -0400, Jeff Layton wrote:
> On Fri, 2025-06-13 at 08:34 +0100, Al Viro wrote:
> > ... and make sure we set the rpc_pipe-private part of inode up before
> > attaching it to dentry.
> > 
> 
> "rpc_pipe->private"

Nope; fs-private, if anything.  That, or rpc_pipefs-private...

> nit: subject should say  "...switch to simple_start_creating()".

D'oh...

