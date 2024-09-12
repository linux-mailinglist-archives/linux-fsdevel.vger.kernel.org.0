Return-Path: <linux-fsdevel+bounces-29162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F377D9768E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 14:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322191C235FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 12:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FD91A2631;
	Thu, 12 Sep 2024 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDi9swVe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD3042AAF
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726143349; cv=none; b=mNdry9QL78VgngfQTGNnqxL3RsYrpnyVcMoH2yvhUlmgG305Xt5gf1pSgiYut7KjyLl0gbI4/G/UUMmxfOv+r7P7gF84EMAH5i7CzVVfoxyUlbJiRAkiCGkNGkCLQCh3QWjAB4KS74R7gUnYuNo+GbrkL37/8lsz97avTJLfxhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726143349; c=relaxed/simple;
	bh=MOqfkVx3FW0XYUE8P3aLfQ0gXb2FlySHwk/JmhC/3b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIDTeGUveMYY7s6JmhJaAn+G0TDQ7zfJfKPiLk+mfA8L8ljzreB1W7+iH4NDO37fyshltIWM+Pio2Sdz/CBwVruwmc42jHSZgMjYdaz1oSKzOTva41Hpj0Zt9ir9nLa5Bg6ezGUa0oGLWJ69seg5kj9Vx68hm0SF+ub45TyyQ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hDi9swVe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726143347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MOqfkVx3FW0XYUE8P3aLfQ0gXb2FlySHwk/JmhC/3b0=;
	b=hDi9swVesbBli9I+XV6HopbcxVtYtcet8VPrECAT8EZt7ogo4q0x50WdKyZv75ktixFF25
	LD1gUf3yESWQLqJfkwgiZjRwSmr1kMXCFg1Gob5j/jBCr9v3d+XWeNwbC+8TmTwSU++c8X
	z3d7Z+x8QdO89vl6EplobodS6l0/rNo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-ViN-0xzSNv27tQtSfpW6DQ-1; Thu,
 12 Sep 2024 08:15:44 -0400
X-MC-Unique: ViN-0xzSNv27tQtSfpW6DQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9305194510D;
	Thu, 12 Sep 2024 12:15:39 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACDE71956086;
	Thu, 12 Sep 2024 12:15:34 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Amir Goldstein <amir73il@gmail.com>,
 Neil Brown <neilb@suse.de>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andreas Gruenbacher <agruenba@redhat.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Alexander Ahring Oder Aring <aahringo@redhat.com>,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 gfs2@lists.linux.dev, ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH v1 0/4] Fixup NLM and kNFSD file lock callbacks
Date: Thu, 12 Sep 2024 08:15:32 -0400
Message-ID: <CD2C6A05-2D9B-4F46-A6A4-DA708BF0E6B3@redhat.com>
In-Reply-To: <f4f6d39fbe5d30c5a2d1623d8b9c22e3dee636a8.camel@kernel.org>
References: <cover.1726083391.git.bcodding@redhat.com>
 <f798d5225cc52ec227b4458f3313f1908c471984.camel@kernel.org>
 <20240912-akkreditieren-montag-8e935460169d@brauner>
 <f4f6d39fbe5d30c5a2d1623d8b9c22e3dee636a8.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 12 Sep 2024, at 7:51, Jeff Layton wrote:

> On Thu, 2024-09-12 at 13:32 +0200, Christian Brauner wrote:
>>
>> It might be a bit late for v6.12 so I would stuff this into a branch for
>> v6.13. Sound ok?
>
> Ok. I figured Chuck would take this set, but I guess it is more VFS-y.
>
> I think this is reasonably safe though, so if Ben needs it before then,
> we could pull it in sooner.

Absolutely no rush here, v6.13 is not a problem.

Ben


