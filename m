Return-Path: <linux-fsdevel+bounces-77783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPk6JbMymGleCgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 11:08:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36131166AB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 11:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67A15300832B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 10:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF211337B8C;
	Fri, 20 Feb 2026 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CFE1givt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FDE337B9D
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582126; cv=none; b=jtUXONnqSE5X0EKIlZyQL0T42OThffHkjwlz7i4VNcN8VBlTaIybszZ01Qn4aTIcUyN6oaulMGtRBV4uwiygx3OhLoD8aL9uVLwoFRUkxDorMviSDSvf3jkmof5XtSa4sYuEMCuvNj8n5r1LDYS6LB8+ZKycebfOrdO06/sctoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582126; c=relaxed/simple;
	bh=XWwLHdUyhebPJACVUV6EjAM44WQ6O69L/5Jw/JN/wh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GakMz/7iG1jhB/rfxLIHm2tm6TCgCj4sIkNH4buFA+R+A1jNBsZLPppGjNOBf1nujUOruRnxUljerPk724yFVArKQSvEYFCszzX0dtZ4fHdOorIeQX8DMIxa16fLLB3lRhQb9QtzeQEw6XjzO7whEmgsqN6fOHBVGd6n5PbPyKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CFE1givt; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 20 Feb 2026 10:08:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771582110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8tDGJbI5FE8OyurRsiUKK7fUsDEFmbQate1+4YcD99o=;
	b=CFE1givtQqWIkgpUoykKYf0ZibeD6kxuIu8KPMJi1urMTEkYxiL9t1mA+WjPJ8a6ISnluW
	Ao/a0OlZC18fs3Z6PaadaAOCuz4G5ccBYj5MfPeRgP0vkjoVCwbXh7QjwFRtOsl5HjN+JB
	thrd5F8gIpvJ0cY6Um/Nw+s4dSzcgjg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org
Cc: Andres Freund <andres@anarazel.de>, djwong@kernel.org, 
	john.g.garry@oracle.com, willy@infradead.org, hch@lst.de, ritesh.list@gmail.com, 
	jack@suse.cz, ojaswin@linux.ibm.com, Luis Chamberlain <mcgrof@kernel.org>, 
	dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>, gost.dev@samsung.com, 
	tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <sjuplc6ud6ym3qyn7qmhzpr3jzjxpf6wcza3s2cenvmwwibbxr@aorfpiuxf7qy>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77783-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pankaj.raghav@linux.dev,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[anarazel.de,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,suse.cz,linux.ibm.com,redhat.com,samsung.com,mit.edu];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:dkim]
X-Rspamd-Queue-Id: 36131166AB3
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 11:20:36AM +0100, Pankaj Raghav wrote:
> Hi all,
> 
> Atomic (untorn) writes for Direct I/O have successfully landed in kernel
> for ext4 and XFS[1][2]. However, extending this support to Buffered I/O
> remains a contentious topic, with previous discussions often stalling due to
> concerns about complexity versus utility.
> 

Hi,

Thanks a lot everyone for the input on this topic. I would like to
summarize some of the important points discussed here so that it could
be used as a reference for the talk and RFCs going forward:

- There is a general consensus to add atomic support to buffered IO
  path.

- First step is to add support to RWF_WRITETHROUGH as initially proposed
  by Dave Chinner.

  Semantics of RWF_WRITETHROUGH (based on my understanding):
  
  * Immediate Writeback Initiation: When RWF_WRITETHROUGH is used with a
    buffered write, the kernel will immediately initiate the writeback of
    the data to storage. We use page cache to serialize overlapping
    writes.
  
  Folio Lock -> Copy data to the page cache -> Initiate and complete writeback -> Unlock folio
  
  * Synchronous I/O Behavior: The I/O operation will behave synchronously
    from the application's perspective. This means the system call
    will block until the write operation has been submitted to the device.
    Any I/O errors will be reported directly to the caller. (Similar to Direct I/O)
  
  * No Inherent Data Integrity Guarantees: Unlike RWF_DSYNC,
    RWF_WRITETHROUGH itself does not inherently guarantee that the data
    has reached non-volatile storage.

- Once we have writethrough infrastructure is in place, we layer in
  atomic support to buffered IO path. But they will require more
  guarantees such as no short copies, using stable pages during
  writeback, etc.

Feel free to add/correct the above points.

--
Pankaj

