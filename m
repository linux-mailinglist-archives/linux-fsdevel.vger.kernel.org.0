Return-Path: <linux-fsdevel+bounces-34413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD31B9C5189
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 10:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B032B24595
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 08:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1A920BB39;
	Tue, 12 Nov 2024 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0v3DeVK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D0820B808
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731401670; cv=none; b=DEtncG00OJ7nQ2NJx9ahf1/woW4PGbF/1tJ0DNaZhBCPUpBcmb6vTvR+nY06i8ipKxzqP1uPmo/l6w4ZImII42a6pij3/zE5RVgj8OEGJ5c2MQvRU6nJJQ9cL9Oasa4B0N3GjLMVauoPuve5NF9cMUlnj3gH77fuFX5c853iPyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731401670; c=relaxed/simple;
	bh=D+OR7DXqW7oJhBvoNSK+FItozipqU3FWMHtDLNKzmnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6hCFBunULD80fTcdOsBJo8XozCD2SFUtvadUDaGMlpgrbraSMt3FoY+UmKwVlC5jzRASLNxdMLAhsGZQJBbQ61Yfs8v0jmrnIKaq0U+eDNKKjbTOkho3yMMsg3aeTDwzX2ndsswKeFT/QbMF6RSBRFzbTr+UvPBO9d5PO1En4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0v3DeVK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731401668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7WcrqPI4E4/sq7ozAJvCWrUqHcInLoL+KPoKReN8VBc=;
	b=R0v3DeVKqRUhYrzHTV7Ru0W0KDF9q3BMDGcvUkydPxlrEiP1ARus8gqupif1JaPRcdRVtX
	M83UhCVHSitlzHfhXwoAS5kVhZlGiaNgsUt85EcXsIFRLaMJSJbZEPsHW4+y/Y7JDu3Lhv
	rm08/1Lyzt1QPf19pXFJDu1i21oouqA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-x-uaRYhGO0mcW2Mi1M1b_A-1; Tue,
 12 Nov 2024 03:54:22 -0500
X-MC-Unique: x-uaRYhGO0mcW2Mi1M1b_A-1
X-Mimecast-MFC-AGG-ID: x-uaRYhGO0mcW2Mi1M1b_A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0945B1955F41;
	Tue, 12 Nov 2024 08:54:21 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.223])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5086919560A3;
	Tue, 12 Nov 2024 08:54:18 +0000 (UTC)
Date: Tue, 12 Nov 2024 09:54:15 +0100
From: Karel Zak <kzak@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Josef Bacik <josef@toxicpanda.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/4] Add the ability to query mount options in statmount
Message-ID: <abkoq7b4vwzrllqveyqdupwal64uhu72lkmt24e7q4ge24tiye@2xxmrl6gek3a>
References: <20240625-tragbar-sitzgelegenheit-48f310320058@brauner>
 <20240625130008.GA2945924@perftesting>
 <CAJfpeguAarrLmXq+54Tj3Bf3+5uhq4kXOfVytEAOmh8RpUDE6w@mail.gmail.com>
 <20240625-beackern-bahnstation-290299dade30@brauner>
 <5j2codcdntgdt4wpvzgbadg4r5obckor37kk4sglora2qv5kwu@wsezhlieuduj>
 <20240625141756.GA2946846@perftesting>
 <CAJfpegs1zq+wsmhntdFBYGDqQAACWV+ywhAWdZFetdDxcL3Mow@mail.gmail.com>
 <CAJfpegs=JseHWx1H-3iOmkfav2k0rdFzr03eoVsdiW3rT_2MZg@mail.gmail.com>
 <20241111152805.GA675696@perftesting>
 <CAJfpegtxcoUBWC46439+Dw_2z4RoKwahGtDNoKQRHHexMpP0LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtxcoUBWC46439+Dw_2z4RoKwahGtDNoKQRHHexMpP0LQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Nov 11, 2024 at 05:02:10PM GMT, Miklos Szeredi wrote:
> As Christian said, we can add a new flag for the un-escaped variant, if needed.
> 
> I'll make a patch, because I think it would be better if there was a
> variant that non-libmount users could use without having to bother
> with unescaping the options.  Maybe having two variants isn't such a
> bad thing, as the current version is still useful for getting a single
> printable string.

I believe the ideal solution would be to support both variants. The
comma-separated variant is not a mistake, in my opinion. It is a very
common formatting style that has been used for decades.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


