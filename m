Return-Path: <linux-fsdevel+bounces-78260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDHCGUCjnWlrQwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 14:10:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F8F187681
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 14:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30C2A300BE17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 13:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A2A37D11B;
	Tue, 24 Feb 2026 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vBUnboDs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4642A18DB26
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938618; cv=none; b=DxlTQp+eUK0a6AjHfOBGmAoFEq5Uy/a2vw9REUexEYco6Fmi0zVi3ecRmJSyMw3Az9EHwbVcoymP6OgGHunBXPQJNaIa/90nd6l0HmHrvlm5dhW/hAsltsZAo+GbTvoINZGkV/SQyunUKR7TkAoozXgoWWYukZD1LEAdTEm6nI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938618; c=relaxed/simple;
	bh=KRyQEqdx9nDxD05wNjoY0C4vqHurq7T/UtjpGKJqkio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYRnc2eXIu1sQyGR1BogUzgY97xPJEC6s+D4uCwzr+mQpOa+1IxsHgK4NKuEPWXdZMqokxEocOVN7ADr5Qso1io8iAHr1kVcUm4wKzXLUFRRyxQsTmtKrAo+pXkBoHZMBJrwIwz93Wg3r8hf1kRzcKS0nIoDp5ONjsaFxSYX+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vBUnboDs; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 24 Feb 2026 13:09:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771938605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iHmLfEoIM1CK3zmKD5Au1dNJD5+SaRgc7xYd5V7yZqE=;
	b=vBUnboDszDrSTC7QiGdYqXIqUsnhzZtkBEA7USdkiADpAfHtm6T9DfjxqFbBXytJE/L6tf
	VArkOf8r/dQ6ACwRXGLIXwSKcO5/2Ce6K7WlXo7QHh9xSLKOPcT0T9ZXHVvQDlVPSJhahv
	JWl83yCyyqPB8h4ZtUK0L5NzrygQuY4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	Andres Freund <andres@anarazel.de>, djwong@kernel.org, john.g.garry@oracle.com, willy@infradead.org, 
	ritesh.list@gmail.com, jack@suse.cz, ojaswin@linux.ibm.com, 
	Luis Chamberlain <mcgrof@kernel.org>, dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>, 
	gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <rn5qoix7rattqns5ut7q6wmasjm4x3usfbh5x4e7yg22fzpiqt@744cbmehelmt>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <sjuplc6ud6ym3qyn7qmhzpr3jzjxpf6wcza3s2cenvmwwibbxr@aorfpiuxf7qy>
 <20260220151050.GA14064@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220151050.GA14064@lst.de>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78260-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pankaj.raghav@linux.dev,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux-foundation.org,anarazel.de,kernel.org,oracle.com,infradead.org,gmail.com,suse.cz,linux.ibm.com,redhat.com,samsung.com,mit.edu];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:dkim]
X-Rspamd-Queue-Id: 82F8F187681
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 04:10:50PM +0100, Christoph Hellwig wrote:
> On Fri, Feb 20, 2026 at 10:08:26AM +0000, Pankaj Raghav (Samsung) wrote:
> > On Fri, Feb 13, 2026 at 11:20:36AM +0100, Pankaj Raghav wrote:
> > > Hi all,
> > > 
> > > Atomic (untorn) writes for Direct I/O have successfully landed in kernel
> > > for ext4 and XFS[1][2]. However, extending this support to Buffered I/O
> > > remains a contentious topic, with previous discussions often stalling due to
> > > concerns about complexity versus utility.
> > > 
> > 
> > Hi,
> > 
> > Thanks a lot everyone for the input on this topic. I would like to
> > summarize some of the important points discussed here so that it could
> > be used as a reference for the talk and RFCs going forward:
> > 
> > - There is a general consensus to add atomic support to buffered IO
> >   path.
> 
> I don't think that's quite true.

Ok, s/consensus/some consensus/ :). I do get your concern that buffered
IO might not be a good fit for doing atomic IO operation (I also
mentioned that in the proposal).

As you replied, either direct IO or writethrough semantics might be the way
forward. That is why I mentioned the first step is to do a prototype of
writethrough and see if adding atomic support on top will make sense for
the buffered IO path.

-- 
Pankaj

