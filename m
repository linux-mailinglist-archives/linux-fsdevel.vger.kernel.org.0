Return-Path: <linux-fsdevel+bounces-57425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09BBB2150B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 21:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08573A9E58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 19:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3892E2EFA;
	Mon, 11 Aug 2025 19:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icypy6Ds"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF842E2DFA
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754938858; cv=none; b=ZaCSIMjAZDoTubITYtz5SDL6JmeH32Fgl8kfe1PWblFl1hwRfiPPrPOaXTA9HCqXQOQa4/Fq2yCQ8NlBUX+JAvAdTXcqDbBLHCqK+lbAV5SNMVLWIeZWarcVHSJ1VbCGEuX2unQ47r3ehTL4YMCF5gp0pdcDnfzAkSPScKMhof8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754938858; c=relaxed/simple;
	bh=ybcjvOJlMNn70eoStdwho8f04eAjfDTqsUepVF/tZCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyEPFaAAZfje9R/0zO+Phm1nCSvJ9LKNXFt+CoUxqsvOfVE3HyUQi5lVPVn5VyS5LRU/WEKb3TdJc8mTgL32GLiWdI17sc+rBqA1Yxe4kWZ4S2bpW5ACHC/BYpN9RWCEbUca6aLJjAlB3uAIn0A+RN5Ijzs/N1/SsRYm93G5kFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icypy6Ds; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754938836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=58JoT5HH4eptH1LhdQHcGjevevo6yl7PELRmS6dCCGw=;
	b=icypy6Ds1D5COnupWJhZDJmtECTqDPuygWMlgjk8HYpbaYyMMMMqe+tnP6dxrxxF9HZ70o
	Zh+2FLdal59Tdla4GgFQCtRA74AM0eq9E894/eQfVy2DrdfJtA8hnkG6PGVVDsmKjXOUAt
	m3yFdsbUVonma4qS1fC+BqnA9i45hdM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-C_S1mD-oPbq09gk5BJhxKA-1; Mon, 11 Aug 2025 15:00:33 -0400
X-MC-Unique: C_S1mD-oPbq09gk5BJhxKA-1
X-Mimecast-MFC-AGG-ID: C_S1mD-oPbq09gk5BJhxKA_1754938832
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b78aa2a113so2247976f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 12:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754938832; x=1755543632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58JoT5HH4eptH1LhdQHcGjevevo6yl7PELRmS6dCCGw=;
        b=HM6zB0SXKvM9wn8iP2EVm2mALue8kp3RzP67htpVAjEHkIS3PST+xx3cTfGbAinZUq
         Dz7F4OLXYLdqcLYn5wGWMUGrO5lK1L3xExzYPOcSCanfOICP61rETE2ZIw1znVXLE6t8
         s29LwH0e+m/y1FvjEwpQFwX2ylQNuicu3bQHAcV06bAhA3QRKN/NRuNl40kf9+RB6IA1
         lgHR7R6U5+1hZzlBJZ9R0ui0Sm5dipUYXeDAZKMVdZHxG1AWlkr2DAGW4hm9XjGfpQTU
         AAEGD070Y12ai42TC5pslu4LNIhCKlJO5HYxFDS4MCNn213gcuFvqeG40U6T0yK3oIaS
         kzZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUJwszGhKTHsQu9OJLu8huuEZ26zNMG0FI/E8tu9RyorW0FRb/ApduHEc9yEwly/yWMWMdLs33MkimUNna@vger.kernel.org
X-Gm-Message-State: AOJu0YyBORLYyX5LPJtHep5B55H1ERSxJRrdakql8uFhKntm82enR0S4
	/E23GCRS3RLkVQr1ji84J++0T7fpebR1O3Mk4dhd0HpPsOZT2a3NP/OM6jTNez0uhYZ+vQSuKAm
	OosUVt+Obx06dZWZh7PKV4zVzAgcp3oDSRS7T29Z2KXRWukYaMAy5hoxdIWirNKtjig==
X-Gm-Gg: ASbGncuc5VcMa/TLg3tqTzd41AR50QYJJhriH6AlPlK/aGhEw1rMuUS3cJSBKvoxiV7
	I9YoLkFBtah9oREtVkgMwujDoFzaW6eXOucBGXi0erKpfyePhtUI6lbjvPiWKy5pnDtOzkGMnmy
	L8zV7/7Re5td+jpA0HueClf67wke30IYlJq4cuqycWvVRbXn/8jQ0qOnWD5Hu7lQjlJfdUXPuzs
	BUSgfwnr8OvHCH0LxGFTVBc7o3bMa3i9V/bLFuDKGQJQGW57JSKtKmTRCUqOfhtYl3buwm4QT5v
	nTmiALhjOYVYx+rxUHb2M5j+J2YRxjdTWPaMsyBtCENTgW2ni4FMFmE3KlQ=
X-Received: by 2002:a05:6000:310d:b0:3a5:3b03:3bc6 with SMTP id ffacd0b85a97d-3b911007a82mr729071f8f.28.1754938832135;
        Mon, 11 Aug 2025 12:00:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhSlMkIt2XZ85mTyNIxX5yeT/WsbII4MET5l/kPnwGJDSFQsCvBR4Sv0f4Njm12y3xRw1vzQ==
X-Received: by 2002:a05:6000:310d:b0:3a5:3b03:3bc6 with SMTP id ffacd0b85a97d-3b911007a82mr729045f8f.28.1754938831710;
        Mon, 11 Aug 2025 12:00:31 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b866392csm232787035e9.2.2025.08.11.12.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 12:00:31 -0700 (PDT)
Date: Mon, 11 Aug 2025 21:00:29 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, ebiggers@kernel.org, 
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 14/29] xfs: add attribute type for fs-verity
Message-ID: <je3ryqpl3dyryplaxt6a5h6vtvsa2tpemfzraofultyfccr4a4@mftein7jfwmt>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-14-9e5443af0e34@kernel.org>
 <20250811115023.GD8969@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811115023.GD8969@lst.de>

On 2025-08-11 13:50:23, Christoph Hellwig wrote:
> On Mon, Jul 28, 2025 at 10:30:18PM +0200, Andrey Albershteyn wrote:
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > The fsverity descriptor is stored in the extended attributes of the
> > inode. Add new attribute type for fs-verity metadata. Add
> > XFS_ATTR_INTERNAL_MASK to skip parent pointer and fs-verity attributes
> > as those are only for internal use. While we're at it add a few comments
> > in relevant places that internally visible attributes are not suppose to
> > be handled via interface defined in xfs_xattr.c.
> 
> So ext4 and other seems to place the descriptor just before the verity
> data.  What is the benefit of an attr?
> 

Mostly because it was already implemented. But looking for benefits,
attr can be inode LOCAL so a bit of saved space? Also, seems like a
better interface than to look at a magic offset

-- 
- Andrey


