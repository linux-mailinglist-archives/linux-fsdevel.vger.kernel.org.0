Return-Path: <linux-fsdevel+bounces-63188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95515BB0AC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 16:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515072A45D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 14:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E061254AF5;
	Wed,  1 Oct 2025 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AILS6Cd7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BFC248F57
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759328382; cv=none; b=pPA8hnJkwBh2/Kpfc/WLiR3JPMIIfHsxnerLppkro36aLZzBkAt3Y58HcDBCejW94wKdCtPtZrnAvheOSfZWZCP2+/lj3B9PJqJXzKYHyT6kx0+jetrxNFIWapl+AZK1tJZY70LegjmubR7kL8WRj3CGPqkJkbt0jPJDebfrwb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759328382; c=relaxed/simple;
	bh=G/jjU2TfIOrHy8eHO94iP3qPgO2EprU2mJD/htT6HG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKD/3Zo3l95Y89mlKCTYC9ZrmwNWND/4f6PZRcU6ek88QbxgyJJwsar7xN7JRNRhbU6lOF+90RcvSGsjzKKPCb7qN03QAa58e9kLoll/b7x+MF2CT3L7fjbCVIREjmnK/CPTvp2dCqjfP7z1A1NHGh8ivkC0kU911cpLFiLZIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AILS6Cd7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759328380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=th22CVHHRF16+pDNVIT1p3bZ2phIhHgtEHYs26Cgu1M=;
	b=AILS6Cd7ooh3tvH+swrOCLvzkBa3Az8Cf38LfGCQARxjf6oLL9AcJLNR4IrDuRgutP5wIQ
	tlWLSjGwP5FWVimkCo7wq6q5DE858qHg/Jl7h3Wj5rwBFkitLaxXsWY2R8sP/PdgKSC29G
	w6fNzr39MsjhGvMtfuoJg+LX5QH5aec=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-Sfqu8UdUMKSobrlY-eucpg-1; Wed,
 01 Oct 2025 10:19:38 -0400
X-MC-Unique: Sfqu8UdUMKSobrlY-eucpg-1
X-Mimecast-MFC-AGG-ID: Sfqu8UdUMKSobrlY-eucpg_1759328377
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90A26180057A;
	Wed,  1 Oct 2025 14:19:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3474919560B4;
	Wed,  1 Oct 2025 14:19:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  1 Oct 2025 16:18:15 +0200 (CEST)
Date: Wed, 1 Oct 2025 16:18:12 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [GIT PULL 05/12 for v6.18] pidfs
Message-ID: <20251001141812.GA31331@redhat.com>
References: <20250926-vfs-618-e880cf3b910f@brauner>
 <20250926-vfs-pidfs-3e8a52b6f08b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926-vfs-pidfs-3e8a52b6f08b@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/26, Christian Brauner wrote:
>
> Oleg Nesterov (3):
>       pid: make __task_pid_nr_ns(ns => NULL) safe for zombie callers
...
> gaoxiang17 (1):
>       pid: Add a judgment for ns null in pid_nr_ns

Oh... I already tried to complain twice

	https://lore.kernel.org/all/20250819142557.GA11345@redhat.com/
	https://lore.kernel.org/all/20250901153054.GA5587@redhat.com/

One of these patches should be reverted. It doesn't really hurt, but it makes
no sense to check ns != NULL twice.

Oleg.


