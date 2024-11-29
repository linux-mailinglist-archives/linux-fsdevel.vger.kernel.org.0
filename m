Return-Path: <linux-fsdevel+bounces-36137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140409DE699
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 13:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFEBB164C98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 12:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DC6199934;
	Fri, 29 Nov 2024 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cw89ivNw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B902A155352
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732884097; cv=none; b=Mh0ibONjxq+sDDe9dvk//s8GxzXFrYG6W3mt8MqjIZhpqgei5/VtQeq59s8cQzGl1ez4JkYU6b8hipF6jj77wx0lbu2C6qN3tMKtvWCKgi72HKXv789L8aJr+ZE8rFeFaAzP9jAJb2hRF66uUNP20aNspqD8qBzUC719Hk8aNKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732884097; c=relaxed/simple;
	bh=/5hkHpGXIRPZIGRYrzi9fORbfclpImv7n31LW92dn5U=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Epbm0NKFuJwW1hhF5ThO6sdbfit1f/CzPgmqnwbXE0JNdMA6/D1aTzO+XKoeuziQcTFK7dKrIuG1N98lnu+omJUhIqXN92GhGE5VOpHO9m22ZAoHIc8f1K6afAWEIX4A77ckXc+47G7uzGrQNRyHZOqNjvGmZQ5xvvjsatIs8Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cw89ivNw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732884094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRkQ7caS5vjHyMGGRL+u1PZKOEaI3catRgsdocSqOXY=;
	b=Cw89ivNwibNW/rfK7d1J1dON8bSkfqy51Hd+c3uvmGLlmYJqHsDd3ztPDMtUWhbQU9SVG0
	uA7EfGQ8jE8GUaSows9QtLAbE9uaaTKtbldrviZvIMpp3wfAosJ0FK1AD+K2l38PQEnD+4
	EpndUAypxFDwbjNVNuaAkPONNlifO7o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-sMpMOHflNWmnyAF14Y2mUQ-1; Fri,
 29 Nov 2024 07:41:31 -0500
X-MC-Unique: sMpMOHflNWmnyAF14Y2mUQ-1
X-Mimecast-MFC-AGG-ID: sMpMOHflNWmnyAF14Y2mUQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 690E819560AB;
	Fri, 29 Nov 2024 12:41:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B625230001A2;
	Fri, 29 Nov 2024 12:41:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
References: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    netfs@lists.linux.dev, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
    linux-kernel@vger.kernel.org
Subject: Re: 6.12 WARNING in netfs_consume_read_data()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3990749.1732884087.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Nov 2024 12:41:27 +0000
Message-ID: <3990750.1732884087@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Max,

Could you try:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dnetfs-writeback

I think the patches there should fix it.

However, as these aren't making it till the next merge window, I'll try an=
d
work out an interim fix.

David


