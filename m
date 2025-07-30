Return-Path: <linux-fsdevel+bounces-56354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0890DB166DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 21:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4EE175824
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 19:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573432E3360;
	Wed, 30 Jul 2025 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rpeva/s9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296482E172B
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903520; cv=none; b=f+yq1zToI1bDu2v46r0nY7E1D3U7qaQ74x0s/7tMdNmuv/yFb3hRNxoCYqD3rVDodf3rX4SBpJktR/bdoH8SrozuYwq7iIcDQ1NHc+FU5K7CDJLBhtvjTqv8IgCqi/CNh20EZ/mbSErkMqhJt5+n3GoEst78184vIyjTFOx1zKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903520; c=relaxed/simple;
	bh=BZoMgRUOzIahZorpcRCfxv1zE179JhlzYN3IkVMcTNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jppIlMnkzqXDaYwiKKEtwPj4aJLQkT0cjwnLATXt2jIs1le7PBK9yFn1+9rgsq03z47XIRhZExPdnWrwIVnQERMkAUOWIV1Y4hdryuMWEuCHmsZ7esAwEKGLmiHcEOWtN5CrjKIuO2l8+IAJUnb8Aco8wKuW57SNT0qjWabTJJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rpeva/s9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753903518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BZoMgRUOzIahZorpcRCfxv1zE179JhlzYN3IkVMcTNM=;
	b=Rpeva/s92OtuV6W8YH+RFip4PaeYGQJSFhvE1/8TYK5mZaxDGLGbMxXHMZQAY4gFTZq1On
	2tBQPu0+WbGfB7gbgeRI41A0G79dAVd5dRWncEp+BJhYLP+828aohDmxtDUroChmLn/wye
	hkuONwprziE6kp3PkeSLhe5nm4OxGbQ=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-2n0PcuBBMYiFVKoFUfl4mw-1; Wed, 30 Jul 2025 15:25:16 -0400
X-MC-Unique: 2n0PcuBBMYiFVKoFUfl4mw-1
X-Mimecast-MFC-AGG-ID: 2n0PcuBBMYiFVKoFUfl4mw_1753903516
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8812640a640so14497939f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 12:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753903516; x=1754508316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZoMgRUOzIahZorpcRCfxv1zE179JhlzYN3IkVMcTNM=;
        b=Zp/VDrEUp6JMN+D9xoEca0YYYVCi3UItX92AC9DhXDZHazLcIsKo0FKVRQ4I00fsON
         JlcjKwhbnSK7Wybn0opgUd81y4J+RoF2/tid6YLTgie/qZcf9kM++ih2Q91hJJObwvZ9
         pL2CXpaKMTFGcl19lVDY8UWMZFaeVPxkMxuQnEQZO7N8UlWGsv25dWgqq8xtn9Yw43yf
         jfXJ7HO49rau95l40plzXIqFX+FLODXqkKvH8YfLTSbr4G00S78jJF/MdRYA8Hu/2+uz
         EO2fP+VQlL/byutYiy7PbinTd95cJdmIoIoLiQ/kVohzvLvT7zvddjQ6e9SBIrB/hG53
         zgjQ==
X-Gm-Message-State: AOJu0YwrQlvkg9OCY8P3/ui+h5CUz06tLrQUXWMgSuV4ysNGW1rVAeXc
	YsrC8TI+HvaP2dJIXOyCIDwdqMTN2SsBdZH4UmNI8Hg8oBWdOrf3tYdfuWIl5rNqZtDEhiIE0PL
	2QsWMZlGikXCFV3LwjfH8lZgcfzkKEIc9hno/EUGrH5AXTXIQIvyVrrKz3lknXWQjAOk=
X-Gm-Gg: ASbGncvCaA6GAvJTfnrxJ4kCVp8r5ZvLbiyC1bVQBPweTKlE9pnWyKhXMhI8GPOQtDt
	u/2ZMt3woQJkNqDTXG8jDek5TpA8dGny1attcnrHk3wxeUPqPwzWRO8qeDWSF/1eCx5oy+hDQXl
	e5hUduXult4yXDCvvcYg/Ikq0uX1VRGmTAZnwTltSR1LnXgbfxfJoTr9mGZYYYdIojZsdAI9Nv9
	qZQutT33IKZvKd3aclV7vvd+KDPy57peLX59jyDApQ+mUuTQhWFwRVFbW8ILw8GBp7OpUH20z+q
	w8fiLo4HXpQ5+YZBntqUhBbi/1Mgbt2+iFDti/M/e7NP
X-Received: by 2002:a05:6602:1495:b0:87c:72f3:d5d7 with SMTP id ca18e2360f4ac-88138913d8amr779529139f.13.1753903515945;
        Wed, 30 Jul 2025 12:25:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFpCFALf7IPXCoobyto93MhXLiAr8cMVLoJgoZHBK0x34eSoXpHWsaWyDpGqrEeEKztmMvPQ==
X-Received: by 2002:a05:6602:1495:b0:87c:72f3:d5d7 with SMTP id ca18e2360f4ac-88138913d8amr779525339f.13.1753903515535;
        Wed, 30 Jul 2025 12:25:15 -0700 (PDT)
Received: from big24.sandeen.net ([79.127.136.56])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-880f7a29956sm284856039f.25.2025.07.30.12.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:25:15 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	dhowells@redhat.com,
	sandeen@redhat.com
Subject: [PATCH V2 0/4] 9p: convert to the new mount API
Date: Wed, 30 Jul 2025 14:18:51 -0500
Message-ID: <20250730192511.2161333-1-sandeen@redhat.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an updated attempt to convert 9p to the new mount API. 9p is
one of the last conversions needed, possibly because it is one of the
trickier ones!

I was able to test this to some degree, but I am not sure how to test
all transports; there may well be bugs here. It would be great to get
some feedback on whether this approach seems reasonable, and of course
any further review or testing would be most welcome.

V2: Address "make W=1" warnings from kernel test robot, comments from
dhowells, and some kernel-doc comments for changed arguments.

Thanks,
-Eric



