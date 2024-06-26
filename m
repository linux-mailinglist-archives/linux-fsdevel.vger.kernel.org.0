Return-Path: <linux-fsdevel+bounces-22479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03A9917A12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 09:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED861C219E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 07:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD43915D5CF;
	Wed, 26 Jun 2024 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7GLi0mB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82A9219FC
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388117; cv=none; b=HCj2HM2DLzMyKsCKDJKMtuD8oQEthn756bZpVq0XfCn2DTxvtvZMnbBEzQlVdKLqlmWtQ8rrNNXGCdwQS/47SxKU9EpxMsmbmjUWqkixnmSWHcLwckpj1C4syp0i7PlKpMUG6kl14CnspaNiUz25FB0UvGpIMkZujg9zt03GPGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388117; c=relaxed/simple;
	bh=y2NUzE7G4RrvR7C/UeqccGMrU4AATADZv90ccr/swAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ6fVt0R7qVcl7iO/WDabpUMp9nypz82c8JmgY3pN4RwBF6RfwUBf8JdiKr+zaHNG/fQfTJsi/XrN7hrl+dCI1zvV5WDqFIzzInp46Aq+HKkFhKrUXAQXM2JqizazzHjB4WzKALu7ecNTpE+2Z1YIJkjnC4q4p5gZqAd44OptvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7GLi0mB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719388114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1hPvDRsZdsjSVZX2GHqQUdyysyzKsJEMre1GKQutKZQ=;
	b=L7GLi0mB7bWeYDIG/AYFeFl/wjcmaauuTUDEp55H8e6o7eWPFTB0pqxPYf1pDtAyKV9BHN
	iC9FLraphV2c6OssfwTBoMVhab3zeo+7HlHjE4UIciBpd+LLqCUIs2Jc8Lr0kpNP8KW22Z
	RMHZRTrGuzTrFHpUEO9Znhy3gv/dn3E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-qW8MbzFoNlGTwAJUzNcrpg-1; Wed,
 26 Jun 2024 03:47:42 -0400
X-MC-Unique: qW8MbzFoNlGTwAJUzNcrpg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73BB119560AA;
	Wed, 26 Jun 2024 07:47:41 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.185])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D8E33000601;
	Wed, 26 Jun 2024 07:47:39 +0000 (UTC)
Date: Wed, 26 Jun 2024 09:47:36 +0200
From: Karel Zak <kzak@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	kernel-team@fb.com
Subject: Re: [PATCH 2/4] fs: add a helper to show all the options for a mount
Message-ID: <wf65zvnp45az55myxjjpyn5vm5q2mylv3gxbcw3676abxtrmph@swqpqnv63j2p>
References: <cover.1719257716.git.josef@toxicpanda.com>
 <ba65606c5f233c6d937dfa690325e95712a69a95.1719257716.git.josef@toxicpanda.com>
 <20240625-wallung-rekultivieren-71c4a6c2072f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625-wallung-rekultivieren-71c4a6c2072f@brauner>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Jun 25, 2024 at 04:16:47PM GMT, Christian Brauner wrote:
> On Mon, Jun 24, 2024 at 03:40:51PM GMT, Josef Bacik wrote:
> So Karel just made me aware of this. You're using the old /proc/mounts
> format here and you're mixing generic sb options, mount options, and fs
> specific mount options.

Yes, the patch takes us back in time to the era of /etc/mtab when vfs
and fs options were merged into a single string. For example,
/proc/self/mountinfo separates the options into two fields.

> Please only call ->show_options().

 +1

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


