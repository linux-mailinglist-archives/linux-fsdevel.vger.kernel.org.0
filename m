Return-Path: <linux-fsdevel+bounces-13252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E2686DCB7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 09:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29AAEB209F6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 08:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DA26930E;
	Fri,  1 Mar 2024 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJeOx9UC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED37200C3
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709280573; cv=none; b=IW69iMmKrEmG1k2Fu/e4aOrFFC1oPAbnAjGHUBNc5o/hJVbH07tS19onYEAwYvEqQqbrWjrmWnb39VoIhMcM00cBlFDGp5KPAkoW0BL3F8xO01GDzhVEQOBwmFTtajcFRh4WThZUzhO3zXfO9SsS6QLbdRwXoWY6Eoid3uIKnEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709280573; c=relaxed/simple;
	bh=kuwxMjvg2D8D0d+WRS7QPtzX1/KuXizoc3YnuJhLMEg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cqcRAewzUVoMFL6kSx3/ra6PRyD7fJblMFNCYDt6Mk1FaiVtlqU0KgLBqiC/QPfL76Lr8+rebP192Q1agKJKNpYcojvIw5Spv4U+lMRrMpWnQrLWUYrbJ//pq56dupQFMwp/jtCKqDaOds+FAku/+FqzKzkNx+hwYSTEUGz1OBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJeOx9UC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709280570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b3pVN5cvWn9XYrPN7iaiQppwCy5r6vPEVFm9r3u///Y=;
	b=LJeOx9UCJEJ7+s2sTc9RwUyUgkLz9i1WOF62EapN2n0pQEz0p1ODNZ6tzKUoqfukWL9tcu
	qynlfERJCmOXWgCZtwL8xUjGhEG0Y3QwCf/sgOBGy8jTaNqmsPvExcwKL/5zpG7Sg/RhSi
	zUSZmlH6VXkiLT2lT5yhL89Vrzmm83o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-fz2QBzLSP_e1_Bz8GfuuTA-1; Fri,
 01 Mar 2024 03:09:29 -0500
X-MC-Unique: fz2QBzLSP_e1_Bz8GfuuTA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA9261C05EAF;
	Fri,  1 Mar 2024 08:09:28 +0000 (UTC)
Received: from localhost (unknown [10.39.193.82])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 806C21C060B1;
	Fri,  1 Mar 2024 08:09:28 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: linux-fsdevel@vger.kernel.org,  Christian Brauner <brauner@kernel.org>,
  rodrigo@sdfg.com.ar
Subject: Re: [PATCH] hugetlbfs: support idmapped mounts
In-Reply-To: <1B974CF9-C919-48F5-AC0F-7F296EC5364F@linux.dev> (Muchun Song's
	message of "Fri, 1 Mar 2024 14:45:21 +0800")
References: <20240229152405.105031-1-gscrivan@redhat.com>
	<1B974CF9-C919-48F5-AC0F-7F296EC5364F@linux.dev>
Date: Fri, 01 Mar 2024 09:09:27 +0100
Message-ID: <87ttlq5q6g.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Muchun Song <muchun.song@linux.dev> writes:

>> On Feb 29, 2024, at 23:24, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>> 
>> pass down the idmapped mount information to the different helper
>> functions.
>> 
>> Differently, hugetlb_file_setup() will continue to not have any
>> mapping since it is only used from contexts where idmapped mounts are
>> not used.
>
> Sorry, could you explain more why you want this changes? What's the
> intention?

we are adding user namespace support to Kubernetes to run each
pod (a group of containers) without overlapping IDs.  We need idmapped
mounts for any mount shared among multiple pods.

It was reported both for crun and containerd:

- https://github.com/containers/crun/issues/1380
- https://github.com/containerd/containerd/issues/9585

Regards,
Giuseppe


