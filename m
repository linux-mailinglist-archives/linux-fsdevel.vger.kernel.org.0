Return-Path: <linux-fsdevel+bounces-60494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBD3B48941
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A66189DEA6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 09:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340972F533F;
	Mon,  8 Sep 2025 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dh+kXw1c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6EB2F1FFB
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325482; cv=none; b=jhCky7ZdfFyLiYBFeCZ3dWoF0akEnD1bHhkJtYpQK8DwV/DAALaoDj9eJChcWlbrZTAIHbWKJa/PnKaUmFMuwgYum/4XOQsx+Mgp0JloTldW2JBh8nmqRYWrbmfuEMjvLvxoNvNt2mZMixtGHaJOi3g2z08vCuY96taPNPU/FU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325482; c=relaxed/simple;
	bh=pNeha5NzhVmf2b7hPxmjuibxVc7jmXiZdeJsKpjfY/8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=RLwSjfnxpCeJFBocaX+FWWiZNf9DU9Ye066Hv30cRB5FWhXkddMzZw2CBOGx5sTe/JvcI+4KfXMiPAgeYBkAO3NolUfq/WQsCqlIb7N1AK+YlWnvpHrmTZLBlGiICHo6g74nJyuX5bpkYciuZTUxikWmI5vtY0pu7P5imQH707M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dh+kXw1c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757325480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ytBuzOgrWlKNqcg4AWjhpdU4p9P4PKRd8bMQZz8RMg=;
	b=dh+kXw1ctcsY4+MZQWuGPBDJuoI+M4xGxsdctb1swPqeCBoXwSvp+QYz+fpZBi4sVEnT2q
	lrMgW0Cc+8C6RJAncNJJsTfi9byR4PqP0YseM4d47AH28s2w8gKAEACeWrLLRPLOJ3sksL
	oAeGriJyDsYoDuRln5uYf/QJtnrlFb4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-uHBJfTOiPm-t6lrBUIRvRw-1; Mon,
 08 Sep 2025 05:57:51 -0400
X-MC-Unique: uHBJfTOiPm-t6lrBUIRvRw-1
X-Mimecast-MFC-AGG-ID: uHBJfTOiPm-t6lrBUIRvRw_1757325469
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D9DE19560B6;
	Mon,  8 Sep 2025 09:57:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 036621800576;
	Mon,  8 Sep 2025 09:57:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250905015925.2269482-1-lizhi.xu@windriver.com>
References: <20250905015925.2269482-1-lizhi.xu@windriver.com> <68b9d0eb.050a0220.192772.000c.GAE@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, Lizhi Xu <lizhi.xu@windriver.com>,
    syzbot+b73c7d94a151e2ee1e9b@syzkaller.appspotmail.com,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    netfs@lists.linux.dev, pc@manguebit.org,
    syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] netfs: Prevent duplicate unlocking
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1476482.1757325464.1@warthog.procyon.org.uk>
Date: Mon, 08 Sep 2025 10:57:44 +0100
Message-ID: <1476483.1757325464@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Christian,

Can you pick this up and add:

	Acked-by: David Howells <dhowells@redhat.com>

Thanks,
David


