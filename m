Return-Path: <linux-fsdevel+bounces-74061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCE7D2CD49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 07:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 939E4303B468
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 06:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA7F34F270;
	Fri, 16 Jan 2026 06:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4AWN4t+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A17B34EF1B
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768546751; cv=none; b=SZ1mq7m3QWofg6kMN5bUGSzPb1fXZf6855Bu0k1lqYWvPDC/jXSye3A3qRQRf8eBnu+yYN2gGGjkZq9ativEz56YnmlwpzXIW/97iIp3CYblUYm5NndO3rkHeO6MyGJ7H9pCw1XGBnXp/cDnzLxzbAn+WwQY0NunQ4q3425Yjb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768546751; c=relaxed/simple;
	bh=pU+GJFAcqJqr/C81QZBW+yPDoC1/fnZdRkamwDS/s5Y=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=N3cUumIEjjcaRYgZslUjzq5o2E+N4uwfajqpLFKoaOmC+pqR+TyTPSPeeG/wyb+EEesVUFfSp2PGdXlTMlvEg4WxZH/ELIQYsRwIkYl63QpZNzDmOb2HJXCaISDlw7iCHVgjRcz5LTJHWvxbIFWrAfUDiMe8b6YV9kgMzL5QlCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z4AWN4t+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768546748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YaiNwVLbrz2KTYbOSTVWyY04sbTALdHVVqyWzgDlXC4=;
	b=Z4AWN4t+Du/d4YVVGVrA6ltEnjJzqzLTLDmKAVSM0MgexsTHZEvfRdy5yXGTn86q/6Pb6N
	LzKj+gLvNDfvQWI4CSHrxpNqa3/dkJY850xWdqXKia9CLQzuZ6izw0/24TBn+Ru/ST/r7X
	Hp68wVx0OHlAUe7zeNzJa/z7nRQeC6I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-hxTnI4-dPFq4X50ESR47AQ-1; Fri,
 16 Jan 2026 01:59:05 -0500
X-MC-Unique: hxTnI4-dPFq4X50ESR47AQ-1
X-Mimecast-MFC-AGG-ID: hxTnI4-dPFq4X50ESR47AQ_1768546743
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0083E180045C;
	Fri, 16 Jan 2026 06:59:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B50A1800240;
	Fri, 16 Jan 2026 06:58:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5mtgC_s2J9g0smr5NDxSp1TO7d+dtZ7=afnuw9hMxQ4TYQ@mail.gmail.com>
References: <CAH2r5mtgC_s2J9g0smr5NDxSp1TO7d+dtZ7=afnuw9hMxQ4TYQ@mail.gmail.com> <20251222223006.1075635-1-dhowells@redhat.com> <sijmvmcozfmtp3rkamjbgr6xk7ola2wlxc2wvs4t4lcanjsaza@w4bcxcxkmyfc>
To: Steve French <smfrench@gmail.com>
Cc: dhowells@redhat.com, Enzo Matsumiya <ematsumiya@suse.de>,
    Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    henrique.carvalho@suse.com, ChenXiaoSong <chenxiaosong@kylinos.cn>,
    ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
Subject: Re: [PATCH 00/37] cifs: Scripted header file cleanup and SMB1 split
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <320462.1768546738.1@warthog.procyon.org.uk>
Date: Fri, 16 Jan 2026 06:58:58 +0000
Message-ID: <320463.1768546738@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Steve French <smfrench@gmail.com> wrote:

> I have tentatively merged the first 24 of this series to cifs-2.6.git
> for-next (pending testing etc) but had merge conflicts with the
> remainder on current mainline.  I also added Enzo's Acked-by
> 
> David,
> Do you have a newer/rebased version of this series that applies to
> current mainline?

I can make one.

> Also are there other patches you would like in for-next?

Not right at the moment.

> Chen,
> Will we need to rebase your patch series as well? Let me know your
> current cifs.ko patches for 6.20-rc

Chen's patches will conflict with mine.  Do you want be to base on top of his
patches, or would you like his patches on top of these?

David


