Return-Path: <linux-fsdevel+bounces-69868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 509AEC88F3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 10:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14303B558C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 09:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A15315D32;
	Wed, 26 Nov 2025 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvVg+JQT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB862D6619
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764149365; cv=none; b=bQ05ZnTrelHA0+B7eL2HOzE3yXS0vmbj+5Cgk4nhQ3YwZ78Dfm/ldrMDNgbc3682KXvRxWBXhrs+/LiP4W30YdsD3a5Ypw5mujCcNWQgmupZNnNXebLpTzVNNCv8ZLubU3ovFr/gPeXbwSzNwhE++pTETsSIHPTFwRCpn1/KiCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764149365; c=relaxed/simple;
	bh=XEgbhasiEpSms0h402RHZvPDr5E5khBsLB1SqkusMcY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=uKHhIqBD6ZQsIKLlWhro0eVuIBllEX/0PEoGJ9eGaRYzTES3Z4Zui4hdTEsquUJyUHAczE07kWbLd9i/jRSLfucSdoANDlDYxYlOAC9a5dLYFoUc9iXzE7XKbuW2xLUEFPK785hB3GrfCKcPAX6l5GLpKFGtFYdRFdalWD9gBZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvVg+JQT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764149363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+aY+5ew8rcXS+xACgTbpXJmyaLs/YT49cWfbDySIt4=;
	b=DvVg+JQTYfb8qeuU6FWPDj7FuR3eoWgsM8Rx05PZQHT8fgLZUtCSD/SFnWdIPUw+xrXSM2
	bdR4ejp9q/KHMqHk/vlWdLS4hkla3HdgYfrEld+Rj2gug1k9RLjPZbXBGFrV6vNj+ikwsS
	37pIc7sgqzOfg7lOHOXNEcnJ5lfMKlc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-j7Mb_VQhPOmR4Wu3kWLr7A-1; Wed,
 26 Nov 2025 04:29:18 -0500
X-MC-Unique: j7Mb_VQhPOmR4Wu3kWLr7A-1
X-Mimecast-MFC-AGG-ID: j7Mb_VQhPOmR4Wu3kWLr7A_1764149356
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A894F19560BD;
	Wed, 26 Nov 2025 09:29:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2435919560B2;
	Wed, 26 Nov 2025 09:28:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20251126025511.25188-2-bagasdotme@gmail.com>
References: <20251126025511.25188-2-bagasdotme@gmail.com> <20251126025511.25188-1-bagasdotme@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: dhowells@redhat.com,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Linux Documentation <linux-doc@vger.kernel.org>,
    Linux AFS <linux-afs@lists.infradead.org>,
    Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jonathan Corbet <corbet@lwn.net>,
    Damien Le Moal <dlemoal@kernel.org>,
    Naohiro Aota <naohiro.aota@wdc.com>,
    Johannes Thumshirn <jth@kernel.org>,
    Andrew Morton <akpm@linux-foundation.org>,
    Dan Williams <dan.j.williams@intel.com>,
    Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
    Daniel Palmer <daniel.palmer@sony.com>
Subject: Re: [PATCH 1/5] Documentation: afs: Use proper bullet for bullet lists
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4103078.1764149334.1@warthog.procyon.org.uk>
Date: Wed, 26 Nov 2025 09:28:54 +0000
Message-ID: <4103079.1764149334@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> The lists use an asterisk in parentheses (``(*)``) as the bullet marker,
> which isn't recognized by Sphinx as the proper bullet. Replace with just
> an asterisk.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: David Howells <dhowells@redhat.com>


