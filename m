Return-Path: <linux-fsdevel+bounces-13667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00477872ACF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 00:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93DA81F22695
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 23:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65EE12D20C;
	Tue,  5 Mar 2024 23:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1T4gKni"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4375E41760
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709680065; cv=none; b=Uy6pCP6aPRR/dj7gfj8mpcnthhWYJbneKLY1TwTF9RR79XrZtXuKuebPBU5RWouAnkbhCqyuHd/Ok5hqZKo73X0l2ubbCMEa4kQIFY0PTxlZZ4QSZrqFYAca1RErGixi+G4GzZNO6o6GD+FicCDbqE/skgXsbHDvY0WMC+5HKUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709680065; c=relaxed/simple;
	bh=z4f2CZATeqJZnfe8/ysWbi4qu/Qrqmb1Zwyfv2N2sjs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=b7kw3HE3CgBX+XnO8xaymIOephf3PxrToMPY8U3RO/a1vBbRL68FWD2bofd2cWR+3eCU10bRTUv0Os9o3YMjzjW5X/jLrUnrroDbK/zcfGaePsPYqd2g+XvZ/4X+XaO5rjlPeg+Eiq9Vx2Dn6qD3VGZzt07D0aM17XP5TSCyg3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O1T4gKni; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709680062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z4f2CZATeqJZnfe8/ysWbi4qu/Qrqmb1Zwyfv2N2sjs=;
	b=O1T4gKni1yYONnZ42y6LM6RAO30VFLZ2LImnrRAX/Qr0PxBl8ZOfCP0t6mNViB3eTLQisG
	mLQ5RsmFyPce9QEjzgm3Gi8pTirOFjHvUJMXxnWiSAB0IBlhfss0IhsMkzuFa4i5fAfwWc
	nf5eZ0qilqz4N8Xkhtf2Z4xluyPzQJQ=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-YX0nPDbIORuQ38n_yvMAig-1; Tue, 05 Mar 2024 18:07:35 -0500
X-MC-Unique: YX0nPDbIORuQ38n_yvMAig-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3657bb7b9d2so93167855ab.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 15:07:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709680051; x=1710284851;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z4f2CZATeqJZnfe8/ysWbi4qu/Qrqmb1Zwyfv2N2sjs=;
        b=ePmrwccjYDGLxIrUpBpJFxZLJkOnJfEjcrXnPdT8lFA2Q2ffbQah5EiDGuWwqgj88E
         PxCGA8up5IL8IZODmPz8+P92WLgAZG7LIQHzvAmZNCIg+osOoexykuGurKjSh65PkTHA
         xo/fBE9ctL5G9X6RFguJTZhvOSbWaotp2upHXa9+OzDIuHt96S6fu7YdjiPKCn6zG6aA
         /3xODeLBstLzboJVuq/08yOa7I22Udnl602tmPoHgr31Iyi8bH816it3jNceN0YZI2Gl
         I3bvvCxsiF0LfPM/bsP8UZPmJ2ifekin7FHsGie7RBiJUWnE4wZQ27hAszvNiS5Ox4ta
         UT7Q==
X-Gm-Message-State: AOJu0YxOCHdtCkqY042M+9FO65VIi6hrIKGKld9SaNA2KPXLBXw4J8Uv
	07JypeSsMqmoP9CTUEsrQGKT/6zOudKSD6M9PDSYQp6di3fVgzZM2cdLqGB42r0ZMsgVK2O5DlL
	6NPycp/eVfQ0RUpsL4AKtYuoaJA2X6RMd+9tX4LSx5Sj1QQIj8xd9yQzhBV15MJZT/izrawgiG8
	bZQkfL5wOVMUZH3vuvq51LlRIpYYzFS4MnFMpGx7sHqh2JwN1y
X-Received: by 2002:a05:6e02:b47:b0:365:b485:734c with SMTP id f7-20020a056e020b4700b00365b485734cmr18843419ilu.25.1709680051035;
        Tue, 05 Mar 2024 15:07:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkk92D6XweRyTSc2xdRt+EtvJ1VY812coIYxj7wMnujUyxCTTBRjA7E9zhGeX2JDEoPjHLlQ==
X-Received: by 2002:a05:6e02:b47:b0:365:b485:734c with SMTP id f7-20020a056e020b4700b00365b485734cmr18843395ilu.25.1709680050672;
        Tue, 05 Mar 2024 15:07:30 -0800 (PST)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id u11-20020a92d1cb000000b0036600aa51dbsm390770ilg.47.2024.03.05.15.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 15:07:30 -0800 (PST)
Message-ID: <cfdebcc3-b9de-4680-a764-6bdf37c0accb@redhat.com>
Date: Tue, 5 Mar 2024 17:07:29 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 0/2] vfs: convert debugfs & tracefs to the new mount API
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Bill O'Donnell <billodo@redhat.com>,
 David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Since debugfs and tracefs are cut & pasted one way or the other,
do these at the same time.

Both of these patches originated in dhowells' tree at
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=mount-api-viro

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=mount-api-viro&id=ec14be9e2aa76f63458466bba86256e123ec4e51
and
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=mount-api-viro&id=c4f2e60465859e02a6e36ed618dbaea16de8c8e0

I've forward-ported them to the mount API that landed, and
fixed up remounting; ->reconfigure() needed to copy the
parsed context options into the current superblock options
to effect any remount changes.

While these do use the invalf() functions for some errors, they
are new messages, not messages that used to go to dmesg that
would be lost if userspace isn't listening.

I've done minimal testing - booting with the patches, testing
some of the remount behavior for mode & uid.
Oh, and I built it too. </brown_paper_bag>

thanks,
-Eric


