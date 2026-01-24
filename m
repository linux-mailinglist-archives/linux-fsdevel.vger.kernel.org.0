Return-Path: <linux-fsdevel+bounces-75338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iORKG54kdGn/2QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 02:47:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0C97C025
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 02:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93DFF301AD05
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 01:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14516199920;
	Sat, 24 Jan 2026 01:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="DQl0aiyh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F8D27456
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 01:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769219226; cv=none; b=MGXx4s1zVDqQL2wQ3jt2Mp2cOS5OMleCSLLDssBjcLHdBKiRUSTjLls/pA576hej60YYe7Csya3Kzkq4lRtpQi7HwdUSkTwktAVC4TW54lb+a6wNKF+yWuK+GggOfGfhueraWy4tCKxhaF4nbjbXFrocmjlXcBSfL5cszhPgETM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769219226; c=relaxed/simple;
	bh=y0NvhWFLXq+98kpflMEM8llVFKpYdLD5nvpgayTqbqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpoxJ6aIilE+y37z6BemyZA387grgvVy32+VUD6SMIiXBsAViWwc637a4v4bglpWQPby9BkZf3KRGY4PN+oCro8Ew8dJ+CM0ePPTJGt/uKIETrhV2k96q4SxHexZzlOejPf226cJBXEf1+r2OZLTLX5MvFTRS6Id+d0ZyCQpaW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=DQl0aiyh; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([193.36.225.251])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 60O1kd8W016618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 20:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1769219206; bh=XdScpqUnVSUlHqO0WX62t5zWNepy398qlpb842alAPQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=DQl0aiyh5abU4cBp/KWW7QcsfolC/QxhQHaeWH67tOynkVZyXGAtzk2fNeaf9iRUg
	 EhFqNeLFYw49HeUrpuJ7QSn6DqnSE4v+MWDTpwi9gaiN3OvbaMvErinKUS/CkBz7rA
	 rZyl9SYumgwU5Ak//N91divI1g311QBiUCjA6xzdnzczf6xhrG8TOyhIrcZtsuRKZk
	 Vbpogyr5a0nhJuaKh0h8kWVKND2cbRVk9jEe116sHV/WcwPRunwgs25M9m+vrKf1LD
	 vA5MK4BAXk5gDfoRT9QJOL3vddqsPET++W5FnlFa+dEEa89u0la7z62meJbyPMUyHm
	 4b3+CWdTxNOFA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 1CEF355EB1F2; Fri, 23 Jan 2026 15:46:38 -1000 (HST)
Date: Fri, 23 Jan 2026 15:46:38 -1000
From: "Theodore Tso" <tytso@mit.edu>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "konishi.ryusuke@gmail.com" <konishi.ryusuke@gmail.com>,
        "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>
Subject: Re: [LSF/MM/BPF TOPIC] Is it time of refreshing interest to NILFS2
 file system?
Message-ID: <20260124014638.GH19954@macsyma.local>
References: <8e6c3a70db8b216ab3e9aba1a485de8e6e9db23d.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e6c3a70db8b216ab3e9aba1a485de8e6e9db23d.camel@ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-75338-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux-foundation.org,vger.kernel.org,dubeyko.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[mit.edu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,macsyma.local:mid]
X-Rspamd-Queue-Id: BE0C97C025
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 11:15:08PM +0000, Viacheslav Dubeyko wrote:
> 
> Fresh Linux kernel guys always ask how they can contribute to Linux kernel and
> many guys are considering the file system direction. NILFS2 is viable direction
> with plenty opportunities for optimizations and new features implementation. I
> would like to deliver this talk with the goals of: (1) encouraging fresh Linux
> kernel developers of joining to contribution into NILFS2, and (2) convincing
> open-source community to revive the interest to NILFS2. I believe that NILFS2
> deserves the second life in the world of QLC NAND flash and AI/ML workloads.
> NILFS2 is part of Linux ecosystem with unique set of features and it makes sense
> to make it more efficient, secure, and reliable.

I wonder if this might be better fit for the Linux Plumbers
Conference.  The LSF/MM/BPF is workshop is a invite-only workshop
which is focused on discussions, not talks.  If the target of your
talk includes "fresh Linux kernel developers", it is unlikely that
there will be many at the LSF/MM.  They are more likely to be at
Plumbers, which will have roughly an order of magnitude ore attendees.

	  	     	  	     	      - Ted

