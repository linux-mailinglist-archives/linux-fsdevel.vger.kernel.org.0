Return-Path: <linux-fsdevel+bounces-39066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 097E2A0BEE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 18:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073F83A7C2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 17:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D0B1C1F09;
	Mon, 13 Jan 2025 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1Iutai2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792761BC9FB
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736789427; cv=none; b=ggdX/ZmikGa4SaYlF44Hj9P5jcIPxJPeNAGQjXTCdPzqbdLIN7u/ttMWj8QEKbtn/H90gATQEiE9Ai6OvFEqP3FIa/Xb3pY1EUPibZN+N11J3lo1aujjWyW5NNgYZdTSEh0IJK54re/SMgB/4S/XB6+sDNryYGZ/E2FrQf0vJgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736789427; c=relaxed/simple;
	bh=t8ENE+tkNTwqboXwRljldWTdBVaqJJqQa4+UiYJ6Ndc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cFMJ6aXdZW+K3iAlz5T5NYfVfpo08ssxQET5fQi51sQ3DPKXvlnmtIw1dYJM12O+8TIhPiZUnmNoIgx0eZy/bOhqXXu7zmOEQvsN+/Pavt2t3tHaH7JA66oEQ8Vt/VlpEcrb26W4KFMjR6FSMSsBRqGGyCU3DQPvRgw6/PQPe3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1Iutai2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736789424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=IzniXLkosj7OSjKrj8zLs6jq5HcVVLPCndFNhhyaAKQ=;
	b=F1Iutai25WS8iq7diYQ2PDvhT/AF9cKheI9CezxOZX5hC53oy6MN58UvZqiAulP5w2J7oA
	NRgJHRp2gBBN2COfNgJZ/tjoCiXnVUlEjpQ0BEb3JXXY5+jdAxJ6bd1iVUpJiLRSK+QROw
	/nhNkVjhtV8RWFDC78F4x55cqISeHqw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-a02pAmthMWa27KVjDeKHyA-1; Mon,
 13 Jan 2025 12:30:21 -0500
X-MC-Unique: a02pAmthMWa27KVjDeKHyA-1
X-Mimecast-MFC-AGG-ID: a02pAmthMWa27KVjDeKHyA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E91631955D81;
	Mon, 13 Jan 2025 17:30:19 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.208])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D33F019560A3;
	Mon, 13 Jan 2025 17:30:17 +0000 (UTC)
Date: Mon, 13 Jan 2025 18:30:14 +0100
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.40.4
Message-ID: <loilfdpgmyhzx2xwtu4n2gpeyvmo3ug3rwsjfax65swjri7ws3@czkl3qygyk5u>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


The util-linux stable maintenance release v2.40.4 is now available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.40
 
Feedback and bug reports, as always, are welcomed.
 
Please note that the previous release, v2.40.3 (4 days ago), contained
a bug that made it impossible to use some /sbin/mount.<type> helpers.
I apologize for this bug and kindly request that you use v2.40.4 instead.

  Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


