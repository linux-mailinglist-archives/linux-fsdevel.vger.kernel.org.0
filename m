Return-Path: <linux-fsdevel+bounces-17249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7708A9B54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 15:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E24E1F23189
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 13:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274921607B1;
	Thu, 18 Apr 2024 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1rEpiXj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4652B15FD07
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447178; cv=none; b=AlVHmaPKL4FoM2J7HUZczamDtSAHDDrfv05BMA0Ys8GZPTGjM8DtXkWHO7N2wiyyseYeHWT5YlS6Rn+1/y0zlTsC/Lva/WyastbgbtiHtctbWrbQlcZxl89hRAe/AshdW5pwahoMBOfHErACKDoCCTP5olJcrhV8CGfHq598PLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447178; c=relaxed/simple;
	bh=TfYtJDHbPf2euigtbi87wfK7vPE3w18UUyGJQIHIFVs=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=sOwmMrCc792uNOMfcQacrxERvbkackakRLDLKyk6WEmEukmiJG900oMXf/a/nWhHzBpVFkUuDDbCatssno4381dPQzMhU0/G9GceEk46gxbfDqhieUuznp6HJfo+bKTMaGqZ3I9aqOFbsNhwC4ignsY/K2ih3aWTrBpIdfrdCvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B1rEpiXj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713447176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TfYtJDHbPf2euigtbi87wfK7vPE3w18UUyGJQIHIFVs=;
	b=B1rEpiXjIr+wrx7cjE+p63Fx7Na7VV4Atqum//XBbLinZnY8sPmnXSetkWkYy/QVrFPxqT
	rpuY4L9CTC90Jjl29XojvfTsTJO54nwpC303w8BAKNVge+DfZUodcQPCgRiybA9TDwkUJT
	BTsZymyeeAA02LwroETsbDioPKpChIg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-67BLzES1NHGrSehYlCfHCQ-1; Thu, 18 Apr 2024 09:32:52 -0400
X-MC-Unique: 67BLzES1NHGrSehYlCfHCQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A848834FB8;
	Thu, 18 Apr 2024 13:32:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0019A1121312;
	Thu, 18 Apr 2024 13:32:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <e33d0b65-fc0b-49ab-ba48-7a13327d88aa@talpey.com>
References: <e33d0b65-fc0b-49ab-ba48-7a13327d88aa@talpey.com> <1a94a15e6863d3844f0bcb58b7b1e17a@manguebit.com> <14e66691a65e3d05d3d8d50e74dfb366@manguebit.com> <3756406.1712244064@warthog.procyon.org.uk> <2713340.1713286722@warthog.procyon.org.uk> <277920.1713364693@warthog.procyon.org.uk>
To: Tom Talpey <tom@talpey.com>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.com>,
    Steve French <sfrench@samba.org>,
    Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix reacquisition of volume cookie on still-live connection
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <554984.1713447170.1@warthog.procyon.org.uk>
Date: Thu, 18 Apr 2024 14:32:50 +0100
Message-ID: <554987.1713447170@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Tom Talpey <tom@talpey.com> wrote:

> The tcon is a property of the SMB3 session, it's not shared nor is
> it necessarily created at mount time.

Trust me, it can be shared between superblocks.

David


