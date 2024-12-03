Return-Path: <linux-fsdevel+bounces-36325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC1A9E1A56
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 12:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF709162105
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 11:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776181E3787;
	Tue,  3 Dec 2024 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECcsYzFi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D931E32D4
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223997; cv=none; b=mX13eSD0+ppPEDekaPbiKVKGRURufYMMsAOzc6JBYXltxJ4aAPkQ1D1G6CZ8mBUUjvyfq//HYpGw7UXV4kGFAulGp9d1Ew7/oTd7tqPrYSpMnLaPOl2HmsEjjPKXcR6shjisu0T94NOjjTb4pCmzKcNJJ2m+ozaYl8Hju+vnkEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223997; c=relaxed/simple;
	bh=lxfOJRXrxx+dWakvC8EvzMH3A8aZbAED2kDuKY05gH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0r7xiZT0xie8NX06QftEX2ARDjkMtA/nHKyLB23Gc3unRNkJXvJgvrZFRkpj8MIF/vR3/2wqVBGTd9N+nkf52nITrxqow+wkeZty0WH9C7i2gH/M0MbXFM26WXcAPcaz877pvxyw++rOAHjnUHGCExdaphC8NTZPpfVdZzY8gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ECcsYzFi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733223995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m4FIF9gw1EICHUD5qSyfdnNpzFIEsgWGAfP35Vi4oC0=;
	b=ECcsYzFiPgiM4oiIMaIHYVj4uzbkAq1dogUcAO4Zfabpl0/kINOLu2+dW9Mlnmf6Zqur58
	z4ZV72etekgvgLpE877EbCoJ8zRN+P9tQSwey7khQs8vfjxwBsRSISuLJnh9zgKNMn5tX0
	RavApHaVt/6Kk20c+ZYMEkboNWf/Sb8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-IAyWHCF9M3yZ0jtKZRjILQ-1; Tue,
 03 Dec 2024 06:06:31 -0500
X-MC-Unique: IAyWHCF9M3yZ0jtKZRjILQ-1
X-Mimecast-MFC-AGG-ID: IAyWHCF9M3yZ0jtKZRjILQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B919195608B;
	Tue,  3 Dec 2024 11:06:30 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 487721956052;
	Tue,  3 Dec 2024 11:06:29 +0000 (UTC)
Date: Tue, 3 Dec 2024 12:06:25 +0100
From: Karel Zak <kzak@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jon DeVree <nuxi@vault24.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] 2038 warning is not printed with new mount API
Message-ID: <l3mzxqp47r73ovsxiok24whdaxd7ddgtsnil5jvbp3fbmq3vyw@i7f45urzlnko>
References: <Z00wR_eFKZvxFJFW@feynman.vault24.org>
 <20241202-natur-davor-864eb423be9c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-natur-davor-864eb423be9c@brauner>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Dec 02, 2024 at 12:55:13PM GMT, Christian Brauner wrote:
> libmount will log additional information about the mount to figure out
> what filesystem caused this warning to be logged.

I will improve the functionality of mount(8) by adding extra messages,
including information when the --verbose option is used and warnings
by default. However, I do not think the kernel should rely on this.

The kernel log is valuable for post-analysis and archiving, and there
is no reason to modify the logging in the new API.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


