Return-Path: <linux-fsdevel+bounces-13903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D66875455
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 17:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714511C23CF9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 16:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B744412FB15;
	Thu,  7 Mar 2024 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSlPhJwp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3E81BDDB
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829652; cv=none; b=OYtMIJZE1d8j6SZupgG/m6BQlHxlJrCP0cNgbgQAxVEUm1eX+V6OgmptLNVsjEbypWwnN6K6jnEdugbIZZjKcV9dpMFAPs2QeirniBFhMXLX9YKN/iwS3EY07POZML20L5aIR1AYwk/NeNCPczTO+6QgVSrX30J3riVKvGwsDVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829652; c=relaxed/simple;
	bh=pzMJaJ5QQvtbDFrZkd0r1OvRpiDHiAhrEioioZW9pMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oABeKZaUfq+Q/8H4WsLsG6QrI+C5DE1AO6tGtCkwZ49tZbsJzhi4F33QbJgoCYCX0BDePqt2RtaluKvUYS+tESCW6FCUZqFsH1iQK9JkL3wPS/vqQiu/xCiyYchfXvsQsI7JPHhxH5KEUOT8eqMt3Ji9yNEY1Xw2ubsuFMTbjqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JSlPhJwp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709829649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8m0BB8GbJicO+v/bNKGCN/mpdDM+ErTBhNQ0VHkx4js=;
	b=JSlPhJwp/ischuOJ6hjE8Y8LBs1yerHn4/kAKEg4frlvIMVfnQ1ypEdoUZm3DJNRZBDR7N
	/ECuuzoAqsXv8+zNX//XJ3oCwCradzn7ocjxrig84asbTTikhJ5b/dlLn840J+fR0MhP3s
	zPMPF6MT8py2Bp8APAcadiz4zomJttE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-T1by4vRNMgClHIzdtQlidg-1; Thu,
 07 Mar 2024 11:40:46 -0500
X-MC-Unique: T1by4vRNMgClHIzdtQlidg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 781AC28000BE;
	Thu,  7 Mar 2024 16:40:42 +0000 (UTC)
Received: from redhat.com (unknown [10.22.32.76])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BA7040C6CBE;
	Thu,  7 Mar 2024 16:40:41 +0000 (UTC)
Date: Thu, 7 Mar 2024 10:40:39 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, sandeen@redhat.com
Subject: Re: [PATCH] minix: convert minix to use the new mount api
Message-ID: <ZenuBzrEXGseZ_fI@redhat.com>
References: <20240305210829.943737-1-bodonnel@redhat.com>
 <20240305212950.GA538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305212950.GA538574@ZenIV>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Tue, Mar 05, 2024 at 09:29:50PM +0000, Al Viro wrote:
> On Tue, Mar 05, 2024 at 03:08:18PM -0600, Bill O'Donnell wrote:
> > -	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
> > +	if ((bool)(fc->sb_flags & SB_RDONLY) == sb_rdonly(sb))
> >  		return 0;
> 
> This is getting really annoying - let's just add
> 
> static inline bool fc_rdonly(const struct fs_context *fc)
> {
> 	return fc->sb_flags & SB_RDONLY;
> }
> 
> and spell the above as
> 
> 	if (fc_rdonly(fc) == sb_rdonly(sb))
> 		return 0;
> 
> etc.  Quite a few places have that open-coded...
> 

Thanks for your review. I sent a v2, but I'll treat the suggested change
to fs_context_core_code separately.
-Bill


