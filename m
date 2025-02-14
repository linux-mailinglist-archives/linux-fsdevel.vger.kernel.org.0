Return-Path: <linux-fsdevel+bounces-41721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEDAA361EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 16:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7301892FEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AC5266F04;
	Fri, 14 Feb 2025 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XpZdjSyk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AED26659B
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547437; cv=none; b=pzdIDeDNe5/PggAtqY3csbKES80mZkoQSPg2LelRD3UBxC742q4ZiCkItCScmzP/V/qyzQbP7EKj3AHnSvYGWv8d97thMmH5lonWLMsjmw3qaafb/cQQ9nrIT1cjNzK1k6JCUOMQsChJWM0vnLJCUc1pCNxD+6kLukrLu3vPUZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547437; c=relaxed/simple;
	bh=oHid6NyBmTQvF1BB6pKUdDmaDvlW2eQEDQK94Tk7lVE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MTmfL5NL2/ecbnxKxE3DofpKZew3eT78Q8bmyOltvP0YzSNIabsqSJk7lGxxOOZVTWb3JYD4tQFxIjuB5+wZajdQxdUEcJCEDonPSCdvpn+g8ETl7Gb9FvVDyLTOchhDjPvcMyMzK9lPFR0pRnXMMaEQlMTGXLwFksvCEKArfA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XpZdjSyk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739547434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3hRSJ+mvKJWNVtQjs3dF0LR7XA3IMD1iBZgNTg1OX8=;
	b=XpZdjSyk6BzBq1ziZEmYIDDAvv8ZHLi0p6ZVCG/jZHj875qL4GssUZo0xVQa2RkMOyMvV0
	JZFJn06Tm40pHhS3iq0uwCNikllC9JHaX4ftLcHs8uykU1gC1s+zph30LTFpXBU0zqRSfO
	EQ6LBr6IRdo2PWwJJK+6DXuKBDxI7Xs=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-Tso8VrItPuSv0_w_uc61tA-1; Fri, 14 Feb 2025 10:37:13 -0500
X-MC-Unique: Tso8VrItPuSv0_w_uc61tA-1
X-Mimecast-MFC-AGG-ID: Tso8VrItPuSv0_w_uc61tA_1739547433
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8556a6f3482so117181939f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 07:37:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547432; x=1740152232;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k3hRSJ+mvKJWNVtQjs3dF0LR7XA3IMD1iBZgNTg1OX8=;
        b=lIezNjmOo1nIeQoZOWuez27W2EmCB7P4ZRg4omvqaTPxoAYe42/zRpQD04STfnym1o
         l8xhnz3bYoOadnDUU0QDjpzHSE5Iy+uWEnCst720GS6zCBpZFqcSSYohfZNoUCpvoZ2U
         vQ/g7SQXpIcCkSdzYjrFm3jYLQIswwbXMI6PST6093hpXZF/c0VaO/fabHZZvxkaKC8k
         y0g1pfBlfc5OxIFno2XqT72fH8VExJmbRiIOu1dNr6tsinIog231iatm7fHzS4OofAMn
         HqkDW+XY793rAOBEhTP7AvC4C0ijvhffTZL3V1DYUuoyOTgf9C/HcGkP8/XNuJ2VuasH
         vqSg==
X-Gm-Message-State: AOJu0YxlXQTAXoLxQ8z7z1/u+eEtcPyG66DJjWTt6M/RbcS9JVqZZRQi
	lgBO37YatLkFBZgfREmisnIddsao2/RWAvXcLYC9JkFYU0469/rszgcsnOpLcS2SIU/CCj2+wGB
	CEWaZ+kyOeXAdXCiXY1T6QKAV/aoI5NDwj+Ds2jwdmfp8Tk57m2UPNrPaqERVR6zdlpV00cwENW
	9CfHbz2P1KuNVMpDYbvlzKx4Y1LmTVam1OeOMScccFj9moMPix
X-Gm-Gg: ASbGncuazTCAkEGOb7s760EAU/HBV5sMS60TRw1Oxl3KohngxJgTiUkWj+UycHtChER
	nlzpWtbumYAZ7nOax4Pif8lDdqoVg1KIWTMhUjK8mVVs+Cd8IgoovWgAke82IWr6SUtC9ZEQRNB
	AfWHeNehOchlqmB7DI8+ZP5wWDKFeqGlazn9QtInRruhJ7QUo5P9EkdDm2BIglfeUo2l8z0FlrM
	PImvuS0mPwvVuEHCequ0f856z38gp1vgdbtgQYdzis2mcF7erablSd1trHtDaF9Sn4Bk4RnLU9s
	XGAWn50LvzsN/z3t+jRUCBl9x7WspsUkIyF+rgdJ7wal
X-Received: by 2002:a05:6602:6d87:b0:855:6f53:7045 with SMTP id ca18e2360f4ac-8556f538293mr374970339f.14.1739547432571;
        Fri, 14 Feb 2025 07:37:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyfDOWZVATdtg/8qdoS5aAwnH0e7LUT69c6qNJpecfpYEBSVStbu1WoPs3bv1d+E9EJPTKow==
X-Received: by 2002:a05:6602:6d87:b0:855:6f53:7045 with SMTP id ca18e2360f4ac-8556f538293mr374968139f.14.1739547432203;
        Fri, 14 Feb 2025 07:37:12 -0800 (PST)
Received: from [10.0.0.22] (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85566e3bfa0sm75993339f.19.2025.02.14.07.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 07:37:11 -0800 (PST)
Message-ID: <a9168241-1d8e-4e35-9594-f878a31eb8a9@redhat.com>
Date: Fri, 14 Feb 2025 09:37:11 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [RFC PATCH 1/2] watch_queue: Fix pipe buffer allocation
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: David Howells <dhowells@redhat.com>, Lukas Schauer <lukas@schauer.dev>
References: <b34d5d5f-f936-4781-82d3-6a69fdec9b61@redhat.com>
Content-Language: en-US
In-Reply-To: <b34d5d5f-f936-4781-82d3-6a69fdec9b61@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

It seems that watch_queue_set_size() calls pipe_resize_ring() with the
number of notifications in play, not the number of pages required to
hold those notifications, as pipe_resize_ring() expects. Change from
nr_notes to nr_pages to fix this.

Fixes: c73be61cede58 ("pipe: Add general notification queue support")
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 5267adeaa403..10b4d311e930 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -254,6 +254,8 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 
 	nr_pages = (nr_notes + WATCH_QUEUE_NOTES_PER_PAGE - 1);
 	nr_pages /= WATCH_QUEUE_NOTES_PER_PAGE;
+	/* Round nr_notes up to fill the pages */
+	nr_notes = nr_pages * WATCH_QUEUE_NOTES_PER_PAGE;
 	user_bufs = account_pipe_buffers(pipe->user, pipe->nr_accounted, nr_pages);
 
 	if (nr_pages > pipe->max_usage &&
@@ -264,8 +266,7 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 		goto error;
 	}
 
-	nr_notes = nr_pages * WATCH_QUEUE_NOTES_PER_PAGE;
-	ret = pipe_resize_ring(pipe, roundup_pow_of_two(nr_notes));
+	ret = pipe_resize_ring(pipe, nr_pages);
 	if (ret < 0)
 		goto error;
 


