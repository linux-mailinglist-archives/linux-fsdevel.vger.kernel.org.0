Return-Path: <linux-fsdevel+bounces-29519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCA297A6AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 19:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD562829E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 17:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A15B15B104;
	Mon, 16 Sep 2024 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvqKkhYo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08BA5647F
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507497; cv=none; b=JFagL0kaN1zVwYPIDls83j7ZSC86owGqkKfxV9INQ+/prErXIb/oCTx06Y6rA7iwg7t9kmdl4dTCvFRmIgYGb/FymLCVNy5mDdBLkclyJPu2qGJ7Rueb+PDuHk0sfCrGNyk2ifxf1JEAKkiqmTPDzcgPw/bdY3Qq5F8Uku4eIFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507497; c=relaxed/simple;
	bh=EHOclolu6uElxKUaes9YBTF5Z5lvuYoTixk4U3z1obk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N9gPfBr6cY1Ys1vVZVOfWPzhFVzK1wqGze7hCKnHvFh83kcEGw/bpZMGGhOZGsrKWPuPHWvBOJ4oldKCt7+yd5IAyzj/EBnkEpRw4VpnEKZYshmed0sBfIxg84sSm9XpamQEt5niytA0UHbSDs0lzT8ro8uVp5wwfQJL5OEWDbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PvqKkhYo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726507494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EHOclolu6uElxKUaes9YBTF5Z5lvuYoTixk4U3z1obk=;
	b=PvqKkhYoTyH4hGzhZJALzwT+0vS6EESY6pmE/zoA2eBjhguZV0EU4amb0miAnBQ2f6/KFv
	FKzgz5QpXmRI/u9NEs6wRkW/KDljitMCU/utPIFkX+em7vWRR6FtYKFpVlNvccL/7xn05X
	HCJr5iucW6KFwGoIw+MYhPPNegDG4uo=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-BBopmLJ4PNyIUI6XsQXoyQ-1; Mon, 16 Sep 2024 13:24:53 -0400
X-MC-Unique: BBopmLJ4PNyIUI6XsQXoyQ-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f510b3f81so95061915ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 10:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726507493; x=1727112293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EHOclolu6uElxKUaes9YBTF5Z5lvuYoTixk4U3z1obk=;
        b=f24Ijum4MNbWwFsWaR9yNBEshf5Rd4ZYBC+jZPAdaCAtrB1bhC0kIoiNlZHoWJPkve
         80/1lI05qq9gq6uUqfhleDvZuD83270X1rm4Z2Y7r3HNh3FMTQmkMNvkMzeOFyDErVrd
         CfwbLs1nvrFDwoeROsUWZc3VJyLsOjsk2vHrJcuDAeLwD190k+OHpTsYWFDfSJXY9FNd
         f+JRT5uBTVfCbs8DyNw1O/3ybUAeT3voygLxIFK/7OpNPOOqnXbj/m34RNcLCVD4bjBd
         9y5J3Os9tuIeofbC+fn67ouwf3inzbZ9gvhqjSwzetEYQmw32CtZ5zCJJbuuOH3/2eZq
         71Dw==
X-Gm-Message-State: AOJu0YxVZ15VuY/mdtMsshCFVx3FDBqBFQGQYa92DkSTSE8WGFUSsK6N
	4OZYGAt1K4S2EpsjRQ1QHgBBRqP1Z8364OVhxHmMHmZfqH+h5vijX87tWFkvOIwygOhiHTRCZ+2
	phlIkHSMYgAHwFVS2FUPhs4Bf5uXMulhlI97ClTBX6yKc0++ptJv+X60e/5FfPPdjOkjoWe8pvb
	qksN3T/dDGk7mZUrK90r9hw1jKkEm7a/EAD9DjE+exV5wYEg==
X-Received: by 2002:a05:6e02:1446:b0:3a0:abd0:122 with SMTP id e9e14a558f8ab-3a0abd004e0mr12995115ab.8.1726507492784;
        Mon, 16 Sep 2024 10:24:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0rYQdTtqElQwu8sHqhWTTz/y2aQ2AjFr7gaCIpksV72MAACX7jdT2VVocGKEWS/mWKriSPQ==
X-Received: by 2002:a05:6e02:1446:b0:3a0:abd0:122 with SMTP id e9e14a558f8ab-3a0abd004e0mr12994935ab.8.1726507492320;
        Mon, 16 Sep 2024 10:24:52 -0700 (PDT)
Received: from fedora-rawhide.sandeen.net (67-4-202-127.mpls.qwest.net. [67.4.202.127])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed190a2sm1610876173.89.2024.09.16.10.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 10:24:51 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org
Subject: [PATCH 0/5] adfs, affs, befs, hfs, hfsplus: convert to new mount api
Date: Mon, 16 Sep 2024 13:26:17 -0400
Message-ID: <20240916172735.866916-1-sandeen@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These were all tested against images I created or obtained, using a
script to test random combinations of valid and invalid mount and
remount options, and comparing the results before and after the changes.

AFAICT, all parsing works as expected and behavior is unchanged.

(Changes since first send: fixing a couple string leaks, added hfs
and hfsplus.)

Thanks,
-Eric



