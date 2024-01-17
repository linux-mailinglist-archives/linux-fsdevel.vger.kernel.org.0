Return-Path: <linux-fsdevel+bounces-8179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DD7830AEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 17:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B561C268E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 16:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF07224C8;
	Wed, 17 Jan 2024 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbkJjw+O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1040C219F6
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508469; cv=none; b=ZZshxQZSFINh8mOGOGkjopAZ1/lgZlqmutO+Rg+7Z2OAjS16PQ2QAIUkusjoU/fKiRQDeDtQsv2rZLktqr3JrNMI/0RBi4zAMGU0NORnT2yUKwxgS2oyXqBUDIjIiXo1V/dwA8O8T6dFifw0iyFAP4nklu6talnrGXXJxZR8ens=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508469; c=relaxed/simple;
	bh=flbXHwDCTp+j6stWsTGEWwJGNNEZkTEfymW8XvfG8QU=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:
	 Organization:From:In-Reply-To:References:Cc:Subject:MIME-Version:
	 Content-Type:Content-ID:Content-Transfer-Encoding:Date:Message-ID:
	 X-Scanned-By; b=EEdjvRB/Sm14UYCMMj700GZXyHMgYpwq/s/ddbRnAX1ZXoOLtFhhjledXn4gOq+nVwln8XpfKLLeZn2iobsXaaN5eCx5KjNRUlvDT9uM9dIzRSvUKNiFnYcZqdY8qZrrQouzj3T1fTxTDvtCOdBMJ0NzZHHPoNUj6WadKRoJ4vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KbkJjw+O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705508466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=flbXHwDCTp+j6stWsTGEWwJGNNEZkTEfymW8XvfG8QU=;
	b=KbkJjw+O9NUpd2Y+fzNf47ID31HSoVyH8vNl4EQg7pw2ZBT/N35EDbGfJL3tzSH7DYdk0z
	PXwxhFLD9uXCRf6IPWC0Z0nlqIn327UQvF8kEMsChPgYrJIM53nom2fUnUFZe19xqVfEhH
	YvHYC8fl7KLmCT66qUCB0nfyIk31TsI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-qCUP_KtoMCmRpnD6WO-2jA-1; Wed,
 17 Jan 2024 11:21:04 -0500
X-MC-Unique: qCUP_KtoMCmRpnD6WO-2jA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5AF038149AF;
	Wed, 17 Jan 2024 16:21:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2B2EF2026D6F;
	Wed, 17 Jan 2024 16:21:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2929034.1705508082@warthog.procyon.org.uk>
References: <2929034.1705508082@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix missing/incorrect unlocking of RCU read lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2929562.1705508462.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jan 2024 16:21:02 +0000
Message-ID: <2929563.1705508462@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

David Howells <dhowells@redhat.com> wrote:

> In afs_proc_addr_prefs_show(), we need to unlock the RCU read lock in bo=
th
> places before returning (and not lock it again).
> =

> Fixes: f94f70d39cc2 ("afs: Provide a way to configure address priorities=
")
> Reported-by: Marc Dionne <marc.dionne@auristor.com>

Actually:

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202401172243.cd53d5f6-oliver.sang@i=
ntel.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-afs@lists.infradead.org
> cc: linux-fsdevel@vger.kernel.org

David


